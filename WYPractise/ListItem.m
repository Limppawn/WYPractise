//
//  ListItem.m
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "ListItem.h"

@implementation ListItem

+(BOOL)propertyIsOptional:(NSString *)propertyName{
    
    if ([propertyName isEqualToString:@"expertId"]) {
        
        return NO;
    }
    return YES;
}

@end
