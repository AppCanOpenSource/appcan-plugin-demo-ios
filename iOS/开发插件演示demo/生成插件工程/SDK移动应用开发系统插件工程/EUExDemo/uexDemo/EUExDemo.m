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

-(void)open:(NSMutableArray *)array{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    [view setBackgroundColor:[UIColor brownColor]];
    [EUtility brwView:meBrwView addSubview:view];
    [view release];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 100, 200)];
    
}

@end
