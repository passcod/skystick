// pinetrim 230x18mm
// 110mm plate - 10mm gap - 110mm plate

inner_width = 40;
inner_length = 120;
inner_height = 50;

waterline = 20;
back_flashing_thickness = 5;

// predrill holes diameter
prehole = 2;

groove_depth = 9;
groove_width = 9;
seal_thickness = 3; // 4mm real
sealed_groove_depth = groove_depth - seal_thickness;

panel_thickness = groove_depth * 2;

outer_width = inner_width + panel_thickness * 4;
outer_length = inner_length + panel_thickness * 4;
outer_height = inner_height + groove_depth + waterline;

module plate () {
    difference() {
        // plate
        cube([outer_width, outer_length, panel_thickness]);
        
        // outer sides grooves
        translate([groove_width, 0, groove_depth])
            cube([groove_width, outer_length, groove_depth]);
        translate([outer_width - groove_width * 2, 0, groove_depth])
            cube([groove_width, outer_length, groove_depth]);
        
        // inner sides grooves
        translate([groove_width * 3, panel_thickness, groove_depth])
            cube([groove_width, outer_length - panel_thickness * 2, groove_depth]);
        translate([outer_width - groove_width * 4, panel_thickness, groove_depth])
            cube([groove_width, outer_length - panel_thickness * 2, groove_depth]);
        
        // outer ends grooves
        translate([groove_width, 0, groove_depth])
            cube([outer_width - groove_width * 2, groove_width, groove_depth]);
        translate([groove_width, outer_length - groove_width, groove_depth])
            cube([outer_width - groove_width * 2, groove_width, groove_depth]);
        
        // inner ends grooves
        translate([groove_width * 3, groove_width * 2, groove_depth])
            cube([outer_width - groove_width * 7, groove_width, groove_depth]);
        translate([groove_width * 3, outer_length - groove_width * 3, groove_depth])
            cube([outer_width - groove_width * 7, groove_width, groove_depth]);
    }
}

module panel_front_outer () {
    difference() {
        panel_width = outer_width - groove_width * 2;

        // panel
        cube([panel_width, outer_height, panel_thickness]);

        // bottom groove
        cube([panel_width, groove_depth, groove_width]);
        
        // side grooves
        translate([0, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([panel_width - groove_width, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);

        // preholes
        translate([panel_width / 3, outer_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
        translate([panel_width * 2 / 3, outer_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
    }
}


module panel_back_outer () {
    difference() {
        panel_width = outer_width - groove_width * 2;
        panel_height = outer_height - waterline - back_flashing_thickness;

        // panel
        cube([panel_width, panel_height, panel_thickness]);

        // bottom groove
        cube([panel_width, groove_depth, groove_width]);
        
        // side grooves
        translate([0, 0, groove_width])
            cube([groove_width, panel_height + groove_width, groove_width]);
        translate([panel_width - groove_width, 0, groove_width])
            cube([groove_width, panel_height + groove_width, groove_width]);

        // preholes
        translate([panel_width / 3, panel_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
        translate([panel_width * 2 / 3, panel_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
    }
}

module panel_side_outer () {
    difference() {
        // panel
        cube([outer_length, outer_height, panel_thickness]);
        
        // bottom groove
        cube([outer_length, groove_depth, groove_width]);
        
        // side grooves
        translate([groove_width, groove_depth, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([outer_length - groove_width * 2, groove_depth, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);
    }
}












// for reference
translate([0, 0, -panel_thickness * 2.2]) plate();

rotate([90, 0, 0]) translate([groove_width, -groove_depth, -panel_thickness])
    panel_front_outer();

rotate([90, 0, 90]) translate([0, -groove_depth, -panel_thickness])
    panel_side_outer();

rotate([90, 0, 270]) translate([-outer_length, -groove_depth, -panel_thickness - outer_width])
    panel_side_outer();

rotate([90, 0, 180]) translate([-outer_width + groove_width, -groove_depth, outer_length - panel_thickness])
    panel_back_outer();

/* */






