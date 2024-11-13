$fn=50; //renders with 80 faces per object
s1m=3.1; //multiplier for the first shell
buffer=0.99; //universial 
buffer2=1.5; //buffer for the shell deth
radiuss1=10; //radius for the first shell
radiuss2=10; //radius for the first shell
radius=10;

module shell1(radius) { // Renders a shell
    difference() {
    balls(radius);
    translate([0,0,-11]) //adjust here for scaling 
        cube([20,20,15], center = true);
    translate([-10*s1m+5,0,-10]) //adjust here for scaling
        sphere(r=radius*s1m);
    
    }      
}

module cutout(radius) { //cutout to make the shell hollow
    /*
        difference() {
             translate([0,-radius/2,0])
            sphere(radius);
            translate([0,-radius-0.5000001,0]) //half the cube
                cube([radius*2+buffer,radius*2+buffer,radius*2+buffer], center=true);
            translate([radius/2+buffer2,radius/2,0])//quarter the cube
                cube([radius,radius,radius*2], center=true);
        }
        */
        scale([0.9,0.9,0.9]) translate([6.5,0,0]) {
            intersection() {
                translate([-10*s1m,0,-10])
                    sphere(r=10*s1m);
                translate([-7,0,0])
                    shell1(radiuss2);
            }
        }
    
}

module balls(ra) { //renders 2 balls in an intersection
    intersection() {
            translate([0,ra / 2,0])
                sphere(r=ra);
            translate([0,-ra / 2,0])
                sphere(r=ra);
                
        }
}

module transition() {
    scale([0.39,0.39,0.39]) rotate([20,-5,30]) translate([-9,6,-18])
    union() {
        difference() {
            difference() {
                sphere(20);
                sphere(20-1);
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

module roof() {
    difference() { //first shell
        color("gray") shell1(radiuss1);
        cutout(radiuss1-0.75);
        mirror([0,1,0]) {
            cutout(radiuss1-0.75);
        }
    }
    translate([-4,0,-3.4]) rotate([0,-2.5,0])
        difference() { //second shell
            color("gray") shell1(radiuss2);
            cutout(radiuss1-0.75);
            mirror([0,1,0]) {
                cutout(radiuss1-0.75);
            }
        }
    translate([-8.5,0,-6]) rotate([0,-5,0])
        difference() { //second shell
            color("gray") shell1(radiuss2);
            cutout(radiuss1-0.75);
            mirror([0,1,0]) {
                cutout(radiuss1-0.75);
            }
        }
    scale([1,0.8,1]) translate([7.2,0,-2]) rotate([0,5,0])
            difference() { //first transition from biggest to middle shell
                color("gray") mirror([1,0,0]) shell1(radiuss2);
                translate([4,0,4])
                    cube([13,13,13], center=true);  
            }
            
    scale([1,0.8,1]) translate([1,0,-5]) rotate([0,5,0])
            difference() { //second transition from middle to smallest shell
                color("gray") mirror([1,0,0]) shell1(radiuss2);
                translate([4,0,4])
                    cube([13,13,13], center=true);  
            }
    color("gray") transition();
        
}

difference() {
roof();
translate([0,0,-8.5]) rotate([0,0,0]) {
    cube([30,20,10], center=true);
    }
}