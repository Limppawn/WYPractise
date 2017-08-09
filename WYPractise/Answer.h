//
//  Answer.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "JSONModel.h"

@interface Answer : JSONModel

@property(nonatomic,copy)NSString *content;//提问内容
@property(nonatomic,copy)NSString *specialistName;
@property(nonatomic,copy)NSString *specialistHeadPicUrl;

@end
