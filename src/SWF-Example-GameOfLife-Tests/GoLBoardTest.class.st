"
A GoLBoardTest is a test class for testing the behavior of GoLBoard
"
Class {
	#name : #GoLBoardTest,
	#superclass : #TestCase,
	#instVars : [
		'b'
	],
	#category : #'SWF-Example-GameOfLife-Tests-Model'
}

{ #category : #fixtures }
GoLBoardTest >> board3x3 [
	^ GoLBoard newWithSize: 3 @ 3
]

{ #category : #'tests-actions' }
GoLBoardTest >> testClearCells [
	b := self board3x3.
	b putCellAt: 2@2.
	b clearCells.
	self assert: (b hasCellAt: 2@2) equals: false.
]

{ #category : #'tests-private' }
GoLBoardTest >> testCountNeighboursOf [
	b := self board3x3.
	b putCellAt: 1 @ 1.
	b putCellAt: 3 @ 3.
	self assert: (b countNeighboursOf: 2@2) equals: 2.
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

{ #category : #'tests-actions' }
GoLBoardTest >> testPutCellAt [
	b := self board3x3.
	b putCellAt: 2 @ 2.
	self assert: (b hasCellAt: 2 @ 2)
]
