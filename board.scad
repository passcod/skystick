include <slat.scad>;

// pinetrim 115x18mm
board_thickness = 18;
board_width = 115;

slot_angle = 45;

// how much space there is between slot pairs and board edge, at minimum
slot_offset = 80;

// how spaced the slots are, along their axis
slot_gap = 35.4 - slat_width;

// the length taken by a slot pair, along the board's axis
machine_thickness = 30;
slot_effective_length = max(machine_thickness, (slat_width * 2 + slot_gap) * sin(slot_angle));

// how spaced the slot pairs are, along the board's axis
slot_repeat_gap = 8;

// M6 tie rod thread and 10mm socket for flanged nuts, both + clearance
rod_inner_diameter = 7;
rod_outer_diameter = 20;

// flanged nuts are 6mm tall
rod_outer_depth = max(7, board_thickness / 2);
rod_inner_depth = board_thickness - rod_outer_depth;

// how far the tie rod holes are from the edges
rod_offset = 30;

module board_slot () {
    slot_depth = board_thickness / 2;
    translate([0, 0, board_thickness - slot_depth]) {
        rotate(-slot_angle) {
            translate([0, slot_gap / 2, 0]) {
                cube([slat_thickness, slat_width, slot_depth + 1]);
            }

            translate([0, (slot_gap / -2) - slat_width, 0]) {
                cube([slat_thickness, slat_width, slot_depth + 1]);
            }
        }
    }
}

module board_hole () {
    inner_radius = rod_inner_diameter / 2;
    outer_radius = rod_outer_diameter / 2;

    translate([0, 0, -1]) {
        cylinder(rod_outer_depth + 2, outer_radius, outer_radius, $fn = 100);
    }

    translate([0, 0, rod_inner_depth - 1]) {
        cylinder(rod_inner_depth + 2, inner_radius, inner_radius, $fn = 100);
    }
}

module board (length = 900) {
    translate([length / -2, 0, 0]) {
        difference() {
            translate([0, board_width / -2, 0]) {
                cube([length, board_width, board_thickness]);
            }

            translate([rod_offset, 0, 0]) board_hole();
            translate([length - rod_offset, 0, 0]) board_hole();

            translate([length / 2, 0, 0]) for (direction = [0 : 1]) rotate(direction * 180)
            translate([(slot_effective_length + slot_repeat_gap) / 2, 0, 0]) {
                for (offset = [0 : slot_effective_length + slot_repeat_gap : length / 2 - slot_offset - slot_effective_length / 2]) {
                    translate([offset, 0, 0]) board_slot();
                }
            }
        }
    }
}

board();