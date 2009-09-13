//
//  SDWordCountValueTransformer.m
//  Macdown
//
//  Created by Steven Degutis on 9/12/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "SDWordCountValueTransformer.h"


@implementation SDWordCountValueTransformer

+ (Class) transformedValueClass { return [NSNumber class]; }
+ (BOOL) allowsReverseTransformation { return NO; }
- (id) transformedValue:(id)value {
	int count = 0;
	
	if (value != nil) {
		NSTextStorage *textStorage = [[NSTextStorage alloc] initWithString:value];
		NSArray *words = [textStorage words];
		count = [words count];
		[textStorage release];
	}
	
	return [NSNumber numberWithInt:count];
}

@end
