# Zency Demo App

This is a basic salon booking demo app built with **Flutter** and **Firebase**, featuring a simple and minimal UI.

## Features

- Select a service (e.g., haircut, shave)
- Choose a date and time
- Confirm booking
- Booking details are saved in **Firestore**

## Firestore Structure

```
bookings (collection)
  └── bookingId (document)
          ├── service_type: "Haircut"
          ├── date: June 23, 2025 at 12:00:00 AM UTC+5:30
          └── status: "pending"
```

## Screenshots
<img src="https://github.com/user-attachments/assets/a661d302-d171-4e8f-b68e-21dcf0043cfe" alt="screenshot" width="400"/>