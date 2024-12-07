standardfn=50;
$fn=standardfn; //renders with 50 faces per object
s1m=3.1; //multiplier for the shells
buffer=0.99; //universial 
buffer2=1.5; //buffer for the shell depth
radiuss1=10; //radius for the first shell
radiuss2=10; //radius for the second shell
radius=10;
color="#758C7C";
color2="#B6BCBD";
 
module shell1(radius) { // Renders a shell
    difference() {
        balls(radius);
        translate([0,0,-11]) 
            cube([20,20,15], center = true);
        translate([-10*s1m+5,0,-10])
            sphere(r=radius*s1m);
    }      
}
module cutout(radius) { //cutout to make the shell hollow
    color(color) {
        scale([0.9,0.9,0.9]) translate([6.5,0,0]) {
            intersection() {
                translate([-10*s1m,0,-10])
                    sphere(r=10*s1m);
                translate([-7,0,0])
                    shell1(radiuss2);
            }
        }
    }
}
module balls(ra) { //renders 2 balls in an intersection
    color(color2)
    intersection() {
            translate([0,ra / 2,0])
                sphere(r=ra);
            translate([0,-ra / 2,0])
                sphere(r=ra);
        }
}
module transition() {
    scale([0.39,0.39,0.39]) rotate([20,-5,30]) translate([-8,6,-18])
        union() {
            difference() {
                difference() {
                    sphere(20);
                    sphere(20-2);
                }
                rotate([0,0,45]) translate([-20,0,-20])
                    cube([40,40,40]);
                translate([0,-20,-20])
                    cube([40,40,40]);
                difference() {
                    sphere(30);
                    translate([-40,-40,10])
                        cube([80,80,80]);
                }
                translate([0,0,0])
                    cube([15,15,15]);
            }
        }
}
module f1inside(x) {
    translate([x,2.15,-1.5]) rotate([0,0,-15])
        cube([2,5,5], center=true);
    translate([x,-2.15,-1.5]) rotate([0,0,15])
        cube([2,5,5], center=true);
}
module f2inside(x) {
    translate([-1.7,0,-5.2]) rotate([0,45,0]) {
        translate([x,1.3,-1.5]) rotate([0,0,-15])
            cube([2,3.25,2], center=true);
        translate([x,-1.3,-1.5]) rotate([0,0,15])
            cube([2,3.25,2], center=true);
    }
    difference() {
        translate([x+15.6,0,2.1]) rotate([0,-15,0]) {
            difference() {
                cylinder(r=20, h=1, $fn=100);
                translate([x+10,0,0.5])
                    cube([40,42,1.6], center=true);
                translate([x-13,10,0.5]) rotate([0,0,120])
                    cube([10,10,1.6], center=true);
                translate([x-7.26,7,0.5]) rotate([0,0,20])
                    cube([10,10,1.6], center=true);
                mirror([0,1,0]) {
                    translate([x-13,10,0.5]) rotate([0,0,120])
                        cube([10,10,1.6], center=true);
                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                        cube([10,10,1.6], center=true);
                }
            }
        }
        translate([-10,-5.8,-3.8]) rotate([20,0,-7.5]) {
            color("#B8A693") cube([4,2,2]);
        }
        mirror([0,1,0])
            translate([-10,-5.8,-3.8]) rotate([20,0,-7.5]) {
                color("#B8A693") cube([4,2,2]);
            }
    }
}
module binside(x) {
    translate([x-0.5,-1,-4]) rotate([0,0,-5])
        color(color) cube([2,5,6]);
    translate([x,-5.5,-4]) rotate([0,-10,-5])
        color(color) cube([2,5,6]);
    translate([11.8,2,-3.25]) rotate([0,-90,85]) //triangle roof thingy -> transition
        color("#B8A693")
        linear_extrude(height=2.5)
            circle(r=0.5, $fn=3);
}
module binside_second_hall(x) {
    translate([x+0.9,0,-4]) rotate([0,-10,10])
        color(color) cube([2,5,6]);
    translate([x,-4.3,-4]) rotate([0,-10,-10])
        color(color) cube([2,5,6]);
    translate([13.23,-2.5,-3.277]) rotate([-90,0,10]) //triangle roof thingy -> transition
        color("#B8A693")
        linear_extrude(height=2.5)
            circle(r=0.5, $fn=3);
    translate([x+1,-2.9,-2.94]) rotate([0,0,10])
        color("#B8A693") cube([2,2.5,0.1]);
}
module roof() {
    difference() { //first shell
        color(color2) shell1(radiuss1);
        cutout(radiuss1-0.75);
        mirror([0,1,0]) {
            cutout(radiuss1-0.75);
        }
    }
    translate([-4,0,-3.4]) rotate([0,-2.5,0])
        difference() { //second shell
            color(color2) shell1(radiuss2);
            cutout(radiuss1-0.75);
            mirror([0,1,0]) {
                cutout(radiuss1-0.75);
            }
        }
    translate([-7.5,0,-6.5]) rotate([0,-5,0])
        difference() { //third shell
            color(color2) shell1(radiuss2);
            translate([0.79,0,0]) {
                cutout(radiuss1-0.75);
                mirror([0,1,0]) {
                    cutout(radiuss1-0.75);
                }
            }
        }
    translate([14,0,-6]) rotate([0,-5,180]) scale([1,0.8,1])
        difference() { //back shell (from biggest shell)
            color(color2) shell1(radiuss2);
            scale([0.9,0.9,0.9])
                balls(10);
        }
    scale([1,0.8,1]) translate([7.2,0,-2]) rotate([0,5,0])
            difference() { //first transition from biggest to middle shell / inside
                color(color2) mirror([1,0,0]) shell1(radiuss2);
                translate([4,0,4])
                    cube([13,13,13], center=true);  
            }
    scale([1,0.8,1]) translate([2,0,-5]) rotate([0,5,0])
            difference() { //second transition from middle to smallest shell / inside
                color(color2) mirror([1,0,0]) shell1(radiuss2);
                translate([4,0,4])
                    cube([13,13,13], center=true);  
            }
    color(color2) transition();              //transition bottom shell / sides
    mirror([0,1,0])  {                         
        color(color2) transition();
    }
    scale([1,1,1.25]) translate([5,-0.4,0]) { //transition top shell / sides
        translate([-0.1,0.3,1.5]) rotate([10,-3,6])
            color(color2) transition();
        mirror([0,1,0]) {
            translate([-0.1,-0.3,1.5]) rotate([10,-3,6]) 
                color(color2) transition();
       }
    }
    translate([10,0,-1]) {
        rotate([-15,20,-20]) translate([1,-1,-0.5]) scale([0.7,0.7,1]) {
            color(color2) transition();     //transition back shell left / sides
        }
        rotate([-5,-5,0]) translate([1.4,-0.7,0]) scale([0.7,0.7,1]) {
            color(color2) transition();     //transition back shell left/ sides
        }
    }
    translate([10,0,-1]) mirror([0,1,0]) {
        rotate([-15,20,-20]) translate([1,-1,-0.5]) scale([0.7,0.7,1]) {
            color(color2) transition();     //transition back shell right / sides
        }
        rotate([-5,-5,0]) translate([1.4,-0.7,0]) scale([0.7,0.7,1]) {
            color(color2) transition();     //transition back shell right/ sides
        }
    }
    color(color) {
        translate([0.5,0,0]) {
            intersection() {  //front shell inside
                translate([-8.5,0,-6]) scale([0.89,0.89,0.89])
                    balls(10);
                    f1inside(-6);
            }
            f2inside(-6);
        }
    }
}

module triangle() {
    color("#B8A693") intersection() {
        scale([0.1,0.1,0.1]) translate([790/4-46,105/4,-66/4-21.5]) rotate([0,0,7.5]) {
            rotate_extrude(angle=360, $fn=1000) {
                rotate([0, 0, 0]) {
                    translate([250,0,0])
                    polygon(points=[[0, 0], [1, 0], [0, 1]]);
                }
            }
        }
        translate([-10,-5.75,-4]) rotate([0,0,7.5])
            cube([2,7.99,1]);
    }
}

module fence() {
    translate([-1.8,4,-3])
    color("gray")
        for(i=[0:0.1:5.9]) {
            translate([0,i/2,0])
                cube([0.01,0.01,0.4]);
        }
    color("gray")
        translate([-1.8,4,-2.8]) cube([0.025,3,0.025]); 
}

module bottom(x, depth) {
        translate([0,0,-8.5]) rotate([0,0,0]) color("#B8A693"){ // top floor
            translate([2.5,0,4.3]) rotate([0,15,0])
                cube([2, 10, 2], center=true);
                translate([-0.2,0,4.525]) rotate([0,0,0])
                    cube([4, 10, 2], center=true);
            difference() {
                union() {
                    translate([-2.9,0,5]) rotate([0,15,0])
                        cube([3.5, 10, 2], center=true);
                    translate([-5.825,0,5.425]) rotate([0,0,0])
                        cube([3, 10, 2], center=true);
                    translate([-7.35,-5,3])
                        cube([12,10,2]);
                }
                    translate([-8,-6.3,2.5]) rotate([0,0,-7.5]) 
                        cube([7.5,2,4]);
                    translate([-8,4.25,2.5]) rotate([0,0,7.5]) 
                        cube([7.5,2,4]);        
            }
        }
    translate([0,-0.01,-1]) { // top floor
        difference() {
            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                color("#B8A693") difference() {
                    cylinder(r=20, h=2, $fn=100);
                    translate([x+10,0,1])
                        cube([40,42,4], center=true);
                    translate([x-13,10,0.5]) rotate([0,0,120])
                        cube([10,10,4], center=true);
                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                        cube([10,10,4], center=true);
                    mirror([0,1,0]) {
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                    }
                }
            }
            
            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([4,2,4]);
            }
            mirror([0,1,0]) {
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
            }
            translate([-0.1,0,1.9]) scale([0.9,0.9,0.9]){
                difference() { // top green inside
                    translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) {
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-5.25,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-5.25,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    
                    translate([-11,4,-6]) rotate([0,0,0])
                        cube([5,5,5]);
                    mirror([0,1,0]) {
                        translate([-11,4,-6]) rotate([0,0,0]) {
                            cube([5,5,5]);
                        }
                    }
                }
            }
        }
    }
    difference() { //middle cutout
        translate([0.5,-0.01,-1.75]) scale([1.1,1.1,1.1]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        translate([0.575,-0.01,-0.1]) scale([1.1,1.06,1]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        translate([-8.5,-4.56,-3.4]) rotate([0,25,-7.5]) {
            color("#B8A693") cube([2,0.4,0.9]);
        }
        translate([-8.5,-4.8,-3.3]) rotate([0,25,-7.5]) {
            color("#B8A693") cube([2,0.4,0.9]);
        }
        mirror([0,1,0]) {
            translate([-8.5,-4.56,-3.4]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.4,0.9]);
            }
            translate([-8.5,-4.8,-3.3]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.4,0.9]);
            }
        }
        translate([0.5,0,0.8]) {
            difference() { // middle green inside
                translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) {
                    difference() {
                        translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                            color(color) difference() {
                                cylinder(r=20, h=2, $fn=100);
                                translate([x+10,0,1])
                                    cube([40,42,4], center=true);
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                                mirror([0,1,0]) {
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                }
                            }
                        }
                        
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                        mirror([0,1,0]) {
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                        }
                    }
                }
                translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                    difference() {
                        translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                            color(color) difference() {
                                cylinder(r=20, h=2, $fn=100);
                                translate([x+10,0,1])
                                    cube([40,42,4], center=true);
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                                mirror([0,1,0]) {
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                }
                            }
                        }
                        
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                        mirror([0,1,0]) {
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                        }
                    }
                }
                
                translate([-11,4,-6]) rotate([0,0,0])
                    cube([5,5,5]);
                mirror([0,1,0]) {
                    translate([-11,4,-6]) rotate([0,0,0]) {
                        cube([5,5,5]);
                    }
                }
            }
        }
    }
    
    difference() { // bottom cutout 
        translate([0.55,-0.01,-2.25]) scale([1.15,1.15,1.15]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        color(color) cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        translate([0.25,-0.01,-0.65]) scale([1.1,1.125,1]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        difference() { // bottom green inside
            translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) color(color){
                difference() {
                    translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                        color(color) difference() {
                            cylinder(r=20, h=2, $fn=100);
                            translate([x+10,0,1])
                                cube([40,42,4], center=true);
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                            mirror([0,1,0]) {
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                            }
                        }
                    }
                    
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color(color) cube([4,2,4]);
                    }
                    mirror([0,1,0]) {
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                    }
                }
            }
            translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                difference() {
                    translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                        color(color) difference() {
                            cylinder(r=20, h=2, $fn=100);
                            translate([x+10,0,1])
                                cube([40,42,4], center=true);
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                            mirror([0,1,0]) {
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                            }
                        }
                    }
                    
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color(color) cube([4,2,4]);
                    }
                    mirror([0,1,0]) {
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                    }
                }
            }
            
            translate([-11,4,-6]) rotate([0,0,0])
                cube([5,5,5]);
            mirror([0,1,0]) {
                translate([-11,4,-6]) rotate([0,0,0]) {
                    cube([5,5,5]);
                }
            }
        }
    } // left stairset
    translate([-8.1,-4.6,-3.64999]) rotate([0,0,-7.5]) for(i = [0:0.05:1.15]) {
        translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.4,0.05]);
    }
    translate([1.4,-0.3,-1.7]) {
        translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,00.8,0.9]);
        }
        translate([-8.6,-4.8,-3.12]) rotate([0,25,-7.5]) {
            color("#B8A693") cube([2,0.12,0.9]);
        }
        translate([-8.8,-4.78,-3.35]) rotate([0,0,-7.5]) {
            color("#B8A693") cube([0.6,0.8,0.9]);
        }
        translate([-8.8,-4.78,-3.195]) rotate([0,0,-7.5]) {
            color("#B8A693") cube([0.6,0.12,0.9]);
        }
    }
    translate([-6.79,-5.1,-4.2]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
        translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
    } // right stairset
    mirror([0,1,0]) {
        translate([-8.1,-4.6,-3.64999]) rotate([0,0,-7.5]) for(i = [0:0.05:1.15]) {
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.4,0.05]);
        }
        translate([1.4,-0.3,-1.7]) {
            translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,00.8,0.9]);
            }
            translate([-8.6,-4.8,-3.12]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.12,0.9]);
            }
            translate([-8.8,-4.78,-3.35]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.8,0.9]);
            }
            translate([-8.8,-4.78,-3.195]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.12,0.9]);
            }
        }
        translate([-6.79,-5.1,-4.2]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
        }
    }
    // the triangle shaped roof at the front / top one
    rotate([0,0,-10])
        triangle();
    // bottom triangle roof thingy
    translate([-0.43,0,-0.8]) rotate([0,0,-10])
        triangle();
    
} 

module bottom_second_hall(x, depth) {
        translate([0,0,-8.5]) rotate([0,0,0]) color("#B8A693"){ // top floor
            translate([2.5,0,4.3]) rotate([0,15,0])
                cube([2, 10, 2], center=true);
                translate([-0.2,0,4.525]) rotate([0,0,0])
                    cube([4, 10, 2], center=true);
            difference() {
                union() {
                    translate([-2.9,0,5]) rotate([0,15,0])
                        cube([3.5, 10, 2], center=true);
                    translate([-5.825,0,5.425]) rotate([0,0,0])
                        cube([3, 10, 2], center=true);
                    translate([-7.35,-5,3])
                        cube([12,10,2]);
                }
                    translate([-8,-6.3,2.5]) rotate([0,0,-7.5]) 
                        cube([7.5,2,4]);
                    translate([-8,4.25,2.5]) rotate([0,0,7.5]) 
                        cube([7.5,2,4]);        
            }
        }
    translate([0,-0.01,-1]) { // top floor
        difference() {
            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                color("#B8A693") difference() {
                    cylinder(r=20, h=2, $fn=100);
                    translate([x+10,0,1])
                        cube([40,42,4], center=true);
                    translate([x-13,10,0.5]) rotate([0,0,120])
                        cube([10,10,4], center=true);
                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                        cube([10,10,4], center=true);
                    mirror([0,1,0]) {
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                    }
                }
            }
            
            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([4,2,4]);
            }
            mirror([0,1,0]) {
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
            }
            translate([-0.1,0,1.9]) scale([0.9,0.9,0.9]){
                difference() { // top green inside
                    translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) {
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-5.25,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-5.25,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    
                    translate([-11,4,-6]) rotate([0,0,0])
                        cube([5,5,5]);
                    mirror([0,1,0]) {
                        translate([-11,4,-6]) rotate([0,0,0]) {
                            cube([5,5,5]);
                        }
                    }
                }
            }
        }
    }
    /*
    #difference() { //middle cutout
        translate([0.5,-0.01,-1.75]) scale([1.1,1.1,1.1]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        translate([0.575,-0.01,-0.1]) scale([1.1,1.06,1]) {
            difference() {
                translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                    color("#B8A693") difference() {
                        cylinder(r=20, h=2, $fn=100);
                        translate([x+10,0,1])
                            cube([40,42,4], center=true);
                        translate([x-13,10,0.5]) rotate([0,0,120])
                            cube([10,10,4], center=true);
                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                            cube([10,10,4], center=true);
                        mirror([0,1,0]) {
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                        }
                    }
                }
                
                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([4,2,4]);
                }
                mirror([0,1,0]) {
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                }
            }
        }
        translate([-8.5,-4.56,-3.4]) rotate([0,25,-7.5]) {
            color("#B8A693") cube([2,0.4,0.9]);
        }
        translate([-8.5,-4.8,-3.3]) rotate([0,25,-7.5]) {
            color("#B8A693") cube([2,0.4,0.9]);
        }
        mirror([0,1,0]) {
            translate([-8.5,-4.56,-3.4]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.4,0.9]);
            }
            translate([-8.5,-4.8,-3.3]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.4,0.9]);
            }
        }
        translate([0.5,0,0.8]) {
            difference() { // middle green inside
                translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) {
                    difference() {
                        translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                            color(color) difference() {
                                cylinder(r=20, h=2, $fn=100);
                                translate([x+10,0,1])
                                    cube([40,42,4], center=true);
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                                mirror([0,1,0]) {
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                }
                            }
                        }
                        
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                        mirror([0,1,0]) {
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                        }
                    }
                }
                translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                    difference() {
                        translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                            color(color) difference() {
                                cylinder(r=20, h=2, $fn=100);
                                translate([x+10,0,1])
                                    cube([40,42,4], center=true);
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                                mirror([0,1,0]) {
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                }
                            }
                        }
                        
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color(color) cube([4,2,4]);
                        }
                        mirror([0,1,0]) {
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                        }
                    }
                }
                
                translate([-11,4,-6]) rotate([0,0,0])
                    cube([5,5,5]);
                mirror([0,1,0]) {
                    translate([-11,4,-6]) rotate([0,0,0]) {
                        cube([5,5,5]);
                    }
                }
            }
        }
    }
    */
    translate([0.5,0,0.5]) {
        difference() { // bottom cutout 
            translate([0.55,-0.01,-2.25]) scale([1.15,1.15,1.15]) {
                difference() {
                    translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                        color("#B8A693") difference() {
                            color(color) cylinder(r=20, h=2, $fn=100);
                            translate([x+10,0,1])
                                cube([40,42,4], center=true);
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                            mirror([0,1,0]) {
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                            }
                        }
                    }
                    
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                    mirror([0,1,0]) {
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color("#B8A693") cube([4,2,4]);
                        }
                    }
                }
            }
            translate([0.25,-0.01,-0.65]) scale([1.1,1.125,1]) {
                difference() {
                    translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                        color("#B8A693") difference() {
                            cylinder(r=20, h=2, $fn=100);
                            translate([x+10,0,1])
                                cube([40,42,4], center=true);
                            translate([x-13,10,0.5]) rotate([0,0,120])
                                cube([10,10,4], center=true);
                            translate([x-7.26,7,0.5]) rotate([0,0,20])
                                cube([10,10,4], center=true);
                            mirror([0,1,0]) {
                                translate([x-13,10,0.5]) rotate([0,0,120])
                                    cube([10,10,4], center=true);
                                translate([x-7.26,7,0.5]) rotate([0,0,20])
                                    cube([10,10,4], center=true);
                            }
                        }
                    }
                    
                    translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                        color("#B8A693") cube([4,2,4]);
                    }
                    mirror([0,1,0]) {
                        translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                            color("#B8A693") cube([4,2,4]);
                        }
                    }
                }
            }
            translate([0,0,-0.9]) {
                difference() { // bottom green inside
                    translate([0,-0.01,-3.1]) scale([1.1,1.125,1]) color(color){
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    translate([0.2,-0.01,-2.8]) scale([1.1,1.125,1]) {
                        difference() {
                            translate([x+16.75,0,-3.5]) rotate([0,0,0]) {
                                color(color) difference() {
                                    cylinder(r=20, h=2, $fn=100);
                                    translate([x+10,0,1])
                                        cube([40,42,4], center=true);
                                    translate([x-13,10,0.5]) rotate([0,0,120])
                                        cube([10,10,4], center=true);
                                    translate([x-7.26,7,0.5]) rotate([0,0,20])
                                        cube([10,10,4], center=true);
                                    mirror([0,1,0]) {
                                        translate([x-13,10,0.5]) rotate([0,0,120])
                                            cube([10,10,4], center=true);
                                        translate([x-7.26,7,0.5]) rotate([0,0,20])
                                            cube([10,10,4], center=true);
                                    }
                                }
                            }
                            
                            translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                color(color) cube([4,2,4]);
                            }
                            mirror([0,1,0]) {
                                translate([-10,-6.025,-5]) rotate([0,0,-7.5]) {
                                    color(color) cube([4,2,4]);
                                }
                            }
                        }
                    }
                    
                    translate([-11,4,-6]) rotate([0,0,0])
                        cube([5,5,5]);
                    mirror([0,1,0]) {
                        translate([-11,4,-6]) rotate([0,0,0]) {
                            cube([5,5,5]);
                        }
                    }
                }
            }
        }
    } 
    // left stairset
    //translate([-8.1,-4.6,-3.64999]) rotate([0,0,-7.5]) for(i = [0:0.05:1.15]) {
    //    translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.4,0.05]);
    //}
    translate([2.25,-0.25,0]) {
        translate([1.4,-0.3,-2.2]) {
            translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                    color("#B8A693") cube([2,00.8,0.9]);
            }
            translate([-8.6,-4.8,-3.12]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.12,0.9]);
            }
            translate([-8.8,-4.78,-3.35]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.8,0.9]);
            }
            translate([-8.8,-4.78,-3.195]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.12,0.9]);
            }
        }
        translate([-6.79,-5.1,-4.7]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
        }
    }
    translate([0.25,0,0.8]) {
        translate([1.4,-0.3,-2.2]) {
            translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                    color("#B8A693") cube([2,00.8,0.9]);
            }
            translate([-9.47,-4.65,-5]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.12,3]);
            
            }
            translate([-8.8,-4.76,-3.25]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.8,0.9]);
            }
            translate([-8.8,-4.76,-3.1]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.12,0.9]);
            }
        }
        translate([-6.79,-5.1,-4.7]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
        }
    }
    // right stairset
    mirror([0,1,0]) {
        //translate([-8.1,-4.6,-3.64999]) rotate([0,0,-7.5]) for(i = [0:0.05:1.15]) {
        //    translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.4,0.05]);
        //}
        translate([2.25,-0.25,0]) {
        translate([1.4,-0.3,-2.2]) {
            translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                    color("#B8A693") cube([2,00.8,0.9]);
            }
            translate([-8.6,-4.8,-3.12]) rotate([0,25,-7.5]) {
                color("#B8A693") cube([2,0.12,0.9]);
            }
            translate([-8.8,-4.78,-3.35]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.8,0.9]);
            }
            translate([-8.8,-4.78,-3.195]) rotate([0,0,-7.5]) {
                color("#B8A693") cube([0.6,0.12,0.9]);
            }
        }
        translate([-6.79,-5.1,-4.7]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
        }
        }
        translate([0.25,0,0.8]) {
            translate([1.4,-0.3,-2.2]) {
                translate([-8.57,-4.7,-3.26]) rotate([0,25,-7.5]) {
                        color("#B8A693") cube([2,00.8,0.9]);
                }
                translate([-9.47,-4.65,-5]) rotate([0,25,-7.5]) {
                    color("#B8A693") cube([2,0.12,3]);
                
                }
                translate([-8.8,-4.76,-3.25]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([0.6,0.8,0.9]);
                }
                translate([-8.8,-4.76,-3.1]) rotate([0,0,-7.5]) {
                    color("#B8A693") cube([0.6,0.12,0.9]);
                }
            }
            translate([-6.79,-5.1,-4.7]) rotate([0,0,-7.5]) for(i = [0:0.05:1.85]) {
                translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,0.8,0.05]);
            }
        }
    }
    // the triangle shaped roof at the front / top one
    // rotate([0,0,-10])
    //    triangle();
    // bottom triangle roof thingy
    translate([0.07,0,-1.2]) rotate([0,0,-10])
        triangle();
} 

module ground() {
    difference() {
        translate([7,2.5,-6]) rotate([0,0,90]) //bottom plate
            color("#6D675A") cube([22.5,35,2], center=true);
        translate([-9,14,-6]) rotate([0,0,0]) 
            color("#6D675A") cube([6,6,3], center=true);
    }
    translate([-7,3,-7]) rotate([0,0,0]) //cylinder
        color("#6D675A") cylinder(h=2, r=10, $fn=100);
    translate([0,-4.45,-5.6]) rotate([0,0,0]) //ground plate 
        color("#B8A693") cube([15,17.75,2]);
    translate([0,-4.45,-3.6]) rotate([0,0,0]) //ground plate / top part
        color("#6D675A") cube([15,17.75,0.1]);
    translate([-8,12.1,-6]) rotate([0,0,24]) //cylinder addon
        color("#6D675A") cube([6,2.5,2], center=true);
    translate([-3.725,13,-6]) rotate([0,0,0]) //ground plate addon
        color("#6D675A") cube([7.5,4,2], center=true);
    translate([4.7,12.365,-6]) rotate([0,0,-7.5]) //ground plate addon
        color("#6D675A") cube([10,4,2], center=true);
    translate([15,6.3,-3.55]) rotate([0,0,0]) { //stairsset -> second hall
        for(i = [0:0.05:0.7]) {
            translate([0+i,0,0-i/3]) color("#B8A693") cube([0.05,7,0.05]);
        }
        translate([0.7,0,-0.7/3])
            color("#B8A693") cube([0.25,7,0.05]);
        translate([0.7+0.25,0,-0.7/3]) {
            for(i = [0:0.05:0.7]) {
                translate([0+i,0,0-i/3]) color("#B8A693") cube([0.05,7,0.05]);
            }
        }
    }  
    translate([-0.65,5.5,-4.45]) //transition between the two halls in the middle
        color("#B8A693") cube([2.5,3,3], center=true);
    translate([-1.9,7,-3.5]) rotate([0,-90,90]) //triangle roof thingy -> transition
        color("#B8A693")
        linear_extrude(height=3)
            circle(r=0.5, $fn=3);
    translate([0.6,4,-3]) for(i = [0:0.05:1.85]) //stairs back -> transition
            translate([0+i,0,0-i/2.2]) color("#B8A693") cube([0.05,3,0.05]);
    fence(); //fencing in the transition
        
}
module hall1() {
    difference() {
        roof();
        translate([0,0,-8.5]) rotate([0,0,0]) {
            cube([30,20,10], center=true);
            translate([2.5,0,4.3]) rotate([0,15,0])
                cube([2, 20, 2], center=true);
            translate([-3.2,0,4.525]) rotate([0,0,0])
                cube([10, 20, 2], center=true);
            translate([-2.9,0,5]) rotate([0,15,0])
                cube([3.5, 20, 2], center=true);
            translate([-5.825,0,5.425]) rotate([0,0,0])
                cube([3, 20, 2], center=true);
        }
    } 
    difference() {
        bottom(-6,1);
        translate([0,3.1,-4.5]) //adjust for stairs
            cube([5,2,2]);
    }
    intersection() { //back shell inside
        binside(10);
        translate([14,0,-6]) scale([0.89,0.79,0.89])
            balls(10);
    }
}

module hall2() {
    difference() {
        roof();
        translate([0,0,-8.5]) rotate([0,0,0]) {
            cube([30,20,10], center=true);
            translate([2.5,0,4.3]) rotate([0,15,0])
                cube([2, 20, 2], center=true);
            translate([-3.2,0,4.525]) rotate([0,0,0])
                cube([10, 20, 2], center=true);
            translate([-2.9,0,5]) rotate([0,15,0])
                cube([3.5, 20, 2], center=true);
            translate([-5.825,0,5.425]) rotate([0,0,0])
                cube([3, 20, 2], center=true);
        }
    } 
    bottom_second_hall(-6,1);
    intersection() { //back shell inside
        binside_second_hall(10);
        translate([14,0,-6]) scale([0.89,0.79,0.89])
            balls(10);
    }
}

rotate([0,0,10])
    hall1();

rotate([0,0,-10]) translate([-2.5,9.5,-1.2]) scale([0.7,0.7,0.7])
    hall2();

ground();