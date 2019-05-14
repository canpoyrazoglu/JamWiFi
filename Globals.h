//
//  Globals.h
//  JamWiFi
//
//  Created by Can Poyrazoğlu on 30.04.2019.
//

#import <Foundation/Foundation.h>
#import <CoreWLAN/CoreWLAN.h>


@interface Globals : NSObject

@property(nonatomic) NSArray<CWNetwork*> *nets;
+(instancetype)instance;

@end
