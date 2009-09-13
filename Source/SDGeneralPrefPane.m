//
//  SDGeneralPrefPane.m
//  Appcastic
//
//  Created by Steven Degutis on 7/24/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "SDGeneralPrefPane.h"

@implementation SDGeneralPrefPane

- (id) init {
	if (self = [super initWithNibName:@"GeneralPrefPane" bundle:nil]) {
		[self setTitle:@"General"];
	}
	return self;
}

- (NSImage*) image {
	return [NSImage imageNamed:@"NSPreferencesGeneral"];
}

- (NSString*) tooltip {
	return nil;
}

@end
