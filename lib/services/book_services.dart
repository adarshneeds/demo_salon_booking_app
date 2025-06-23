import 'package:cloud_firestore/cloud_firestore.dart';

class BookServices {
  static Future<void> bookRequest({required String service, required DateTime date}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('bookings').add({'service_type': service, 'date': date, 'status': 'pending'});
  }
}
