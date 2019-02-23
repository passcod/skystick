// all parts for one stick

include <board.scad>;

board_length = 900;

translate([board_length / 2, board_width / 2, 0]) {
    board(board_length);
translate([0, board_width + 50]) {
    mirror() board(board_length);
translate([(-board_length + slat_width) / 2, board_width + 50]) rotate(90) {
    for (w = [0 : 1]) {
        for (n = [0 : 16]) translate([w * (slat_outer_length + 20), -n * (slat_width + 20), 0]) slat();
    }
translate([slat_outer_length / -3, -17 * (slat_width + 20), 0]) {
    for (offset = [1 : 4]) translate([0, offset * -30, 0])
    difference() {
        union () {
            cylinder(2, 14.5/2, 14/2, $fn = 20);
            translate([0, 0, 2]) cylinder(2, 14/2, 10/2, $fn = 20);
            translate([0, 0, 4]) cylinder(6, 10/2, 10/2, $fn = 6);
        }
        
        translate([0, 0, -1]) cylinder(12, 6/2, 6/2, $fn = 20);
    }
translate([60, -slat_width - 20, 0]) {
    for (offset = [0 : 1]) translate([0, offset * -30, 0])
        rotate([0, 90]) cylinder(100 + board_thickness * 2, 6/2, 6/2, $fn = 20);
} } } } }