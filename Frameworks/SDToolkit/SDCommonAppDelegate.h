//
//  SDCommonAppDelegate.h
//  DeskLabels
//
//  Created by Steven Degutis on 7/4/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SDPreferencesController.h"

@class SUUpdater;

@interface SDCommonAppDelegate : NSObject <SDPreferencesDelegate> {
	SUUpdater *updater;
	SDPreferencesController *preferencesController;
}

- (IBAction) showPreferencesPanel:(id)sender;
- (IBAction) checkForUpdates:(id)sender;

// must override these in subclass:

- (BOOL) showsPreferencesToolbar;
- (NSArray*) preferencePaneControllerClasses;

@end
