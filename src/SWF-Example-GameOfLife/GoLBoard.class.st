"
Model for a game-of-life simulation.

A board has a certain dimension/size, contains cells at certain positions,
and can be asked to compute its next iteration.

The next iteration is given as a new board (it does *not* mutate in-place).
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

{ #category : #iterating }
GoLBoard >> cellPositionsDo: aBlock [
	1 to: self rowCount do: [ :y | 
		1 to: self columnCount do: [ :x | 
			aBlock value: x@y ] ]
]

{ #category : #actions }
GoLBoard >> clearCells [
	cells := Set new.
]

{ #category : #accessing }
GoLBoard >> columnCount [
	^ size x
]

{ #category : #private }
GoLBoard >> computeBirthAt: pos for: newBoard [
	"A new cell might be born at this position"
	| amount |
	amount := (self countNeighboursOf: pos).
	(amount = 3) ifTrue: [ newBoard putCellAt: pos ].
]

{ #category : #private }
GoLBoard >> computeSurvivalAt: pos for: newBoard [
	"An existing cell might survive to the next iteration at this position"
	| amount |
	amount := (self countNeighboursOf: pos).
	(#(2 3) includes: amount) ifTrue: [ newBoard putCellAt: pos ].
]

{ #category : #private }
GoLBoard >> countNeighboursOf: cellPos [
	^ (self liveNeighboursOf: cellPos) size
]

{ #category : #querying }
GoLBoard >> hasCellAt: aPoint [ 
	^ cells includes: aPoint.
]

{ #category : #initialization }
GoLBoard >> initialize [
	super initialize.
	self size: 3@3.
]

{ #category : #private }
GoLBoard >> isValidPosition: pos [
	^ (pos > (0@0)) 
		and: [ pos <= ((self columnCount)@(self rowCount)) ]
]

{ #category : #iterating }
GoLBoard >> liveCellsDo: aBlock [
	cells do: [ :cellPos | aBlock value: cellPos ].
]

{ #category : #private }
GoLBoard >> liveNeighboursOf: cellPos [
	^ (self neighbourPositionsOf: cellPos) select: [ :pos | self hasCellAt: pos ]
]

{ #category : #private }
GoLBoard >> neighbourPositionsOf: pos [
	| potentialPositions |
	potentialPositions := { 
		pos + ((-1)@(-1)). pos + ((0)@(-1)). pos + ((1)@(-1)). 
		pos + ((-1)@(0)). "                " pos + ((1)@(0)). 
		pos + ((-1)@(1)).  pos + ((0)@(1)).  pos + ((1)@(1)). 
	}.
	^ potentialPositions select: [ :p | self isValidPosition: p ]
]

{ #category : #'game logic' }
GoLBoard >> nextIteration [
	| newBoard |
	newBoard := self class newWithSize: (self size).
	self cellPositionsDo: [ :pos | 
		(self hasCellAt: pos) 
			ifTrue: [ self computeSurvivalAt: pos for: newBoard ] 
			ifFalse: [ self computeBirthAt: pos for: newBoard ].
	].
	^ newBoard.
]

{ #category : #actions }
GoLBoard >> putCellAt: aPoint [ 
	cells add: aPoint
]

{ #category : #actions }
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
