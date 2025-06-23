# Zency Demo App

This is a basic salon booking demo app built with **Flutter** and **Firebase**.

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