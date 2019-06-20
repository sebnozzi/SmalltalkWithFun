"
Model for a game-of-life
"
Class {
	#name : #GoLGame,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'SWF-GameOfLife-Model'
}

{ #category : #accessing }
GoLGame >> hasCellAt: aPoint [ 
	^ cells includes: aPoint.
]

{ #category : #initialization }
GoLGame >> initialize [
	super initialize.
	cells := Set new.
]

{ #category : #'game logic' }
GoLGame >> iterate [
	| position nc newCells |
	newCells := Set new.
	((cells size = 3) or: [cells size = 4]) ifTrue: [  
		newCells add: 2@2
	].
	cells := newCells.
]

{ #category : #accessing }
GoLGame >> putCellAt: aPoint [ 
	cells add: aPoint
]
