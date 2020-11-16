// # SYNOPSIS
// Yields a customizeable star 2D polygon.
//
// # PARAMETERS
//
// n       :: This is the number of spikes you want your star to have. 
//            Please note that a spike is a spike regardless of its height.
//            Please also note that two consecutive ends of a segment are
//            assumed to either be the 'top' and 'low' of one spike.
//
// heights :: A vector consisting of the heights pattern.
//
// # EXAMPLES
//
// ## Basic example
// Here is a basic example that draws the typical 5 spiked "US star"
// ```
// linear_extrude(3) star(5, [15, 6]);
// ```
//
// ## More complete example
// Assuming you'd want to draw a pretty star with alternating long and short 
// spikes, you would want to use this module as follows:
// ```
// linear_extrude(5)           // Star is nothing but the polygon, give it 
//                             // some thickness by extruding it.
//   offset(r=.5)              // If you want rounded corners
//   star(10, [15, 5, 10, 5]); // Yields the 2D star polygon
// ```
// 
// # CREDITS
//
// This design was inspired by @annoved's star module 
// (https://gist.github.com/anoved/9622826) but I altered it so as to deal
// with "irregular" stars having 'spikes' of various heights.
//
module star(n, heights) {
    angle             = 360 / (2*n); // The angle between any two points
    function x(r, a)  = r * cos(a);  // x-member of a 2d coordinate
    function y(r, a)  = r * sin(a);  // y-member of a 2d coordinate
    function h(i)     = heights[i % len(heights)]; // height of the ith vertex
    function point(i) = [ x(h(i), i * angle), y(h(i), i * angle) ];
    
    coordinates = [ for(i = [0:(2*n)-1]) point(i) ];
    polygon(points=coordinates);
}


// Basic example
linear_extrude(3) offset(r=.5) star(5, [15, 6]);

// Advanced example
translate([30, 0, 0])
linear_extrude(5) offset(r=.5) star(10, [15, 5, 10, 5]);
