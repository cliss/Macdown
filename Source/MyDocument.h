//
//  MyDocument.h
//  Macdown
//
//  Created by Steven Degutis on 9/13/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//


#import <Cocoa/Cocoa.h>

#import <WebKit/WebKit.h>

@interface MyDocument : NSDocument {
	IBOutlet WebView *webView;
	IBOutlet NSTextView *textView;
	
	NSString *baseHTMLString;
	NSString *str;
}

- (IBAction)copySource:(id)sender;

@end
