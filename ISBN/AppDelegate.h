//
//  AppDelegate.h
//  ISBN
//
//  Created by Christian camilo fernandez on 4/08/16.
//  Copyright © 2016 Carolain Lenes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    Reachability* internetReachable;
    Reachability* hostReachable;
}

@property (strong, nonatomic) UIWindow *window;


@end

