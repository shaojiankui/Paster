//
//  HistoryCell.h
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HistoryCell : NSView

@property (weak) IBOutlet NSTextField *content;
@property (weak) IBOutlet NSButton *reduceButton;
- (IBAction)reduceTouched:(id)sender;
+(HistoryCell*)nib;
@end

NS_ASSUME_NONNULL_END
