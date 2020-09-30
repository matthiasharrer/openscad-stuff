$fn=100;

width = 50;
depth = 50;
height = 60;
inset = 2;

bottom = 1.2;
wall = 0.8;

edge_radius = 3;

module basedrawing(width, depth, edge_radius) {
    hull() {
        translate([width / 2- edge_radius, depth  / 2- edge_radius,0]) circle(r=edge_radius);
        translate([-width / 2 + edge_radius, depth  / 2- edge_radius,0]) circle(r=edge_radius);
        translate([width / 2- edge_radius, -depth  / 2 + edge_radius,0]) circle(r=edge_radius);
        translate([-width / 2 + edge_radius, -depth  / 2 + edge_radius,0]) circle(r=edge_radius);
    }
}

module bottom(width, depth, inset, edge_radius) {    
    basedrawing(width - 2 * inset, depth - 2 * inset, edge_radius);
}


module base(width, depth, inset, edge_radius) {
     linear_extrude(height=height, scale=[width / (width - 2 * inset),depth / (depth- 2 * inset)]) {
         bottom(width, depth, inset, edge_radius);
     }
}

module sign_holder() {
    sign_depth = 12;
    sign_width = 25;
    sign_radius = 2;
    sign_height = 10;
    
    offset = inset / height * sign_height;
    
    translate([0, depth / 2, height]) rotate([0, 180, 180]) translate([0, offset]) linear_extrude(height=10, scale=[0,0]) translate([0,-offset]) {
        hull() {
                translate([-sign_width / 2 + sign_radius, sign_depth-sign_radius]) circle(r=sign_radius);
                translate([sign_width / 2 - sign_radius, sign_depth-sign_radius]) circle(r=sign_radius);
                translate([-sign_width / 2, 0]) square([sign_width, sign_depth - sign_radius]);
        }
   }
}


module container() {
    difference() {
        base(width, depth, inset, edge_radius);
        difference() {
            base(width - 2 * wall, depth - 2 * wall, inset, edge_radius);
            cube([width, depth, bottom], true);
        }
    }
}

union() {
    container();
    sign_holder();
}