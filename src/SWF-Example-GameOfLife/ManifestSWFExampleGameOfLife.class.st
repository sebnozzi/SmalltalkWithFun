"
Example project for the ""game-of-life"".

If you want to interact / play with it, see inside ""Morphic"".

If you want to inspect the model and tests, go to ""Model"" and ""Tests"".
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
