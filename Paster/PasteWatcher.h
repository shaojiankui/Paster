//
//  PasteWatcher.h
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
NS_ASSUME_NONNULL_BEGIN


@class PasteWatcher;
typedef void(^PasteBoardDidChange)(PasteWatcher *pasteWatcher,NSString *content);


@interface PasteWatcher : NSObject
{
    PasteBoardDidChange _pasteBoardDidChange;
}
@property(nonatomic,strong) NSPasteboard *pasteboard;
@property (assign,nonatomic) NSInteger changeCount;

+ (PasteWatcher*)sharedWatcher;
- (void)watch;
- (void)cancle;
+ (void)pasteBoardDidChange:(PasteBoardDidChange)pasteBoardDidChange;
@end

NS_ASSUME_NONNULL_END
