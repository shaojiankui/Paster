//
//  HistoryMenuItem.h
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryMenuItem : NSMenuItem
@property (assign,nonatomic) NSInteger index;
@property (strong,nonatomic) NSString *content;
@end

NS_ASSUME_NONNULL_END
