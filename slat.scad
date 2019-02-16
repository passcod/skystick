module hole (offset) {
    radius = 3;
    translate([offset, 0, -10]) {
        color("white") cylinder(20, radius, radius, $fn=100);
    }
}

module slat () {
    translate([-60, -16, 0]) {
        // from pinetrim 32x40mm, cut longitudinally
        color("violet") cube([120, 32, 4]);
    }
}

difference() {
    slat();
    hole(20);
    hole(-20);
}