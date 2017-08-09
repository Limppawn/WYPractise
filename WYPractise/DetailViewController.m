//
//  DetailViewController.m
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailCell.h"
#import "DetailItem.h"
#import "AFNetworking.h"
#import "ListItem.h"

//复用标志
#define KReuseID @"cell"
//xib文件名
#define KXibName @"DetailCell"


@interface DetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *DetailCollectionView;

@property(nonatomic,strong)NSMutableArray *DetailData;

@end

@implementation DetailViewController



-(NSMutableArray *)DetailData{
    
    if (!_DetailData) {
        
        _DetailData =[NSMutableArray new];
    }
    
    return _DetailData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setUpUI];
    
    //向服务器请求数据
    [self requestData];
    
    
    
}

-(void)setUpUI{
    //注册
    [self.DetailCollectionView registerNib:[UINib nibWithNibName:KXibName bundle:nil] forCellWithReuseIdentifier:KReuseID];
    self.view.backgroundColor =[UIColor lightGrayColor];
}

-(void)requestData{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    //设置最大并发数
    manager.session.configuration.HTTPMaximumConnectionsPerHost =3;
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    NSString *url_str =[NSString stringWithFormat:@"http://c.m.163.com/newstopic/qa/%@.html",self.item.expertId];
    //EX2884402295158045470
    //http://c.m.163.com/newstopic/qa/EX2884402295158045470.html
    //GET
   // NSString *url_str =[NSString stringWithFormat:@"http://c.m.163.com/newstopic/qa/EX2884402295158045470.html"];
    NSURLSessionDataTask *dataTask =[manager GET:url_str parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"%@",[(NSHTTPURLResponse *)task.response allHeaderFields] );
        

        NSLog(@"====successful=====");
        id jsonObj =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *DetailArr =jsonObj[@"data"][@"hotList"];
        
        for (NSDictionary *dic in DetailArr) {
           
            DetailItem *itmeModel =[[DetailItem alloc]initWithDictionary:dic error:nil];
          
                 [self.DetailData addObject:itmeModel];
        }
        
        //UI
        [self.DetailCollectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error =%@",error);
    }];
    
    //执行
    [dataTask resume];
}

#pragma mark -UICollectionViewDataSource

//items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.DetailData.count;
}

//cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:KReuseID forIndexPath:indexPath];
    
    DetailItem *detModel =self.DetailData[indexPath.item];
    [cell refreshUI:detModel];
    
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
}

#pragma mark -UICollectionViewFlowLayout
//大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 180);
}

//间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 8;
}

//section边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsZero;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
