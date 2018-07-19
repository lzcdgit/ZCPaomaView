//
//  ViewController.m
//  跑马灯
//
//  Created by lzc on 2018/7/17.
//  Copyright © 2018年 lzc. All rights reserved.
//

#import "ViewController.h"
#import "PaoMaView.h"
#import "testViewController.h"


@interface ViewController ()< ZCPaomaDelegate>

@property  (nonatomic , strong) PaoMaView *paoma;

@property (nonatomic , strong) NSMutableArray *longAry;
@property (nonatomic , strong) NSMutableArray *shortAry;
@end

@implementation ViewController

- (NSMutableArray *)longAry
{
    if (!_longAry) {
        _longAry = [NSMutableArray array];
    }
    return _longAry;
}


- (NSMutableArray *)shortAry
{
    if (!_shortAry) {
        _shortAry = [NSMutableArray array];
    }
    return _shortAry;
}


- (IBAction)startRun:(UIButton *)sender {
    
    self.shortAry = [@[@"初始化的跑道"]mutableCopy];
    self.longAry = [@[@"初始化的跑道"]mutableCopy];
    if (self.shortAry.count > 0) {
        [self.paoma.dataAry addObject:self.shortAry[0]];
    }
    [self.paoma reloadData];
    sender.hidden = YES;
}


- (IBAction)replaceAllwaysClick:(UIButton *)sender {////打掉跑道
    
    NSArray * ary = @[@"11111我是老大我是老大我是老大我是老大我是老大我是老大11111我是老大我是老嘿嘿嘿",@"22222我是老大我是老大2222",@"3333我是老大哈哈哈33333"];
    NSString *str = ary[arc4random() %3];
    
//    NSString *str = @"11111我是老大我是老大我是老大我是老大我是老大我是老大11111嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿嘿";
    [_longAry replaceObjectAtIndex:0 withObject:str];
    
    [_shortAry addObject:str];
    NSLog( @"打掉跑道,前俩都变=== %@",str);
}


- (IBAction)testClick:(UIButton *)sender {//新增跑道
//    NSLog( @"添加一个公告");
    NSArray * ary = @[@"11111我是替换的文字哈哈哈11111",@"22222我是替换的文字哈哈哈2222",@"3333我是替换的文字哈哈哈33333"];
    NSString *str = ary[arc4random() %3];

     [_shortAry addObject:str];
    
      NSLog( @"添加跑道=== %@",str);
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    self.paoma = [[PaoMaView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 17) withTitle:@"" withTextFontSize:17 withStopTime:2 withScrollSpeed:120];
    self.paoma.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.paoma];
    self.paoma.delegate = self;
    
//    self.shortAry = [@[@"初始化的跑道"]mutableCopy];
//     self.longAry = [@[@"初始化的跑道"]mutableCopy];
    
//    if (self.shortAry.count > 0) {
//        [self.paoma.dataAry addObject:self.shortAry[0]];
//    }
    [self.paoma reloadData];
    
//    [self.paoma start];

    
    // Do any additional setup after loading the view, typically from a nib.
}

#pragma mark - delegate

- (void)reloadPaomaView:(UILabel *)view dataAry:(NSMutableArray *)dataAry
{
    if (self.shortAry.count == 0 && self.longAry.count > 0) {
        NSString *str = self.longAry[0];

        view.text = str;
        [dataAry replaceObjectAtIndex:1 withObject:str];
        [dataAry replaceObjectAtIndex:0 withObject:str];
    }
    
    if (self.shortAry.count > 0) {
        NSString *str = self.shortAry[0];

        view.text = str;

        [dataAry replaceObjectAtIndex:1 withObject:str];
        [self.shortAry removeObjectAtIndex:0];
        
    }
   
    return;
    
}

- (void)reloadAlwayShowPaomaView:(UILabel *)view dataAry:(NSMutableArray *)dataAry
{
   
    if (self.shortAry.count == 0 && self.longAry.count > 0) {
        NSString *str = self.longAry[0];

        view.text = str;
        [dataAry replaceObjectAtIndex:1 withObject:str];
        [dataAry replaceObjectAtIndex:0 withObject:str];
    }
    
    if (self.shortAry.count > 0) {
        NSString *str = self.shortAry[0];
      
        CGFloat w = [self.paoma getFontSizeOfWidth:str fontHeigt:17];

         NSLog(@"4计算的宽 %f",w);
          view.text = str;
        [dataAry replaceObjectAtIndex:0 withObject:str];
        [self.shortAry removeObjectAtIndex:0];
        
    }
   
    
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    testViewController *vc = [[testViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
