"
Baseline for the ""Smalltalk with Fun"" project.

The project contains a examples and a library of helper components.
"
Class {
	#name : #BaselineOfSWF,
	#superclass : #BaselineOf,
	#category : #BaselineOfSWF
}

{ #category : #baselines }
BaselineOfSWF >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			"Packages"
			spec 
				package: 'SWF-Library';
				package: 'SWF-Library-Tests' with: [ spec requires: #('SWF-Library') ];
				package: 'SWF-Example-GameOfLife'	with: [ spec requires: #('SWF-Library') ].
			"Groups"
			spec
				group: 'Library' with: #('SWF-Library' 'SWF-Library-Tests');
				group: 'GameOfLife' with: #('SWF-Example-GameOfLife').
		]
]
