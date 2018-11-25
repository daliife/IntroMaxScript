clearListener() 							
delete $objects

-- Information text
t1 = TextPlus Plane:0 name:"spline_text" size:8 pos:[0,-50,0] wirecolor:(color 255 255 255)
t1.SetPlaintextString("Spline filled with objects")

-- Function that creates a two-point spline
fn drawLineBetweenTwoPoints pointA pointB =
(
  ss = SplineShape pos:pointA name:"spline_temporal"
  addNewSpline ss
  addKnot ss 1 #corner #line PointA
  addKnot ss 1 #corner #line PointB
  updateShape ss
  ss
)

-- Spline creation calling function
input_spline = drawLineBetweenTwoPoints [-50,0,0] [50,0,0]

-- Filling spline surroundings with props
density = 200 as float
for i = 0 to density do (
	road_point = lengthInterp input_spline (i/density)
	road_tangent = lengthtangent input_spline 1 (i/density)
	road_off_dir = cross road_tangent  [0,0,1]

	new_pos1 = road_point + (random 5 22) * road_off_dir
	new_pos2 = road_point - (random 5 22) * road_off_dir
	b1 = box name:("prop_" + i as string) pos:new_pos1 scale:[0.1,0.1,0.1]
	b2 = box name:("prop_" + i as string) pos:new_pos2 scale:[0.1,0.1,0.1]
	local amount = random 0 4	
)