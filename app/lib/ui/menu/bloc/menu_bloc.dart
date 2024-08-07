import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../app.dart';
import 'menu.dart';

@Injectable()
class MenuBloc extends BaseBloc<MenuEvent, MenuState> {
  MenuBloc(this._repository) : super(MenuState()) {
    on<MenuPageInitiated>(
      _onMenuPageInitiated,
      transformer: log(),
    );
    on<TabViewInitiated>(
      _onTabViewInitiated,
      transformer: log(),
    );
    on<TabViewAddOrder>(
      _onTabViewAddOrder,
      transformer: log(),
    );
  }
  final Repository _repository;

  FutureOr<void> _onMenuPageInitiated(MenuPageInitiated event, Emitter<MenuState> emit) async {
    return runBlocCatching(
      action: () async {
        final _result = await _repository.getCategory();
        emit(state.copyWith(isShimmerLoading: true,lCategories: _result.lMCategories));
    },
    doOnSubscribe: () async {
      
    },
    doOnEventCompleted: () async {
      
    },
    );
  }

  FutureOr<void> _onTabViewInitiated(TabViewInitiated event, Emitter<MenuState> emit) async {
    return runBlocCatching(
      action: () async {
        final _result = await _repository.getItemMenu(event.categories);
        emit(state.copyWith(isShimmerLoading: true,lItemCategories: _result.lMItemCategories));
    },
    doOnSubscribe: () async {
      
    },
    doOnEventCompleted: () async {
      
    },
    );
  }

  FutureOr<void> _onTabViewAddOrder(TabViewAddOrder event, Emitter<MenuState> emit) async {
    return runBlocCatching(
      action: () async {
        final _result = List<MItemCategories>.from(state.lItemCategoriesOder);
        _result.add(event.itemCategoriesOder);
        emit(state.copyWith(lItemCategoriesOder: _result));
    },
    doOnSubscribe: () async {
      
    },
    doOnEventCompleted: () async {
    },
    );
  }
}
