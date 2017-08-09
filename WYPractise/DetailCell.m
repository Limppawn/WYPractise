//
//  DetailCell.m
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "DetailCell.h"
#import "UIImageView+WebCache.h"



@interface DetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userHeadImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userContentLabel;


@property (weak, nonatomic) IBOutlet UIImageView *speciaHeadImageView;

@property (weak, nonatomic) IBOutlet UILabel *speciaNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ansContentLabel;

@end

@implementation DetailCell


-(void)refreshUI:(DetailItem *)detModel{
    
    //question
    self.userNameLabel.text =detModel.question.userName;
    self.userContentLabel.text =detModel.question.content;
    
    //异步加载图片
    [self.userHeadImageView sd_setImageWithURL:[NSURL URLWithString:detModel.question.userHeadPicUrl]];
    
    //answer
    self.speciaNameLabel.text =detModel.answer.specialistName;
    self.ansContentLabel.text =detModel.answer.content;
    
    //加载图片
    [self.speciaHeadImageView  sd_setImageWithURL:[NSURL URLWithString:detModel.answer.specialistHeadPicUrl]];
    
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.userHeadImageView.clipsToBounds =YES;
    self.userHeadImageView.layer.cornerRadius =15.0f;
    
    self.speciaHeadImageView.clipsToBounds =YES;
    self.speciaHeadImageView.layer.cornerRadius =15.0f;
    
}

@end
