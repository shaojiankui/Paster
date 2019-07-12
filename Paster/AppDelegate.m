//
//  AppDelegate.m
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()<NSMenuDelegate>

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[PasteWatcher sharedWatcher] watch];
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
@end
