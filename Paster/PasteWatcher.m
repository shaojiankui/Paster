//
//  PasteWatcher.m
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import "PasteWatcher.h"

@implementation PasteWatcher

+ (void)pasteBoardDidChange:(PasteBoardDidChange)pasteBoardDidChange{
    [self sharedWatcher]-> _pasteBoardDidChange = [pasteBoardDidChange copy];
}

+ (PasteWatcher*)sharedWatcher
{
    static PasteWatcher *sharedWatcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWatcher = [[PasteWatcher alloc] init];
    });
    return sharedWatcher;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.pasteboard = [NSPasteboard generalPasteboard];
        self.changeCount = _pasteboard.changeCount;
    }
    return self;
}
- (void)dealloc
{
    [self cancle];
}
- (void)watch
{
    if(self.pasteboard.changeCount!=self.changeCount){
        NSString *current  = [self.pasteboard stringForType:NSPasteboardTypeString];
        self.changeCount  = self.pasteboard.changeCount;
        if(_pasteBoardDidChange!=NULL){
            _pasteBoardDidChange(self,current);
        }
    }
 

   [self performSelector:@selector(watch) withObject:nil afterDelay:1.0];
}
- (void)cancle
{
   
}
@end
