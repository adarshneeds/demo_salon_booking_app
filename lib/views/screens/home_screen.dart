import 'package:demo_app/config/helper.dart';
import 'package:demo_app/provider/home_provider.dart';
import 'package:demo_app/services/book_services.dart';
import 'package:demo_app/views/widgets/date_picker_textfield.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_loading_handler/screen_loading_controller.dart';
import 'package:screen_loading_handler/screen_loading_handler.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final ScreenLoadingController controller = ScreenLoadingController();

  @override
  Widget build(BuildContext context) {
    return ScreenLoadingHandler(
      controller: controller,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  Image.asset("images/salon_illustration.png", width: double.infinity, fit: BoxFit.fitWidth),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Book Service',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select a service and book your appointment with ease.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 28),
                  Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return DropdownButtonFormField(
                        value: provider.serviceType,
                        items: [
                          DropdownMenuItem(
                            enabled: false,
                            value: 'select',
                            child: Text('Select Service', style: TextStyle(fontSize: 14, color: Colors.grey)),
                          ),
                          DropdownMenuItem(
                            value: 'haircut',
                            child: Text('Haircut', style: TextStyle(fontSize: 14)),
                          ),
                          DropdownMenuItem(
                            value: 'shave',
                            child: Text('Shave', style: TextStyle(fontSize: 14)),
                          ),
                        ],
                        onChanged: (value) => provider.setServiceType(value ?? 'select'),
                      );
                    },
                  ),
                  SizedBox(height: 28),
                  DatePickerTextField(onDateSelected: (date) => context.read<HomeProvider>().setSelectedDate(date)),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => _onBookNowPressed(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                      minimumSize: Size(double.infinity, 50.0),
                      maximumSize: Size(double.infinity, 52.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        side: BorderSide(color: Colors.black, width: 1.0),
                      ),
                    ),
                    child: Text('Book Now'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onBookNowPressed(BuildContext context) async {
    try {
      controller.startLoading();

      String service = context.read<HomeProvider>().serviceType;
      DateTime? date = context.read<HomeProvider>().selectedDate;

      if (service == 'select') {
        Helper.showSnackbar(context, 'Please select a service.');
        return;
      }

      if (date == null) {
        Helper.showSnackbar(context, 'Please select a date and time.');
        return;
      }

      await BookServices.bookRequest(service: service, date: date);
      if (context.mounted) Helper.showSnackbar(context, 'Booking successful!');
      if (context.mounted) context.read<HomeProvider>().reset();
    } on FirebaseException catch (e) {
      switch (e.code) {
        case 'unavailable':
          if (context.mounted) {
            Helper.showSnackbar(context, 'Service is currently unavailable. Please try again later.');
          }
          break;
        case 'permission-denied':
          if (context.mounted) {
            Helper.showSnackbar(context, 'You do not have permission to perform this action.');
          }
          break;
        default:
          if (context.mounted) {
            Helper.showSnackbar(context, 'An error occurred: ${e.message}');
          }
      }
    } catch (e) {
      if (context.mounted) {
        Helper.showSnackbar(context, 'Something went wrong. Please try again later.');
      }
    } finally {
      controller.stopLoading();
    }
  }
}
