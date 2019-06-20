"
A GridMorphTest is a test class for testing the behavior of GridMorph
"
Class {
	#name : #GridMorphTest,
	#superclass : #TestCase,
	#instVars : [
		'gm'
	],
	#category : #'SWF-Tests-Library-Morphic'
}

{ #category : #fixtures }
GridMorphTest >> gridMorph2x2 [
	^ self gridMorphSize: 2 cellSize: 10
]

{ #category : #fixtures }
GridMorphTest >> gridMorphCellSize10 [
	^ self gridMorphSize: 2 cellSize: 10
]

{ #category : #fixtures }
GridMorphTest >> gridMorphSize: gridSize cellSize: cellSize [
	^ GridMorph new
		beSquare: gridSize;
		cellSize: cellSize;
		yourself
]

{ #category : #'tests-accessing' }
GridMorphTest >> testBackgroundColor [
	gm := self gridMorph2x2.
	self assert: (gm backgroundColor) equals: (Color white).
	gm backgroundColor: (Color gray).
	self assert: (gm backgroundColor) equals: (Color gray).
]

{ #category : #'tests-accessing' }
GridMorphTest >> testBorderWidth [
	gm := self gridMorph2x2.
	gm borderWidth: 3.
	self assert: (gm borderWidth) equals: 3.
	self assert: (gm width) equals: ((2*10)+(3*3)).
	self assert: (gm height) equals: ((2*10)+(3*3)).
]

{ #category : #'tests-actions-colors' }
GridMorphTest >> testCellAtFillWith [
	gm := self gridMorph2x2.
	gm cellAt: 1@1 fillWith: (Color blue).
	self assert: (gm colorAt: 1@1) equals: (Color blue).
]

{ #category : #'tests-actions-images' }
GridMorphTest >> testCellAtShowImage [
	| form |
	form := Form new.
	gm := self gridMorph2x2.
	gm cellAt: 1@1 showImage: form.
	self assert: (gm imageAt: 1@1) equals: form.
	self assert: (gm imageAt: 2@2) equals: nil.
]

{ #category : #'tests-accessing' }
GridMorphTest >> testCellSize [
	gm := self gridMorph2x2.
	gm cellSize: 20.
	self assert: (gm width) equals: ((20*2)+3).
	self assert: (gm height) equals: ((20*2)+3).
]

{ #category : #'tests-actions-clearing' }
GridMorphTest >> testClearAll [
	| form |
	form := Form new.
	gm := self gridMorph2x2.
	gm cellAt: 1@1 showImage: form.
	gm cellAt: 2@2 fillWith: (Color red).
	gm clearAll.
	self assert: (gm imageAt: 1@1) equals: nil.
	self assert: (gm colorAt: 2@2) equals: nil.

]

{ #category : #'tests-actions-clearing' }
GridMorphTest >> testClearColors [
	gm := self gridMorph2x2.

	gm cellAt: 1@1 fillWith: (Color blue).
	gm cellAt: 2@2 fillWith: (Color red).
	gm clearColors.
	
	self assert: (gm colorAt: 1@1) equals: nil.
	self assert: (gm colorAt: 2@2) equals: nil.
]

{ #category : #'tests-actions-clearing' }
GridMorphTest >> testClearImages [
	| form |
	form := Form new.
	gm := self gridMorph2x2.
	gm cellAt: 1@1 showImage: form.
	gm cellAt: 2@2 showImage: form.
	gm clearImages.
	self assert: (gm imageAt: 1@1) equals: nil.
	self assert: (gm imageAt: 2@2) equals: nil.
]

{ #category : #'tests-actions-colors' }
GridMorphTest >> testColorAt [
	gm := self gridMorph2x2.
	gm cellAt: 2@2 fillWith: (Color red).
	self assert: (gm colorAt: 2@2) equals: (Color red).
	self assert: (gm colorAt: 1@1) equals: nil.
]

{ #category : #'tests-private' }
GridMorphTest >> testColumnBorderOffsets [
	| positions |
	gm := self gridMorph2x2.
	
	gm borderWidth: 2.
	positions := gm columnBorderOffsets asArray.
	"[0-1] 2-11 [12-13] 14-23 [24-25]"
	self assertCollection: positions equals: #(0 12 24).

]

{ #category : #'tests-accessing' }
GridMorphTest >> testGridSize [
	gm := self gridMorphCellSize10.
	gm := gm gridSize: 5@2.
	self assert: (gm columnCount) equals: 5.
	self assert: (gm rowCount) equals: 2.
	gm := gm gridSize: 10.
	self assert: (gm columnCount) equals: 10.
	self assert: (gm rowCount) equals: 10.

]

{ #category : #'tests-event handling' }
GridMorphTest >> testIgnoreClicks [
	| clicked |
	gm := self gridMorph2x2.

	clicked := false.
	gm whenCellClickedDo: [ :pos | clicked := true ].
	gm morphClickedAtPoint: 5@7.
	self assert: clicked equals: true.
	
	clicked := false.
	gm ignoreClicks.
	gm morphClickedAtPoint: 5@7.
	self assert: clicked equals: false.
]

{ #category : #'tests-event handling' }
GridMorphTest >> testIgnoreKeyPresses [
	| keyChar |
	gm := self gridMorph2x2.
	
	keyChar := nil.
	gm whenKeyPressedDo: [ :kc | keyChar := kc ].
	gm ignoreKeyPresses.
	gm handleKeyCharacter: $A.
	self assert: keyChar equals: nil.
]

{ #category : #'tests-actions-images' }
GridMorphTest >> testImageAt [
	| form |
	form := Form new.
	gm := self gridMorph2x2.
	gm cellAt: 1@1 showImage: form.
	self assert: (gm imageAt: 1@1) equals: form.
	self assert: (gm imageAt: 2@2) equals: nil.
]

{ #category : #'tests-accessing' }
GridMorphTest >> testRecangularSize [
	gm := self gridMorphCellSize10.
	gm := gm beRectangular: 5 by: 2.
	"Test properties"
	self assert: (gm columnCount) equals: 5.
	self assert: (gm rowCount) equals: 2.
	"Test Morphic dimensions"
	self assert: (gm width) equals: (5*10)+(5+1).
	self assert: (gm height) equals: (2*10)+(2+1).
]

{ #category : #'tests-accessing' }
GridMorphTest >> testRectangularCellSize [
	gm := self gridMorph2x2.
	gm cellSize: 30@40.
	self assert: (gm width) equals: ((30*2)+3).
	self assert: (gm height) equals: ((40*2)+3).
]

{ #category : #initialization }
GridMorphTest >> testRectangularSize [
	gm := GridMorph new.
]

{ #category : #'tests-actions-colors' }
GridMorphTest >> testRemoveColorAt [
	gm := self gridMorph2x2.
	gm cellAt: 1@1 fillWith: (Color blue).
	gm removeColorAt: 1@1.
	self assert: (gm colorAt: 1@1) equals: nil.
]

{ #category : #'tests-actions-images' }
GridMorphTest >> testRemoveImageAt [
	| form |
	form := Form new.
	gm := self gridMorph2x2.
	gm cellAt: 1@1 showImage: form.
	gm removeImageAt: 1@1.
	self assert: (gm imageAt: 1@1) equals: nil.
]

{ #category : #'tests-private' }
GridMorphTest >> testRowBorderOffsets [
	| positions |
	gm := self gridMorph2x2.

	gm borderWidth: 2.
	positions := gm rowBorderOffsets.
	"[0-1] 2-11 [12-13] 14-23 [24-25]"
	self assertCollection: positions equals: #(0 12 24).
]

{ #category : #'tests-accessing' }
GridMorphTest >> testSquareSize [
	gm := self gridMorphCellSize10.
	gm beSquare: 3.
	"Test properties"
	self assert: (gm columnCount) equals: 3.
	self assert: (gm rowCount) equals: 3.
	"Test Morphic dimensions"
	self assert: (gm width) equals: (3*10)+(3+1).
	self assert: (gm height) equals: (3*10)+(3+1).
	
]

{ #category : #'tests-event handling' }
GridMorphTest >> testWhenCellClickedDo [
	| clickedCellPosition |
	gm := self gridMorph2x2.
	
	clickedCellPosition := nil.
	gm whenCellClickedDo: [ :pos | clickedCellPosition := pos ].
	
	gm morphClickedAtPoint: 5@7.
	self assert: clickedCellPosition equals: 1@1.
	
	gm morphClickedAtPoint: 12@14.
	self assert: clickedCellPosition equals: 2@2.
	
	"Clicking on the border should be ignored"
	clickedCellPosition := nil.
	gm morphClickedAtPoint: 11@5.
	self assert: clickedCellPosition equals: nil.
	

]

{ #category : #'tests-event handling' }
GridMorphTest >> testWhenKeyPressedDo [
	| keyChar |
	gm := self gridMorph2x2.

	gm whenKeyPressedDo: [ :kc | keyChar := kc ].
	gm handleKeyCharacter: $A.
	self assert: keyChar equals: $A.
]
