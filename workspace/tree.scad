// Simple tree model with cylindrical trunk and rounded crown

// Parameters for easy adjustment
trunk_height = 40;
trunk_radius = 5;
crown_radius = 18;

module tree(trunk_h, trunk_r, crown_r) {
    // Trunk
    color([0.55, 0.27, 0.07])
        cylinder(h=trunk_h, r=trunk_r, center=false);
    // Foliage (crown)
    translate([0,0,trunk_h])
        color([0.13, 0.55, 0.13])
            sphere(r=crown_r);
}

// Render the tree
translate([0,0,0]) tree(trunk_height, trunk_radius, crown_radius);
