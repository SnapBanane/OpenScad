$fn=50; //renders with 50 faces per object
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
}
module binside(x) {
    translate([x-0.5,-1,-4]) rotate([0,0,-5])
        cube([2,5,6]);
    translate([x,-5.5,-4]) rotate([0,-10,-5])
        cube([2,5,6]);
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
    
    color(color)  {
        intersection() { //back shell inside
            binside(10);
                translate([14,0,-6]) scale([0.89,0.79,0.89])
                    balls(10);
        }
    }
}
 
module bottom() {
    translate([0,0,-8.5]) rotate([0,0,0]) color("#B8A693"){
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
                }
                translate([-8,-6.3,2.5]) rotate([0,0,-7.5]) {
                        cube([7.5,2,4]);     
                }
           }
    }
} 

module ground() {
     difference() {
        translate([7,2.5,-6]) rotate([0,0,90]) //bottom plate
            color("#6D675A") cube([22.5,35,2], center=true);
        translate([-9,14,-6]) rotate([0,0,0]) 
            color("#6D675A") cube([6,6,3], center=true);
     }
     translate([-7,3,-7]) rotate([0,0,0])
        color("#6D675A") cylinder(h=2, r=9, $fn=100);
     translate([0,-4.45,-5.5]) rotate([0,0,0]) 
        color("#B8A693") cube([15,17.75,2]);
     translate([-6,11.28,-6]) rotate([0,0,15])
        color("#6D675A") cube([6,2.5,2], center=true);
     translate([-3,12.5,-6]) rotate([0,0,0])
        color("#6D675A") cube([6,4,2], center=true);
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
    
    bottom();
}

rotate([0,0,10])
    hall1();
rotate([0,0,-10]) translate([-2.5,10,-1]) scale([0.7,0.7,0.7])
    hall1();
ground();