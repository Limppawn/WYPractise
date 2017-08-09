//
//  Question.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "JSONModel.h"

@interface Question : JSONModel

@property(nonatomic,copy)NSString *content;//内容
@property(nonatomic,copy)NSString *userName;//用户名
@property(nonatomic,copy)NSString *userHeadPicUrl;//用户头像url


@end
