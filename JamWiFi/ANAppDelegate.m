//
//  ANAppDelegate.m
//  JamWiFi
//
//  Created by Alex Nichol on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ANAppDelegate.h"
#import "ANListView.h"
#import "Output.h"

@implementation ANAppDelegate{
    NSWindow *outputWindow;
}

-(NSView *)loadWithNibNamed:(NSString *)nibNamed owner:(id)owner class:(Class)loadClass {
    
    NSNib * nib = [[NSNib alloc] initWithNibNamed:nibNamed bundle:nil];
    
    NSArray * objects;
    if (![nib instantiateWithOwner:owner topLevelObjects:&objects]) {
        NSLog(@"Couldn't load nib named %@", nibNamed);
        return nil;
    }
    
    for (id object in objects) {
        if ([object isKindOfClass:loadClass]) {
            return object;
        }
    }
    return nil;
}

@synthesize window = _window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    
    outputWindow = [[NSWindow alloc] initWithContentRect:NSMakeRect(860, 500, 450, 300) styleMask: NSWindowStyleMaskTitled backing:NSBackingStoreBuffered defer:NO];
    outputWindow.isVisible = YES;
    outputWindow.title = @"Output";
    outputWindow.contentView = [self loadWithNibNamed:@"Output" owner:Output.instance class:[NSView class]];
    networkList = [[ANListView alloc] initWithFrame:[self.window.contentView bounds]];
    [self pushView:networkList direction:ANViewSlideDirectionForward];
    [[CarbonAppProcess currentProcess] makeFrontmost];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication {
    return YES;
}

- (void)pushView:(NSView *)view direction:(ANViewSlideDirection)direction {
    if (animating) return;
    __weak id weakSelf = self;
    NSRect oldDestFrame = activeView.bounds;
    if (direction == ANViewSlideDirectionForward) {
        oldDestFrame.origin.x = -oldDestFrame.size.width;
    } else {
        oldDestFrame.origin.x = oldDestFrame.size.width;
    }
    
    NSRect newSourceFrame = [self.window.contentView bounds];
    NSRect newDestFrame = [self.window.contentView bounds];
    
    if (direction == ANViewSlideDirectionForward) {
        newSourceFrame.origin.x = newSourceFrame.size.width;
    } else {
        newSourceFrame.origin.x = -newSourceFrame.size.width;
    }
    
    animating = YES;
    
    [view setFrame:newSourceFrame];
    [self.window.contentView addSubview:view];
    nextView = view;
    
    [[NSAnimationContext currentContext] setDuration:0.3];
    [[NSAnimationContext currentContext] setCompletionHandler:^{
        [weakSelf animationComplete];
    }];
    [NSAnimationContext beginGrouping];
    [[activeView animator] setFrame:oldDestFrame];
    [[view animator] setFrame:newDestFrame];
    [NSAnimationContext endGrouping];
}

- (void)animationComplete {
    [activeView removeFromSuperview];
    animating = NO;
    activeView = nextView;
    nextView = nil;
}

- (void)showNetworkList {
    [self pushView:networkList direction:ANViewSlideDirectionBackward];
}

@end
