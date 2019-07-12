//
//  PasterMenuController.h
//  Paster
//
//  Created by Jakey on 2019/7/12.
//  Copyright © 2019 Jakey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>


@interface PasterMenuController : NSObject
@property (nonatomic, strong)IBOutlet NSMenu *statusMenu;
@property (nonatomic, strong) NSStatusItem *statusItem;

@end


