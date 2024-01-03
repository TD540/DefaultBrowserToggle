//
//  DefaultBrowserHandler.m
//  DefaultBrowserToggle
//
//  Created by thomas on 02/01/2024.
//

#import "DefaultBrowserHandler.h"

@implementation DefaultBrowserHandler

+ (void)setDefaultBrowser:(NSString *)bundleID {
    LSSetDefaultHandlerForURLScheme(CFSTR("http"), (__bridge CFStringRef)bundleID);
    LSSetDefaultHandlerForURLScheme(CFSTR("https"), (__bridge CFStringRef)bundleID);
}

@end
