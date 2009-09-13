//
//  SDMainWindowController.m
//  Macdown
//
//  Created by Steven Degutis on 8/29/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "SDMainWindowController.h"


@implementation SDMainWindowController

- (id) init {
	if (self = [super initWithWindowNibName:@"MainWindow"]) {
		NSString *baseContextFile = [[NSBundle mainBundle] pathForResource:@"Context"
																	ofType:@"html"];
		
		baseHTMLString = [[NSString stringWithContentsOfFile:baseContextFile
													encoding:NSUTF8StringEncoding
													   error:NULL] retain];
	}
	return self;
}

- (void) dealloc {
	[str release];
	[super dealloc];
}

- (void) windowDidLoad {
	[textView setTextContainerInset:NSMakeSize(10, 10)];
}

- (NSString*) convertedStringUsingMarkdown {
	NSTask *task = [[NSTask alloc] init];
	
	NSString *perlFile = [[NSBundle mainBundle] pathForResource:@"Markdown"
														 ofType:@"pl"];
	[task setLaunchPath:perlFile];
	
	[task setStandardInput:[NSPipe pipe]];
	[task setStandardOutput:[NSPipe pipe]];
	
	NSFileHandle *writingHandle = [[task standardInput] fileHandleForWriting];
	[writingHandle writeData:[str dataUsingEncoding:NSUTF8StringEncoding]];
	[writingHandle closeFile];
	
	[task launch];
	[task waitUntilExit];
	
	NSData *outputData = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
	NSString *resultString = [[[NSString alloc] initWithData:outputData encoding:NSUTF8StringEncoding] autorelease];
	
	[task release];
	
	return resultString;
}

- (void)textDidChange:(NSNotification *)aNotification {
	[[self class] cancelPreviousPerformRequestsWithTarget:self
												 selector:@selector(resetWebView)
												   object:nil];
	
	[self performSelector:@selector(resetWebView)
			   withObject:nil
			   afterDelay:0.5];
}

- (void) resetWebView {
	NSString *newString = [self convertedStringUsingMarkdown];
	[[webView mainFrame] loadHTMLString:NSSTRINGF(baseHTMLString, newString)
								baseURL:[NSURL URLWithString:@""]];
}

- (void)webView:(WebView *)someWebView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id < WebPolicyDecisionListener >)listener {
	[listener ignore];
	
	[[NSWorkspace sharedWorkspace] openURL:[request URL]];
}

@end
