//
//  UrlConstructor.m
//  Linker
//
//  Created by KUBO on 11/25/15.
//  Copyright © 2015 KUBO. All rights reserved.
//

#import "UrlConstructor.h"

//static NSString *domain = @"http://lealapim.kubo.co/api/";

static NSString *domain = @"https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:";

@implementation UrlConstructor

+(NSString *)searchIsbn:(NSMutableDictionary *)datos{
    
    NSString * isbn = [datos objectForKey:@"isbn"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,isbn];
    
    NSLog(@"%@",url);
    
    return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@end
