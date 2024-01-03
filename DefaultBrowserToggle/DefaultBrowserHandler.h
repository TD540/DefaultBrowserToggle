//
//  DefaultBrowserHandler.h
//  DefaultBrowserToggle
//
//  Created by thomas on 02/01/2024.
//

#ifndef DefaultBrowserHandler_h
#define DefaultBrowserHandler_h

#import <Foundation/Foundation.h>
#import <ApplicationServices/ApplicationServices.h>

@interface DefaultBrowserHandler : NSObject

+ (void)setDefaultBrowser:(NSString *)bundleID;

@end

#endif /* DefaultBrowserHandler_h */
