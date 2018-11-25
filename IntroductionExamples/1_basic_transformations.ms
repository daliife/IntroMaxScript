clearListener()
delete $objects

-- Information text
global names= #("creation","movement","scaling","rotation")
for i = 0 to 3 do (
	temp = -50 + i*50 
	t = TextPlus Plane:0 name:("text_" + names[i+1] as string) size:10 pos:[temp,-50,0] wirecolor:(color 255 255 255)
	t.SetPlaintextString(names[i+1])
)
	
-- Primitive creation. We can use diferent type of primitives: box, sphere, plane,...
box name:"box_creation" wirecolor:(color 255 0 0) pos:[-50,0,0]

-- Primitive displacement. It's important to check the units setup, it will affect the results.
box name:"box_movement" wirecolor:(color 0 255 0) pos:[0,0,0]
move $box_movement [0,0,15]

-- Primitive scaling
box name:"box_scale" wirecolor:(color 0 0 255) pos:[50,0,0]
scale $box_scale [0.5,0.5,2]

-- Primitive rotation
box name:"box_rotation" wirecolor:(color 255 255 0) pos:[100,0,0]
rotate $box_rotation (eulerangles 0 15 45)