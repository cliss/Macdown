//
//  MacdownAppDelegate.h
//  Macdown
//
//  Created by Steven Degutis on 9/12/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDCommonAppDelegate.h"

@class SDMainWindowController;

@interface MacdownAppDelegate : SDCommonAppDelegate <NSApplicationDelegate> {
	SDMainWindowController *mainWindowController;
}

@property (readonly) SDMainWindowController *mainWindowController;

@end
