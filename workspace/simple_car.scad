// Simple parametric car model

// Car body parameters
body_length = 60;
body_width = 30;
body_height = 15;

// Wheel parameters
wheel_radius = 7;
wheel_width = 5;
axle_radius = 2;
axle_length = body_width + 2 * (wheel_width + 1);

// Wheel positions
wheel_offset_x = body_length / 2 - wheel_radius - 3;
wheel_offset_y = body_width / 2 + wheel_width / 2 + 1;

// Main car module
module simple_car() {
    // Body
    difference() {
        union() {
            // Main body
            translate([0,0,wheel_radius + 1])
                cube([body_length, body_width, body_height], center=true);
            // Cabin (simple block for windshield)
            translate([6,0,wheel_radius + body_height + 1])
                cube([body_length/2, body_width*0.7, body_height*0.6], center=true);

        }
    }

    // Wheels and axles
    for(side=[-1,1]) {  // Front/Rear wheels
        // Axles
        translate([side * wheel_offset_x,0,wheel_radius])
            rotate([90,0,0])
                cylinder(h=axle_length, r=axle_radius, center=true);
        // Left and Right wheels at each axle
        for(lr=[-1,1])
            translate([side * wheel_offset_x, lr * wheel_offset_y, 0])
                rotate([90,0,0])
                    wheel();
    }
}

// Wheel module (with simple hubcap)
module wheel() {
    difference() {
        color("black")
            cylinder(h=wheel_width, r=wheel_radius, center=true);
        color("silver")
            translate([0,0,0])
                cylinder(h=wheel_width+0.2, r=wheel_radius*0.6, center=true);
    }
}

// Render the car
simple_car();

