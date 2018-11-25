clearListener() 							
delete $objects 	

-- Information text
t = TextPlus Plane:0 name:"raytrace_text" size:14 pos:[0,-60,0] wirecolor:(color 255 255 255)
t.SetPlaintextString("Ray intersections")

-- Primitive object example to cast ray and place object on
cone pos:[0,0,0] name:("raytrace_sphere") wirecolor:green scale:[2,2,3]

-- Raytracer function
rayPicker_primitive = box
tool rayPicker
(
	on mousePoint clickno do
	(
		ry = mapScreenToWorldRay mouse.pos
		myray = ray ry.pos ry.dir
		local intersect = intersectRayScene myray
		
		if intersect.count > 0 do
		(
			rayPicker_primitive name:"raytracer_primitive" pos:intersect[1][2].pos scale:[0.1,0.1,0.1] wirecolor:(color (random 0 255) 0 0)
		)
	)
)

-- Widget instantiation and parameters
rollout RaytracerWidget "Raytracer Widget tool" width:245 height:106
(
	button 'btn1' "Apply" pos:[11,63] width:220 height:29 align:#left
	dropDownList 'ddl1' "Spawn primitive type" pos:[11,11] width:219 height:40 align:#left items:#("sphere","box","teapot")
	
	on btn1 pressed do (
		case ddl1.selection of
		(
			1: rayPicker_primitive = sphere
			2: rayPicker_primitive = box
			3: rayPicker_primitive = teapot
			default: box
		)
		
		stopTool rayPicker
		startTool rayPicker
		
	)
	
)

-- Widget creation
createDialog RaytracerWidget