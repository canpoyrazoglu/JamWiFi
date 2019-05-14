//
//  Output.m
//  JamWiFi
//
//  Created by Can Poyrazoğlu on 30.04.2019.
//

#import "Output.h"

static id instance;

@implementation Output

+(instancetype)instance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!instance){
            instance = [[Output alloc] init];
        }
    });
    return instance;
}

@end
