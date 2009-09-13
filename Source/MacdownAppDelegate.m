//
//  MacdownAppDelegate.m
//  Macdown
//
//  Created by Steven Degutis on 9/12/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "MacdownAppDelegate.h"

#import "SDMainWindowController.h"

#import "SDGeneralPrefPane.h"

#import <Sparkle/Sparkle.h>

@implementation MacdownAppDelegate

+ (void) initialize {
	if (self == [MacdownAppDelegate class]) {
		[NSApp registerDefaultsFromMainBundleFile:@"DefaultValues.plist"];
	}
}

- (SDMainWindowController*) mainWindowController {
	if (mainWindowController == nil)
		mainWindowController = [[SDMainWindowController alloc] init];
	
	return mainWindowController;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	[[self mainWindowController] showWindow:self];
}

- (BOOL) showsPreferencesToolbar {
	return NO;
}

- (NSArray*) preferencePaneControllerClasses {
	return [NSArray arrayWithObjects:
			[SDGeneralPrefPane class],
			nil];
}

@end
