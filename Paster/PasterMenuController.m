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
}
- (void)addHistoryItem:(NSString*)content{
    //todo 去重
    if(content && ![content isEqualToString:@""]){
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
    NSLog(@"itemTouched");
}
- (NSStatusItem *)statusItem{
    if (!_statusItem) {
        _statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
        [_statusItem setImage:[NSImage imageNamed:@"paster"]];
        [_statusItem setHighlightMode:YES];
    }
    return _statusItem;
}
@end
