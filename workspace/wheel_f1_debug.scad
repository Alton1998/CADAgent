// Quick tire-only debug
outer_diameter = 70;
tire_width = 40;
tire_thickness = 12;
$fn=128;

module tire() {
    rotate_extrude(angle=360) {
        translate([outer_diameter/2-tire_thickness, 0, 0])
            circle(r=tire_thickness);
    }
}

tire();