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
      self.statusItem.menu = self.mainMenu;
    // Insert code here to initialize your application
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
- (NSStatusItem *)statusItem{
    if (!_statusItem) {
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
       [_statusItem setImage:[NSImage imageNamed:@"paster"]];
        [_statusItem setHighlightMode:YES];
    }
    return _statusItem;
}
- (NSMenu *)mainMenu{
    if (!_mainMenu) {
        _mainMenu = [[NSMenu alloc] initWithTitle:@"xxxx"];
        _mainMenu.delegate = self;
    }
    return _mainMenu;
}

@end
