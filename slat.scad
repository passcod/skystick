// 3mm holes on PCB
slat_inner_diameter = 3;
// 5mm nuts for M2.5 screws, 5.5mm for M3
slat_outer_diameter = 6;
// just enough to position
slat_outer_depth = 0.5;

// from pinetrim ??, cut longitudinally
slat_width = 22;
slat_length = 100;
slat_thickness = 4;

// the actual length of the slat, taking into account inserts into the board
board_thickness = 18;
slat_outer_length = slat_length + board_thickness;

module slat_hole (offset, offcenter) {
    inner_radius = slat_inner_diameter / 2;
    outer_radius = slat_outer_diameter / 2;
    translate([offset, offcenter, 0]) {
        union() {
            cylinder(slat_thickness, inner_radius, inner_radius, $fn=30);
            translate([0, 0, -1]) {
                cylinder(slat_outer_depth+1, outer_radius, outer_radius, $fn=30);
            }
            translate([0, 0, slat_thickness - slat_outer_depth]) {
                cylinder(slat_outer_depth+1, outer_radius, outer_radius, $fn=30);
            }
        }
    }
}

module slat_plank () {
    translate([slat_outer_length / -2, slat_width / -2, 0]) {
        cube([slat_outer_length, slat_width, slat_thickness]);
    }
}

module slat(offcenter = 0, hole_width = 35.40) {
    difference() {
        slat_plank();
        slat_hole(hole_width / 2, offcenter);
        slat_hole(hole_width / -2, offcenter);
    }
}

// slat();
