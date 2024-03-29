"
Main morph used to play ""game of life"".

See class side for examples.

Start with: 

GameOfLifeMorph new openInWindow.
"
Class {
	#name : #GameOfLifeMorph,
	#superclass : #Morph,
	#instVars : [
		'gridMorph',
		'clearButton',
		'startStopButton',
		'stepButton',
		'board',
		'animating'
	],
	#category : #'SWF-Project-GameOfLife-Morphic'
}

{ #category : #examples }
GameOfLifeMorph class >> play [
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
	self toggleCellAt: cellPosition	
]

{ #category : #'default-values' }
GameOfLifeMorph >> cellSize [
	^ 30
]

{ #category : #'event-handling' }
GameOfLifeMorph >> clearClicked [
	| answer |
	answer := UIManager default
		confirm: 'This will remove all cells. Are you sure?'
		label: 'Clear cells'.
	answer
		ifTrue: [ board clearCells.
					 self repaintCells ]
]

{ #category : #'default-values' }
GameOfLifeMorph >> gridSize [
	^ 10@10
]

{ #category : #initialization }
GameOfLifeMorph >> initialize [
	super initialize.
	self initializeVisualProperties.
	animating := false.
	board := GoLBoard newWithSize: (self gridSize).
	self buildUI.
	self repaintCells.

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
		help: 'Iterates to next step'.
]

{ #category : #initialization }
GameOfLifeMorph >> initializeVisualProperties [
	self color: Color lightGray.
	self
		layoutPolicy: TableLayout new;
		hResizing: #shrinkWrap;
		vResizing: #shrinkWrap
]

{ #category : #updating }
GameOfLifeMorph >> iterateOneStep [
	board := board nextIteration.
	self repaintCells
]

{ #category : #'default-values' }
GameOfLifeMorph >> liveCellColor [
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
	self iterateOneStep
]

{ #category : #windows }
GameOfLifeMorph >> openInWindow [
	^ (self openInWindowLabeled: 'Game of Life')
		beUnresizeable;
		removeExpandBox.
]

{ #category : #updating }
GameOfLifeMorph >> repaintCells [
	gridMorph clearAll.
	board liveCellsDo: [ :cellPos | 
		gridMorph cellAt: cellPos fillWith: self liveCellColor ]
]

{ #category : #'stepping-animation' }
GameOfLifeMorph >> startAnimating [
	self startStepping.
	clearButton enabled: false.
	stepButton enabled: false.
	startStopButton label: 'Stop'.
	animating := true.
]

{ #category : #'event-handling' }
GameOfLifeMorph >> startStopClicked [
	self toggleAnimationState
]

{ #category : #'stepping-animation' }
GameOfLifeMorph >> step [
	"Despite my best efforts to prevent it, the Morph starts with stepping ON
	when opened in a Window. This is a workaround to correct that inconsistent
	state a-posteriori"
	animating ifFalse: [ ^ self stopAnimating ].
	
	"If we are indeed animating, then iterate one step"
	self iterateOneStep.
	"Stop if there is nothing to animate"
	(board isEmpty) ifTrue: [ self stopAnimating ]
	
	
]

{ #category : #'stepping-animation' }
GameOfLifeMorph >> stepTime [
	^ 400
]

{ #category : #'stepping-animation' }
GameOfLifeMorph >> stopAnimating [
	self stopStepping.
	clearButton enabled: true.
	stepButton enabled: true.
	startStopButton label: 'Start'.
	animating := false.
]

{ #category : #'stepping-animation' }
GameOfLifeMorph >> toggleAnimationState [
	animating ifTrue: [
		self stopAnimating.
	] ifFalse: [ 
		self startAnimating.
	]
]

{ #category : #updating }
GameOfLifeMorph >> toggleCellAt: cellPosition [
	board toggleCellAt: cellPosition.
	self repaintCells.
]
