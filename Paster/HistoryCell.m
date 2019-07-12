//
//  HistoryCell.m
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import "HistoryCell.h"

@implementation HistoryCell

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}
- (IBAction)reduceTouched:(id)sender {
    NSLog(@"reduceTouched");
}

+(HistoryCell*)nib{
//    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HistoryCell" owner:self topLevelObjects:nil];
    HistoryCell *view = nil;

    NSNib *xib =  [[NSNib alloc] initWithNibNamed:@"HistoryCell" bundle:nil];;
    NSArray *viewsArray = [[NSArray alloc] init];
    [xib instantiateWithOwner:nil topLevelObjects:&viewsArray];
    
    for (int i = 0; i < viewsArray.count; i++) {
        if ([viewsArray[i] isKindOfClass:[HistoryCell class]]) {
            view = (HistoryCell *)viewsArray[i];
            break;
        }
    }
    return view;
}
@end
