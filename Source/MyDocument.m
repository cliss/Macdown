//
//  MyDocument.m
//  Macdown
//
//  Created by Steven Degutis on 9/13/09.
//  Copyright 2009 Thoughtful Tree Software. All rights reserved.
//

#import "MyDocument.h"

static NSString *kSDMarkdownFileType = @"MarkdownFile";

@interface MyDocument (PrivateMethods)

- (NSString*) convertedStringUsingMarkdown;

@end

@implementation MyDocument

- (id)init {
	if (self = [super init]) {
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

- (NSString *)windowNibName {
	return @"MyDocument";
}

- (void)windowControllerDidLoadNib:(NSWindowController *) aController {
	[super windowControllerDidLoadNib:aController];
	
	[textView setTextContainerInset:NSMakeSize(0, 10)];
	[textView setFont:[NSFont fontWithName:@"Monaco" size:11.0]];
	
	[[aController window] setContentBorderThickness:24.0 forEdge:NSMinYEdge];
}

- (NSData *)dataOfType:(NSString *)typeName error:(NSError **)outError 
{
	NSLog(@"Getting data of type %@.", typeName);
	if ([typeName isEqualToString:kSDMarkdownFileType])
	{
		return [str dataUsingEncoding:NSUTF8StringEncoding];
	}
	else if ([typeName isEqualToString:@"NSHTMLTextDocumentType"])
	{
		return [[NSString stringWithFormat:@"<html><body>%@</body></html>", [self convertedStringUsingMarkdown]] dataUsingEncoding:NSUTF8StringEncoding];

	}

	
	if (outError)
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	
	return nil;
}

- (BOOL)readFromData:(NSData *)data ofType:(NSString *)typeName error:(NSError **)outError {
	if ([typeName isEqualToString: kSDMarkdownFileType]) {
		str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		
		[self performSelector:@selector(resetWebView)
				   withObject:nil
				   afterDelay:0.0];
		
		return YES;
	}
	
	if (outError)
		*outError = [NSError errorWithDomain:NSOSStatusErrorDomain code:unimpErr userInfo:NULL];
	
	return YES;
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
	[[webView mainFrame] loadHTMLString:[NSString stringWithFormat:baseHTMLString, newString]
								baseURL:[NSURL URLWithString:@""]];
}

- (void)webView:(WebView *)someWebView decidePolicyForNavigationAction:(NSDictionary *)actionInformation request:(NSURLRequest *)request frame:(WebFrame *)frame decisionListener:(id < WebPolicyDecisionListener >)listener {
	[listener ignore];
	
	[[NSWorkspace sharedWorkspace] openURL:[request URL]];
}

- (IBAction)copySource:(id)sender
{
	//[[NSPasteboard generalPasteboard] clearContents];
	[[NSPasteboard generalPasteboard] declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:nil];
	[[NSPasteboard generalPasteboard] setData:[[self convertedStringUsingMarkdown] dataUsingEncoding:NSUTF8StringEncoding] forType:NSStringPboardType];
}

@end
