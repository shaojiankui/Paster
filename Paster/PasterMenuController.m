//
//  PasterMenuController.m
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import "PasterMenuController.h"
#import "HistoryMenuItem.h"
#import "HistoryCell.h"

#import "PasteWatcher.h"
@implementation PasterMenuController
-(void)awakeFromNib{
    [super awakeFromNib];
    self.statusItem.menu = self.statusMenu;
    __weak typeof(self) weakSelf = self;
    
    [PasteWatcher pasteBoardDidChange:^(PasteWatcher * _Nonnull pasteWatcher, NSString * _Nonnull content) {
        __weak typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf addHistoryItem:content];
    }];
    [self build];
}
  
- (void)build{
    NSMenu *oprationMenu =  (NSMenu*)[self.statusItem.menu itemWithTag:1000].submenu;

    self.autoStartButton = [[NSButton alloc]init];
    self.autoStartButton.frame = NSMakeRect(0, 0, 80, 30);
    self.autoStartButton.title = @"自启";
    self.autoStartButton.font = [NSFont systemFontOfSize:15];
    [self.autoStartButton setButtonType:NSButtonTypeSwitch];
    [self.autoStartButton setTarget:self];
    [self.autoStartButton setAction:@selector(autoStartupTouched:)];
    [oprationMenu itemWithTag:2000].view =  self.autoStartButton;
    
    NSString *launchFolder = [NSString stringWithFormat:@"%@/Library/LaunchAgents",NSHomeDirectory()];
    NSString *boundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    NSString *dstLaunchPath = [launchFolder stringByAppendingFormat:@"/%@.plist",boundleID];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    if ([fm fileExistsAtPath:dstLaunchPath isDirectory:&isDir] && !isDir) {
        self.autoStartButton.state = NSOnState;
    }
}
- (NSStatusItem *)statusItem{
    if (!_statusItem) {
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [_statusItem setImage:[NSImage imageNamed:@"paster"]];
        [_statusItem setHighlightMode:YES];
    }
    return _statusItem;
}
- (void)addHistoryItem:(NSString*)content{
    if(content && ![content isEqualToString:@""]){
        for(HistoryMenuItem *item in  self.statusItem.menu.itemArray){
            if(item.tag !=1000 && item.tag !=1001 && [content isEqualToString:item.content]){
                [self.statusItem.menu removeItem:item];
            }
        }
        HistoryMenuItem *menuItem = [[HistoryMenuItem alloc] init];
        [menuItem setTarget:self];
        menuItem.title = content;
        menuItem.content = content;
        [menuItem setAction:@selector(itemTouched:)];
        //    menuItem.view = [HistoryCell nib];
        [self.statusItem.menu insertItem:menuItem atIndex:0];
    }
}
- (void)itemTouched:(HistoryMenuItem*)menuItem{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard writeObjects:@[menuItem.content]];
}

- (IBAction)exitTouched:(id)sender {
    [NSApp terminate:self];
}

- (IBAction)settingTouched:(id)sender {
    
}
- (IBAction)clearTouched:(id)sender {
    for(NSMenuItem *item in self.statusItem.menu.itemArray){
        if(item.tag!=1000 && item.tag !=1001){
            [self.statusItem.menu removeItem:item];
        }
    }
}


//自启动
- (IBAction)autoStartupTouched:(id)sender {
    NSLog(@"Switch (%@) is %@", sender, (self.autoStartButton.state ==1) ? @"checked" : @"unchecked");
    if(self.autoStartButton.state ==1)
    {
        [self installDaemon];
    }
    else
    {
        [self unInstallDaemon];
    }
}
-(void)installDaemon{
    NSString *launchFolder = [NSString stringWithFormat:@"%@/Library/LaunchAgents",NSHomeDirectory()];
    NSString *boundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    NSString *dstLaunchPath = [launchFolder stringByAppendingFormat:@"/%@.plist",boundleID];
    NSFileManager *fm = [NSFileManager defaultManager];
    BOOL isDir = NO;
    //已经存在启动项中，就不必再创建
    if ([fm fileExistsAtPath:dstLaunchPath isDirectory:&isDir] && !isDir) {
        return;
    }
    //下面是一些配置
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    NSMutableArray* arr = [[NSMutableArray alloc] init];
    [arr addObject:[[NSBundle mainBundle] executablePath]];
    [arr addObject:@"-runMode"];
    [arr addObject:@"autoLaunched"];
    [dict setObject:[NSNumber numberWithBool:true] forKey:@"RunAtLoad"];
    [dict setObject:boundleID forKey:@"Label"];
    [dict setObject:arr forKey:@"ProgramArguments"];
    isDir = NO;
    if (![fm fileExistsAtPath:launchFolder isDirectory:&isDir] && isDir) {
        [fm createDirectoryAtPath:launchFolder withIntermediateDirectories:NO attributes:nil error:nil];
    }
    [dict writeToFile:dstLaunchPath atomically:NO];
    
}
-(void)unInstallDaemon{
    NSString* launchFolder = [NSString stringWithFormat:@"%@/Library/LaunchAgents",NSHomeDirectory()];
    BOOL isDir = NO;
    NSFileManager* fm = [NSFileManager defaultManager];
    if (![fm fileExistsAtPath:launchFolder isDirectory:&isDir] && isDir) {
        return;
    }
    NSString * boundleID = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleIdentifierKey];
    NSString* srcLaunchPath = [launchFolder stringByAppendingFormat:@"/%@.plist",boundleID];
    [fm removeItemAtPath:srcLaunchPath error:nil];
}
@end
