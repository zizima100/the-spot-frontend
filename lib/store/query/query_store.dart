import 'package:flutter/material.dart' show debugPrint;
import 'package:mobx/mobx.dart';
import 'package:thespot/data/model/reservation.dart';
import 'package:thespot/repository/reservation/reservation_repository_interface.dart';

import 'query_state.dart';

part 'query_store.g.dart';

class QueryStore extends _QueryStore with _$QueryStore {
  QueryStore({
    required IReservationRepository repository,
  }) {
    super._repository = repository;
  }
}

abstract class _QueryStore with Store {
  late IReservationRepository _repository;
  Reservation? _reservation;

  @observable
  QueryState _state = QueryStateLoading();

  @computed
  QueryState get state => _state;

  @action
  Future<void> query() async {
    try {
      _reservation = await _repository.getReservation();
      _state = QueryStateQueried(_reservation!);
    } catch (e) {
      debugPrint('Error on _query: $e');
      _state = QueryStateFailure();
    }
  }

  @action
  void detailedReservation() {
    _state = QueryStateDetailed(_reservation!);
  }

  @action
  void resetState() {
    _state = QueryStateLoading();
  }

  @action
  void backToInitial() {
    _state = QueryStateQueried(_reservation!);
  }

  @action
  void confirmCancellation() {
    _state = QueryStateConfirmCancellation();
  }

  @action
  void backToReservationDetailed() {
    _state = QueryStateDetailed(_reservation!);
  }

  @action
  void cancelReservation() {
    try {
      _repository.cancel(_reservation!.id);
      _state = QueryStateReservationCancelled();
    } on Exception catch (e) {
      print('QueryStore cancelReservation error: $e');
      _state = QueryStateFailure();
    }
  }
}
