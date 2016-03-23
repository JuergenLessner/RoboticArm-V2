//////////////////////
// Robotic Arm V2.0 //
//////////////////////
//DESIGN VERSION 1.1

/* 
Todo:
1x Voltageregulator 6-7.2V
1x Base plate
---
*/

$fn=360; //360 for printing, 36 for designing
ToothAngle = 18; //Angle of the Wheeltooth, Default = 18
ShowScrewDummies = 0; // Default = 0
ShowServoDummies = 0; // Default = 0
ShowBallBearings = 0; // Default = 0
ShowTurnAxis = 0; // Default = 0
ShowRobotArm = 0; // Default = 1
ShowControlparts = 0; // default = 0


/// BEGIN
// Modules
module screwBracket(){
//screwBracket
	difference(){
		union(){
			minkowski(){
				cube([5.25,17,1]);
				translate([1,1,0]) cylinder(h=1.5, d=2);
				}
			cube([5.25,19,2.5]);
			rotate([0,10,0]) translate([-1.4,9,1.7]) cube([8,1,2]);
			}
		//srewHoles
		union() {
			translate([4.25,4.3,-1])  cylinder(h=4, d=4.5);
			translate([4.25,14.8,-1])  cylinder(h=4, d=4.5);	
			translate([5,3,-1]) cube([2.5,2.5,4]);
			translate([5,13.5,-1]) cube([2.5,2.5,4]);
			}
	}
}
module TorqueMount(){
// torque mount
		color("Silver"){
			difference(){
				union(){
					translate([0,0,2.7]) cylinder(h=2, d=20);
					cylinder(h=4.7, d=9);				
				}
				translate([0,0,-1])cylinder(h=8, d=4.5);
				translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,90]) translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,180]) translate([7,0,2]) cylinder(h=4,d=3);
				rotate([0,0,270]) translate([7,0,2]) cylinder(h=4,d=3);
			}
		}
}
module WireTerminal(){
		//wireTerminal
	color("DimGray",1){
		translate([40,6.5,4]) cube([5,7,4]);
		}
		color("Red",1){
			translate([40,7.5,5.5]) cube([7,5,1]);
		}
}
module ServoMainPart(){
	color("DimGray",1){
		//mainpart
		cube([40.5,20,36.5]);
		translate([40.5,0.5,28]) screwBracket();
		rotate([0,0,180]) translate([0,-19.5,28])  screwBracket();
		translate([10,10,36.5]) cylinder(h=2, d=19);
		translate([10,10,38.5]) cylinder(h=1, d=13);
		translate([10,10,39.5]) cylinder(h=0.5, d=11);
		translate([14,1.5,36.5]) cube([21,17,2]);
		}
		//torqueConnector
		color("Gold",1){
			translate([10,10,40]) cylinder(h=4.5, d=5);
		}
	//silver torque disc
	translate([10,10,40.5]) TorqueMount();
	//red wire terminal
	rotate([0,0,180]) translate([-42,-20,0]) WireTerminal();
}
module BasePlateBallb(){
	cylinder(d=10, h=4);
	translate([0,0,-5]) cylinder(d=3, h=14);
	}
module CutBasePBB(){
	translate([0,0,-2]) cylinder(d=13, h=5);
	translate([0,0,-7])  cylinder(d=4, h=15);
	translate([-4,-2,-7]) cube([4,4,15]);
	translate([-13,-6.5,-2]) cube([13,13,5]);
	}
module BaseMount(){
	difference(){
		union(){
			cube([12,15,5]);
			translate([0,0,5]) cube([12,15,10]);
			}
		translate([5,7.5,-1]) cylinder(h=7,d=4.5);
		translate([-10,-1,12]) rotate([0,45,0]) cube([12,20,30]);
		translate([5,7.5,5]) cylinder(h=25, d=8);
		}
	}
module InnerMountNose(){
	difference(){
		translate([0,0,0]) cube([10,39,15]);
		translate([-10,-1,7]) rotate([0,45,0]) cube([12,45,30]);
		}	
}
module BaseCone(){
    difference(){
        union(){
            difference(){
                union(){
                    //lower ring
                    translate([0,0,0]) cylinder(d=130, h=22);
                    //upper ring
                    translate([0,0,20]) cylinder(h = 40, d1 = 130, d2 = 125);
                    }
                translate([0,0,-1.9]) cylinder(d=122, h=22);
                translate([0,0,20]) cylinder(h = 35, d1 = 122, d2 = 117);
                // Cutout top plate
                translate([0,0,54]) cylinder(d=54, h=7);
                //BB Cuts
                translate([51.5,0,59]) rotate([0,90,0]) CutBasePBB();
                translate([-52.5,0,59]) rotate([0,90,0]) CutBasePBB();
                translate([0,52.5,59]) rotate([90,90,0]) CutBasePBB();
                translate([0,-51.5,59]) rotate([90,90,0]) CutBasePBB();
                }
        
            //Base Mounts
            translate([-74,-5,0]) BaseMount();
            translate([5,-74,0]) rotate([0,0,90]) BaseMount();
            translate([74,5,0]) rotate([0,0,180]) BaseMount();
            translate([-5,74,0]) rotate([0,0,270]) BaseMount();
            //Inner Nose
            difference(){
                union(){
                    translate([50,-18.5	,0]) InnerMountNose();
                    rotate([0,0,180]) translate([50,-19.5,0]) InnerMountNose();
                    }
                translate([-100,-13.5,-1]) cube([200,27,6.5]);
                translate([45,-15.5,-1]) cube([50,31,6.5]);
            }
        }
    //BASEHOLES
	// bottom wire hole
	translate([50,50,0]) rotate([135,90,0]) cylinder(h=20,d=8);
	// ??? translate([65,65,0]) cylinder(h=30,d=4);
	// base servo screw hole
	translate([0,0,30]) cylinder(h=50, d=4);
	// Main Wire hole
	translate([-19.5,0,15]) cylinder(h=60, d=15);
	// whole plates screw holes
	translate([-15,15,20]) cylinder(h=80, d=3.5);
	rotate([0,0,90]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,180]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,270]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	translate([-15,15,66.1]) cylinder(h=3, d=6.8);	
	rotate([0,0,90]) translate([-15,15,66.1]) cylinder(h=3, d=6.8);
	rotate([0,0,180]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	rotate([0,0,270]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	
	// Servo screw holes

	translate([0,7,30]) cylinder (h=50, d=3.5);
	translate([0,-7,30]) cylinder (h=50, d=3.5);
	translate([7,0,30]) cylinder (h=50, d=3.5);
	translate([-7,0,30]) cylinder (h=50, d=3.5);    
    }

}
module TPServoMount(){
difference(){	
	union(){
		cube([6,55,50]);
		rotate([0,90,0]) translate([-43,25,0]) cylinder(h=6, d=35);
		translate([-12,9.5,0]) cube([12,5,51]);
		translate([-12,35.5,0]) cube([12,5,51]);
		}
	translate([-2,50.5,-3]) rotate([10,0,0]) cube([9,20,60]);
	translate([7,-0.5,-3]) rotate([10,0,180]) cube([9,20,60]);
	translate([-20,14.5,8]) cube([35,21,42]);
	//screwholes
	translate([-3,19.75,53])rotate([0,90,0]) cylinder(h=10, d=4);
	translate([-3,19.75,4.25])rotate([0,90,0]) cylinder(h=10, d=4);
	translate([-3,30,4.25])rotate([0,90,0]) cylinder(h=10, d=4);
	translate([-3,30,53])rotate([0,90,0]) cylinder(h=10, d=4);
	translate([-2,24,1]) cube([7,2,8]);
	translate([-2,24,49]) cube([7,2,8]);
	//vert Mount
	rotate([0,10,0]) translate([-23.8,8.5,-9.2]) cube([15,7,59.5]);
	rotate([0,10,0]) translate([-23.8,34.5,-9.2]) cube([15,7,59.5]);
    // cable tie
    translate([-10,4,8 ]) rotate([-10,0,0]) cube([30,1.8,5]);
	}
// Screw on topplate
    difference(){
        union(){
            translate([-8,1,0]) cube([10,9,3]);
            translate([-8,40,0]) cube([10,9,3]);
        }
    //Screw holes
    translate([-4,5,-7]) cylinder(h=20,r=2);
    translate([-4,45,-7]) cylinder(h=20,r=2);
    translate([-4,5,-5.2]) cylinder(h=2.2,r=6.5/2,$fn=6);
    translate([-4,45,-5.2]) cylinder(h=2.2,r=6.5/2,$fn=6);

    }
    

}
module TopPlate(){
    /*
	// better Print surface  
	difference(){
		translate([0,0,69]) cylinder(h=0.5, d= 123);
		translate([0,0,68]) cylinder(h=4, d= 120);
		}
	difference(){
		translate([0,0,69]) cylinder(h=0.5, d= 100);
		translate([0,0,68]) cylinder(h=4, d= 80);
		}
    //end printsurface
    */
    difference(){
        union(){
            difference(){
                union(){
                    translate([0,0,64]) cylinder (h=5, d1= 125, d2=123);
        
                    }
                translate([0,0,62])cylinder(h=8, d=10);
                // holes for TPservoMount
                translate([-45,-20,62]) cylinder(h=20,r=2);
                translate([-45,20,62]) cylinder(h=20,r=2);
                translate([-45,-20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([-45,20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([5,-20,62]) cylinder(h=20,r=2);
                translate([5,20,62]) cylinder(h=20,r=2);
                translate([5,-20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([5,20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
            }
            translate([9,-25,69]) TPServoMount();
            translate([-41,-25,69]) TPServoMount();
        }
    //BASEHOLES
	// bottom wire hole
	//translate([50,50,0]) rotate([135,90,0]) cylinder(h=20,d=15);
	// ??? translate([65,65,0]) cylinder(h=30,d=4);
	// base servo screw hole
	translate([0,0,30]) cylinder(h=50, d=4);
	// Main Wire hole
	translate([-19.5,0,15]) cylinder(h=60, d=15);
	// whole plates screw holes
	translate([-15,15,20]) cylinder(h=80, d=3.5);
	rotate([0,0,90]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,180]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,270]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	translate([-15,15,66.1]) cylinder(h=3, d=6.8);	
	rotate([0,0,90]) translate([-15,15,66.1]) cylinder(h=3, d=6.8);
	rotate([0,0,180]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	rotate([0,0,270]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	
	// Servo screw holes

	translate([0,7,30]) cylinder (h=50, d=3.5);
	translate([0,-7,30]) cylinder (h=50, d=3.5);
	translate([7,0,30]) cylinder (h=50, d=3.5);
	translate([-7,0,30]) cylinder (h=50, d=3.5);  
    }
}
module TopPlatePrint(){
    /*
	// better Print surface  
	difference(){
		translate([0,0,69]) cylinder(h=0.5, d= 123);
		translate([0,0,68]) cylinder(h=4, d= 120);
		}
	difference(){
		translate([0,0,69]) cylinder(h=0.5, d= 100);
		translate([0,0,68]) cylinder(h=4, d= 80);
		}
    //end printsurface
    */
    difference(){
        union(){
            difference(){
                union(){
                    translate([0,0,64]) cylinder (h=5, d1= 125, d2=123);
        
                    }
                translate([0,0,62])cylinder(h=8, d=10);
                // holes for TPservoMount
                translate([-45,-20,62]) cylinder(h=20,r=2);
                translate([-45,20,62]) cylinder(h=20,r=2);
                translate([-45,-20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([-45,20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([5,-20,62]) cylinder(h=20,r=2);
                translate([5,20,62]) cylinder(h=20,r=2);
                translate([5,-20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
                translate([5,20,63.5]) cylinder(h=2.6,r=6.5/2,$fn=6);
            }
            //translate([9,-25,69]) TPServoMount();
            //translate([-41,-25,69]) TPServoMount();
        }
    //BASEHOLES
	// bottom wire hole
	translate([50,50,0]) rotate([135,90,0]) cylinder(h=20,d=15);
	// ??? translate([65,65,0]) cylinder(h=30,d=4);
	// base servo screw hole
	translate([0,0,30]) cylinder(h=50, d=4);
	// Main Wire hole
	translate([-19.5,0,15]) cylinder(h=60, d=15);
	// whole plates screw holes
	translate([-15,15,20]) cylinder(h=80, d=3.5);
	rotate([0,0,90]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,180]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,270]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	translate([-15,15,66.1]) cylinder(h=3, d=6.8);	
	rotate([0,0,90]) translate([-15,15,66.1]) cylinder(h=3, d=6.8);
	rotate([0,0,180]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	rotate([0,0,270]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	
	// Servo screw holes

	translate([0,7,30]) cylinder (h=50, d=3.5);
	translate([0,-7,30]) cylinder (h=50, d=3.5);
	translate([7,0,30]) cylinder (h=50, d=3.5);
	translate([-7,0,30]) cylinder (h=50, d=3.5);  
    }
}
module MiddlePlateConnector(){
    difference(){
        union(){
    	//// MIDDLE PLATE CONNECTOR begin
	translate([0,0,55]) cylinder(h=14, d=9.5);
	translate([0,0,52]) cylinder(h=11.9, d=52);
	//base servo mount connector
	translate([0,0,47.5]) cylinder(h=10, d=20);
	//// MIDDLE PLATE CONNECTOR end
        }
    //BASEHOLES
	// bottom wire hole
	//translate([50,50,0]) rotate([135,90,0]) cylinder(h=20,d=15);
	// ??? translate([65,65,0]) cylinder(h=30,d=4);
	// base servo screw hole
	translate([0,0,30]) cylinder(h=50, d=4);
	// Main Wire hole
	translate([-19.5,0,15]) cylinder(h=60, d=15);
	// whole plates screw holes
	translate([-15,15,20]) cylinder(h=80, d=3.5);
	rotate([0,0,90]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,180]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,270]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	translate([-15,15,66.1]) cylinder(h=3, d=6.8);	
	rotate([0,0,90]) translate([-15,15,66.1]) cylinder(h=3, d=6.8);
	rotate([0,0,180]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	rotate([0,0,270]) translate([-15,15,66.1]) cylinder(h=8, d=6.8);
	
	// Servo screw holes

	translate([0,7,30]) cylinder (h=50, d=3.5);
	translate([0,-7,30]) cylinder (h=50, d=3.5);
	translate([7,0,30]) cylinder (h=50, d=3.5);
	translate([-7,0,30]) cylinder (h=50, d=3.5);  
    }
}
module LowerArm(){
	difference(){
		union(){
		//lowerpart
		cube([4,35,37.5]);
		translate([0,17.5,0]) rotate([0,90,0]) cylinder(h=4,d=35);
		//upperpart
		translate([0,2,37]) cube([4,31,80]); //28.5,3.25
		translate([0,17.5,117.5]) rotate([0,90,0]) cylinder(h=4,d=31);
		}
	translate([-3,35,-0]) rotate([5,0,0]) cube([10,20,38]);
	translate([-3,-20.2,1.75]) rotate([-5,0,0]) cube([10,20,38]);
	translate([-3,31.7,37.8]) rotate([-0.9,0,0]) cube([10,20,100]);
	translate([-3,-17,37.5]) rotate([0.9,0,0]) cube([10,20,100]);
	//servo screwholes
	translate([-3,10,1]) rotate([0,90,0]) cylinder(h=10,d=3.5);
	translate([-3,24,1]) rotate([0,90,0]) cylinder(h=10,d=3.5);
	translate([-3,17,8]) rotate([0,90,0]) cylinder(h=10,d=3.5);
	translate([-3,17,-6]) rotate([0,90,0]) cylinder(h=10,d=3.5);
	translate([-3,17,1]) rotate([0,90,0]) cylinder(h=10,d=4);
	}
}
module bracingCylinder(){
// bracing cylinder
    difference(){
    rotate([0,90,0]) cylinder(d = 7.5, h=50, $fn=36);
    translate([-2,0,0]) rotate([0,90,0]) cylinder(d = 3.5, h=54, $fn=36);
    }
}
module lowerFrontArm(){
    translate([-26,8,145]) bracingCylinder();
    translate([-26,-8,145]) bracingCylinder();
    translate([-26,-8,185]) bracingCylinder();
    translate([-26,8,185]) bracingCylinder();
    difference(){
        translate([23.3,-17,107]) LowerArm();//23.3
        union(){
            //servo screwholes
            translate([-32,8,185]) rotate([0,90,0]) cylinder(h=62,d=3.5);
            translate([-32,-8,185]) rotate([0,90,0]) cylinder(h=62,d=3.5);
            translate([-32,8,145]) rotate([0,90,0]) cylinder(h=62,d=3.5);
            translate([-32,-8,145]) rotate([0,90,0]) cylinder(h=62,d=3.5);
            }
    translate([23,-16.5,223]) 
        union(){
            translate([-3,10,1]) rotate([0,90,0]) cylinder(h=10,d=3.5);
            translate([-3,24,1]) rotate([0,90,0]) cylinder(h=10,d=3.5);
            translate([-3,17,8]) rotate([0,90,0]) cylinder(h=10,d=3.5);
            translate([-3,17,-6]) rotate([0,90,0]) cylinder(h=10,d=3.5);
            translate([-3,17,1]) rotate([0,90,0]) cylinder(h=10,d=4);
            }
    }
}
module lowerRearArm(){
    difference(){
		translate([-28.8,-17,107]) LowerArm();//23.3
		// axis back hole
		translate([-34,0.5,224]) rotate([0,90,0]) cylinder(d=14.5,h=15,$fn=360);
		translate([-29.8,0,108]) rotate([0,90,0]) cylinder(h=2,d=22);
		translate([-32,8,185]) rotate([0,90,0]) cylinder(h=62,d=3.5);
		translate([-32,-8,185]) rotate([0,90,0]) cylinder(h=62,d=3.5);
		translate([-32,8,145]) rotate([0,90,0]) cylinder(h=62,d=3.5);
		translate([-32,-8,145]) rotate([0,90,0]) cylinder(h=62,d=3.5);
		}
}
module servoCutOut(){
    color("blue"){
        translate([0,0,-300]) union(){
                //screwholes
                translate([-10,5.75,348.75]) rotate([0,90,0]) cylinder(d=4, h=30, $fn=36);
                translate([-10,-4.75,348.75]) rotate([0,90,0]) cylinder(d=4, h=30, $fn=36);
                translate([-10,5.75,299.25]) rotate([0,90,0]) cylinder(d=4, h=30, $fn=36);
                translate([-10,-4.75,299.25]) rotate([0,90,0]) cylinder(d=4, h=30, $fn=36);
                //servocutout
                translate([-23,-10.5,303.25]) cube([50,21,41]);
                //translate([8,-0.5,344.25]) cube([7,2,8]);
                //translate([8,-0.5,297.25]) cube([7,2,8]);
                }
        }
    }
module upperFrontArm(){
	difference(){
		union(){
			translate([8.6,-15,220]) cube([4,31,120]);
			translate([8.6,0.5,219]) rotate([0,90,0]) cylinder(d=31,h=4,$nf=360);
			translate([8.6,0.5,340]) rotate([0,90,0]) cylinder(d=31,h=4,$nf=360);
		}
		color("blue"){
			union(){
			//screwholes
				translate([-35,5.75,349.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,349.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,5.75,300.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,300.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);

				translate([-35,5.75,258.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,258.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,5.75,209.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,209.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
			//servocutout
				translate([-23,-9,304.25]) cube([50,20,41]);
				translate([-23,-9,213.75]) cube([50,20,41]);

				translate([8,-0.5,344.25]) cube([7,2,8]);
				translate([8,-0.5,297.25]) cube([7,2,8]);
				translate([8,-0.5,253.75]) cube([7,2,8]);
				translate([8,-0.5,206.75]) cube([7,2,8]);
					color("green"){
						translate([-30,14,277]) rotate([-2,0,0]) cube([50,20,80]);
						translate([-30,16.70,205]) rotate([2,0,0]) cube([50,20,80]);
						translate([-30,-34.70,205]) rotate([-2,0,0]) cube([50,20,80]);
						translate([-30,-32,277]) rotate([2,0,0]) cube([50,20,80]);
						translate([-30,113,280])  rotate([0,90,0]) cylinder(d=200, h=70, $fn=360);
						translate([-30,-111,280])  rotate([0,90,0]) cylinder(d=200, h=70, $fn=360);
					}
			}
		}
	}
}
module upperRearArm(){
	difference(){	
		union(){
			translate([-24,-15,220]) cube([6,31,120]);
			translate([-24,0.5,219]) rotate([0,90,0]) cylinder(d=31,h=6,$nf=360);
			translate([-24,0.5,340]) rotate([0,90,0]) cylinder(d=31,h=6,$nf=360);
			translate([-29.5,0.5,224]) rotate([0,90,0]) cylinder(d=13.5,h=7,$nf=360);
			translate([-33.5,0.5,335]) rotate([0,90,0]) cylinder(d=13.5,h=11,$nf=360);
		}
		color("blue"){
			union(){
			//screwholes
				translate([-35,5.75,349.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,349.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,5.75,300.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,300.25]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
                
				translate([-24.5,5.75,349.25]) rotate([0,90,0]) cylinder(d=6.7, h=3, $fn=6);
				translate([-24.5,-4.75,349.25]) rotate([0,90,0]) cylinder(d=6.7, h=3, $fn=6);
                
				translate([-35,5.75,258.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,258.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,5.75,209.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
				translate([-35,-4.75,209.75]) rotate([0,90,0]) cylinder(d=4, h=100, $fn=36);
                
                translate([-24.5,5.75,209.75]) rotate([0,90,0]) cylinder(d=6.7, h=3, $fn=6);
                translate([-24.5,-4.75,209.75]) rotate([0,90,0]) cylinder(d=6.7, h=3, $fn=6);
			//servocutout
				translate([-23,-9.5,304.25]) cube([50,21,41]);
				translate([-23,-9.5,213.75]) cube([50,21,41]);

				translate([8,-0.5,344.25]) cube([7,2,8]);
				translate([8,-0.5,297.25]) cube([7,2,8]);
				translate([8,-0.5,253.75]) cube([7,2,8]);
				translate([8,-0.5,206.75]) cube([7,2,8]);
					color("green"){
						translate([-30,14,277]) rotate([-2,0,0]) cube([50,20,80]);
						translate([-30,16.70,205]) rotate([2,0,0]) cube([50,20,80]);
						translate([-30,-34.70,205]) rotate([-2,0,0]) cube([50,20,80]);
						translate([-30,-32,277]) rotate([2,0,0]) cube([50,20,80]);
						translate([-30,113,280])  rotate([0,90,0]) cylinder(d=200, h=70, $fn=360);
						translate([-30,-111,280])  rotate([0,90,0]) cylinder(d=200, h=70, $fn=360);
					}
			}
		}
	}

}

module wristMount(){
	difference(){
		union(){
			translate([28,-13.5,335]) cube([4,28,50]);
			translate([-32,-13.5,335]) cube([4,28,50]);
			translate([-28,-13.5,377]) cube([60,28,8]);
			translate([23,0.5,335]) rotate([0,90,0])cylinder(d=28,h=10,$fn=360);
			translate([-33,0.5,335]) rotate([0,90,0])cylinder(d=28,h=8,$fn=360);
		}
		translate ([-24.5,0.5,391]) rotate([0,90,0]) servoCutOut();
	//facette
		translate ([-35,14.7,330]) rotate([2,0,0]) cube([70,20,60]);
		translate ([-35,-33.7,330]) rotate([-2,0,0]) cube([70,20,60]);
		translate ([28,-15,386]) rotate([0,45,0]) cube([12,30,12]);
		translate ([-45,-15,386]) rotate([0,45,0]) cube([12,30,12]);
	//axis hole
		translate([-38,0.5,335]) rotate([0,90,0]) cylinder(d=14.5,h=15,$fn=360);
	//screwholes
		translate([22,-16.5,334]) union(){
			translate([-3,10,1]) rotate([0,90,0]) cylinder(h=20,d=3.5);
			translate([-3,24,1]) rotate([0,90,0]) cylinder(h=20,d=3.5);
			translate([-3,17,8]) rotate([0,90,0]) cylinder(h=20,d=3.5);
			translate([-3,17,-6]) rotate([0,90,0]) cylinder(h=20,d=3.5);
			translate([-3,17,1]) rotate([0,90,0]) cylinder(h=20,d=4);           
		}
        translate([24.3,6.25,376.9]) rotate([0,0,30]) cylinder(h=3.1,r=6.7/2,$fn=6);
        translate([24.3,-4.25,376.9]) rotate([0,0,30]) cylinder(h=3.1,r=6.7/2,$fn=6);
         translate([-24.9,6.25,376.9]) rotate([0,0,30]) cylinder(h=3.1,r=6.7/2,$fn=6);
        translate([-24.9,-4.25,376.9]) rotate([0,0,30]) cylinder(h=3.1,r=6.7/2,$fn=6);  
	} 
}
module InnerLowerPlate(){
	difference(){
	translate([0,0,46.5]) cylinder(h=5.5, d=105);
	// Middle hole
	translate([0,0,46]) cylinder(h=7, d=21);
	// Main Wire hole
	translate([-19.5,0,15]) cylinder(h=60, d=15);
	// ballbearing holes
	translate([36.5,0,50]) rotate([0,90,0]) CutBasePBB();
	translate([-37.5,0,50]) rotate([0,90,0]) CutBasePBB();
	translate([0,37.5,50]) rotate([90,90,0]) CutBasePBB();
	translate([0,-36.5,50]) rotate([90,90,0]) CutBasePBB();
	//whole plates screw holes
	translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,90]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,180]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	rotate([0,0,270]) translate([-15,15,20]) cylinder(h=50, d=3.5);
	translate([-15,15,46]) cylinder(h=3, d=7.8, $fn=6);
	rotate([0,0,90]) translate([-15,15,46]) cylinder(h=3, d=7.5, $fn=6);
	rotate([0,0,180]) translate([-15,15,46]) cylinder(h=3, d=7.5, $fn=6);
	rotate([0,0,270]) translate([-15,15,46]) cylinder(h=3, d=7.5, $fn=6);
////////// DEBUG CUTTROUGH
	//translate([0,-90,1]) cube([150,190,80]);
	}
}

//BaseServoMount
module BaseServoMount(){
difference(){
	union(){
            //bottom
            translate([-80,-13,0]) cube([160,26,5]);	
            translate([-42,-15,0]) cube([105,30,5]);
            //servomount
            translate([31,-15,5]) cube([9,30,22.7]);
            translate([-19.5,-15,5]) cube([9,30,22.7]);
		}
		//bottom hole
		translate([-10.5,-10.5,-1]) cube([41.5,21,20]);
		translate([-20,-5,-2]) cube([10,10,10]);
		//servomounthole
		translate([30,-10,5]) cube([11,20,15.7]);
		translate([-20,-10,5]) cube([11,20,15.7]);

		//servosrewholes
		translate([34.8,5.3,26]) cylinder(h=20,d=3.5);
		translate([34.8,-5.3,26]) cylinder(h=20,d=3.5);
		translate([-14.2,5.3,26]) cylinder(h=20,d=3.5);
		translate([-14.2,-5.3,26]) cylinder(h=20,d=3.5);
        translate([34.8,5.3,22]) cylinder(h=3,d=7,$fn=6);
		translate([34.8,-5.3,22]) cylinder(h=3,d=7,$fn=6);
		translate([-14.2,5.3,22]) cylinder(h=3,d=7,$fn=6);
		translate([-14.2,-5.3,22]) cylinder(h=3,d=7,$fn=6);
        translate([34.8,2.3,22]) cube([10,6,3]);
		translate([34.8,-8.3,22]) cube([10,6,3]);
		translate([-23.2,2.3,22]) cube([10,6,3]);
		translate([-23.2,-8.3,22]) cube([10,6,3]);
		//lower ring cutout
		difference(){
			translate([0,0,-1]) cylinder(d=180, h=21);
			translate([0,0,-1.9]) cylinder(d=120, h=23);
		}
	}
	//servomount supportwalls		
	difference(){
		union(){
			translate([35,10,5])cube([30,5,22.7]);
			translate([35,-15,5])cube([30,5,22.7]);
		}
		translate([102,9,20])rotate([0,240,0]) cube([50,7,50]);
		translate([102,-16,20])rotate([0,240,0]) cube([50,7,50]);
	}
	rotate([0,0,180]) difference(){
		union(){
			translate([17,10,5])cube([30,5,22.7]);
			translate([17,-15,5])cube([30,5,22.7]);
		}
		translate([75,9,20])rotate([0,225,0]) cube([50,7,35]);
		translate([75,-16,20])rotate([0,225,0]) cube([50,7,35]);
	}
    //end servomount supportwalls
}
module LeftClawBase(){
    difference(){
        union(){
            cylinder(h=3,r=10);      
        }
        translate([-1.5,-10,-3])cube([22,22,10]);
        translate([0,0,-1]) cylinder(h=10,r=3);
        translate([-7,0,-6]) cylinder(h=20,r=3.5/2);
    }
    //both
    difference(){
       
        union(){
            translate([-4.5,-10,0]) cube([3,20,10]);  
        }
        translate([0,0,-1]) cylinder(h=5,r=3);
        difference(){
            translate([0,0,-3]) cylinder(h=20,r=14);
            translate([0,0,-4]) cylinder(h=20,r=10);  
        }
        //horizontalholes
        translate([-20,5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-20,-5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
    }
}
module RightClawBase(){
    difference(){
        union(){
            cylinder(h=3,r=10);
        }
        translate([-20.5,-10,-3])cube([22,22,10]);
        translate([0,0,-1]) cylinder(h=10,r=3);
        translate([7,0,-6]) cylinder(h=20,r=3.5/2);
    }
    difference(){
        union(){
            translate([1.5,-10,0]) cube([3,20,10]);
        }
        translate([0,0,-1]) cylinder(h=5,r=3);
        difference(){
            translate([0,0,-3]) cylinder(h=20,r=14);
            translate([0,0,-4]) cylinder(h=20,r=10);          
        }
        //horizontalholes
        translate([-20,5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-20,-5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
    }
}
module ClawCenterMount() {
    difference(){
        union(){
            translate([0,15,26]) cube([3,72,48],center=true);
        }
        translate([0,0,-6]) cylinder(h=10,r=3);
         //horizontalholes
        translate([-20,5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-20,-5,7]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-3,-22.7,-6]) rotate([29,0,0]) cube([8,15,30]);
        translate([-3,8.3,0]) rotate([319,0,0]) cube([8,15,23.9]);
        translate([-5,24,-4]) cube([8,30,22]);
        translate([-3,-35.5,35]) rotate([331,0,0]) cube([8,15,30]);
        translate([-5,24,34]) cube([8,30,22]);
        translate([-3,24,34]) rotate([41,0,0]) cube([8,15,30]);
        //servo- and screw holes
        translate([-20,0,31.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-20,0,20.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        
        translate([-20,49,31.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-20,49,20.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-20,14,26]) rotate([0,90,0]) cylinder(h=50,r=9);
        translate([-20,-14,26]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-20,5,46]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        translate([-20,-5,46]) rotate([0,90,0]) cylinder(h=50,r=3.5/2);
        // other holes
        translate([-20,0,40]) rotate([0,90,0]) cylinder(h=30,r=4);
        translate([-20,-6,16]) rotate([0,90,0]) cylinder(h=50,r=3);
        translate([-20,-6,26]) rotate([0,90,0]) cylinder(h=50,r=3);
    }
    //servomount
    difference(){
        union(){
            translate([-11,0,31.5]) rotate([0,90,0]) cylinder(h=12.5,r=3.2);
            translate([-11,0,20.5]) rotate([0,90,0]) cylinder(h=12.5,r=3.2);
            
            translate([-11,49,31.5]) rotate([0,90,0]) cylinder(h=12.5,r=3.2);
            translate([-11,49,20.5]) rotate([0,90,0]) cylinder(h=12.5,r=3.2);
        }
        translate([-20,0,31.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-20,0,20.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        
        translate([-20,49,31.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-20,49,20.5]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
    }
}
module RightGear(){
difference(){
    union(){
        translate([4,14,26]) rotate([0,90,0]) cylinder(h=3,r=12.5); //14 12.5
        //servodisc
        translate([2,14,26]) rotate([0,90,0]) cylinder(h=2,r=12);
        translate([-1,14,26]) rotate([0,90,0]) cylinder(h=3,r=4.5);
        translate([4,14,26]) 
        union(){
            rotate([ToothAngle/2+20,0,0]) Wheelcog();
            rotate([-ToothAngle+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*2+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*3+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*4+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*5+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*6+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*7+(ToothAngle/2)+20,0,0]) Wheelcog();
            rotate([-ToothAngle*8+(ToothAngle/2)+20,0,0]) Wheelcog();  
        //rotate([-ToothAngle*9+(ToothAngle/2)+20,0,0]) Wheelcog();
        //rotate([-ToothAngle*10+(ToothAngle/2)+20,0,0]) Wheelcog();
        //rotate([-ToothAngle*11+(ToothAngle/2)+20,0,0]) Wheelcog();
        }
    }
    translate([3,14,26]) rotate([0,90,0]) cylinder(h=5,r=3.5/2);
    translate([-2,14,26]) rotate([0,90,0]) cylinder(h=6,r=2.95);
    translate([-10,14,19]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
    translate([-10,14,33]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
}
    //arm
    difference(){
        union(){
            translate([4,9,37]) cube([3,10,19]);
            translate([4,14,37+19]) rotate([0,90,0]) cylinder(h=3,r=5);
        }
        translate([3,14,37+19]) rotate([0,90,0]) cylinder(h=5,r=3.5/2);
    }

}
module LeftGear(){
    //Wheel
    difference(){
        union(){     
            translate([4,-14,26])rotate([0,90,0]) cylinder(h=3,r=12.5); 
            translate([1,-14,26])rotate([0,90,0]) cylinder(h=5,r=6);
            translate([4,-14,26]) 
            union(){
                rotate([0-20,0,0])Wheelcog();
                rotate([ToothAngle-20,0,0]) Wheelcog();
                rotate([ToothAngle*2-20,0,0]) Wheelcog();
                rotate([ToothAngle*3-20,0,0]) Wheelcog();
                rotate([ToothAngle*4-20,0,0]) Wheelcog();
                rotate([ToothAngle*5-20,0,0]) Wheelcog();
                rotate([ToothAngle*6-20,0,0]) Wheelcog();
                rotate([ToothAngle*7-20,0,0]) Wheelcog();
                rotate([ToothAngle*8-20,0,0]) Wheelcog(); 
                //rotate([ToothAngle*9-20,0,0]) Wheelcog();
                //rotate([ToothAngle*10-20,0,0]) Wheelcog();
                //rotate([ToothAngle*11-20,0,0]) Wheelcog();
            }
        }
        translate([0,-14,26])rotate([0,90,0]) cylinder(h=10,r=3.5/2);
        translate([-10,-14,19]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
        translate([-10,-14,33]) rotate([0,90,0]) cylinder(h=30,r=3.5/2);
    }
    //arm
    difference(){
        union(){
            translate([4,-7-12,37]) cube([3,10,19]);
            translate([4,-14,37+19]) rotate([0,90,0]) cylinder(h=3,r=5);
        }
        translate([3,-14,37+19]) rotate([0,90,0]) cylinder(h=5,r=3.5/2);
    }
}
module Wheelcog(){
    difference(){
            union(){
                translate([0,0,-14]) rotate([0,90,0]) cylinder(h=3,r=1);
                translate([1.5,0,-11]) cube([3,2,6],center=true);
                translate([1.5,0,-11.5]) cube([3,4,4],center=true);
            }
        translate([-1,2,-13.5]) rotate([180,0,0]) 
            union(){
            rotate([0,90,0]) cylinder(h=5,r=1);
            translate([1.5,0,3]) cube([3,2,6],center=true);
            }
        translate([-1,-2,-13.5]) rotate([180,0,0]) 
            union(){
            rotate([0,90,0]) cylinder(h=5,r=1);
            translate([1.5,0,3]) cube([3,2,6],center=true);
            }
        }
}
module RobotClaw(){
    RightClawBase();
    LeftClawBase();
    ClawCenterMount();
    RightGear();
    LeftGear();
    LeftFrontBar();
    RightFrontBar();
    LeftRearBar();
    RightRearBar();
    LeftGripper();
    RightGripper();
    if (ShowServoDummies == 1){
        translate([-41.3,4,16]) rotate([90,0,0]) rotate([0,90,0]) ServoMainPart();
    }
}
module LeftGripper(){
 //lowerpart
 difference(){
     union(){
         translate([-2,-14,37+19]) rotate([0,90,0]) cylinder(h=6,r=5);
          translate([1,-10,67]) rotate([-20,0,0]) cube([6,10,22],center=true);
         translate([-2,-6,78]) rotate([0,90,0]) cylinder(h=6,r=5);
     }
     translate([-3,-14,37+19]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
     translate([-3,-6,78]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
 }
 //upperpart
 difference(){
     union(){
         translate([1,-6,89.5])cube([6,10,23],center=true);
         translate([-2,-1,91+10]) rotate([0,90,0])  cylinder(h=6,r=10);
     }
     translate([-3,0,89.5]) cube([10,20,30]);
     translate([-3,-6,78]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
     translate([0,14,-4]) union(){
        translate([-3,-14,90]) rotate([0,90,0]) cylinder(h=10,r=5);
        translate([-3,-19,90]) cube([10,10,12]);
        translate([-3,-14,102]) rotate([0,90,0]) cylinder(h=10,r=5);
        } 
    translate([-5,-0,110]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,-0,108]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,-0,106]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,-0,104]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    }
 }
 
module RightGripper(){
 //lowerpart
 difference(){
     union(){
        translate([-2,14,37+19]) rotate([0,90,0]) cylinder(h=6,r=5);
         translate([1,10,67]) rotate([20,0,0]) cube([6,10,22],center=true);
         translate([-2,6,78]) rotate([0,90,0]) cylinder(h=6,r=5);
     }
     translate([-3,14,37+19]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
     translate([-3,6,78]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
 }  
 //upperpart
 difference(){
     union(){
         translate([1,6,89.5])cube([6,10,23],center=true);
         translate([-2,6-5,91+10]) rotate([0,90,0])  cylinder(h=6,r=10);
     }
     translate([-3,-20,89.5]) cube([10,20,30]);
     translate([-3,6,78]) rotate([0,90,0]) cylinder(h=8,r=3.5/2);
     translate([0,14,-4]) union(){
        translate([-3,-14,90]) rotate([0,90,0]) cylinder(h=10,r=5);
        translate([-3,-19,90]) cube([10,10,12]);
        translate([-3,-14,102]) rotate([0,90,0]) cylinder(h=10,r=5);
        } 
    translate([-5,0,110]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,0,108]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,0,106]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    translate([-5,0,104]) rotate([0,90,0]) cylinder(h=14,r=0.5);
    }
 }
 module RightFrontBar(){
    difference(){
        union(){
            translate([1.5,5,46]) rotate([0,90,0]) cylinder(h=6,r=3);
            translate([4,6,78]) rotate([0,90,0]) cylinder(h=3.5,r=3);
            translate([6,5.5,62]) rotate([-2,0,0]) cube([3,6,32],center=true);
        }
        translate([-1,5,46]) rotate([0,90,0]) cylinder(h=15,r=3.5/2);
        translate([-7,6,78]) rotate([0,90,0]) cylinder(h=15,r=3.5/2);
    }
}
 module LeftFrontBar(){
    difference(){
        union(){
            translate([1.5,-5,46]) rotate([0,90,0]) cylinder(h=6,r=3);
            translate([6,-5.5,62]) rotate([2,0,0]) cube([3,6,32],center=true);
            translate([4,-6,78]) rotate([0,90,0]) cylinder(h=3.5,r=3);
        }
        translate([-1,-5,46]) rotate([0,90,0]) cylinder(h=15,r=3.5/2);
        translate([-7,-6,78]) rotate([0,90,0]) cylinder(h=15,r=3.5/2);
    }
}
module RightRearBar(){
    difference(){
        union(){
       translate([-5.5,5,46]) rotate([0,90,0]) cylinder(h=4,r=3);
       translate([-5.5,6,78]) rotate([0,90,0]) cylinder(h=3.5,r=3);
       translate([-4,5.5,62]) rotate([-2,0,0]) cube([3,6,32],center=true);
        }
        translate([-7,5,46]) rotate([0,90,0]) cylinder(h=10,r=3.5/2);
        translate([-7,6,78]) rotate([0,90,0]) cylinder(h=10,r=3.5/2);
    }
}
 module LeftRearBar(){
    difference(){
        union(){
            translate([-5.5,-5,46]) rotate([0,90,0]) cylinder(h=4,r=3);
            translate([-5.5,-6,78]) rotate([0,90,0]) cylinder(h=3.5,r=3);
            translate([-4,-5.5,62]) rotate([2,0,0]) cube([3,6,32],center=true);
        }
        translate([-8,-5,46]) rotate([0,90,0]) cylinder(h=10,r=3.5/2);
        translate([-7,-6,78]) rotate([0,90,0]) cylinder(h=10,r=3.5/2);
    }
}

module A9685Bumper1(){
    difference(){
        union(){    
            union(){
            translate([5,5,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([70,5,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([5,27,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([70,27,2.5]) cylinder(d=6,h=3,$fn=36);       
                difference (){
                    union(){
                    cube([75,32,5.5]);   
                    }
                    translate([4,4,-1]) cube([67,24,10.5]);
                    translate([2,2,-3]) cube([71,28,5.5]);
                }
            }
        }
        translate([5,5,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([70,5,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([5,27,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([70,27,1.5]) cylinder(d=3.5,h=5,$fn=36);      
    }    
}

module A9685Bumper2(){
    difference(){
        union(){    
            union(){
            translate([5,5,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([63,5,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([5,24,2.5]) cylinder(d=6,h=3,$fn=36);
            translate([63,24,2.5]) cylinder(d=6,h=3,$fn=36);       
                difference (){
                    union(){
                    cube([68,28,5.5]);   
                    }
                    translate([4,4,-1]) cube([60,20,10.5]);
                    translate([2,2,-3]) cube([64,24,5.5]);
                }
            }
        }
        translate([5,5,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([63,5,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([5,24,1.5]) cylinder(d=3.5,h=5,$fn=36);
        translate([63,24,1.5]) cylinder(d=3.5,h=5,$fn=36);      
    }

translate([65,31,0]) 
difference(){
    cylinder(d=9, h=5.5,$fn=36);
    translate([0,0,-1]) cylinder(d=4, h=12,$fn=36);
}
translate([2,31,0]) 
difference(){
    cylinder(d=9, h=5.5,$fn=36);
    translate([0,0,-1]) cylinder(d=4, h=12,$fn=36);
}
translate([71,5,0]) 
difference(){
    cylinder(d=9, h=5.5,$fn=36);
    translate([0,0,-1]) cylinder(d=4, h=12,$fn=36);
}
translate([-3,5,0]) 
difference(){
    cylinder(d=9, h=5.5,$fn=36);
    translate([0,0,-1]) cylinder(d=4, h=12,$fn=36);
}    
}

module switchButton(){
    color("Gray"){
        cube([6.3,6.3,4],center=true);
    }
    color("Black"){
    translate([0,0,2])     cylinder(h=6, r1=3.6/2, r2=3.2/2);
    }
}   
module buttonBoard(){
    difference(){
        color("Goldenrod"){
            cube([93,55,1.5],center=true);
        }
    // holes
        translate([42,23,-2]) cylinder(h=4, r=3.5/2);
        translate([-42,23,-2]) cylinder(h=4, r=3.5/2);
        translate([42,-23,-2]) cylinder(h=4, r=3.5/2);
        translate([-42,-23,-2]) cylinder(h=4, r=3.5/2); 
        
        translate([-42+(2.54*2),-23,0])
        for (h = [0:18]){
            for (l = [0:29]){
                translate([l*2.54,h*2.54,-2]) cylinder(h=4, r=0.5);
            }
        }
        translate([-42,-23+(2.54*2),0])
        for (h = [0:14]){
            for (l = [0:1]){
                translate([l*2.54,h*2.54,-2]) cylinder(h=4, r=0.5);
            }
        }
        translate([ 42-2.54,-23+(2.54*2),0])
        for (h = [0:14]){
            for (l = [0:1]){
                translate([l*2.54,h*2.54,-2]) cylinder(h=4, r=0.5);
            }
        }

    }
}   
module switchButtonBoard(){
    translate([0,0,-3]) buttonBoard();
    translate([29.06,20.46,0]) switchButton();
    translate([29.06-(2.54*8),20.46,0]) switchButton();
    translate([29.06-(2.54*15),20.46,0]) switchButton();
    translate([29.06-(2.54*23),20.46,0]) switchButton();

    translate([29.06,2.34-2.54,0]) switchButton();
    translate([29.06-(2.54*8),2.34-2.54,0]) switchButton();
    translate([29.06-(2.54*15),2.34-2.54,0]) switchButton();
    translate([29.06-(2.54*23),2.34-2.54,0]) switchButton();

    translate([39.32,10.1,0]) switchButton(); //11,3
    translate([39.32-(2.54*8),10.1,,0]) switchButton();
    translate([39.32-(2.54*23),10.1,,0]) switchButton();
    translate([39.32-(2.54*31),10.1,,0]) switchButton();

    translate([34.24,-20.52,0]) switchButton();
    translate([34.24-(2.54*5),-20.52,0]) switchButton();
    translate([34.24-(2.54*10),-20.52,0]) switchButton();
    translate([34.24-(2.54*17),-20.52,0]) switchButton();
    translate([34.24-(2.54*22),-20.52,0]) switchButton();
    translate([34.24-(2.54*27),-20.52,0]) switchButton();
}
module Display16x2(){    
    color("Black"){
        difference(){
            translate([0,0,3.5]) cube([72,24,7],center=true);
            translate([0,0,6.5]) cube([65,16.5,3],center=true);
        }
    }
    color("Lime"){
        translate([0,0,5.5]) cube([65,16.5,3],center=true);
    }
    color("Darkgreen"){
        difference(){
            cube([80,36.5,1.8],center=true);
            translate([37.5,16,-10]) cylinder(h=20,r=2);
            translate([37.5,-16,-10]) cylinder(h=20,r=2);
            translate([-37.5,16,-10]) cylinder(h=20,r=2);
            translate([-37.5,-16,-10]) cylinder(h=20,r=2);
        }
    }
    color("DarkOliveGreen"){
        translate([13,-5,-5.4]) cube([42,19,9],center=true);
    }
    color("White"){
        translate([-37,0,2.5]) cube([5,16,3],center=true);
    }
}
module ControllerTopCover(){
difference(){
    translate([0,0,3.6]) cube([110,65,3],center=true);
        union(){
            translate([29.06,20.46,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*8),20.46,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*15),20.46,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*23),20.46,0]) cylinder(h=10,d=4.5);

            translate([29.06,2.34-2.54,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*8),2.34-2.54,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*15),2.34-2.54,0]) cylinder(h=10,d=4.5);
            translate([29.06-(2.54*23),2.34-2.54,0]) cylinder(h=10,d=4.5);

            translate([39.32,10.1,0]) cylinder(h=10,d=4.5);
            translate([39.32-(2.54*8),10.1,,0]) cylinder(h=10,d=4.5);
            translate([39.32-(2.54*23),10.1,,0]) cylinder(h=10,d=4.5);
            translate([39.32-(2.54*31),10.1,,0]) cylinder(h=10,d=4.5);

            translate([34.24,-20.52,0]) cylinder(h=10,d=4.5);
            translate([34.24-(2.54*5),-20.52,0]) cylinder(h=10,d=4.5);
            translate([34.24-(2.54*10),-20.52,0]) cylinder(h=10,d=4.5);
            translate([34.24-(2.54*17),-20.52,0]) cylinder(h=10,d=4.5);
            translate([34.24-(2.54*22),-20.52,0]) cylinder(h=10,d=4.5);
            translate([34.24-(2.54*27),-20.52,0]) cylinder(h=10,d=4.5);   
        }
    translate([42,23,-3]) cylinder(h=10, r=3.5/2);
    translate([-42,23,-3]) cylinder(h=10, r=3.5/2);
    translate([42,-23,-3]) cylinder(h=10, r=3.5/2);
    translate([-42,-23,-3]) cylinder(h=10, r=3.5/2); 
    translate([0,10,0])  cylinder(h=10, r=3.5/2); 
    }
translate([0,0,-1]) union(){
 // TEXT   

//upper row
 translate([41,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Res",font = "Arial:style=Bold", size = 4);
 translate([-30,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Res",font = "Arial:style=Bold", size = 4);
 translate([27,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Del",font = "Arial:style=Bold", size = 4);
 translate([-18,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Del",font = "Arial:style=Bold", size = 4);
 translate([16,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Mem",font = "Arial:style=Bold", size = 4);
 translate([1,-13,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Speed",font = "Arial:style=Bold", size = 4);
// arm Control
 translate([46.5,12.2,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("L",font = "Arial:style=Bold", size = 4);
 translate([15,12.2,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("R",font = "Arial:style=Bold", size = 4);
 translate([-12.2,12.2,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("L",font = "Arial:style=Bold", size = 4);
 translate([-43.3,12.2,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("R",font = "Arial:style=Bold", size = 4);

translate([-5.3,-4,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("T ►",font = "Arial:style=Bold", size = 4);
    
translate([-5.3,28,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("T ◄",font = "Arial:style=Bold", size = 4);
   
translate([14,-4,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("M ►",font = "Arial:style=Bold", size = 4); 

translate([14,28,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("M ◄",font = "Arial:style=Bold", size = 4); 
    
translate([33,-4,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("B ►",font = "Arial:style=Bold", size = 4);     
    
 translate([33,28,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("B ◄",font = "Arial:style=Bold", size = 4); 
 
    translate([-26.3,-4,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Op",font = "Arial:style=Bold", size = 4);

    translate([-26.3,28,5.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Cl",font = "Arial:style=Bold", size = 4);
}

}
module ArduinoMegaCH(){
    
    color("Darkblue"){
        difference(){
        cube([102,54,4],center=true);  
        translate([51-16,-27+2.5,-15]) cylinder(h=30,r=1.5);
        translate([51-14,27-2.5,-15]) cylinder(h=30,r=1.5);
        translate([-51+11,-27+2.5,-15]) cylinder(h=30,r=1.5);
        translate([-51+5,27-2.5,-15]) cylinder(h=30,r=1.5); 
        }  
    }
    color("Black"){
        translate([-2,-24.5,7]) cube([70,2.5,10],center=true);  
        translate([-7,23,7]) cube([67,2.5,10],center=true);  
        translate([-44,-2,7]) cube([5,46,10],center=true);  
        // Plug
        translate([-2,-24,19.1]) cube([6,2.5,14],center=true); 
        //Powerplug
        translate([52,16,7]) cube([14,9,11],center=true);
    }
    color("Silver"){
        translate([52,-11,7]) cube([17,12,11],center=true);
        //screwholes
        translate([51-16,-27+2.5,-15]) cylinder(h=30,r=0.5);
        translate([51-14,27-2.5,-15]) cylinder(h=30,r=0.5);
        translate([-51+11,-27+2.5,-15]) cylinder(h=30,r=0.5);
        translate([-51+5,27-2.5,-15]) cylinder(h=30,r=0.5);
    }
}
module switchBoardSpacer(){
    difference(){
        cylinder(h=4.4, r=3);
        translate([0,0,-1]) cylinder(h=6.4, r=1.7);
    }
}
module lowerBoardSpacer(){
    difference(){
        cylinder(h=6, r=3);
        translate([0,0,-1]) cylinder(h=8, r=1.7);
    }
}
module DisplaySpacer(){
    difference(){
        cylinder(h=5,r=3);
        translate([0,0,-1]) cylinder(h=7,r=1.7);
    }
}
module DisplaySpacerlow(){
    difference(){
        cylinder(h=2,r=3);
        translate([0,0,-1]) cylinder(h=7,r=1.7);
    }
}
module SdCardReader(){
    color("DarkCyan"){
        
        translate([30,-38,-24]) rotate([0,0,0]) 
            union(){
                difference(){
                    translate([0,0,0.5]) cube([43,3,23],center=true);
                    translate([20,2,10.5]) rotate([90,0,0])cylinder(h=10, r=1);
                    translate([-20,2,10.5]) rotate([90,0,0])cylinder(h=10, r=1);
                    translate([20,2,-9.5]) rotate([90,0,0])cylinder(h=10, r=1);
                    translate([-20,2,-9.5]) rotate([90,0,0])cylinder(h=10, r=1);
                }
                
            }
        }
}
module DisplayPlate(){
    difference(){
      translate([0,-67.5,7]) rotate([-15,0,0]) 
    union(){
        difference(){
            
            //displayPlate
            union(){
              translate([0,4,5.5]) cube([110,65,3],center=true); 


//text
                translate([0,0,-1.1]) union(){
            translate([42,27,7.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("On",font = "Arial:style=Bold", size = 4);     
            translate([15,27,7.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("Off",font = "Arial:style=Bold", size = 4);           
            translate([-12,27,7.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("P",font = "Arial:style=Bold", size = 4);      
                  translate([-35,27,7.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("R",font = "Arial:style=Bold", size = 4);     
                  translate([-23,18,7.5]) rotate([0,0,180]) linear_extrude(height = 2, center = true, convexity = 10, twist = 0) text("N",font = "Arial:style=Bold", size = 4);    
                }
     
            }
            translate([0,-5,7]) cube([74,26,15],center=true); 
            translate([37.5,16-5,-15]) cylinder(h=30,r=1.8);
            translate([37.5,-16-5,-10]) cylinder(h=20,r=1.8);
            translate([-37.5,16-5,-10]) cylinder(h=20,r=1.8);
            translate([-37.5,-16-5,-10]) cylinder(h=20,r=1.8);
            
                
        
            
            //switchholes
          translate([25,25,-2]) cylinder(h=10,r=3.7);  
          translate([-25,25,-2]) cylinder(h=10,r=3.7); 
        }
        
    }  
     translate([0,-27.4,-25]) cube([120,10,70],center=true);
}
    
}
module FrontWall(){
            difference(){
                union(){
                    translate([0,31,-22.9]) cube([110,3,50],center=true);
                    translate([0,27,-41.9]) cube([110,6,6],center=true);
                    translate([42,23,-9.9]) lowerBoardSpacer();
                    translate([-42,23,-9.9]) lowerBoardSpacer();
                    translate([0,28,-6.9]) cube([110,6,6],center=true);
                    
                }
                MegaHoles();
            }
        }
module MegaHoles(){
            
        translate([0,2,-48])  union(){
            translate([51-16,-27+2.5,-15]) cylinder(h=40,r=2);
            translate([51-14,27-2.5,-15]) cylinder(h=30,r=2);
            translate([-51+11,-27+2.5,-15]) cylinder(h=30,r=2);
            translate([-51+5,27-2.5,-15]) cylinder(h=30,r=2);
        }
        
    }
module RearWall(){
    difference(){
        union(){
            translate([45,-31,-22.9]) cube([20,3,50],center=true);
            translate([0,-28,-6.9]) cube([110,6,6],center=true);
            translate([0,-29.5,-6.9]) cube([110,6,6],center=true);
            translate([-45,-31,-22.9]) cube([20,3,50],center=true);
            translate([0,-25,-41.9]) cube([110,12,6],center=true);
            translate([0,-26.5,-41.9]) cube([110,12,6],center=true);

            translate([42,-23,-9.9]) lowerBoardSpacer();
            translate([-42,-23,-9.9]) lowerBoardSpacer();
        }
        MegaHoles();
        translate([48,36.5,-6.9]) rotate([90,0,0])cylinder(h=70,r=1.7);
        translate([48,36.5,-41.5]) rotate([90,0,0])cylinder(h=70,r=1.7);
        translate([-48,36.5,-6.9]) rotate([90,0,0])cylinder(h=70,r=1.7);
        translate([-48,36.5,-41.5]) rotate([90,0,0])cylinder(h=70,r=1.7);
    }     
}
module BoardSpacer(){
            translate([42,23,-2.3]) switchBoardSpacer();
            translate([-42,23,-2.3]) switchBoardSpacer();
            translate([42,-23,-2.3]) switchBoardSpacer();
            translate([-42,-23,-2.3]) switchBoardSpacer();
}
module MegaSpacer(){
            translate([0,2,-24])  union(){
            translate([51-16,-27+2.5,-15]) cylinder(h=3,r=3);
            translate([51-14,27-2.5,-15]) cylinder(h=3,r=3);
            translate([-51+11,-27+2.5,-15]) cylinder(h=3,r=3);
            translate([-51+5,27-2.5,-15]) cylinder(h=3,r=3);
        }
        translate([36,2,-38]) rotate([0,0,-2])cube([3,44,2],center=true);
        translate([-43,2,-38]) rotate([0,0,7])cube([3,45,2],center=true);
}
module RightWall(){
    difference() {
        union(){
            translate([-45,-47,4.4]) rotate([-15,0,0]) cube([20,28,2.2],center=true);
            translate([-45,-34,-22.9]) cube([20,3,50],center=true);
            translate([-53.5,-3,0]) rotate([0,90,0]) linear_extrude(height = 3, center = true, convexity = 10, twist = 0) polygon(points=[[-2,-30.5],[37,-30],[37,-32],[-15.6,-90.6],[-18.2,-90.7]], paths=[[0,1,2,3,4]]);
        }
        translate([-48,30.5,-6.9]) rotate([90,0,0])cylinder(h=70,r=1.7);
        translate([-48,30.5,-41.5]) rotate([90,0,0])cylinder(h=70,r=1.7);  
            translate([0,-68,5]) rotate([-15,0,0]) 
                union(){
                    translate([37.5,16-5,-10]) cylinder(h=20,r=1.8);
                    translate([37.5,-16-5,-10]) cylinder(h=20,r=1.8);
                    translate([-37.5,16-5,-10]) cylinder(h=20,r=1.8);
                    translate([-37.5,-16-5,-10]) cylinder(h=20,r=1.8);            
                }
       translate([-35,-64,6.4]) rotate([-15,0,0]) rotate([0,0,-60]) cube([10,10,10],center=true);
                       translate([-55,-40,-10]) cube([10,5,2],center=true);
       translate([-55,-40,-15]) cube([10,5,2],center=true);
       }


}
module LeftWall(){
    difference(){
            union(){
                /*
                translate([30,-30,-24]) rotate([0,0,0]) 
                    union(){
                        translate([20,-5,10.5]) rotate([90,0,0])cylinder(h=2, r=2);
                        translate([-20,-5,10.5]) rotate([90,0,0])cylinder(h=2, r=2);
                        translate([20,-5,-10.5]) rotate([90,0,0])cylinder(h=2, r=2);
                        translate([-20,-5,-10.5]) rotate([90,0,0])cylinder(h=2, r=2);
                    
                */
                translate([45,-47,4.4]) rotate([-15,0,0]) cube([20,28,2.2],center=true);
                translate([45,-34,-22.9]) cube([20,3,50],center=true);
                //translate([30,-34,-23.9]) cube([50,3,25],center=true);
                translate([53.5,-3,0]) rotate([0,90,0]) linear_extrude(height = 3, center = true, convexity = 10, twist = 0) polygon(points=[[-2,-30.5],[37,-30],[37,-32],[-15.6,-90.6],[-18.2,-90.7]], paths=[[0,1,2,3,4]]);
            }
            // SD Cutout
            translate([36,-38.7,-25]) cube([43,3.5,13.5],center=true); 
          
            
            // Sd Srewholes
            translate([30,-30,-24]) rotate([0,0,0]) 
            union(){
                translate([20,2,10.5]) rotate([90,0,0])cylinder(h=10, r=1);
                //translate([-20,2,10.5]) rotate([90,0,0])cylinder(h=10, r=1);
                translate([20,2,-9.5]) rotate([90,0,0])cylinder(h=10, r=1);
                //translate([-20,2,-10.5]) rotate([90,0,0])cylinder(h=10, r=1);
                }
                //bottom holes
           translate([0,-30,0]) union(){
                translate([48,36.5,-6.9]) rotate([90,0,0])cylinder(h=70,r=1.7);
                translate([48,36.5,-41.5]) rotate([90,0,0])cylinder(h=70,r=1.7);
                }
            translate([0,-68,5]) rotate([-15,0,0]) union(){
                translate([37.5,16-5,-10]) cylinder(h=20,r=1.8);
                translate([37.5,-16-5,-10]) cylinder(h=20,r=1.8);
                translate([-37.5,16-5,-10]) cylinder(h=20,r=1.8);
                translate([-37.5,-16-5,-10]) cylinder(h=20,r=1.8);
                    
            }
            translate([35,-64,6.4]) rotate([-15,0,0]) rotate([0,0,60]) cube([10,10,10],center=true);
        }
    
}

module ControllerCase(){
//DisplayPlate();
    difference(){
        union(){

            ControllerTopCover();
            BoardSpacer();

            DisplayPlate();

            //walls
            FrontWall();
            RearWall();
            MegaSpacer();
            RightWall();
            LeftWall();
        }


        MegaHoles();
    }
    
}
module ControlCaseSpacer(){
    difference(){
        cylinder(h=57, r=3);
        translate([0,0,-1])cylinder(h=59, r=1.7);
    }
}
module OnSwitch(){
    color("Silver"){
        translate([0,0,5])cylinder(h=9.8, r=3);
        translate([0,0,15]) rotate([10,0,0]) cylinder(h=9, r1=1.1, r2=1.5); 
     translate([0,0,9])cylinder(h=2, r=5, $fn=6);   
    }
    color("Lightblue"){
        translate([0,0,0]) cube([8,13,10],center=true);
    }
}
module ModeSwitch(){
    
    color("Silver"){
        translate([0,0,5])cylinder(h=9.8, r=3);
        translate([0,0,15]) rotate([10,0,0]) cylinder(h=9, r1=1.1, r2=1.5);  
        translate([0,0,9])cylinder(h=2, r=5, $fn=6);
    }
    color("DarkBlue"){
        translate([0,0,0]) cube([13,14,10],center=true);
    }
    
}
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
module PowerSupply(){
    
    
    PsRearPlate();
    PsFrontPlate();
    PsTopPlate();
}
//END MODULES

//RobotArm Whole Parts Begin
if (ShowRobotArm == 1){
 //   difference(){
    union(){
    //base begin
    BaseCone();
    TopPlate();
    MiddlePlateConnector();
    InnerLowerPlate();
    BaseServoMount();
    // base end
        
    //// LOWER ARMS begin
    //front arm
    lowerFrontArm();
    //rear arm
    lowerRearArm();
    //// LOWER ARMS end
    
    //// UPPER ARM begin
    upperFrontArm();
    upperRearArm();
    //// UPPER ARM end
    
    ////WRIST begin
    wristMount();
    ////WRIST end
    
    // Robot Claw 
    translate([-10,0,402]) rotate([0,0,90]) RobotClaw();
    
    //Electronics
    translate([-39,15,0]) A9685Bumper2();
    rotate([0,0,90]) translate([0,150,30]) PowerSupply();
    //Controller
    translate([-150,-100,50]) ControllerCase();
}
    // DIFF
   // translate([150,150,0]) cube([300,300,1000],center=true);
//}
    
}

//// WHOLE PARTS end



//PRINTING
if(ShowRobotArm == 0){

//RobotClaw for printing Rotoate if necessary
//rotate([0,270,0]) RightClawBase();
//LeftClawBase();
// rotate([0,90,0])ClawCenterMount();
//rotate([0,90,0]) RightGear();
//rotate([0,90,0]) LeftGear();
 //rotate([0,90,0]) LeftFrontBar();
//RightFrontBar();
//rotate([0,270,0]) LeftRearBar();
//RightRearBar();
// rotate([0,90,0]) LeftGripper();
 //rotate([0,90,0]) RightGripper();
// arms
//Rotate for print

/*
difference(){
    translate([-280,-0.5,-20])rotate([0,90,0])upperRearArm();
    //translate([10,10,0]) cube([100,30,20],center=true); 
}
//upperreararm print support
union(){
    translate([25+40,6.7,0.4]) cube([0.6,6.7,4.8],center=true);
    translate([25,0,0.4]) cube([0.6,7.6,4.8],center=true);
    translate([25+40,-6.6,0.4]) cube([0.6,6.7,4.8],center=true);
    translate([45,9.7,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,3.5,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,-3.5,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,-9.7,0.4]) cube([40,0.6,4.8],center=true);

    }
translate([-91,0,0]) union(){
    translate([25+40,6.7,0.4]) cube([0.6,6.7,4.8],center=true);
    translate([25,0,0.4]) cube([0.6,7.6,4.8],center=true);
    translate([25+40,-6.6,0.4]) cube([0.6,6.7,4.8],center=true);
    translate([45,9.7,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,3.5,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,-3.5,0.4]) cube([40,0.6,4.8],center=true);
    translate([45,-9.7,0.4]) cube([40,0.6,4.8],center=true);
    }
*/

//rotate([0,90,0])lowerFrontArm();

//rotate([0,90,0]) upperFrontArm();
rotate([0,90,0]) lowerRearArm();


//wrist
//rotate([0,180,0])  wristMount();
// Baseparts
//rotate([0,180,0]) InnerLowerPlate();
//BaseServoMount();

//BASEPRINT
//rotate([0,180,0]) BaseCone();

//TopPlatePrint();

//MiddleplateconnectorPrint upper part
//difference(){
 //   MiddlePlateConnector();
  //  cylinder(h=52,r=50);
//}
//MiddleplateconnectorPrint lower part
//difference(){
//    MiddlePlateConnector();
//    translate([0,0,51.99]) cylinder(h=52,r=50);
//} 
//rotate([0,90,0]) TPServoMount();


// electronics
//translate([-39,15,0]) A9685Bumper1();
//rotate([0,180,0]) translate([-34,15,0]) A9685Bumper2();


    difference(){
        union(){

            //rotate([0,0,0]) ControllerTopCover();
            
            //switchBoardSpacer(); // 5 Stk
            //DisplaySpacer(); // 2 Stk
            //rotate([15,0,0])DisplayPlate();

            //walls
            //rotate([270,0,0]) FrontWall();
            //rotate([90,0,0]) RearWall();
            //MegaSpacer(); 
            //rotate([0,270,0]) RightWall();
            //rotate([0,90,0]) LeftWall();
            // DisplaySpacerlow(); //2 Stk
        }

       //MegaHoles();
    }
 //Powersupply   
    //PsTopPlate();
//rotate([0,-90,0]) PsRearPlate();   
//rotate([0,90,0]) PsFrontPlate();
 // Printplate


// print end
}


//// DUMMIES begin
if (ShowBallBearings == 1){
    //BallBear Topplate
    //BallBearing (10x4mm, 3mm) for Base Plate 
    color("Silver",1){ 
        translate([50,0,59])rotate([0,90,0]) BasePlateBallb();
        rotate([0,0,90]) translate([50,0,59])rotate([0,90,0]) BasePlateBallb();
        rotate([0,180,0]) translate([50,0,-59])rotate([0,90,0]) BasePlateBallb();
        rotate([0,0,270]) translate([50,0,59])rotate([0,90,0]) BasePlateBallb();
        }
    // lower ballbears
    color("Silver",1){
        translate([35,0,50])rotate([0,90,0]) BasePlateBallb();
        rotate([0,0,90]) translate([35,0,50])rotate([0,90,0]) BasePlateBallb();
        rotate([0,0,180]) translate([35,0,50])rotate([0,90,0]) BasePlateBallb();
        rotate([0,0,270]) translate([35,0,50])rotate([0,90,0]) BasePlateBallb();
        }
    }

if (ShowServoDummies == 1){
    //Base Servo
    translate([-10,-10,0]) ServoMainPart();
    
    //Dual Servos
    translate([-22,-10,118]) rotate([0,90,0]) ServoMainPart();
    translate([-72,-10,118]) rotate([0,90,0]) ServoMainPart();
    
    //upper arm Servos
    //lower servo
    translate([-22,10.5,214]) rotate([0,-90,180]) ServoMainPart();//-22
    //upper servo
    translate([-22,-9.5,345]) rotate([0,90,0]) ServoMainPart();//-22
    
    //wrist servo
    translate([-20,-9.5,357]) rotate([0,0,0]) ServoMainPart();//-22
    

}

if (ShowScrewDummies == 1){
    //lowerarm screws trough
    color("Silver",1){
        translate([-32,8,185]) rotate([0,90,0]) cylinder(h=62,d=3);
        translate([-32,-8,185]) rotate([0,90,0]) cylinder(h=62,d=3);
        translate([-32,8,145]) rotate([0,90,0]) cylinder(h=62,d=3);
    translate([-32,-8,145]) rotate([0,90,0]) cylinder(h=62,d=3);
    }
    

}

if (ShowTurnAxis == 1){
    color("red"){
        translate([-35,0.5,224]) rotate ([0,90,0])cylinder(d=3, h=85, $fn=36);
        translate([-35,0.5,335]) rotate ([0,90,0])cylinder(d=3, h=85, $fn=36);
    }

}

if (ShowControlparts == 1){
    
    translate([-150,-100,50])
    union(){//ControllerCase();
    switchButtonBoard();
    translate([0,2,-34]) ArduinoMegaCH();
    SdCardReader();
    translate([0,-67.5,7.8]) rotate([-15,0,0]) 
    union(){
        translate([0,-5,0])  Display16x2(); 
        translate([25,25,-2]) OnSwitch();
        translate([-25,25,-2]) ModeSwitch();
    }
}
 
    color("green"){
    rotate([0,0,90]) translate([0,150,30]) translate([0,-5,-22]) cube([70,50,1],center=true);
}


}



//// DUMMIES end


