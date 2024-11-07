/*******************************************************************
*
** written by Julius Gerhardus
*
** aka SnapBanane
*
** ? purpose
*
** informatic lectures and 3d design usage
*
** ? date
*
** written on: 07.11.24
*
*******************************************************************/

module roundedgcube(x, y, z, ra) {
    union() {
        difference() {
            cube([x,y,z]);
        translate([-1,-0.1,-0.1])
            cube([x+2,ra+0.1,ra+0.1]);
        translate([-1,-0.1,z-ra])
            cube([x+2,ra+0.1,ra+0.1]);
        translate([-1,y-ra,z-ra])
            cube([x+2,ra+0.1,ra+0.1]);
        translate([-1,y-ra,-0.1])
            cube([x+2,ra+0.1,ra+0.1]);
        }
    }
    union() {
        translate([x,ra,ra]) rotate([0,-90,0]) //bottom left
            difference() {
                cylinder(h=x, r=ra);
                union() {
                    translate([0,-ra,-1])
                        cube([ra, ra*2, x+2]);
                    translate([-ra-1,0,-1])
                        cube([ra+2, ra, x+2]);
                }
            }
        translate([0,y-ra,ra]) rotate([180,-90,0]) //bottom right
            difference() {
                cylinder(h=x, r=ra);
                union() {
                    translate([0,-ra,-1])
                        cube([ra, ra*2, x+2]);
                    translate([-ra-1,0,-1])
                        cube([ra+2, ra, x+2]);
                }
            }
        translate([0,ra,z-ra]) rotate([0,90,0]) //top left
            difference() {
                cylinder(h=x, r=ra);
                union() {
                    translate([0,-ra,-1])
                        cube([ra, ra*2, x+2]);
                    translate([-ra-1,0,-1])
                        cube([ra+2, ra, x+2]);
                }
            }
        translate([x,y-ra,z-ra]) rotate([180,90,0]) //top right
            difference() {
                cylinder(h=x, r=ra);
                union() {
                    translate([0,-ra,-1])
                        cube([ra, ra*2, x+2]);
                    translate([-ra-1,0,-1])
                        cube([ra+2, ra, x+2]);
                }
            }
    }
}

/******************************************************************/
roundedgcube(40, 26, 12, 4);
/*******************************************************************
*
*   ? roundededgcube()
*
** usage:
** roundededgcube(x, y, z, edgeness);
*
** x = x of the cube
*
** y = y of the cube
*
** z = z of the cube
*
** edgeness = how round you want the edges (keep it low, between 
** 0-10 depending on the size of the cube)
*
******************************************************************/
$fn=50;
/******************************************************************
*
*   ? $fn
*
** how many faces you want the shape to have
*
******************************************************************/