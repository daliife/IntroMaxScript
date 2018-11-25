clearListener() 							-- Clear listener screen (or ctrl + D)
delete $objects 							-- Deletes all the objects in the scene

-- BASIC MOVEMENT/SCALE FUNCTIONS 
box name:"boringbox" wirecolor:(color 255 0 0) pos:[0,0,0]
move $boringbox [-20,0,0]
scale $boringbox [0.5,0.5,1]
rotate $boringbox (eulerangles 0 0 45)

-- FOR LOOPS CREATION
for i = 0 to 10 do
	if mod i 2 == 0 then (
		b = sphere name:(i as string) pos:[3,4*i,6] radius: 2
		b.parent = boringbox -- parent/child linking
	)else(
		b = sphere name:(i as string) pos:[0,4*i,5] radius: 3
		b.parent = boringbox -- parent/child linking		
	)

-- EXTRUSTION EXAMPLE
d = plane widthsegs:10 lengthsegs:10 pos:[25,0,0]
p = convertToPoly(d)
for i = 1 to (polyop.getNumFaces p) do (
	polyop.setFaceSelection p i 
	p.extrudeFaces(random 1 16)
)

-- FUNCTION EXAMPLE
global replace_object = undefined
function replaceItems objs = (
	for item in objs do(
		print item
		maxOps.cloneNodes replace_object cloneType:#instance newNodes:&nnl #nodialog
		nnl.name = "clone_" + item.name
		nnl.position = item.position
		nnl.rotation = item.rotation
	)
	delete objs
)

-- UI INTERFACE DESIGN
-- rollout ReplaceObjectUI "Replace" width:397 height:124
-- (
-- 	pickbutton 'btn2' "Pick Object" pos:[39,39] width:127 height:56 align:#left
-- 	button 'btn3' "Replace Objects" pos:[193,41] width:151 height:58 align:#left	
-- 	on btn2 picked obj do(
-- 		if isValidNode obj do(
-- 			btn2.text = obj.name
-- 			replace_object = getnodebyname obj.name
-- 		)
-- 	)
-- 	on btn3 pressed do(
-- 		print "replacing the items"
-- 		if replace_object != undefined then(
-- 			replaceItems(selection as array)
-- 		)else(
-- 			messagebox "you are a lerdo"
-- 		)
-- 	)	
-- )
-- createDialog ReplaceObjectUI

-- CREATION SPLINE
-- function createSpline pointA pointB = (
-- 	ss = SplineShape pos:pointA
-- 	addKnot ss 1 #corner #line pointA
-- 	addKnot ss 1 #corner #line pointB
-- 	updateShape ss
-- )
-- createSpline [10,20,0] [100,200,0]


-- EXERCISE RECURSIVE
-- delete $objects 
-- global max_depth = 5

-- function createBox childAmount depth = (
-- 	b = box name:(depth as string)
-- 	depth = depth + 1
-- 	
-- 	if depth > max_depth do (
-- 		child = createChildren childAmount depth
-- 		child.parent = b
-- 		
-- 	return b
-- )
-- createBox 2 0

-- GEOMETRY PANEL CREATION
gc()
delete $objects
function createCircle rad step = (	
	local amount = 360 / step	
	for i = 0 to amount do (
		local out_angle = i * step
		x = rad * cos(out_angle)
		y = rad * sin(out_angle)
		sphere name:(i as string) pos:[x,y,0] radius:3
	)
)
function createElipse rad1 rad2 step = (	
	local amount = 360 / step	
	for i = 0 to amount do (
		local out_angle = i * step
		x = rad1 * cos(out_angle)
		y = rad2 * sin(out_angle)
		sphere name:(i as string) pos:[x,y,0] radius:3
	)
)
function createSpiral a b amount = (	
	for i = 0 to amount do (
		local out_angle = i * step
		x = (a + b * out_angle) * cos(out_angle)
		y = (a + b * out_angle) * sin(out_angle)
		sphere name:(i as string) pos:[x,y,i] scale:[0.1,0.1,0.1]
	)
)


rollout creationPanel "Creation Module" width:200 height:124
(
	button 'btn1' "Button" pos:[23,70] width:150 height:38 align:#left
	dropDownList 'ddl1' "DropDownList" pos:[23,16] width:150 height:40 align:#left items:#("Circle","Elipse","Spiral")
	
	on btn1 pressed do(
		delete $objects
		case ddl1.selection of(
			1: createCircle 100 10
			2: createElipse 100 50 10
			3: createSpiral 0.1 0.1 50
		)
	)	
)
createDialog creationPanel

