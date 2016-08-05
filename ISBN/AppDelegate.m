//
//  AppDelegate.m
//  ISBN
//
//  Created by Christian camilo fernandez on 4/08/16.
//  Copyright © 2016 Carolain Lenes. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Rechable internet
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:) name:kReachabilityChangedNotification object:nil];
    
    internetReachable = [Reachability reachabilityForInternetConnection];
    [internetReachable startNotifier];
    
    // check if a pathway to host exists
    hostReachable = [Reachability reachabilityWithHostName:@"http://www.google.com"];
    [hostReachable startNotifier];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) checkNetworkStatus:(NSNotification *)notice{
    // called after network status changes
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus)
    {
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
            [msgDict setValue:@"Atención" forKey:@"Title"];
            [msgDict setValue:@"No se encuentra conectado a internet" forKey:@"Message"];
            [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
            [msgDict setValue:@"0" forKey:@"Tag"];
            
            [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                                waitUntilDone:YES];
            
            [_defaults setObject:@"NO" forKey:@"connectioninternet"];
            [_defaults synchronize];
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            //hayConexionInternet = YES;
            [_defaults setObject:@"YES" forKey:@"connectioninternet"];
            [_defaults synchronize];
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            //hayConexionInternet = YES;
            [_defaults setObject:@"YES" forKey:@"connectioninternet"];
            [_defaults synchronize];
            break;
        }
    }
}

@end
