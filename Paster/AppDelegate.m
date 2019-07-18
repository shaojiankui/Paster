//
//  AppDelegate.m
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import "AppDelegate.h"
#import "GitHubUpdater.h"
@interface AppDelegate ()<NSMenuDelegate>

@property (weak) IBOutlet NSWindow *window;
@property(strong, nullable)  GitHubUpdater * updater;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [[PasteWatcher sharedWatcher] watch];
    
    self.updater            = [[ GitHubUpdater alloc] init];
    self.updater.user       = @"shaojiankui";
    self.updater.repository = @"Paster";
    [self.updater checkForUpdatesInBackground];
    
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
@end
