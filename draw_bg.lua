-- draw_bg.lua
-- draws a radial gradient behind everything else

require "cairo"

function conky_draw_bg()
  if conky_window == nil then return end

  -- get the Conky window dimensions
  local w = conky_window.width
  local h = conky_window.height

  -- create a Cairo surface for the Conky window
  local cs = cairo_xlib_surface_create(
    conky_window.display,
    conky_window.drawable,
    conky_window.visual,
    w, h
  )
  local cr = cairo_create(cs)

  -- center point and radius
  local cx, cy = w/2, h/2
  local radius = math.max(w, h)/2

  -- build a radial pattern:
  --   inner circle at (cx,cy) radius 0
  --   outer circle at (cx,cy) radius = half the larger dimension
  local pat = cairo_pattern_create_radial(cx, cy, 0, cx, cy, radius)

-- COLOR SECTION
  -- For all color stops in this section, you'll edit the values in parentheses to change colors. The first locates where  
  --	the color begins along the gradient's radial (its offset), the next three numbers are 'normalized RGB' values, 
  --	that define the exact color, and the last number is the color's opacity.

  -- The first color‑stop below is the gradient's starting color. It's located at the center of the radial gradient(0.0),
  --	It's a light-blue (0.863, 0.894, 0.804) with 80% opacity (0.8).
  cairo_pattern_add_color_stop_rgba(pat, 0.0, 0.863, 0.894, 0.804, 0.8)

  -- The next two colors are unused in my Conky, but they demonstrate that you can have a gradient with 
  --	multiple color stops. Notice the offsets (first number) begin 1/3 and 2/3 of the way from the center of the 
  --	gradient. And the opacities get lighter as the gradient moves to fully transparent by the last color stop.  
  --cairo_pattern_add_color_stop_rgba(pat, 0.33, 0.863, 0.894, 0.804, 0.5)
  --cairo_pattern_add_color_stop_rgba(pat, 0.66, 0.863, 0.894, 0.804, 0.25)

  -- The last color‑stop is at the outer edge of the radial gradient (1.0) The color is technically white (1.0, 1.0, 1.0) 
  --	but it doesn't really matter because the opacity is 0.0, making it fully transparent.
  cairo_pattern_add_color_stop_rgba(pat, 1.0, 1.0, 1.0, 1.0, 0.0)  
-- END COLOR SECTION

  -- paint it
  cairo_set_source(cr, pat)
  cairo_paint(cr)

  -- clean up
  cairo_pattern_destroy(pat)
  cairo_destroy(cr)
  cairo_surface_destroy(cs)
end
