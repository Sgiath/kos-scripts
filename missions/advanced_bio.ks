// this mission requires rocket to have 2200 m/s at 140km altitude while carrying sounding payload
// this file is meant for debuging and figuring out how much fuel is needed
//
// Usage:
//   - launch rocket with this settings
//   - check if you have speed above 2200 m/s at 140km
//   - if yes, check how much fuel you have left and make your tank smaller accordingly
//   - if not, increase the cutoff speed
//   - repeat until you have almost nothing left in the tank and you barely reach 2200 m/s at 140km

lock cutoff to 2600.

runOncePath("0:/lib/flight.ks").
runOncePath("0:/lib/utils.ks").

autopilot_launch().

print " ".
print "Waiting for speed to reach " + cutoff + " m/s".
wait until verticalSpeed > cutoff.
// disable MechJeb autopilot
toggle_mechjeb_autopilot().
print "Autopilot disabled".

lock throttle to 0.
print "Engine shutoff".

print " ".
print "Remaining resources:".
local ignored is list("ElectricCharge", "SoundingPayload").
for r in ship:resources {
  if not ignored:contains(r:name) {
    print "  " + r:name + ": " + round(r:amount / (r:capacity / 100), 2) + " %".
  }
}

print " ".
print "Waiting to reach 145km to deploy sounding payload".
wait until altitude >= 140_000.
print "Speed at 140km: " + round(verticalSpeed, 2) + " m/s".

// separeate above 140km line
wait until altitude > 145_000.
stage.
print "Sounding payload dropped".

land().
