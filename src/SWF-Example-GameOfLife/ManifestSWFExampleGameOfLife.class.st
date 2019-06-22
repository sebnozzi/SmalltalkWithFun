"
Example of ""game-of-life"".

For opening a GUI, see inside of ""Morphic"".

For exploring the model and its tests, see inside of ""Model"".
"
Class {
	#name : #ManifestSWFExampleGameOfLife,
	#superclass : #PackageManifest,
	#category : #'SWF-Example-GameOfLife-Manifest'
}

{ #category : #'code-critics' }
ManifestSWFExampleGameOfLife class >> ruleGRGuradGuardClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GameOfLifeMorph #clearClicked #false)) #'2019-06-20T18:04:24.575814+02:00') )
]

{ #category : #'code-critics' }
ManifestSWFExampleGameOfLife class >> ruleRBGuardingClauseRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#GameOfLifeMorph #clearClicked #false)) #'2019-06-20T18:04:27.442617+02:00') )
]
