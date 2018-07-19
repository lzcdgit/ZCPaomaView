//
//  PaoMaView.m
//  跑马灯

//  第一次上传GitHub ,希望能点下Star或者提提意见,谢谢.
//  https://github.com/lzcdgit
//  目前还没有很好的封装,后续会优化.

//  Created by lzc on 2018/7/17.
//  Copyright © 2018年 lzc. All rights reserved.
//

#import "PaoMaView.h"

@interface PaoMaView ()

@property (assign, nonatomic) NSInteger interval;

@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic ,assign) CGFloat w1;
@property (nonatomic , assign) CGFloat w2;
@property (nonatomic , assign) CGFloat stopTime;
@property (nonatomic , assign) CGFloat speed;


@end

@implementation PaoMaView


- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTextFontSize:(CGFloat)fontSize withStopTime:(NSInteger)interval withScrollSpeed:(CGFloat )speed
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        contentView.clipsToBounds = YES;
        [self addSubview:contentView];
        
        
        self.stopTime = interval;
        self.speed = speed;
        
        self.oneLB = [[UILabel alloc]init];
        self.oneLB .numberOfLines = 0;
//        self.oneLB .text = title;
        self.oneLB .font = [UIFont systemFontOfSize:fontSize];
        [contentView addSubview:self.oneLB];
        
        self.twoLB = [[UILabel alloc]init];
        self.twoLB.numberOfLines = 0;
//        self.twoLB.text = [NSString stringWithFormat:@"222"];
        self.twoLB.font = [UIFont systemFontOfSize:fontSize];
        [contentView addSubview:self.twoLB];
        
//        self.oneLB.backgroundColor = [UIColor greenColor];
//        self.twoLB.backgroundColor = [UIColor yellowColor];
        self.w1 = 0;
        self.w2 = 0;
    }
    return self;
}


- (void)reloadData
{
    //    CGFloat w1 = 0;
    //    CGFloat w2 = 0;
    if(self.dataAry.count == 0){
        return;
    }
    if (self.dataAry.count == 1) {

        [self.dataAry addObject:self.dataAry[0]];
         NSLog(@"凑够1111111 跑起来 %@",self.dataAry);
    }
    
    for (int i = 0; i < 2; i++) {
        NSString *str = self.dataAry[0];
        if (i == 0) {
            self.w1 =  [self getFontSizeOfWidth:str fontHeigt:17] ;
           
            if (self.w1 < self.frame.size.width) {
                self.w1 = self.frame.size.width;
            }
            self.oneLB.frame = CGRectMake(0, 0,self.w1, 17);
            self.oneLB.text = str;
        }
        if (i == 1) {
            //            lableTwo.text = str;
            self.w2 = [self getFontSizeOfWidth:str fontHeigt:17] ;
            if (self.w2 < self.frame.size.width) {
                self.w2 = self.frame.size.width;
            }
            self.twoLB.frame = CGRectMake(self.oneLB.frame. origin.x + self.oneLB.frame.size.width + 20, 0, self.w2, 17);
            self.twoLB.text = str;
        }
    }
    [self start];
}

- (void)start
{
//    if (self.dataAry.count < 2) {
//        NSLog(@"没超跑");
//        return;
//    }
    if (_timer ) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.stopTime target:self selector:@selector(paoma:) userInfo:nil repeats:NO];
    
}

- (void)again
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self start];
}

- (NSMutableArray *)dataAry
{
    if (!_dataAry) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}

-(void)paoma:(NSTimer *)timer
{
 //   NSLog(@"timer 线程%@",[NSThread currentThread]);
   
    if(self.dataAry.count == 0){
        return;
    }
    if (self.dataAry.count == 1) {
        
        [self.dataAry addObject:self.dataAry[0]];
        NSLog(@"凑够222222 跑起来 %@",self.dataAry);
    }
    
    __weak typeof(self) weakSelf = self;
    
    NSLog(@"移动开始数组 %@",self.dataAry);
    NSString *oneStr = @"";
    NSString *twoStr = @"";
    for (int i = 0; i < self.dataAry.count; i++) {
        NSString *str = self.dataAry[i];
        if (i == 0) {
            oneStr = str;
            self.w1 =  [self getFontSizeOfWidth:str fontHeigt:17];//[self widthForTextString:str height:20 fontSize:17] +10;
            
            if (self.w1 < self.frame.size.width) {
                self.w1 = self.frame.size.width;
            }
        }
        if (i == 1) {
            twoStr = str;

            self. w2 =  [self getFontSizeOfWidth:str fontHeigt:17] ;
            if (self.w2 < self.frame.size.width) {
                self.w2 = self.frame.size.width;
            }

        }
    }
    
    CGFloat allWidth = self.frame.size.width;
    
    if (self.oneLB.frame.origin.x > self.frame.size.width) {
        allWidth = self.w2;
    }else
    {
        allWidth = self.w1;
    }
    NSLog(@"跑道宽 %f",allWidth);
    [UIView animateWithDuration:allWidth / self.speed delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        if (weakSelf.oneLB.frame.origin.x == 0) {
            weakSelf.oneLB.frame = CGRectMake(-self.w1, 0,self. w1, 17);
            weakSelf.twoLB.frame = CGRectMake(0, 0, self.w2, 17);
        }
        else
        {
            weakSelf.oneLB.frame = CGRectMake(0, 0,self. w1, 17);
            weakSelf.twoLB.frame = CGRectMake(-self.w2, 0, self.w2, 17);
        }

    } completion:^(BOOL finished) {
        NSLog(@"移动结束w1 = %f w2 = %f",self.w1,self.w2);
        
        if (weakSelf.oneLB.frame.origin.x < 0) {
            weakSelf.oneLB.frame = CGRectMake(self.w2 + 20, 0,self.w1, 17);
            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(reloadAlwayShowPaomaView:dataAry:)])
            {
                [weakSelf.delegate reloadAlwayShowPaomaView:weakSelf.oneLB dataAry:weakSelf.dataAry];
            }
        }
        else
        {
            weakSelf.twoLB.frame = CGRectMake(self.w1 + 20, 0, self.w2, 17);
            if(weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(reloadPaomaView:dataAry:)])
            {
                [weakSelf.delegate reloadPaomaView:weakSelf.twoLB dataAry:weakSelf.dataAry];
            }
        }

        if (weakSelf.timer) {
            [weakSelf again];
        }
    }];
    
    
}


- (CGFloat)getFontSizeOfWidth:(NSString *)str fontHeigt:(CGFloat)fontHeight
{
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontHeight]}];
    CGFloat width = size.width + 10;
    
    return width;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
