//
//  ListCell.h
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListItem.h"


@interface ListCell : UICollectionViewCell

//刷新UI
-(void)refreshUI:(ListItem *)listModel;

@end
