//
//  uexDynamicDemo.m
//  uexDynamicDemo
//
//  Created by zhijian du on 14-4-18.
//  Copyright (c) 2014年 demo. All rights reserved.
//

#import "uexDynamicDemo.h"
#import "EUtility.h"
@implementation uexDynamicDemo
-(id)initWithBrwView:(EBrowserView *) eInBrwView {
    if (self = [super initWithBrwView:eInBrwView]) {
    }
    return self;
}
-(void)open:(NSMutableArray *)inArguments
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    
    [EUtility brwView:self.meBrwView addSubview:view];
    
    
}

@end
