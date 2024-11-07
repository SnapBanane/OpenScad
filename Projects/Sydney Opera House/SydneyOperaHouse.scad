$fn=80;


difference() 
{
sphere(r=10);
translate([5,85,-40])
    sphere(r=100);
translate([-10,-10,-10])
    cube([10,10,11]);
}

