$fn=36;

PsTopPlate();
PsRearPlate();
PsFrontPlate();

//PRINT EXPORT
//PsTopPlate();
//rotate([0,-90,0]) PsRearPlate();   
//rotate([0,90,0]) PsFrontPlate();
//END PRINT

module PsTopPlate(){
// PS TopPlate
    difference(){
        union(){
            cube([89,60,3],center=true);
        }
        translate([32.5,15,-3]) cylinder(h=6,r=6, $fn=6);
        translate([32.5,0,-3]) cylinder(h=6,r=6, $fn=6);
        translate([32.5,-15,-3]) cylinder(h=6,r=6, $fn=6); 
        translate([22-2.5,7.5,-3]) cylinder(h=6,r=6, $fn=6);
        translate([22-2.5,-7.5,-3]) cylinder(h=6,r=6, $fn=6);
        translate([9-2.5,15,-3]) cylinder(h=6,r=6, $fn=6);
        translate([9-2.5,0,-3]) cylinder(h=6,r=6, $fn=6);
        translate([9-2.5,-15,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-4-2.5,7.5,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-4-2.5,-7.5,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-17-2.5,15,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-17-2.5,0,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-17-2.5,-15,-3]) cylinder(h=6,r=6, $fn=6);  
        translate([-32.5,7.5,-3]) cylinder(h=6,r=6, $fn=6);
        translate([-32.5,-7.5,-3]) cylinder(h=6,r=6, $fn=6);
        // mountholes
        translate([-41.5,-22,-3]) cylinder(h=6,r=1.7);
        translate([41.5,-22,-3]) cylinder(h=6,r=1.7);
        translate([-41.5,22,-3]) cylinder(h=6,r=1.7);
        translate([41.5,22,-3]) cylinder(h=6,r=1.7);
    }
}
module PsRearPlate(){
//PS RearPlate
    difference(){
    rotate([0,90,0]) difference(){
        union(){
            translate([13.5,-5,-46]) cube([30,50,3],center=true);
            translate([8.5,25,-46]) cube([20,10,3],center=true);
            translate([4.5,23,-41.5]) cube([6,12,6],center=true);
            translate([4.5,-23,-41.5]) cube([6,12,6],center=true);
            translate([25.5,-5,-36.5]) cube([6,50,17],center=true);
            }
      
    }
    //mountholes
        translate([-41.5,-22,-10]) cylinder(h=15,r=1.7);
        translate([-41.5,22,-10]) cylinder(h=15,r=1.7);

        translate([-41.5,-12,-35]) cylinder(h=15,r=1.7);
        translate([-41.5,12,-35]) cylinder(h=15,r=1.7);


        translate([0,-5,-21]) cube([72,52,10],center=true);
        translate([-32,22-5,-35]) cylinder(h=15, r=1.7);
        translate([-32,-22-5,-35]) cylinder(h=15, r=1.7);
    }
}

module PsFrontPlate(){
//PS FrontPlate
    difference(){
        rotate([0,90,0]) difference(){
            union(){
                translate([13.5,-5,46]) cube([30,50,3],center=true);
                translate([8.5,25,46]) cube([20,10,3],center=true);
                translate([4.5,23,41.5]) cube([6,12,6],center=true);
                translate([4.5,-23,41.5]) cube([6,12,6],center=true);
                translate([25.5,-5,36.5]) cube([6,50,17],center=true);
            }
           
        }
    // mountholes
        translate([41.5,-22,-10]) cylinder(h=15,r=1.7);
        translate([41.5,22,-10]) cylinder(h=15,r=1.7);  
        
        translate([41.5,-12,-35]) cylinder(h=15,r=1.7);
        translate([41.5,12,-35]) cylinder(h=15,r=1.7);  
        
        translate([0,-5,-21]) cube([72,52,10],center=true);
        translate([32,22-5,-35]) cylinder(h=15, r=1.7);
        translate([32,-22-5,-35]) cylinder(h=15, r=1.7);
    }    
}




/*
color("green"){
    translate([0,-5,-22]) cube([70,50,1],center=true);
}
*/