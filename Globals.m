//
//  Globals.m
//  JamWiFi
//
//  Created by Can Poyrazoğlu on 30.04.2019.
//

#import "Globals.h"

static id instance;

@implementation Globals

+(instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance){
            instance = [[Globals alloc] init];
        }
    });
    return instance;
}


@end
