module slat_hole (offset, offcenter) {
    // 3mm holes on PCB
    slat_inner_radius = 3;
    // 5mm nuts for M2.5 screws, 5.5mm for M3
    slat_outer_radius = 6;
    // just enough to position
    slat_outer_depth = 0.5;
    translate([offset, offcenter, 0]) {
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
    // from pinetrim ??, cut longitudinally
    slat_width = 22;
    slat_length = 120;
    translate([slat_length / -2, slat_width / -2, 0]) {
        cube([slat_length, slat_width, 4]);
    }
}

module slat(offcenter = 0, hole_width = 35.40) {
    difference() {
        slat_plank();
        slat_hole(hole_width / 2, offcenter);
        slat_hole(hole_width / -2, offcenter);
    }
}

slat();