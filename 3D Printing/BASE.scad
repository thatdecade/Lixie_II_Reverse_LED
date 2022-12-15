/* This is a customizable housing for lixie displays

    Dustin Westaby 
    Nov 2022

    USAGE:
    
    Enter the number of displays you want, and you will get an object that you can print as is, or split up for your printer
    
*/

// ********************
// USER DEFINES
// ********************
// Set options here

black_melamine_mdf_thickness = 6.4;
mdf_stack_height = 2;

want_tolerance_for_acrylic  = 1;
want_screw_threaded_inserts = 1;

// ********************
// CALCULATED
// ********************

loose_fit = 2.0;
slide_fit = 0.2;
friction_fit = 0.02;

total_height = black_melamine_mdf_thickness*mdf_stack_height;

// ********************
// MODULES
// ********************

difference()
{
    union()
    {
        base_slice("3mm holder");
        base_slice("1.5mm holder");
    }
    if(want_screw_threaded_inserts) threaded_inserts();
}

module base_slice(part="3mm holder")
{
    scale_adj      = (part=="3mm holder") ? 1 : 1.01;
    x_position_adj = (part=="3mm holder") ? 0 : -0.25;
    
    translate([x_position_adj,0,0])
    linear_extrude(height=total_height)
    {
        scale([scale_adj,1,1]) //no scale change
        difference()
        {
            if(want_screw_threaded_inserts) import("BASE_NoHoles.dxf");
            else                            import("BASE.dxf");
            
            if(want_tolerance_for_acrylic)
            {
                if(part=="3mm holder") translate([-8,-8,0]) square(size = [65, 42]);
                else translate([-8,42-8,0]) square(size = [65, 20]);
            }

        }
    }
}

module threaded_inserts()
{
    
    insert_hole_diameter = 3.73 + slide_fit;
    $fn=25;
    
    //inner holes
    translate([ 4.7,41.54,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([44.2,41.54,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([ 4.7,3.54,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([44.2,3.54,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    
    //outer holes
    translate([ -3.7,46.55,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([52.6,46.55,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([ -3.7,-1.45,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
    translate([52.6,-1.45,-1]) cylinder(d=insert_hole_diameter, h= total_height+2);
}