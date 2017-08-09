//
//  DetailCell.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailItem.h"

@interface DetailCell : UICollectionViewCell

-(void)refreshUI:(DetailItem *)detModel;
@end
