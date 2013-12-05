/**
 * bencoding.reading.list Titanium module
 * Copyright (c) 2013 by Benjamin Bahrenburg. All Rights Reserved.
 * Licensed under the terms of the MIT License
 * Please see the LICENSE included with this distribution for details.
 *
 * Available at https://github.com/benbahrenburg/Ti.Safari.ReadingList
 *
 */

#import "BencodingReadingListModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <SafariServices/SafariServices.h>

@implementation BencodingReadingListModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"f063cdb7-3b06-479b-b0c8-459178101750";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"bencoding.reading.list";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 


#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}
#define stringTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ]

static inline BOOL isEmpty(id thing) {
    return thing == nil
    || [thing isKindOfClass:[NSNull class]]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

#pragma Public APIs

-(NSNumber*)isSupported:(id)unused
{
    if(NSClassFromString(@"SSReadingList")){
        return NUMBOOL(YES);
    }else{
        return NUMBOOL(NO);
    }
}


-(NSDictionary*)add:(id)args
{
    ENSURE_SINGLE_ARG(args,NSDictionary);
    ENSURE_TYPE(args,NSDictionary);
    
    if (![args objectForKey:@"url"]) {
		NSLog(@"[ERROR] URL is required");
        NSMutableDictionary *errMsg = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      NUMBOOL(NO),@"success",
                                      @"URL is required",@"message",
                                      nil];
        return errMsg;
	}
    
    if (![args objectForKey:@"title"]) {
		NSLog(@"[ERROR] title is required");
        NSMutableDictionary *errMsg = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     NUMBOOL(NO),@"success",
                                     @"Title is required", @"message",
                                     nil];
        return errMsg;
	}
    
    NSString *url = stringTrim([TiUtils stringValue:@"url" properties:args]);
    NSString *title = stringTrim([TiUtils stringValue:@"title" properties:args]);
    NSString *preview = stringTrim([TiUtils stringValue:@"previewText" properties:args def:title]);
    
    if(isEmpty(url)){
		NSLog(@"[ERROR] URL is empty");
        NSMutableDictionary *errMsg = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     NUMBOOL(NO),@"success",
                                     @"URL is required, empty string provided",@"message",
                                     nil];
        return errMsg;
    }
 
    if(isEmpty(title)){
		NSLog(@"[ERROR] Title is empty");
        NSMutableDictionary *errMsg = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     NUMBOOL(NO),@"success",
                                     @"Title is required, empty string provided",@"message",
                                     nil];
        return errMsg;
    }
    //If preview is empty, use the title
    if(isEmpty(preview)){
        preview = title;
    }
    
    SSReadingList * readList = [SSReadingList defaultReadingList];
    NSError * error = [NSError new];
    
    BOOL status =[readList addReadingListItemWithURL:[NSURL URLWithString:url] title:title previewText:preview error:&error];
    
    if(status) {
        NSMutableDictionary *success = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     NUMBOOL(status),@"success",
                                     url,@"url",
                                     title,@"title",
                                     preview,@"previewText",
                                     nil];
        return success;
        
    }else{
        NSMutableDictionary *err3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     NUMBOOL(status),@"success",
                                     [error description ], @"message",
                                     nil];
        return err3;
    }
}
@end
