"
Main morph used to play ""game of life"".

See class side for examples.

Start with: 

GameOfLifeMorph new openInWindow.
"
Class {
	#name : #GameOfLifeMorph,
	#superclass : #WindowAwareMorph,
	#instVars : [
		'gridMorph',
		'clearButton',
		'startStopButton',
		'stepButton'
	],
	#category : #'SWF-Example-GameOfLife-Morphic'
}

{ #category : #examples }
GameOfLifeMorph class >> openInWindow [
	<example>
	^ self new openInWindow

]

{ #category : #initialization }
GameOfLifeMorph >> buildUI [
	| buttonsRow mainContainer |
	buttonsRow := self makeButtonsRow.
	gridMorph := self makeGridMorph.
	mainContainer := AlignmentMorph
		inAColumn:
			{gridMorph.
			buttonsRow}.
	self addMorph: mainContainer
]

{ #category : #'event-handling' }
GameOfLifeMorph >> cellClicked: cellPosition [
	(gridMorph colorAt: cellPosition) isNil
				ifTrue: [ gridMorph cellAt: cellPosition fillWith: (self liveCellColor) ]
				ifFalse: [ gridMorph removeColorAt: cellPosition ]	
]

{ #category : #'default-values' }
GameOfLifeMorph >> cellSize [
	^ 30
]

{ #category : #'event-handling' }
GameOfLifeMorph >> clearClicked [
	UIManager default confirm: 'This will remove all cells. Are you sure?' label: 'Clear cells'.
]

{ #category : #'default-values' }
GameOfLifeMorph >> gridSize [
	^ 10
]

{ #category : #initialization }
GameOfLifeMorph >> initialize [
	super initialize.
	self initializeVisualProperties.
	self buildUI
]

{ #category : #initialization }
GameOfLifeMorph >> initializeButtons [
	clearButton := PluggableButtonMorph
		newButtonFor: self
		action: #clearClicked
		label: 'Clear'
		help: 'Clears all cells'.
	startStopButton := PluggableButtonMorph
		newButtonFor: self
		action: #startStopClicked
		label: 'Start'
		help: 'Starts simulation'.
	stepButton := PluggableButtonMorph
		newButtonFor: self
		action: #nextStepClicked
		label: 'Next'
		help: 'Iterates world to next step'.
]

{ #category : #initialization }
GameOfLifeMorph >> initializeVisualProperties [
	self color: Color lightGray.
	self
		layoutPolicy: TableLayout new;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #'default-values' }
GameOfLifeMorph >> liveCellColor [
	"Color fromString: '5194FC'"
	^ Color lightGreen
]

{ #category : #initialization }
GameOfLifeMorph >> makeButtonsRow [
	| buttonsRow |
	self initializeButtons.
	buttonsRow := AlignmentMorph
		inARow:
			{clearButton.
			stepButton.
			startStopButton}.
	buttonsRow
		hResizing: #spaceFill;
		listCentering: #center;
		cellInset: 50;
		layoutInset: 10 @ 10.
	^ buttonsRow
]

{ #category : #initialization }
GameOfLifeMorph >> makeGridMorph [
	| gm |
	gm := GridMorph new
		cellSize: self cellSize;
		gridSize: self gridSize;
		yourself.
	gm whenCellClickedDo: [ :cellPos | self cellClicked: cellPos ].
	^ gm
]

{ #category : #'event-handling' }
GameOfLifeMorph >> nextStepClicked [
	UIManager default inform: 'Next step clicked'.
]

{ #category : #windows }
GameOfLifeMorph >> openInWindow [
	^ (self openInWindowLabeled: 'Game of Life')
		beUnresizeable;
		removeExpandBox.
]

{ #category : #'event-handling' }
GameOfLifeMorph >> startStopClicked [
	UIManager default inform: 'Simulation starting / stopping'.
]
