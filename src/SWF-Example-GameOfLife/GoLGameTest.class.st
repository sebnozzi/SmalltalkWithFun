Class {
	#name : #GoLGameTest,
	#superclass : #TestCase,
	#instVars : [
		'game'
	],
	#category : #'SWF-Example-GameOfLife-Tests'
}

{ #category : #fixtures }
GoLGameTest >> gameWithCellAt: aPoint [ 
	| g |
	g := GoLGame new.
	g putCellAt: 2@2.
	^ g
]

{ #category : #fixtures }
GoLGameTest >> gameWithCellAt: aPoint andNeighboursAt: positions [
	| g |
	g := GoLGame new.
	g putCellAt: 2@2.
	positions do: [ :pos | g putCellAt: pos ].
	^ g
]

{ #category : #'tests-accessing' }
GoLGameTest >> testCellAccessing [
	game := GoLGame new.
	self assert: (game hasCellAt: 2@2) equals: false.
	game putCellAt: 2@2.
	self assert: (game hasCellAt: 2@2) equals: true.
	
]

{ #category : #'tests-survival' }
GoLGameTest >> testCellDiesOfIsolation [
	"An isolated cell, without neighbours, dies"
	game := self gameFrom: 
	{	'...'.
		'.X.'.
		'...'  }.
	game iterate.
	self assert: game isLike: 
	{	'...'.
		'...'.
		'...'  }.
]

{ #category : #'tests-survival' }
GoLGameTest >> testCellSurvives2N [
	"A cell with 2 neighbours survives"
	game := self gameWithCellAt: 2@2 andNeighboursAt: { 1@1. 3@3 }.
	"When ..."
	game iterate.
	"Then ..."
	self assert: (game hasCellAt: 2@2) description: 'Cell should have had survived'.
]

{ #category : #'tests-survival' }
GoLGameTest >> testCellSurvives3N [
	"A cell with 3 neighbours survives"
	game := self gameWithCellAt: 2@2 andNeighboursAt: { 1@1. 3@3. 1@2 }.
	"When ..."
	game iterate.
	"Then ..."
	self assert: (game hasCellAt: 2@2) description: 'Cell should have had survived'.
]
