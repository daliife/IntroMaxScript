clearListener()
delete $objects

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
