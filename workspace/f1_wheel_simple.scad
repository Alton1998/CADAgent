// Simple and robust F1-style wheel: visible tire, rim, hub, and thick spokes
$fn=128;

// Parameters
wheel_radius = 35;         // total outer radius (mm)
tire_radius = 7;           // tire cross-section (mm)
tire_width = 38;           // width of tire (mm)
rim_radius = 24;           // rim outer radius (mm)
rim_width = 32;            // width of rim (mm)
hub_radius = 9;            // central hub radius (mm)
hub_width = 32;            // hub width (mm)
axle_radius = 5;           // central hole (mm)
num_spokes = 10;           // F1 wheel: 10 thick spokes
spoke_r = 3.0;             // radius of spokes (mm)

// Tire, as a torus
module tire() {
    rotate_extrude() {
   ...