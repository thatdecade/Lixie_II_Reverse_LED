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

digits = 4; //Min is 1

chamfer = 2;

screw_hole_diameter = 3; //M3 = 3mm

want_button = 1;

want_power_cable = 1;

switch_hole_diameter = 12; //set want_button=1

usb_cable_diameter = 5;  //set want_power_cable=1

// ********************
// CALCULATED
// ********************

side_wall_thickness = 2; //2 or 3mm

top_wall_thickness = 2 ;

loose_fit = 2.0;
slide_fit = 0.2;
friction_fit = 0.02;

center_digits = digits-2;

edge_length = 74.3;
center_length = 70.3;

outer_length_x = edge_length*2 + center_digits*center_length;
outer_width_y  = 70;

outer_depth_z  = 26 + top_wall_thickness;

switch_hole_z_offset_from_center = outer_depth_z/2-top_wall_thickness/2;

// ********************
// MODULES
// ********************

difference()
{
    union()
    {
        outer_base_shape(use_chamfer=true);
        draw_switch_outline();
    }
    
    inner_base_shape();
    
    display_and_screw_cutouts();
    
    if(want_button) draw_button();
        
    if(want_power_cable) draw_power_cable();
}

module draw_power_cable()
{
    
    hole_depth = side_wall_thickness*2;
    x_position = outer_length_x-(edge_length-side_wall_thickness*2);
    
    //switch_hole_diameter
    translate([x_position,outer_width_y-hole_depth-0.1,usb_cable_diameter/2-0.5]) 
    //cube([usb_cable_diameter,hole_depth+0.2,usb_cable_diameter]);
    rotate([-90,0,0])
    cylinder(d=usb_cable_diameter, h=hole_depth+0.2, $fn=25);
}

module screw_hole()
{
    //for nuts and bolts to BASES.dxf
    cylinder(d=screw_hole_diameter + slide_fit*2 + slide_fit*2, h=outer_depth_z*2, $fn=25);
}

module screw_hole_set(x_offset)
{
    edge_x_offset = 11+x_offset;
    edge_y_offset = 11;
    window_width = 56.3;
    
    translate([edge_x_offset,edge_y_offset,0]) screw_hole();
    translate([edge_x_offset,outer_width_y-edge_y_offset,0]) screw_hole();
    
    translate([window_width+edge_x_offset,edge_y_offset,0]) screw_hole();
    translate([window_width+edge_x_offset,outer_width_y-edge_y_offset,0]) screw_hole();
}

module draw_button()
{
    draw_switch_holes();
}


module draw_switch_cyl(diameter)
{
    hole_depth = side_wall_thickness*1.1;
    x_position = outer_length_x-(edge_length-side_wall_thickness*2);
    
    //switch_hole_diameter
    translate([x_position,0+hole_depth/2-0.01,switch_hole_z_offset_from_center]) rotate([90,0,0]) cylinder(h=hole_depth, d=diameter);
}

module draw_switch_outline()
{
    switch_outline_pad = 2.25;
    draw_switch_cyl(switch_hole_diameter+switch_outline_pad);
}

module draw_switch_holes()
{
    translate([0,-0.01,0]) draw_switch_cyl(switch_hole_diameter);
    translate([0,2,0]) draw_switch_cyl(switch_hole_diameter+4);
}


module display_and_screw_cutouts()
{
    x_offset = center_length;
    
    display_cutout(0);
    screw_hole_set(0);
    
    if(center_digits > 0)
    {
        for(i = [0 : center_digits])
        {
            screw_hole_set(x_offset*(i+1));
            display_cutout(x_offset*(i+1));
        }
        display_cutout(x_offset*(center_digits+1));
    }
    else
    {
        display_cutout(x_offset);
        screw_hole_set(x_offset);
    }
}

module display_cutout(x_offset)
{
    translate([14.55+x_offset,11.55,-0.5])
    cube([49.2,46.9,outer_depth_z+1]);
}

module outer_base_yz_2d_shape(chamfer_adj)
{
    polygon(points=[
        [0,0],
        [outer_depth_z-chamfer_adj, 0],
        [outer_depth_z,             chamfer_adj],
        [outer_depth_z,             outer_width_y-chamfer_adj],
        [outer_depth_z-chamfer_adj, outer_width_y],
        [0,                         outer_width_y],
    ]);
}

module outer_base_xz_2d_shape(chamfer_adj)
{
    polygon(points=[
        [0,0],
        [outer_depth_z-chamfer_adj, 0],
        [outer_depth_z,             chamfer_adj],
        [outer_depth_z,             outer_length_x-chamfer_adj],
        [outer_depth_z-chamfer_adj, outer_length_x],
        [0,                         outer_length_x],
    ]);
}


module outer_base_shape(use_chamfer)
{
    chamfer_adj = use_chamfer ? chamfer : 0;
    
    intersection()
    {
        translate([outer_length_x,0,0])
        rotate([0,-90,0])
        linear_extrude(outer_length_x) 
        outer_base_yz_2d_shape(chamfer_adj);
        
        translate([0,0,0])
        rotate([-90,-90,0])
        linear_extrude(outer_width_y) 
        outer_base_xz_2d_shape(chamfer_adj);
    }
}

module inner_base_shape()
{
    translate([side_wall_thickness,side_wall_thickness,-0.1])
    resize([outer_length_x-side_wall_thickness*2, outer_width_y-side_wall_thickness*2, outer_depth_z-top_wall_thickness]) 
    outer_base_shape(use_chamfer=false);
}   

