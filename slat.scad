module slat_hole (offset) {
    slat_inner_radius = 2;
    slat_outer_radius = 4;
    slat_outer_depth = 0.5;
    translate([offset, 0, 0]) {
        union() {
            cylinder(4, slat_inner_radius, slat_inner_radius, $fn=100);
            translate([0, 0, -1]) {
                cylinder(slat_outer_depth+1, slat_outer_radius, slat_outer_radius, $fn=100);
            }
            translate([0, 0, 4-slat_outer_depth]) {
                cylinder(slat_outer_depth+1, slat_outer_radius, slat_outer_radius, $fn=100);
            }
        }
    }
}

module slat_plank () {
    translate([-60, -16, 0]) {
        // from pinetrim 32x40mm, cut longitudinally
        cube([120, 32, 4]);
    }
}

module slat(hole1 = 20, hole2 = -20) {
    difference() {
        slat_plank();
        slat_hole(hole1);
        slat_hole(hole2);
    }
}

slat();