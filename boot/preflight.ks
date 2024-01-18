// required to keep boot script at minimum length to fit into internal memory
WAIT UNTIL SHIP:LOADED AND SHIP:UNPACKED.

runOncePath("0:/lib/boot.ks").
preflight_check().
