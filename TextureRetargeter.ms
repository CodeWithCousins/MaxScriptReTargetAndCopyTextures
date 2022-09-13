struct TextureRetargeterFuncs
(
	_imageExtensionPatterns = #("*.jpg","*.png","*.tif","*.exr"),
	
	fn IsFilePathTexture filePath=
	(
		local filePathisTexture = false
		for pattern in this._imageExtensionPatterns where ( not filePathIsTexture ) do 
		(
			filePathisTexture = MatchPattern filePath pattern:pattern
		)
		return filePathisTexture
	),
	
	
	fn ReTargetAndCopyTextures outputDir =
	(
		local sceneroot = (for r in (Refs.Dependents rootnode) where (ClassOf r == Scene) collect r)[1]
		local origAssets = for i = 1 to AssetManager.GetNumAssets() collect (AssetManager.GetAssetByIndex i)
		local failedTextures = #()
		for io in origAssets do
		(
			local srcFilePath = io.getfilename()
			local srcFileNameWithExt = FileNameFromPath srcFilePath
			
			local newFilePath = outputDir + "\\" + srcFileNameWithExt
			
			if((IsFilePathTexture srcFilePath) and (DoesFileExist srcFilePath)) do
			(
				local success = CopyFile srcFilePath newFilePath
				if(NOT success) do
				(
					Format "Unable to copy file from [%] to [%]\n" srcFilePath newFilePath
					Append failedTextures newFilePath					
				)
			)
			AtSops.RetargetAssets sceneroot srcFilePath newFilePath createOutputFolder:true
		)
		
		return failedTextures
	)
)