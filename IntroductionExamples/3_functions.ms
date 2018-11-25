clearListener()
delete $objects

-- Information text
t = TextPlus Plane:0 name:"text_functions" size:6 pos:[0,-10,0] wirecolor:(color 255 255 255)
t.SetPlaintextString("Functions")

global max_depth = 5

-- Function implementation with recursive tree exercise.
function createChildren childAmount depth = (
	
	b = box name:(depth as string) width:1 height:1 length:1
	depth = depth + 1
	
	if depth > max_depth do
		return b
	
	initial = (b.pos.x - childAmount/2) 
	
	for i = 1 to childAmount do (
		child = createChildren childAmount depth
		child.parent = b
		child.pos = [initial, depth, 0]
		initial += i*2
	)
	
	return b
	
)

-- Function being called
createChildren 2 0