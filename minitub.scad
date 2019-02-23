// pinetrim 230x18mm
// 110mm plate - 10mm gap - 110mm plate

inner_width = 40;
inner_length = 120;
inner_height = 110;

waterline = 20;
back_flashing_thickness = 5;

echo("Volume inside", 0.001 * inner_width * inner_length * (inner_height - waterline), "mL");

// predrill holes diameter
prehole = 2;

// carrier holes diameter and spacings (center to center)
carrier_hole = 8;
carrier_width_np2 = 35.4;
carrier_width_itx = 94;

// openings
opening_inner = 16;
opening_outer = opening_inner - 6;
intake_height = 5; // above the floor
comms_depths = [-10, 15, 40, 65]; // below the waterline

groove_depth = 9;
groove_width = 9;
seal_thickness = 3; // 4mm real
sealed_groove_depth = groove_depth + seal_thickness;

panel_thickness = groove_depth * 2;

outer_width = inner_width + panel_thickness * 4;
outer_length = inner_length + panel_thickness * 4;
outer_height = inner_height + groove_depth + waterline;

module plate () {
    difference() {
        // plate
        cube([outer_width, outer_length, panel_thickness]);

        // outer sides grooves
        translate([groove_width, panel_thickness, groove_depth])
            cube([groove_width, outer_length - panel_thickness * 2, groove_depth]);
        translate([outer_width - groove_width * 2, panel_thickness, groove_depth])
            cube([groove_width, outer_length - panel_thickness * 2, groove_depth]);

        // inner sides grooves
        translate([groove_width * 3, panel_thickness * 2, groove_depth - seal_thickness])
            cube([groove_width, outer_length - panel_thickness * 4, sealed_groove_depth]);
        translate([outer_width - groove_width * 4, panel_thickness * 2, groove_depth - seal_thickness])
            cube([groove_width, outer_length - panel_thickness * 4, sealed_groove_depth]);

        // outer ends grooves
        translate([panel_thickness, 0, groove_depth])
            cube([outer_width - panel_thickness * 2, groove_width, groove_depth]);
        translate([panel_thickness, outer_length - groove_width, groove_depth])
            cube([outer_width - panel_thickness * 2, groove_width, groove_depth]);

        // inner ends grooves
        translate([groove_width * 3, groove_width * 2, groove_depth - seal_thickness])
            cube([outer_width - groove_width * 6, groove_width, sealed_groove_depth]);
        translate([groove_width * 3, outer_length - groove_width * 3, groove_depth - seal_thickness])
            cube([outer_width - groove_width * 6, groove_width, sealed_groove_depth]);
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
        translate([panel_width * 2 / 5, outer_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
        translate([panel_width * 3 / 5, outer_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);

        // eth & pow & etc
        for (h = comms_depths)
            translate([
                panel_width / 2,
                groove_depth * 2 + (inner_height - waterline - carrier_hole - h) + opening_outer / 2,
                0
            ]) cylinder(panel_thickness, opening_outer / 2, opening_outer / 2, $fn = 20);
    }
}

module panel_front_inner () {
    difference() {
        panel_width = outer_width - panel_thickness * 2;
        panel_inner_height = outer_height - groove_depth;

        // panel
        cube([panel_width, outer_height, panel_thickness]);

        // top notch
        translate([panel_thickness, panel_inner_height, 0])
            cube([panel_width - panel_thickness * 2, groove_depth, panel_thickness]);

        // bottom groove
        cube([panel_width, groove_depth, groove_width]);

        // side grooves
        translate([0, 0, 0])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([panel_width - groove_width, 0, 0])
            cube([groove_width, outer_height + groove_width, groove_width]);

        // bottom corners
        translate([0, 0, groove_width])
            cube([groove_width, groove_depth, groove_width]);
        translate([panel_width - groove_width, 0, groove_width])
            cube([groove_width, groove_depth, groove_width]);

        // eth & pow & etc
        for (h = comms_depths)
            translate([
                panel_width / 2,
                groove_depth * 2 + (inner_height - waterline - carrier_hole - h) + opening_outer / 2,
                0
            ]) cylinder(panel_thickness, opening_inner / 2, opening_inner / 2, $fn = 20);
    }
}

module panel_back_outer () {
    difference() {
        panel_width = outer_width - groove_width * 2;
        panel_inner_height = outer_height - waterline - back_flashing_thickness;

        // panel
        cube([panel_width, outer_height, panel_thickness]);

        // top notch
        translate([panel_thickness + groove_width, panel_inner_height, 0])
            cube([panel_width - panel_thickness * 2 - groove_width * 2, outer_height - panel_inner_height, panel_thickness]);

        // bottom groove
        cube([panel_width, groove_depth, groove_width]);

        // side grooves
        translate([0, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([panel_width - groove_width, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);

        // preholes
        translate([panel_width * 2 / 5, panel_inner_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);
        translate([panel_width * 3 / 5, panel_inner_height - groove_depth / 2, 0])
            cylinder(panel_thickness / 2, prehole / 2, prehole / 2, $fn = 20);

        // intake
        translate([panel_width / 2, groove_depth * 2 + intake_height + opening_outer / 2, 0])
            cylinder(panel_thickness, opening_outer / 2, opening_outer / 2, $fn = 20);
    }
}

module panel_back_inner () {
    difference() {
        panel_width = outer_width - panel_thickness * 2;
        panel_inner_height = outer_height - waterline - back_flashing_thickness - groove_depth;

        // panel
        cube([panel_width, outer_height, panel_thickness]);

        // top notch
        translate([panel_thickness, panel_inner_height, 0])
            cube([panel_width - panel_thickness * 2, outer_height - panel_inner_height, panel_thickness]);

        // bottom groove
        cube([panel_width, groove_depth, groove_width]);

        // side grooves
        translate([0, 0, 0])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([panel_width - groove_width, 0, 0])
            cube([groove_width, outer_height + groove_width, groove_width]);

        // bottom corners
        translate([0, 0, groove_width])
            cube([groove_width, groove_depth, groove_width]);
        translate([panel_width - groove_width, 0, groove_width])
            cube([groove_width, groove_depth, groove_width]);

        // intake
        translate([panel_width / 2, groove_depth * 2 + intake_height + opening_outer / 2, 0])
            cylinder(panel_thickness, opening_inner / 2, opening_inner / 2, $fn = 20);
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

        // seal grooves
        translate([groove_width * 2, groove_depth, panel_thickness - seal_thickness])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([outer_length - groove_width * 3, groove_depth, panel_thickness - seal_thickness])
            cube([groove_width, outer_height + groove_width, groove_width]);

        // bottom corners
        translate([0, 0, groove_width])
            cube([panel_thickness, groove_depth, groove_width]);
        translate([outer_length - panel_thickness, 0, groove_width])
            cube([panel_thickness, groove_depth, groove_width]);
    }
}

module panel_side_inner () {
    difference() {
        panel_length = outer_length - panel_thickness * 2 - groove_width * 2;
        // panel
        cube([panel_length, outer_height, panel_thickness]);

        // bottom groove
        cube([panel_length, groove_depth, groove_width]);

        // side grooves
        translate([0, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);
        translate([panel_length - groove_width, 0, groove_width])
            cube([groove_width, outer_height + groove_width, groove_width]);

        for (d = [
            // NEO Plus 2
            carrier_width_np2 / 2,
            carrier_width_np2 / -2,

            // pico-ITX for APL1
            carrier_width_itx / 2,
            carrier_width_itx / -2
        ]) translate([
                panel_length / 2 + d - carrier_hole / 2,
                outer_height - waterline - carrier_hole * 1.5,
                panel_thickness / 3
            ]) {
                cube([carrier_hole, waterline + carrier_hole * 1.5, panel_thickness * 2 / 3]);
                translate([carrier_hole / 2, 0, 0])
                    cylinder(panel_thickness * 2 / 3, carrier_hole / 2, carrier_hole / 2, $fn = 20);
            }
    }
}







// in place
if (false) {
    plate();

    rotate([90, 0, 0]) translate([groove_width, 0, -panel_thickness])
        panel_front_outer();

    rotate([90, 0, 0]) translate([groove_width * 2, 0, -panel_thickness * 2])
        panel_front_inner();

    rotate([90, 0, 90]) translate([0, 0, 0])
        panel_side_outer();

    rotate([90, 0, 270]) translate([-outer_length, 0, -outer_width])
        panel_side_outer();

    rotate([90, 0, 90]) translate([panel_thickness + groove_width, 0, panel_thickness])
        panel_side_inner();

    rotate([90, 0, 270]) translate([panel_thickness + groove_width - outer_length, 0, panel_thickness - outer_width])
        panel_side_inner();

    rotate([90, 0, 180]) translate([-outer_width + groove_width, 0, outer_length - panel_thickness])
        panel_back_outer();

    rotate([90, 0, 180]) translate([-outer_width + groove_width * 2, 0, outer_length - panel_thickness * 2])
        panel_back_inner();
}

// exploded
else if (true) {
    translate([0, 0, -panel_thickness * 2.2]) plate();

    rotate([90, 0, 0]) translate([groove_width, -groove_depth, -groove_width * 1.5])
        panel_front_outer();

    rotate([90, 0, 0]) translate([groove_width * 2, -groove_depth, -panel_thickness * 1.9])
        panel_front_inner();

    rotate([90, 0, 90]) translate([0, -groove_depth, -panel_thickness / 1.5])
        panel_side_outer();

    rotate([90, 0, 270]) translate([-outer_length, -groove_depth, -panel_thickness/1.5 - outer_width])
        panel_side_outer();

    rotate([90, 0, 90]) translate([panel_thickness + groove_width, -groove_depth, groove_width * 1.5])
        panel_side_inner();

    rotate([90, 0, 270]) translate([panel_thickness + groove_width - outer_length, -groove_depth, groove_width * 1.5 - outer_width])
        panel_side_inner();

    rotate([90, 0, 180]) translate([-outer_width + groove_width, -groove_depth, outer_length - groove_width * 3/2])
        panel_back_outer();

    rotate([90, 0, 180]) translate([-outer_width + groove_width * 2, -groove_depth, outer_length - panel_thickness * 1.9])
        panel_back_inner();
}
