model = "neo+2";
// model = "pico-itx";

// holes on PCB
slat_inner_diameter = (model == "neo+2") ? 3 :
    ((model == "pico-itx") ? 4 :
        0);
// 5mm nuts for M2.5 screws, 5.5mm for M3, 7mm for M4
slat_outer_diameter = slat_inner_diameter + 3;

// just enough to position
slat_outer_depth = 0.5;
slat_outer_depth = 0; // simplify manufacture

// from hardwood or thin ply, cut longitudinally
slat_length = 120;
slat_thickness = 4;
slat_width = (model == "neo+2") ? 22 :
    ((model == "pico-itx") ? 30 :
        25);


// how far the holes are from center to center along slat
mach_hole_width = (model == "neo+2") ? 35.4 :
    ((model == "pico-itx") ? 94 :
        0);

// how far the holes are from center to center across slat
mach_hole_height = (model == "neo+2") ? 35.4 :
    ((model == "pico-itx") ? 66 :
        0);

// how far from center the holes are
slat_offcenter = (model == "neo+2") ? 0 :
    ((model == "pico-itx") ? 6 :
        0);

// the actual length of the slat, taking into account inserts into the board
board_thickness = 18;
slat_outer_length = slat_length + board_thickness;

module slat_hole (offset, offcenter) {
    inner_radius = slat_inner_diameter / 2;
    outer_radius = slat_outer_diameter / 2;
    translate([offset, offcenter, 0]) {
        union() {
            if (slat_outer_depth > 0) {
                cylinder(slat_thickness, inner_radius, inner_radius, $fn=30);
                translate([0, 0, -1]) {
                    cylinder(slat_outer_depth+1, outer_radius, outer_radius, $fn=30);
                }
                translate([0, 0, slat_thickness - slat_outer_depth]) {
                    cylinder(slat_outer_depth+1, outer_radius, outer_radius, $fn=30);
                }
            } else {
                translate([0, 0, -1]) cylinder(slat_thickness + 2, inner_radius, inner_radius, $fn=30);
            }
        }
    }
}

module slat_plank () {
    translate([slat_outer_length / -2, slat_width / -2, 0]) {
        cube([slat_outer_length, slat_width, slat_thickness]);
    }
}

module slat() {
    difference() {
        slat_plank();
        slat_hole(mach_hole_width / 2, slat_offcenter);
        slat_hole(mach_hole_width / -2, slat_offcenter);
    }
}

slat();
