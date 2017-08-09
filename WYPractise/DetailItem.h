//
//  DetailItem.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "JSONModel.h"
#import "Question.h"
#import "Answer.h"


@interface DetailItem : JSONModel

@property(nonatomic,strong)Question *question;
@property(nonatomic,strong)Answer *answer;

@end
