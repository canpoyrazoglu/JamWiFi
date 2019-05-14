//
//  Output.h
//  JamWiFi
//
//  Created by Can Poyrazoğlu on 30.04.2019.
//

#import <Cocoa/Cocoa.h>



NS_ASSUME_NONNULL_BEGIN

@interface Output : NSViewController

+(instancetype)instance;

@property (weak) IBOutlet NSTextField *networkLabel;
@property (weak) IBOutlet NSTextField *clientLabel;

@end

NS_ASSUME_NONNULL_END
