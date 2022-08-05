// SCAD file for two part clip togetehr roller

innerDia    = 10.0;
outerDia    = 16.0;
clipDia     = 14.5;
height      = 25.0;
overHangDeg = 22.0;
edge        = 5.0;
slotWidth   = 1.5;
slotHeight  = 3.0;
slotDepth   = 2.0;

$fn = 60;

tolerance = 0.1;
slop      = 0.2;   // a little bit extra so that differences() make clean holes 

//half a cylinder with clips protruding

module clip1() {
  difference() {
    union() {
        // main body
        sector(height, outerDia, 90, 270);
 
        // add clips
        translate([0,0,edge]) 
          sector(height-edge*2, outerDia, 90-overHangDeg, 270+overHangDeg);
    }

    // subtract inner hole
    translate([0,0,-slop])
      cylinder(height+2*slop, d=innerDia);

    // subtract most of clips leaving just thin clips.
    translate([0,0,-slop])
      sector(height+2*slop, clipDia, 270, 90);
    
    // subtract screwdriver slot for separating halves
    translate([0,clipDia/2, height-edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,-clipDia/2, height-edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,clipDia/2, edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,-clipDia/2, edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    


  }
}

// --------------------------------------------------------------------------
// half a cylinder with recesses to receive clips from other half
// --------------------------------------------------------------------------

module clip2() {
  difference() {
    union () {
      // main body but thinner - as clip diameter
      sector(height, clipDia, 90, 270);

      // top ring to full diameter
      translate([0,0,height-edge]) 
        sector(edge, outerDia, 90, 270);

      // bottom ring to full diameter
      sector(edge, outerDia, 90, 270);

      // fill most of centre ring to full diameter but leave slot recesses
      translate([0,0,edge]) 
        sector(height-edge*2, outerDia, 90+overHangDeg, 270-overHangDeg);

    }
    // subtract hole through middle
    translate([0,0,-slop])
      cylinder(height+2*slop, d=innerDia);
    
    // subtract screwdriver slot for separating halves
    translate([0,clipDia/2, height-edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,-clipDia/2, height-edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,clipDia/2, edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    

    // subtract screwdriver slot for separating halves
    translate([0,-clipDia/2, edge/2])
      cube([slotWidth, slotDepth, slotHeight], center=true);    
  }
}

clip1();
rotate ([0,0,180]) translate([-10,0,0]) clip2();

module sector(h, d, a1, a2) {
    if (a2 - a1 > 180) {
        difference() {
            cylinder(h=h, d=d);
            translate([0,0,-0.5]) sector(h+1, d+1, a2-360, a1); 
        }
    } else {
        difference() {
            cylinder(h=h, d=d);
            rotate([0,0,a1]) translate([-d/2, -d/2, -0.5])
                cube([d, d/2, h+1]);
            rotate([0,0,a2]) translate([-d/2, 0, -0.5])
                cube([d, d/2, h+1]);
        }
    }
} 