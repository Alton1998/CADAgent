// Minimal wheel with enlarged center and grooves - No tire
// Parameters
rim_outer_radius = 30;
rim_inner_radius = 22;
hub_radius = 13;         // Enlarged hub radius
hub_hole_radius = 7;     // Enlarged center hole radius
wheel_thickness = 10;
hub_length = 15;
num_grooves = 16;        // Number of grooves
ridge_width = 1.3;       // Groove width (mm)
$fn = 100;
    // Main rounded tire
    difference() {
        rotate_extrude(angle=360, $fn=180)
            translate([wheel_radius-tire_width/2,0,0])
                scale([1,0.7]) // for roundness
                    circle(d=tire_width);
        // Cut rim area out
        rotate_extrude(angle=360, $fn=100)
            translate([hub_radius+rim_thickness,0,0])
                scale([1,0.8])
                    circle(d=(tire_width-rim_thickness*2));
    }
    // Tread pattern
    for(i = [0:tire_tread_count-1]) {
        rotate([0,0,i*360/tire_tread_count])
            translate([wheel_radius,0,0])
                rotate([0,90,0])
                    cube([tire_width,tread_depth,1.5], center=true);
    }
}

module hub() {
    difference() {
        // Main hub (cylinder)
        cylinder(h=tire_width, r=hub_radius, center=true);
        // Center hole for axle
        cylinder(h=tire_width+2, r=hub_radius/3, center=true);
        // Spokes that fully reach from hub to inside of rim/tire
        if (spoke_count > 0) {
            spoke_length = wheel_radius - hub_radius + 1; // Stretch slightly into tire area
            spoke_radius = 1.7;
            for(j = [0:spoke_count-1]) {
                angle = 360*j/spoke_count;
                rotate([0,0,angle])
                    translate([hub_radius, 0, 0]) // start exactly at hub
                        cylinder(h=spoke_length, r=spoke_radius, center=false, $fn=18);
            }
        } else {
            // Vent holes
            for(j = [0:7]) {
                rotate([0,0,360*j/8])
                    translate([hub_radius-2,0,0])
                        cylinder(h=tire_width+2, r=1.2, center=true);
            }
        }
    }
}

// Wheel assembly with grooves, enlarged hub, no tire
module wheel_with_grooves() {
    difference() {
        union() {
            // Rim (cylindrical ring only)
            difference() {
                cylinder(r=rim_outer_radius, h=wheel_thickness, center=true);
                cylinder(r=rim_inner_radius, h=wheel_thickness+0.2, center=true);
            }
            // Enlarged hub
            cylinder(r=hub_radius, h=hub_length, center=true);
        }
        // Enlarged center hole
        cylinder(r=hub_hole_radius, h=hub_length+2, center=true);
        // Radial grooves
        for(i = [0:num_grooves-1]) {
            angle = i*360/num_grooves;
            rotate([0,0,angle])
                translate([(rim_inner_radius+rim_outer_radius)/2, -ridge_width/2, wheel_thickness/2-1.5])
                    cube([rim_outer_radius-rim_inner_radius-1.5, ridge_width, 2], center=false);
        }
    }
}

// Render
wheel_with_grooves();
