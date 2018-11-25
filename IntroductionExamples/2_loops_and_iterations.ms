clearListener()
delete $objects

-- Information text
t = TextPlus Plane:0 name:"text_loops_and_iterations" size:10 pos:[0,-80,0] wirecolor:(color 255 255 255)
t.SetPlaintextString("Loops and iterations")

-- Example of double 'for loop' to create grid of objects
for i = 0 to 10 do (
	for j = 0 to 10 do (
		if mod i 2 == 0 and mod j 2 == 0 then (
			sphere name:("Red Sphere (x:" + i as string + " y:" + j as string + ")") pos:[-50 + 10*i,-50 + 10*j,6] radius: 5 wirecolor:(color 255 0 0)

		)else(
			sphere name:("Yellow Sphere (x:" + i as string + " y:" + j as string + ")") pos:[-50 + 10*i,-50 + 10*j,6] radius: 2 wirecolor:(color 255 255 0)
		)
	)
)

-- Example of 'for each' iterating all objects in the scene to modify some transform values.
for item in $objects do(
	if classOf item as string != "TextPlus" then (
		if item.wirecolor.r == 255 and item.wirecolor.g == 255 then(
			scale item [2,0.5,0.5]
			rotate item (eulerangles -45 0 0)
		)
	)
)