<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Introduction to Maxscript](#introduction-to-maxscript)
	- [Description](#description)
	- [Syntax](#syntax)
- [Screenshots](#screenshots)
- [Examples](#examples)
	- [1. Basic transformations](#1-basic-transformations)
	- [2. Loops and iterations](#2-loops-and-iterations)
	- [3. Functions](#3-functions)
	- [4. User Interface Widgets](#4-user-interface-widgets)
	- [5. Animations](#5-animations)
	- [6. Splines](#6-splines)
	- [7. Ray intersections](#7-ray-intersections)
	- [8. Macros](#8-macros)

<!-- /TOC -->

# Introduction to Maxscript

## Description
This repository is based on the subject *Tool scripting* from the [Salle Masters MVD](https://www.salleurl.edu/es/estudios/master-en-desarrollo-avanzado-de-videojuegos). Its main purpose is to be used as a tutorial and guide for future projects. Hope it is useful.

You can also find all the maxscript documentation from 3ds Max [here](http://help.autodesk.com/view/3DSMAX/2018/ENU/?guid=__files_GUID_F039181A_C072_4469_A329_AE60FF7535E7_htm).

## Syntax
* *function variable parameters*
* *primitive parameter1:value1 parameter2:value2 ...*
* ...

# Screenshots
![1_basic_transformations](https://i.imgur.com/AbToPnh.jpg)
![2_loops_and_iterations](https://i.imgur.com/aHOhv1p.jpg)
![4_user_interface_widgets_2](https://i.imgur.com/QHrVpXj.jpg)
![5_animations](https://i.imgur.com/xlmvmw6.jpg)
![6_splines](https://i.imgur.com/9X8UXv5.jpg)
![7_ray_intersections](https://i.imgur.com/ydkbcpJ.jpg)

# Examples
## 1. Basic transformations
```maxscript
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
```
*Maxscript file example:* [1_basic_transformations](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/1_basic_transformations.ms)

## 2. Loops and iterations
```maxscript
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
```
*Maxscript file example:* [2_loops_and_iterations](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/2_loops_and_iterations.ms)

## 3. Functions
```maxscript
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
```
*Maxscript file example:*  [3_functions](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/3_functions.ms)

## 4. User Interface Widgets
```maxscript
-- Function that replaces the 3Ds Max selection with the object previously picked
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

-- Widget instantiation/definition and specification. You can create the base through "Tools > New Rollout"
rollout ReplaceObjectsWidget "Replacing Objects Widget" width:397 height:124
(
	pickbutton 'btn2' "Pick Object" pos:[39,39] width:127 height:56 align:#left
	button 'btn3' "Replace Objects" pos:[193,41] width:151 height:58 align:#left

	on btn2 picked obj do(
		if isValidNode obj do(
			btn2.text = obj.name
			replace_object = getnodebyname obj.name
		)
	)

	on btn3 pressed do(
		print "DONE - Replacing selected items"
		if replace_object != undefined then(
			replaceItems(selection as array)
		)else(
			messagebox "ERROR - No selected object, please select any object before replacing."
		)
	)

)

-- Widget creation
createDialog ReplaceObjectsWidget
```
*Maxscript file example 1:* [4_user_interface_widgets_1](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/4_user_interface_widgets_1.ms)
```maxscript
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
```
*Maxscript file example 2:* [4_user_interface_widgets_2](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/4_user_interface_widgets_2.ms)

## 5. Animations
```maxscript
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
```
*Maxscript file example:* [5_animations](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/5_animations.ms)

## 6. Splines
```maxscript
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
```
*Maxscript file example:* [6_splines](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/6_splines.ms)

## 7. Ray intersections
```maxscript
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
```
*Maxscript file example:* [7_ray_intersections](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/7_ray_intersections.ms)

## 8. Macros
```maxscript
-- Remove macro function to avoid stacking up macros on toolbar
function removeMenu m_name = (
	del_menu = menuMan.findMenu m_name
	if del_menu != undefined do
		menuMan.unregistermenu del_menu
)

-- Test function to be called from macro in toolbar
function create_object_test =
(
	delete $objects

	-- Information text
	t1 = TextPlus Plane:0 name:"macro_text" size:8 pos:[0,-40,0] wirecolor:(color 255 255 255)
	t1.SetPlaintextString("Macros")

	-- Sphere object
	sphere name:"macro_sphere" wirecolor:(color (random 0 255) (random 0 255) (random 0 255))

	print "Object created successfully!"
)

macroScript LaunchMenu category:"MVD" --macroscript menu
(
	create_object_test()
)

--Adding menu macro process with menuMan
removeMenu "MVD Tools"
theMainMenu = menuMan.getMainMenuBar() --get the main menu bar
theMenu = menuMan.createMenu "MVD Tools" --create a menu called Forum Help
theSubMenu = menuMan.createSubMenuItem "Launch tool" theMenu --create a SubMenuItem
theMainMenu.addItem theSubMenu (theMainMenu.numItems()+1) --add the SubMenu to the Main Menu
theAction = menuMan.createActionItem "LaunchMenu" "MVD" --create an ActionItem from the MacroScript
theMenu.addItem theAction (theMenu.numItems()+1) --add the ActionItem to the menu
menuMan.updateMenuBar() --update the menu bar
```
*Maxscript file example:* [8_macros](https://github.com/daliife/IntroMaxScript/blob/master/IntroductionExamples/8_macros.ms)
