import 'package:thespot/data/model/has_reservation_response.dart';
import 'package:thespot/data/model/reservation_response.dart';

abstract class IReservationProvider {
  Future<HasReservationResponse> hasReservation();
  Future<ReservationResponse> getReservation();
}
