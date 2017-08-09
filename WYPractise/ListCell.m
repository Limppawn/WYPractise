//
//  ListCell.m
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "ListCell.h"
#import "UIImageView+WebCache.h"

@interface ListCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;

@end

@implementation ListCell

-(void)refreshUI:(ListItem *)listModel{
    
     self.aliasLabel.text =listModel.alias;
    
    //加载图片
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:listModel.picurl]];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
