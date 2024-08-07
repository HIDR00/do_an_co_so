import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import '../bloc/menu.dart';

class TabViewWidget extends StatefulWidget {
  const TabViewWidget({required this.categories, required this.bloc, super.key});
  final String categories;
  final MenuBloc bloc;

  @override
  State<TabViewWidget> createState() => _TabViewWidgetState();
}

class _TabViewWidgetState extends State<TabViewWidget> {
  @override
  void initState() {
    super.initState();
    widget.bloc.add(TabViewInitiated(widget.categories));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (context, state) {
        return Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryBG,
            ),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.d25),
              child: GridView.builder(
                itemCount: state.lItemCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Dimens.d8,
                    mainAxisSpacing: Dimens.d20,
                    childAspectRatio: 0.6),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(Dimens.d15)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(Dimens.d8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(Dimens.d10),
                              child: CachedNetworkImage(
                                imageUrl: state.lItemCategories[index].image,
                                height: Dimens.d100,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(height: Dimens.d10),
                          Text(
                            state.lItemCategories[index].name,
                            style: AppTextStyles.s14w600Primary(),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: Dimens.d10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${state.lItemCategories[index].price.toString()}đ',
                                style: AppTextStyles.s14w400Description(),
                              ),
                              GestureDetector(
                                onTap: () {
                                  widget.bloc.add(TabViewAddOrder(state.lItemCategories[index]));
                                },
                                child: Container(
                                  height: Dimens.d25,
                                  width: Dimens.d25,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(Dimens.d5)),
                                  child: const Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: Colors.white,
                                    size: Dimens.d20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ));
      },
    );
  }
}
