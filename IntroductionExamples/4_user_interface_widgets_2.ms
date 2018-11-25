clearListener() 
delete $objects
gc()

-- Information text
t = TextPlus Plane:0 name:"User interface widgets 2" size:14 pos:[0,-150,0] wirecolor:(color 255 255 255)
t.SetPlaintextString("User interface widgets 2")

function createCircle rad step = (	
	local amount = 360 / step	
	for i = 0 to amount do (
		local out_angle = i * step
		x = rad * cos(out_angle)
		y = rad * sin(out_angle)
		sphere name:("circle_sphere_" + i as string) pos:[x,y,0] radius:3 wirecolor:(color 255 0 0)
	)
)

function createElipse rad1 rad2 step = (	
	local amount = 360 / step	
	for i = 0 to amount do (
		local out_angle = i * step
		x = rad1 * cos(out_angle)
		y = rad2 * sin(out_angle)
		sphere name:("elipse_sphere_" + i as string) pos:[x,y,0] radius:3 wirecolor:(color 0 255 0)
	)
)

function createSpiral a b amount step = (	
	for i = 1 to amount do (
		local out_angle = i * step
		x = (a + b * out_angle) * cos(out_angle)
		y = (a + b * out_angle) * sin(out_angle)
		sphere name:(i as string) pos:[x,y,i] radius:2.5 wirecolor:(color 0 0 255)
	)
)

-- Widget instantiation and parameters
rollout ShapeCreationPanel "Shape Creation Panel" width:200 height:124
(
	button 'btn1' "Generate" pos:[23,70] width:150 height:38 align:#left
	dropDownList 'ddl1' "Type of shape:" pos:[23,16] width:150 height:40 align:#left items:#("Circle","Elipse","Spiral")
	
	on btn1 pressed do(
		case ddl1.selection of(
			1: createCircle 100 10
			2: createElipse 100 50 10
			3: createSpiral 0.1 0.1 100 10
		)
	)
	
)

-- Widget creation
createDialog ShapeCreationPanel