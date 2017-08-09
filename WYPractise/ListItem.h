//
//  ListItem.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "JSONModel.h"

@interface ListItem : JSONModel

@property(nonatomic,copy)NSString *picurl;//图片url
@property(nonatomic,copy)NSString *alias;//简介
@property(nonatomic,copy)NSString *expertId;

@end
