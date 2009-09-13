//
//  SDMainWindowController.h
//  Macdown
//
//  Created by Steven Degutis on 8/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <WebKit/WebKit.h>

@interface SDMainWindowController : NSWindowController {
	NSString *baseHTMLString;
	
	NSString *str;
	
	IBOutlet NSTextView *textView;
	IBOutlet WebView *webView;
}

@end
