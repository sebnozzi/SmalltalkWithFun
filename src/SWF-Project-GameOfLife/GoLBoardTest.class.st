"
Tests for the game-of-life model
"
Class {
	#name : #GoLBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'b'
	],
	#category : #'SWF-Project-GameOfLife-Model'
}

{ #category : #assertions }
GoLBoardTest >> assertBoard: board hasLiveCellAt: position [ 
	self assert: (board hasCellAt: position) 
		description: ('Board should have live cell at {1}' format: {position})
]

{ #category : #assertions }
GoLBoardTest >> assertBoard: board hasNoCellAt: position [ 
	self deny: (board hasCellAt: position) 
		description: ('Board should have NO live cell at {1}' format: {position})
]

{ #category : #fixtures }
GoLBoardTest >> board3x3 [
	^ GoLBoard newWithSize: 3 @ 3
]

{ #category : #fixtures }
GoLBoardTest >> boardWithLiveCellAt: pos [
	| board |
	board := GoLBoard new size: 3@3.
	board putCellAt: pos.
	^ board
]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testCellSurviving2N [
	"Cell survives if it has 2 or 3 neighbours"
	b := self boardWithLiveCellAt: 2@2.
	"Add 2 neighbours"
	b putCellAt: 2@3.
	b putCellAt: 1@1.
	b := b nextIteration.
	"Then ..."
	self assertBoard: b hasLiveCellAt: 2@2.
]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testCellSurviving3N [
	"Cell survives if it has 2 or 3 neighbours"
	b := self boardWithLiveCellAt: 2@2.
	"Add 3 neighbours"
	b putCellAt: 2@3.
	b putCellAt: 1@1.
	b putCellAt: 3@2.
	b := b nextIteration.
	"Then ..."
	self assertBoard: b hasLiveCellAt: 2@2.
]

{ #category : #'tests-actions' }
GoLBoardTest >> testClearCells [
	b := self board3x3.
	b putCellAt: 2@2.
	b clearCells.
	self deny: (b hasCellAt: 2@2) description: 'There should not be any cell in this board'.
]

{ #category : #'tests-private' }
GoLBoardTest >> testCountNeighboursOf [
	b := self board3x3.
	b putCellAt: 1 @ 1.
	b putCellAt: 3 @ 3.
	self assert: (b countNeighboursOf: 2@2) equals: 2.
]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testDyingOfIsolation0N [
	"Dies of isolation if it has 0 or 1 neighbours"
	b := self boardWithLiveCellAt: 2@2.
	"Add no neighbours"
	b := b nextIteration.
	"Then ..."
	self assertBoard: b hasNoCellAt: 2@2.
]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testDyingOfIsolation1N [
	"Dies of isolation if it has 0 or 1 neighbours"
	b := self boardWithLiveCellAt: 2@2.
	"Add 1 neighbour"
	b putCellAt: 1@1.
	b := b nextIteration.
	"Then ..."
	self assertBoard: b hasNoCellAt: 2@2.
]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testDyingOfOvercrowding [
	"Cell dies of overcrowding if it has 4 or more neighbours"
	| possibleNeighbours |
	possibleNeighbours := { 
		1@1. 2@1. 3@1.
		1@2. "  " 3@2.
		1@3. 2@3. 3@3 }.
	4 to: 8 do: [ :amount || neighbourPositions | 
		b := self boardWithLiveCellAt: 2@2.
		"Add neighbours"
		neighbourPositions := possibleNeighbours first: amount.
		neighbourPositions do: [ :pos | b putCellAt: pos ].
		b := b nextIteration.
		"Then ..."
		self assertBoard: b hasNoCellAt: 2@2.
	].

]

{ #category : #'test-testing' }
GoLBoardTest >> testHasCellAt [
	b := self boardWithLiveCellAt: 2@2.
	self assert: (b hasCellAt: 2@2) description: 'Cell expected at position'
]

{ #category : #'test-testing' }
GoLBoardTest >> testIsEmpty [
	b := self board3x3.
	self assert: b isEmpty description: 'Board should be initially empty'.
	b putCellAt: 1@1.
	self deny: b isEmpty description: 'Board should NOT be empty after adding cell'.
]

{ #category : #'tests-private' }
GoLBoardTest >> testIsValidPosition [
	b := self board3x3.
	self assert: (b isValidPosition: 2@2).
	self assert: (b isValidPosition: 4@4) equals: false.
	self assert: (b isValidPosition: 0@0) equals: false.
]

{ #category : #'tests-private' }
GoLBoardTest >> testLiveNeighboursOf [
	| ln |
	b := self board3x3.
	b putCellAt: 1 @ 1.
	b putCellAt: 3 @ 3.
	ln := b liveNeighboursOf: 2@2.
	self assert: (ln includes: 1@1).
	self assert: (ln includes: 3@3).
]

{ #category : #'tests-private' }
GoLBoardTest >> testNeighbourPositionsOf [
	| np |
	b := self board3x3.
	np := b neighbourPositionsOf: 1@1.
	self assert: (np includes: 2@1).
	self assert: (np includes: 2@2).
	self assert: (np includes: 1@2).

]

{ #category : #'tests-game-logic' }
GoLBoardTest >> testNewCellBeingBorn [
	"A new cell is born in an empty space with exactly 3 neighbours"
	b := self board3x3.
	"Add neighbours"
	b putCellAt: 1@1.
	b putCellAt: 3@2.
	b putCellAt: 2@3.
	b := b nextIteration.
	"Then ..."
	self assertBoard: b hasLiveCellAt: 2@2.
]

{ #category : #'tests-actions' }
GoLBoardTest >> testPutCellAt [
	b := self board3x3.
	b putCellAt: 2 @ 2.
	self assert: (b hasCellAt: 2@2) description: 'Cell expected but not found'.
]

{ #category : #'tests-actions' }
GoLBoardTest >> testRemoveCellAt [
	b := self board3x3.
	b putCellAt: 2@2.
	b removeCellAt: 2@2.
	self deny: (b hasCellAt: 2@2) description: 'Cell should have been removed'.
]
