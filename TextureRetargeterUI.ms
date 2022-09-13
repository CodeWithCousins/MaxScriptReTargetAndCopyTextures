FileIn "TextureRetargeter.ms"

try(Destroydialog TextureRetargeter) catch()

rollout TextureRetargeter "Texture Retargeter"
(
	
	local textureDirPath =""
	local TextureRetargeterFunc = TextureRetargeterFuncs()
	label lblTextureDirPath "Texture Dir Path:" align:#left offset:[3,0]
	edittext edtTextureDirPath "" align:#left width:240 height:20 across:2
	button btnBrowseTextureFolder "..." align:#right height:20
	
	button btnReTargetAndCopyTex "ReTarget And Copy Textures" width:273 align:#center

	--EVENTS
	
	on btnBrowseTextureFolder pressed do 
	(
		textureDirPath = GetSavePath caption:"Choose Texture path..."
		if (textureDirPath != undefined) do
		(
			edtTextureDirPath.text = textureDirPath 
		)
	)
	
	on btnReTargetAndCopyTex pressed do
	(
		clearListener()
		
		local failedTextures = TextureRetargeterFunc.ReTargetAndCopyTextures textureDirPath
		
		if(failedTextures.count == 0) then		
		(
			Messagebox "All the Textures moved To the location succesfully"
		)
		else
		(
			messageBox "Textures moved to the location with some failed textures"
		)
	)
)

CreateDialog TextureRetargeter width:300 height:80