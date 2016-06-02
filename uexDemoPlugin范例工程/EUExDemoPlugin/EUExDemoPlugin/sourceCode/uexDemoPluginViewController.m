/**
 *
 *	@file   	: uexDemoPluginViewController.m  in EUExDemoPlugin
 *
 *	@author 	: CeriNo 
 * 
 *	@date   	: Created on 16/3/26.
 *
 *	@copyright 	: 2016 The AppCan Open Source Project.
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Lesser General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Lesser General Public License for more details.
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#import "uexDemoPluginViewController.h"
#import "EUExDemoPlugin.h"
#import <Masonry/Masonry.h>
#import "SVProgressHUD.h"
@interface uexDemoPluginViewController()
@property (nonatomic,weak)EUExDemoPlugin *euexObj;
@end



@implementation uexDemoPluginViewController


- (instancetype)initWithEUExObj:(EUExDemoPlugin *)euexObj{
    self = [super init];
    if (self) {
        _euexObj = euexObj;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, 100, 180, 60);
    [button setTitle:@"关闭ViewController" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onCloseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //.a测试采用libSVProgressHUD.a     .bundle测试用它的资源包SVProgressHUD.bundle
    UIButton *libraryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    libraryBtn.frame = CGRectMake(50, 200, 280, 60);
    [libraryBtn setTitle:@"library第三方库和第三方bundle测试" forState:UIControlStateNormal];
    [libraryBtn addTarget:self action:@selector(onLibraryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:libraryBtn];
    
    //.framework测试用autoLayout库Masonry.framework
    UILabel *masonryLabel = [[UILabel alloc]init];
    masonryLabel.text = @"用Masonry.framework布局的UILabel,永远在屏幕正中间";
    masonryLabel.numberOfLines = 0;
    [self.view addSubview:masonryLabel];
    __weak typeof(self) ws = self;
    [masonryLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@200);
        make.center.equalTo(ws.view);
    }];
    
    //获取插件的bundle实例
    //NSBundle *pluginBundle = [EUtility bundleForPlugin:@"uexDemoPlugin"];
    NSBundle *pluginBundle = nil;
    //从bundle中读取资源图片文件的示例
    //直接用[pluginBundle pathForResource:@"sun" ofType:@"png"];只能匹配"sun.png"这个文件的路径，找不到会返回nil,而不会寻找文件"sun@2x.png"和"sun@3x.png".
    NSString *path = [[pluginBundle resourcePath] stringByAppendingPathComponent:@"sun.png"];
    UIImage *image = [UIImage imageWithContentsOfFile:path];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.backgroundColor = [UIColor grayColor];
    imageView.center = CGPointMake(100, 600);
    [self.view addSubview:imageView];
    
    //国际化字符串的示例
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 60)];
    //label.text = [EUtility uexPlugin:@"uexDemoPlugin" localizedString:@"title"];
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:18];
    label.center = CGPointMake(250, 600);
    [self.view addSubview:label];
    
}




- (void)onCloseButtonClick:(id)sender{
    [self.euexObj dismissViewController];
}

- (void)onLibraryButtonClick:(id)sender{
    [SVProgressHUD showErrorWithStatus:@"SVProgressHUD测试,上方的X引用自SVProgress的bundle"];

}

@end