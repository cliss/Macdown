//
//  SDDelayProxy.h
//  MacSiteAdmin
//
//  Created by Steven Degutis on 8/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SDDelayProxy : NSObject

+ (void) performAfterDelay:(NSTimeInterval)delay block:(dispatch_block_t)someBlock;

@end
