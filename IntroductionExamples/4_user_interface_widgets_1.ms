clearListener()
global replace_object = undefined -- Picked object reference

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