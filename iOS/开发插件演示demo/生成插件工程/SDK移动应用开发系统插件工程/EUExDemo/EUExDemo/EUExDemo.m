//
//  EUExDemo.m
//  EUExDemo
//
//  Created by hui.li on 13-4-11.
//  Copyright (c) 2013年 hui.li. All rights reserved.
//

#import "EUExDemo.h"
#import "EUtility.h"

@implementation EUExDemo

@synthesize view;

-(id)initWithBrwView:(EBrowserView *)eInBrwView{
    self = [super initWithBrwView:eInBrwView];
    if (self) {
    }
    return self;
}

-(void)open:(NSMutableArray *)array{
    if ([array isKindOfClass:[NSMutableArray class]] && [array count]>0) {
        CGFloat x = [[array objectAtIndex:0] floatValue];
        CGFloat y = [[array objectAtIndex:1] floatValue];
        CGFloat w = [[array objectAtIndex:2] floatValue];
        CGFloat h = [[array objectAtIndex:3] floatValue];
        if (!view) {
            view = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
            [view setBackgroundColor:[UIColor whiteColor]];
            [EUtility brwView:meBrwView addSubview:view];
        }
        
        //读取本插件的资源文件
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 140, 50)];
            [label setFont:[UIFont systemFontOfSize:15]];
            [label setBackgroundColor:[UIColor redColor]];
            [label setText:@"本地插件资源文件："];
            [view addSubview:label];
            [label release];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 50, 100, 100)];
            NSString *path = [[NSBundle mainBundle] pathForResource:@"uexDemo/plugin_uexDemo_BG" ofType:@"png"];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [imageView setImage:image];
            [view addSubview:imageView];
            [imageView release];
        }
        
        //读取协议路径资源文件 例如res://
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 140, 50)];
            [label setText:@"协议路径资源文件："];
            [label setFont:[UIFont systemFontOfSize:15]];
            [label setBackgroundColor:[UIColor redColor]];
            [view addSubview:label];
            [label release];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 200, 100, 100)];
            NSString *path = @"res://plugin_uexDemo_RES.png";
            path = [EUtility getAbsPath:self.meBrwView path:path];
            UIImage *image = [UIImage imageWithContentsOfFile:path];
            [imageView setImage:image];
            [view addSubview:imageView];
            [imageView release];
        }
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(110, 350, 100, 50)];
        [btn setBackgroundColor:[UIColor redColor]];
        [btn setTitle:@"回掉测试" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(uexDemoBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
        [btn release];
    }
}

//回调函数
-(void)uexDemoBtnClicked:(UIButton *)btn{
    [self.meBrwView stringByEvaluatingJavaScriptFromString:@"uexDemo.CallBack();"];
}

-(void)close:(NSMutableArray *)array{
    if (view) {
        [view removeFromSuperview];
        if (self.view) {
            self.view = nil;
        }
    }
}

//当前窗口调用uexWindow.close()接口的时候 插件的clean方法会被调用
-(void)clean{
    
}

@end
