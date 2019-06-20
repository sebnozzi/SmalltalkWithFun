"
I am aware whether I am being shown inside of a SystemWindow or not.

Depending on that, I change my behaviour.

If inside of a SystemWindow, then:
- automatically takes keyboard focus when activated
- avoids the normal ""keybord focused as long as mouse over Morph"" behaviour

Useful for interactive keyboard-driven games.
"
Class {
	#name : #WindowAwareMorph,
	#superclass : #Morph,
	#category : #'SWF-Components-Morphic'
}

{ #category : #activation }
WindowAwareMorph >> activate [
	super activate.
	self isInSystemWindow ifTrue: [ self takeKeyboardFocus ].
]

{ #category : #'submorphs-add/remove' }
WindowAwareMorph >> delete [
	super delete.
	self stopStepping.
]

{ #category : #activation }
WindowAwareMorph >> handlesMouseDown: anEvent [
	^ self isInSystemWindow 
]

{ #category : #activation }
WindowAwareMorph >> handlesMouseOver: anEvent [
	^ (self isInSystemWindow) not
]

{ #category : #activation }
WindowAwareMorph >> mouseDown: evt [
	super mouseDown: evt.
	evt hand newKeyboardFocus: self.
	
]

{ #category : #activation }
WindowAwareMorph >> mouseEnter: anEvent [
	self isInSystemWindow
		ifFalse: [ anEvent hand newKeyboardFocus: self ]
]

{ #category : #activation }
WindowAwareMorph >> mouseLeave: anEvent [
	self isInSystemWindow not
		ifTrue: [ anEvent hand newKeyboardFocus: nil ]
]

{ #category : #private }
WindowAwareMorph >> openInWindow [
	super openInWindow.
   owner
		beUnresizeable;
		removeExpandBox.
	^ self
]

{ #category : #activation }
WindowAwareMorph >> takesKeyboardFocus [
	^ self isInSystemWindow.
]
