//
//  SDCommonAppDelegate.m
//  DeskLabels
//
//  Created by Steven Degutis on 7/4/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "SDCommonAppDelegate.h"

#import <Sparkle/Sparkle.h>

@implementation SDCommonAppDelegate

- (id) init {
	if (self = [super init]) {
		updater = [[SUUpdater sharedUpdater] retain];
	}
	return self;
}

- (IBAction) checkForUpdates:(id)sender {
	[updater checkForUpdates:sender];
}

- (IBAction) showPreferencesPanel:(id)sender {
	if (preferencesController == nil) {
		preferencesController = [[SDPreferencesController alloc] init];
		preferencesController.delegate = self;
	}
	
	[NSApp activateIgnoringOtherApps:YES];
	[preferencesController showWindow:self];
}

- (BOOL) showsPreferencesToolbar {
	return NO;
}

- (NSArray*) preferencePaneControllerClasses {
	return [NSArray array];
}

@end
