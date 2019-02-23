use <../minitub.scad>;

plate();

mirror([0, 0, 180]) translate([160, 0, -18])
    panel_back_inner();

translate([150, 110, 0])
    panel_back_outer();

mirror([0, 0, 180]) translate([280, 0, -18])
    panel_front_inner();

translate([270, 110, 0])
    panel_front_outer();

translate([0, 220, 0])
    panel_side_outer();

translate([230, 220, 0])
    panel_side_inner();

translate([0, 320, 0])
    panel_side_outer();

translate([230, 320, 0])
    panel_side_inner();
