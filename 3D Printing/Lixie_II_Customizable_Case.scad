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

digits = 2; //Min is 1

chamfer = 2;

screw_hole_diameter = 3; //M3 = 3mm

want_button = 0;

want_power_cable = 1;

want_pre_cuts_and_glue_tabs = 1;

switch_hole_diameter = 12; //set want_button=1

usb_cable_diameter = 5;  //set want_power_cable=1

window_x = 59.05;
window_y = 29.20;

max_printer_bed_size = 180; //set want_pre_cuts_and_glue_tabs=1, Prusa Mk3 = 21cm (8.3")

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

window_x_size_adj = window_x + loose_fit;
window_y_size_adj = window_y + loose_fit;

glue_tab_insert_depth = 4;

// ********************
// MODULES
// ********************

//max_printer_bed_size
if((want_pre_cuts_and_glue_tabs == 0) || outer_length_x < max_printer_bed_size)
{
    draw_body();
}
else
{
    cut_offsets = glue_tab_insert_depth*2;
    
    //cut up the body every max_printer_bed_size size

    number_of_cuts = ceil(outer_length_x / max_printer_bed_size); //round up
    negative_width = number_of_cuts - 1;
    
    //left side
    draw_body_cut(
        x1_position = outer_length_x * 1 / number_of_cuts, 
        cut_width  = outer_length_x  * negative_width / number_of_cuts, 
        cut_offset = cut_offsets * 0, 
        want_tabs  = true);
    
    //inner parts
    if(number_of_cuts-2 > 0)
    {
        for(i = [1 : number_of_cuts-2])
        {
            cut_width = outer_length_x  * negative_width / number_of_cuts;
            slice_width = outer_length_x / number_of_cuts;
            
            draw_body_cut(
                x1_position = -cut_width+slice_width*i, 
                x2_position = slice_width*(i+1), 
                cut_width  = cut_width,
                cut_offset = cut_offsets * i, 
                want_tabs  = true);
        }
    }
    
    //right side
    draw_body_cut(
        x1_position = 0, 
        cut_width  = outer_length_x  * negative_width / number_of_cuts, 
        cut_offset = cut_offsets * (number_of_cuts-1), 
        want_tabs  = false);
    
}

module draw_body_cut(x1_position, x2_position=0, cut_width, cut_offset, want_tabs=false)
{
    translate([cut_offset,0,0]) 
    difference()
    {
        draw_body();
        
        //cutter 1
        translate([x1_position-1,-1,-1]) 
        cube([cut_width+2,outer_width_y+2,outer_depth_z+2]);
        
        //cutter 2
        if(x2_position != 0) translate([x2_position-1,-1,-1]) 
        cube([cut_width+2,outer_width_y+2,outer_depth_z+2]);
    }
    if(want_tabs)
    {
        if(x2_position > 0)
        {
            glue_tabs((x2_position - 1 + cut_offset) - glue_tab_insert_depth);
        }
        else
        {
            glue_tabs((x1_position - 1) - glue_tab_insert_depth);
        }
    }
}

module draw_body()
{
    difference()
    {
        union()
        {
            outer_base_shape(use_chamfer=true);
            if(want_button) draw_switch_outline();
        }
        
        inner_base_shape();
        
        display_and_screw_cutouts();
        
        if(want_button) draw_button();
            
        if(want_power_cable) draw_power_cable();
    }
}

//TBD, tabs
module glue_tabs(x_position)
{
    translate([x_position,0,0])
    {
        translate([0,side_wall_thickness,0])
        glue_tab();
        
        translate([0,outer_width_y-side_wall_thickness*2,0])
        glue_tab();
    }
}

module glue_tab()
{
    z_alignment = 0.5;
    
    tab_height = outer_depth_z-top_wall_thickness*2-4;
    
    //tab
    cube([glue_tab_insert_depth*2, side_wall_thickness, tab_height+z_alignment]);
    
    //printability ledge
    translate([-glue_tab_insert_depth+0.68,0,0])
    difference()
    {
        translate([0,0,tab_height+z_alignment])
        rotate([0,45,0]) cube([glue_tab_insert_depth*2, side_wall_thickness, glue_tab_insert_depth*2]);
        
        translate([-glue_tab_insert_depth*1.17,-2,0])
        cube([glue_tab_insert_depth*2, side_wall_thickness+4, tab_height*2+z_alignment]);
    }
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
    display_x_position = -window_x_size_adj/2+39+x_offset;
    display_y_position = -window_y_size_adj/2+35;
    
    translate([display_x_position,display_y_position,-0.5])
    cube([window_x_size_adj,window_y_size_adj,outer_depth_z+1]);
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

