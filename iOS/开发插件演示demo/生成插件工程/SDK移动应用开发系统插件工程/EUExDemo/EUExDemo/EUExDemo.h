//
//  EUExDemo.h
//  EUExDemo
//
//  Created by hui.li on 13-4-11.
//  Copyright (c) 2013年 hui.li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EUExBase.h"

//所有的插件都必须要继承EUExBase这个类否则肯定是无法被调用的
@interface EUExDemo : EUExBase{
    UIView      *view;
}
@property (nonatomic,retain) UIView     *view;
@end
