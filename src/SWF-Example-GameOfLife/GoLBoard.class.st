"
Model for a game-of-life
"
Class {
	#name : #GoLBoard,
	#superclass : #Object,
	#instVars : [
		'size',
		'cells'
	],
	#category : #'SWF-Example-GameOfLife-Model'
}

{ #category : #'instance creation' }
GoLBoard class >> newWithSize: boardSize [
	^ self new 
		size: boardSize.
]

{ #category : #'game logic' }
GoLBoard >> cellPositionsDo: aBlock [
	1 to: self rowCount do: [ :y | 
		1 to: self columnCount do: [ :x | 
			aBlock value: x@y ] ]
]

{ #category : #accessing }
GoLBoard >> clearCells [
	cells := Set new.
]

{ #category : #accessing }
GoLBoard >> columnCount [
	^ size x
]

{ #category : #accessing }
GoLBoard >> hasCellAt: aPoint [ 
	^ cells includes: aPoint.
]

{ #category : #initialization }
GoLBoard >> initialize [
	super initialize.
	self size: 3@3.
]

{ #category : #'game logic' }
GoLBoard >> liveCellsDo: aBlock [
	cells do: [ :cellPos | aBlock value: cellPos ].
]

{ #category : #'game logic' }
GoLBoard >> nextIteration [
	| newBoard |
	newBoard := self class newWithSize: (self size).
	self liveCellsDo: [ :cellPos | newBoard putCellAt: (cellPos+(1@1)) ].
	^ newBoard.
]

{ #category : #accessing }
GoLBoard >> putCellAt: aPoint [ 
	cells add: aPoint
]

{ #category : #accessing }
GoLBoard >> removeCellAt: aPoint [ 
	cells remove: aPoint
]

{ #category : #accessing }
GoLBoard >> rowCount [
	^ size y
]

{ #category : #accessing }
GoLBoard >> size [
	^ size
]

{ #category : #accessing }
GoLBoard >> size: newSize [
	self clearCells.
	size := newSize.
]
