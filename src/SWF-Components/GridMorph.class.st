"
I display a grid of cells.

You can change my dimensions, cell-size, border width, color and background color.

My cells can show colors and/or images.

I handle UI events such as mouse-clicks or key-presses.

You can use me to code simple grid-based games.
"
Class {
	#name : #GridMorph,
	#superclass : #WindowAwareMorph,
	#instVars : [
		'gridSize',
		'cellSize',
		'colorDict',
		'imgDict',
		'clickCallback',
		'keyPressCallback'
	],
	#category : #'SWF-Components-Morphic'
}

{ #category : #example }
GridMorph class >> example [
	GridMorph new
		cellSize: 30;
		borderWidth: 3;
		openInWorld.
]

{ #category : #example }
GridMorph class >> exampleInWindow [
	| gm |
	gm := 	GridMorph new
		cellSize: 100;
		openInWindow;
		yourself.
	gm cellAt: 1@1 fillWith: (Color lightGreen).
	gm cellAt: 2@3 fillWith: (Color lightRed).
]

{ #category : #example }
GridMorph class >> exampleOfKeyPress [
	"Move with arrow keys!"
	| gm pos |
	gm := GridMorph new
		cellSize: 30;
		beSquare: 10;
		openInWindow;
		yourself.
	pos := (5@5).
	gm cellAt: pos fillWith: (Color blue).
	gm whenKeyPressedDo: [ :keyChar | 
		gm removeColorAt: pos.
		"Move according to arrow keys"
		(keyChar = Character arrowLeft) ifTrue: [ pos := pos + (-1 @ 0) ].
		(keyChar = Character arrowRight) ifTrue: [ pos := pos + (1 @ 0) ].
		(keyChar = Character arrowUp) ifTrue: [ pos := pos + (0 @ -1) ].
		(keyChar = Character arrowDown) ifTrue: [ pos := pos + (0 @ 1) ].
		"Wrap around grid"
		(pos x > 10) ifTrue: [ pos := (1 @ pos y) ].
		(pos y > 10) ifTrue: [ pos := (pos x @ 1) ].
		(pos x < 1) ifTrue: [ pos := (10 @ pos y) ].
		(pos y < 1) ifTrue: [ pos := (pos x @ 10) ].
		gm cellAt: pos fillWith: (Color blue).
	].
]

{ #category : #example }
GridMorph class >> exampleOfMouseClicks [
	| gm |
	gm := GridMorph new
		cellSize: 30;
		beSquare: 10;
		openInWindow;
		yourself.
	gm whenCellClickedDo: [ :cellPosition | 
			(gm colorAt: cellPosition) isNil
				ifTrue: [ gm cellAt: cellPosition fillWith: (Color fromString: '5194FC') ]
				ifFalse: [ gm removeColorAt: cellPosition ] ].
]

{ #category : #example }
GridMorph class >> exampleRectangularCells [
	GridMorph new
		cellSize: 20@40;
		gridSize: 5@5;
		openInWorld.
]

{ #category : #example }
GridMorph class >> exampleRectangularGrid [
	GridMorph new
		beRectangular: 5 by: 3; 
		openInWorld.
]

{ #category : #example }
GridMorph class >> exampleSquareGrid [
	GridMorph new
		beSquare: 3; 
		openInWorld.
]

{ #category : #example }
GridMorph class >> exampleWithColors [
	| gm |
	gm := 	GridMorph new
		cellSize: 30;
		borderWidth: 3;
		openInHand;
		yourself.
	"You can set the background color"
	gm backgroundColor: (Color lightYellow).
	"You can set the border color"
	gm borderColor: (Color blue).
	"And you can fill any cell with the color you want"
	gm cellAt: 1@1 fillWith: (Color lightGreen).
	gm cellAt: 2@3 fillWith: (Color lightRed).
]

{ #category : #example }
GridMorph class >> exampleWithImage [
	| gm icon |
	gm := 	GridMorph new
		cellSize: 30;
		borderWidth: 2;
		borderColor: (Color gray);
		openInHand;
		yourself.
	icon := self starIconForm.
	gm cellAt: (3@1) showImage: icon.
	gm cellAt: (2@2) showImage: icon.
	gm cellAt: (1@3) showImage: icon.
]

{ #category : #resources }
GridMorph class >> starIcon [
^ 'iVBORw0KGgoAAAANSUhEUgAAAB4AAAAeCAYAAAA7MK6iAAADr0lEQVR4Xr1XPUwUQRQ+UbSw
oJGoMRo12hoTChMxQoJG+dnZPfBACxsLEkst/KkkxsrChtiYWBg7QmViJYo2FnohKre7dxwi
v0ZFiUTZ3ft9vjc7s7d3B8ct8bjkZef2Zt733vf+5kIb+QCEtqy2rukHBgbq6Ono7EjGVE+6
4O672gJD6zYBfN3R1WH+biiydROAhceG8twx2G/QI9trTrkEhWR7I4IuwlwP2Amtjb8bdZmo
Kc0pQ+2DqTAQsGOywU0AdmOZMthTmO2B3IQG6HlCgtaEbknzUjTSYBvsaz6pkbdZAs8klFN+
w/7rZ3TUy2YGX8LkaQ4lDQs9tL4fmG4YCNXRgXUl2b7DzWb2COYRTGcZXGcp1vj8SPGnsopG
m+rX1RW07ukQgszApCY9zpNkEiqkTa0pkDLH6DqKyXIRFZzlEmfn0ZtiMdQOjOtpy1BuZidU
4IA6oydwr6e7AXU8sWKseWWcdZadJ4mp52y9qy2lK73WOHa8P2PtjSlTHYbFXiAFWbQePmuu
TGqFtfguwEoln0vSnnDxmUn3HSUgXy/10d5YWteOe57bOruClq2IxHGISjQoJyj1y1rgxftM
IaiLWHKNVh4UlUmhDSLtJnsHCxekoqz0qAKgJykRc58hadFkflC4SivENSDaXy+nD3o+CNNh
SW26GtASyaARwB3Q2UvrQ9c+2fmoilbNWi/p4ozh4Z/c4soUl1FOJZaJq4ChulXqWMUhL6n4
q3fswbiM+MpnXVDe0Qw2ZcVZs6czyNj0W+joyjOY6eYUrhlfbJ8Eikk6Awlll9Sxof4tk842
lLdUar5kKxfMYGokuF6248qhDd9MZMNP6+oJoTBfkt25MkOwjbq9W73mH6OB2yMfgSa74+vN
HgDRKmo+4xlEwG5IXsh8CUS1fzMCv6fSEt7leW2iIRjLOVyPielEzYL/TtmMT8s2tYOB6fYG
fpwdE4lD9FE956k2EfQVYMbTHuzfD8lLcSlIc6/nedPop99pWgXIaHezZbAbBIT1vMKvOlhW
mGj3SvdbMeUS7lkWNW/R7YQqIZDHECrQjErecEA3brNIX6ufFX/N48TZjxPsNXlLvdnWlV9g
dO+tGlwWuzPReZiPPN721OGl6JkGr+2VJIy/5hH8bhrjDN8jQJfCqm8mMiYY19uCuqvVtD2/
cvuT0kKUI90jgTsXDQrbVFokVUNVHOblIwyHcbYb4/4YKT/g/+tTWQHerwr/EJDaULC2B75M
hm+Xd6625x80CKKBPJlcAQAAAABJRU5ErkJggg=='
]

{ #category : #resources }
GridMorph class >> starIconForm [
	^ PNGReadWriter
		formFromStream:
			(self starIcon base64Decoded readStream)
]

{ #category : #private }
GridMorph >> allCellPositions [
	| positions |
	positions := OrderedCollection new.
	1 to: (self rowCount) do: [ :rowNr | 
		1 to: (self columnCount) do: [ :colNr |
			positions add: (colNr@rowNr) ]	].
	^ positions
]

{ #category : #private }
GridMorph >> assertIsOneArgReceivingBlock: block [
	self
		assert: ((block isKindOf: BlockClosure) and: [ block argumentCount = 1 ])
		description: 'Must be given a block that receives one argument'
]

{ #category : #accessing }
GridMorph >> backgroundColor [
	^ self color
]

{ #category : #accessing }
GridMorph >> backgroundColor: aColor [
	self color: aColor
]

{ #category : #'accessing-geometry' }
GridMorph >> beRectangular: m by: n [
	"Makes the dimensions of this grid MxN (rectangular)"
	self gridSize: m@n.
]

{ #category : #'accessing-geometry' }
GridMorph >> beSquare: n [
	"Makes the dimensions of this grid NxN, given the number passed as parameter"
	self beRectangular: n by: n.
]

{ #category : #accessing }
GridMorph >> borderWidth: anInteger [
	super borderWidth: anInteger.
	self updateBounds.
]

{ #category : #'actions-colors' }
GridMorph >> cellAt: position fillWith: aColor [
	self assert: (position isKindOf: Point).
	self assert: (aColor isKindOf: Color) description: 'Parameter should be instance of Color'.
	
	colorDict at: position put: aColor.
	self changed.
]

{ #category : #'actions-images' }
GridMorph >> cellAt: position showImage: aFormImage [
	self assert: (position isKindOf: Point).
	self assert: (aFormImage isKindOf: Form) description: 'Image should be instance of Form'.
	
	imgDict at: position put: aFormImage.
	self changed.
]

{ #category : #private }
GridMorph >> cellPositionForPoint: pointInMorph [
	^ self cellPositionForPoint: pointInMorph ifNone: nil
]

{ #category : #private }
GridMorph >> cellPositionForPoint: pointInMorph ifNone: alternateValue [
	^ self allCellPositions
		detect: [ :anyCellPosition | 
			(self rectangleForCellAt: anyCellPosition) containsPoint: pointInMorph ]
		ifNone: [ alternateValue ]
]

{ #category : #'accessing-geometry' }
GridMorph >> cellSize: size [
	"Size can be either an Integer or a point, to specify rectangular sizes"
	cellSize := size asPoint. "asPoint converts numbers like 5 => 5@5"
	self updateBounds.
]

{ #category : #'actions-clearing' }
GridMorph >> clearAll [
	self clearColors.
	self clearImages.
	self changed.
]

{ #category : #'actions-clearing' }
GridMorph >> clearColors [
	colorDict removeAll.
	self changed.
]

{ #category : #'actions-clearing' }
GridMorph >> clearImages [
	imgDict removeAll.
	self changed.
]

{ #category : #'actions-colors' }
GridMorph >> colorAt: cellPosition [
	^ colorDict at: cellPosition ifAbsent: nil.
]

{ #category : #private }
GridMorph >> columnBorderOffsets [
	^ (0 to: self columnCount) collect: [ :colNr | colNr * (self columnWidth + (self borderWidth)) ]
]

{ #category : #'accessing-geometry' }
GridMorph >> columnCount [
	^ gridSize x
]

{ #category : #'accessing-geometry' }
GridMorph >> columnWidth [
	^ cellSize x
]

{ #category : #private }
GridMorph >> desiredExtent [
	| width height |
	width := self columnCount * self columnWidth
		+ ((self columnCount + 1) * self borderWidth).
	height := self rowCount * self rowHeight
		+ ((self rowCount + 1) * self borderWidth).
	^ width @ height
]

{ #category : #'private-drawing' }
GridMorph >> drawBackgroundOn: canvas [
	canvas fillRectangle: self bounds color: (self backgroundColor).
]

{ #category : #'private-drawing' }
GridMorph >> drawBordersOn: aCanvas [
	self drawColumnBordersOn: aCanvas.
	self drawRowBordersOn: aCanvas.
]

{ #category : #'private-drawing' }
GridMorph >> drawCellColorsOn: canvas [
	colorDict
		keysAndValuesDo: [ :cellPos :cellColor | 
			| cellRect |
			cellRect := (self rectangleForCellAt: cellPos) translateBy: self topLeft.
			canvas fillRectangle: cellRect color: cellColor ]
]

{ #category : #'private-drawing' }
GridMorph >> drawCellImagesOn: canvas [
	imgDict
		keysAndValuesDo: [ :cellPos :cellImage | 
			| cellRect |
			cellRect := (self rectangleForCellAt: cellPos) translateBy: self topLeft.
			canvas translucentImage: cellImage at: cellRect topLeft ]
]

{ #category : #'private-drawing' }
GridMorph >> drawCellsOn: aCanvas [
	self drawCellColorsOn: aCanvas.
	self drawCellImagesOn: aCanvas
]

{ #category : #'private-drawing' }
GridMorph >> drawColumnBordersOn: canvas [
	| y1 y2 borderColor |
	borderColor := self borderColor.
	y1 := self top.
	y2 := self bottom.
	self columnBorderOffsets do: [ :borderOffset | 
			| x1 x2 |
			x1 := self left + borderOffset.
			x2 := x1 + (self borderWidth ).
			canvas fillRectangle: ((x1@y1) corner: (x2@y2)) color: borderColor ]
]

{ #category : #'private-drawing' }
GridMorph >> drawOn: aCanvas [
	self drawBackgroundOn: aCanvas.
	self drawCellsOn: aCanvas.
	self drawBordersOn: aCanvas.
]

{ #category : #'private-drawing' }
GridMorph >> drawRowBordersOn: canvas [
	| x1 x2 borderColor |
	borderColor := self borderColor.
	x1 := self left.
	x2 := self right.
	self rowBorderOffsets do: [ :borderOffset | 
			| y1 y2 |
			y1 := self top + borderOffset.
			y2 := y1 + self borderWidth.
			canvas fillRectangle: ((x1 @ y1) corner: (x2 @ y2)) color: borderColor ]
]

{ #category : #'accessing-geometry' }
GridMorph >> gridSize: size [
	"Size can be an Integer or a Point"
	gridSize := size asPoint.
	self updateBounds.
]

{ #category : #'private-event-handling' }
GridMorph >> handleKeyCharacter: keyChar [
	keyPressCallback ifNotNil: [ keyPressCallback value: keyChar ].
]

{ #category : #'private-event-handling' }
GridMorph >> handlesKeyDown: evt [
	^ keyPressCallback notNil 
]

{ #category : #'private-event-handling' }
GridMorph >> handlesKeyStroke: evt [
	^ keyPressCallback notNil 
]

{ #category : #'private-event-handling' }
GridMorph >> handlesMouseDown: evt [
	^ clickCallback notNil
]

{ #category : #'event handling' }
GridMorph >> ignoreClicks [
	clickCallback := nil
]

{ #category : #'event handling' }
GridMorph >> ignoreKeyPresses [
	keyPressCallback := nil
]

{ #category : #'actions-images' }
GridMorph >> imageAt: cellPosition [
	^ imgDict at: cellPosition ifAbsent: nil.
]

{ #category : #initialization }
GridMorph >> initialize [
	super initialize.
	self color: Color white.
	self borderColor: Color black.
	
	gridSize := 3@3.
	cellSize := 30@30.
	
	colorDict := Dictionary new.
	imgDict := Dictionary new.
	
	clickCallback := nil.
	keyPressCallback := nil.

	self borderWidth: 1.
]

{ #category : #'private-event-handling' }
GridMorph >> keyStroke: evt [
	self handleKeyCharacter: (evt keyCharacter).
]

{ #category : #'private-event-handling' }
GridMorph >> morphClickedAtPoint: pointInMorph [
	(self cellPositionForPoint: pointInMorph)
		ifNotNil: [ :clickedPosition | clickCallback ifNotNil: [ 
				clickCallback value: clickedPosition ] ]
]

{ #category : #'private-event-handling' }
GridMorph >> mouseDown: evt [
	| pointInMorph |
	super mouseDown: evt.
	pointInMorph := evt cursorPoint - self topLeft.
	self morphClickedAtPoint: pointInMorph
]

{ #category : #private }
GridMorph >> rectangleForCellAt: position [
	"Answer a Rectangle for a given position in the grid in Morph-relative coordinates"
	| x y bw |
	bw := self borderWidth.
	x := (position x - 1) * (self columnWidth + bw) + bw.
	y := (position y - 1) * (self rowHeight + bw) + bw.
	^ (x@y) extent: (self columnWidth @ self rowHeight)
]

{ #category : #'actions-colors' }
GridMorph >> removeColorAt: cellPosition [
	colorDict removeKey: cellPosition ifAbsent: [  ].
	self changed.
]

{ #category : #'actions-images' }
GridMorph >> removeImageAt: cellPosition [
	imgDict removeKey: cellPosition ifAbsent: [  ].
	self changed.
]

{ #category : #private }
GridMorph >> rowBorderOffsets [
	^ (0 to: self rowCount) collect: [ :rowNr | rowNr * (self rowHeight + self borderWidth) ]
]

{ #category : #'accessing-geometry' }
GridMorph >> rowCount [
	^ gridSize y
]

{ #category : #'accessing-geometry' }
GridMorph >> rowHeight [
	^ cellSize y
]

{ #category : #private }
GridMorph >> updateBounds [
	| newGridExtent |
	newGridExtent := self desiredExtent.
	self isInSystemWindow ifTrue: [ self updateOwnerExtentUsing: newGridExtent ].
	self extent: newGridExtent
]

{ #category : #private }
GridMorph >> updateOwnerExtentUsing: newGridExtent [
	| newWinExtent oldGridExtent deltaExtent |
	oldGridExtent := self extent.
	deltaExtent := newGridExtent - oldGridExtent.
	newWinExtent := self owner extent + deltaExtent.
	self owner extent: newWinExtent
]

{ #category : #'event handling' }
GridMorph >> whenCellClickedDo: aCellPositionReceivingBlock [
	self assertIsOneArgReceivingBlock: aCellPositionReceivingBlock.
	clickCallback := aCellPositionReceivingBlock
]

{ #category : #'event handling' }
GridMorph >> whenKeyPressedDo: aKeyEventReceivingBlock [
	self assertIsOneArgReceivingBlock: aKeyEventReceivingBlock.
	keyPressCallback := aKeyEventReceivingBlock
]
