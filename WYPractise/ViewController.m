//
//  ViewController.m
//  WYPractise
//
//  Created by 梁志成 on 16/8/22.
//  Copyright © 2016年 梁志成. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "ListItem.h"
#import "ListCell.h"
#import "JSONModel.h"
#import "DetailViewController.h"

//注册用的xib文件名
#define KListCell @"ListCell"
//复用
#define KCell @"cell"

//数据URL
#define List_urlStr @"http://c.m.163.com/newstopic/list/expert/0-10.html"



@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic,strong)NSMutableArray *dataSource;//数据源数组

@end



@implementation ViewController

//懒加载
-(NSMutableArray *)dataSource{
    
    if (!_dataSource) {
        _dataSource =[NSMutableArray new];
    }
    
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
    [self requestData];//请求网络数据
    
    
}

-(void)setupUI{
    
    //注册
    [self.collectionView registerNib:[UINib nibWithNibName:KListCell bundle:nil] forCellWithReuseIdentifier:KCell];
    self.view.backgroundColor =[UIColor lightGrayColor];
    
}

-(void)requestData{
#if 0
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    //NSDictionary *paramters =@{@"nmber":@"3",@"page":@"1"};
    //GET
    [manager GET:List_urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"success");
        NSArray *arr =responseObject[@"data"][@"expertList"];
        
        for (NSDictionary *dict in arr) {
            
            NSError *error =nil;
            ListItem *itemModel =[[ListItem alloc]initWithDictionary:dict error:&error];
            if (error ==nil) {
                
                [self.dataSource addObject:itemModel];
            }else{
                
                NSLog(@"requsterror=%@",error);
            }
            
        }
        
        
        //刷新UI
        [self.collectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error =%@",error);
    }];
#endif

    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    
    //设置最大并发数
    manager.session.configuration.HTTPMaximumConnectionsPerHost =3;
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    NSURLSessionDataTask *dataTask =[manager GET:List_urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       // NSLog(@"响应头: %@",task.response)
        NSLog(@"%@",[(NSHTTPURLResponse *)task.response allHeaderFields] );
        
        NSLog(@"===succes====");
        
        //jsonmodel 解析
        
        id jsonObj =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *expertListArr =jsonObj[@"data"][@"expertList"];
        
        for (NSDictionary *dic in expertListArr) {
            
            ListItem *itemModel =[[ListItem alloc]initWithDictionary:dic error:nil];
            
            [self.dataSource addObject:itemModel];
        }
        
        //刷新UI
        [self.collectionView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"失败：error=%@",error);
    }];
    
    [dataTask resume];
}

#pragma mark -UICollectionViewDelegate 代理方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailViewController *deVC =[[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
   // DetailViewController *deVC =[DetailViewController new];
    deVC.item =self.dataSource[indexPath.item];
    [self.navigationController pushViewController:deVC animated:YES];
    
}


#pragma mark -UICollectionViewDataSource
//行数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

//cell

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:KCell forIndexPath:indexPath];
    //刷新UI
    ListItem *itemModel =self.dataSource[indexPath.item];
    [cell refreshUI:itemModel];
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
    
}



#pragma mark -UICollectionViewDelegateFlowLayout

//cell大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 140);
}

//cell间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

//cell间距 上下
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 8;
}

//section 与collectionview的边距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsZero;
}


@end
