runOncePath("0:/lib/flight.ks").

// launch with autopilot
autopilot_launch().

// destroy once falling below 40km (no science there)
destroy_bellow(40).
