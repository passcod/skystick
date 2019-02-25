use <../minitub.scad>;

module parts () {
plate();

mirror([0, 0, 180]) translate([130, 80, -18]) rotate(-90)
    panel_back_inner();

translate([130, 190, 0]) rotate(-90)
    panel_back_outer();

mirror([0, 0, 180]) translate([280, 80, -18]) rotate(-90)
    panel_front_inner();

translate([280, 190, 0]) rotate(-90)
    panel_front_outer();

translate([0, 200, 0])
    panel_side_outer();

translate([230, 200, 0])
    panel_side_inner();

translate([0, 350, 0])
    panel_side_outer();

translate([230, 350, 0])
    panel_side_inner();
}

//projection(cut = true) translate([0,0, -10]) parts();
//projection(cut = true) translate([0,0, -1]) parts();
//projection(cut = true) translate([0,0, -16]) parts();
parts();