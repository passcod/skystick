include <board.scad>;

module rod (height, diameter) {
    radius = diameter / 2;
    
}

inner_space = 100;
board_length = 900;
spacing_from_center = inner_space / 2 + board_thickness;

rod_size = 6;
nut_height = 6;
nut_outer_diameter = 14.5;

// tie rods
for (way = [-1 : 2 : 1])
    translate([way * (board_length / 2 - rod_offset), spacing_from_center, 0])
        rotate([90])
            cylinder(inner_space + board_thickness * 2, rod_size / 2, rod_size / 2, $fn = 20);

// nuts
for (way = [-1 : 2 : 1]) for (side = [-1 : 2 : 1])
    translate([
        way * (board_length / 2 - rod_offset),
        side * spacing_from_center + (side - 1) * nut_height / -2, 0
    ]) rotate([90])
        cylinder(nut_height, nut_outer_diameter / 2, nut_outer_diameter / 2, $fn = 6);

// slats
rotate([0, 0, 90]) for (direction = [0 : 1])
    translate([-24, sin(slot_angle) * (2 * direction - 1) * slat_thickness / -2, slat_thickness / -2]) rotate([direction * 180])
        translate([(slot_effective_length + slot_repeat_gap) / 2, 0, 0])
            for (offset = [
                30 :
                slot_effective_length + slot_repeat_gap :
                board_length / 2 - slot_offset - slot_effective_length / 2
            ]) translate([0, offset, 0]) rotate([slot_angle]) {
                translate([0, slot_gap, 0]) slat();
                translate([0, -2*slot_gap, 0]) slat();
            }

// boards
translate([0, spacing_from_center, 0]) rotate([90]) mirror() board(board_length);
translate([0, -spacing_from_center, 0]) rotate([-90]) board(board_length);