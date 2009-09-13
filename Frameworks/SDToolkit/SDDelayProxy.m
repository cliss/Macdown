//
//  SDDelayProxy.m
//  MacSiteAdmin
//
//  Created by Steven Degutis on 8/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "SDDelayProxy.h"
#import <objc/runtime.h>

#define SDDelayProxyBlockKey @"block"

@implementation SDDelayProxy

+ (void) performAfterDelay:(NSTimeInterval)delay block:(dispatch_block_t)someBlock {
	SDDelayProxy *proxy = [[SDDelayProxy alloc] init];
	objc_setAssociatedObject(proxy, SDDelayProxyBlockKey, someBlock, OBJC_ASSOCIATION_COPY);
	[proxy performSelector:@selector(runBlock)
				withObject:nil
				afterDelay:delay];
}

- (void) runBlock {
	void (^block)() = objc_getAssociatedObject(self, SDDelayProxyBlockKey);
	block();
	objc_removeAssociatedObjects(self);
	[self release];
}

@end
