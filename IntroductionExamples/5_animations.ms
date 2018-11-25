clearListener() 							
delete $objects 	

-- Information text
t1 = TextPlus Plane:0 name:"sequential_text" size:8 pos:[20,-40,0] wirecolor:(color 255 255 255)
t1.SetPlaintextString("sequential")
t2 = TextPlus Plane:0 name:"manual_text" size:8 pos:[-20,-40,0] wirecolor:(color 255 255 255)
t2.SetPlaintextString("manual")

-- Add keyframes manual
manual_box = teapot name:"manual_box" wirecolor:(color 255 255 0) pos:[-20,0,0] radius:15
rotate $manual_box (eulerangles 0 0 180)
with animate on(
	at time 0 manual_box.pos.z = 0
	at time 100 manual_box.pos.x = -100
)

-- Add keyframes sequentialy
sequential_box = teapot name:"sequential_box" wirecolor:(color 255 0 0) pos:[20,0,0] radius:15
animate on for t = 0 to 100 by 5 
do at time t(
	sequential_box.position = sequential_box.position + [5,0,0]
)