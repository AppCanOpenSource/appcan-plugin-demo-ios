/**
 *
 *	@file   	: EUExDemoPlugin.m  in EUExDemoPlugin
 *
 *	@author 	: CeriNo
 *
 *	@date   	: Created on 16/3/25.
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

#import "EUExDemoPlugin.h"
#import "uexDemoPluginViewController.h"
@interface EUExDemoPlugin()<AppCanApplicationEventObserver>
@property (nonatomic,strong)UIView *aView;
@property (nonatomic,strong)uexDemoPluginViewController *aViewController;
@end

@implementation EUExDemoPlugin



#pragma mark - Global Event

static NSDictionary *AppLaunchOptions;

+ (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    ACLogDebug(@"app launched");
    //存储launchOptions
    AppLaunchOptions = launchOptions;
    return YES;
}

//第一个网页(root页面)加载完成时会触发此事件
//部分事件(比如application:didFinishLaunchingWithOptions:)触发时，第一个网页可能还没加载完成，因此无法当时回调给网页
//这些回调应该延迟至这个事件触发时再回调给root页面
+ (void)rootPageDidFinishLoading{
    
    //执行root页面的uexDemoPlugin.onAppLaunched方法 参数为AppLaunchOptions转换而成的JSON字符串
    [AppCanRootWebViewEngine() callbackWithFunctionKeyPath:@"uexDemoPlugin.onAppLaunched" arguments:ACArgsPack([AppLaunchOptions ac_JSONFragment])];
    AppLaunchOptions = nil;
    
}


#pragma mark - Life Cycle

- (instancetype)initWithWebViewEngine:(id<AppCanWebViewEngineObject>)engine{
    self = [super initWithWebViewEngine:engine];
    if (self) {
        ACLogDebug(@"插件实例被创建");
    }
    return self;
}


- (void)clean{
    [self dismissViewController];
    ACLogDebug(@"网页即将被销毁");
}



#pragma mark - JavaScript API

- (void)helloWorld:(NSMutableArray *)inArguments{
    //打印 hello world!
    ACLogInfo(@"hello world!");
}

- (void)sendValue:(NSMutableArray *)inArguments{
    //打印传入的参数个数
    ACLogDebug(@"arguments count : %@",@(inArguments.count));
    //打印每个参数的描述，和参数所在的类的描述
    for (NSInteger i = 0; i < inArguments.count; i++) {
        id obj = inArguments[i];
        ACLogDebug(@"value : %@ , class : %@ ",[obj description],[[obj class] description]);
    }
}

- (void)sendJSONValue:(NSMutableArray *)inArguments{
    if([inArguments count] < 1){
        //当传入的参数为空时，直接返回，避免数组越界错误。
        return;
    }

    id json = [inArguments[0] ac_JSONValue];
    ACLogDebug(@"json : %@ class : %@",[json description],[[json class] description]);
}

- (void)sendArguments:(NSMutableArray *)inArguments{
    ACArgsUnpack(NSString *arg1,NSNumber *arg2,NSArray *arg3,NSDictionary *arg4) = inArguments;
    
    for(id arg in @[arg1,arg2,arg3,arg4]){
        ACLogDebug(@"value : %@ , class : %@ ",[arg description],[[arg class] description]);
    }
}







- (void)doCallback:(NSMutableArray *)inArguments{
    NSDictionary *dict = @{
                           @"key":@"value"
                           };
    [self.webViewEngine callbackWithFunctionKeyPath:@"uexDemoPlugin.cbDoCallback"
                                          arguments:ACArgsPack(dict.ac_JSONFragment)
                                         completion:^(JSValue * _Nullable returnValue) {
                                             if (returnValue) {
                                                 ACLogDebug(@"回调成功!");
                                             }
                                         }];
}


- (NSDictionary *)doSyncCallback:(NSMutableArray *)inArguments{

    return @{
             @"key1":@"value1",
             @"key2":@(NO),
             @"key3":@{
                     @"subKey":@"subValue"
                     }
             };

}


- (void)doFunctionCallback:(NSMutableArray *)inArguments{
    ACArgsUnpack(ACJSFunctionRef *callback) = inArguments;
    [callback executeWithArguments:nil completionHandler:^(JSValue * _Nullable returnValue) {
         ACLogDebug(@"回调成功!");
    }];
}


- (void)addView:(NSMutableArray *)inArguments{
    if (self.aView) {
        //如果已经添加了view 直接返回
        return;
    }
    ACArgsUnpack(NSDictionary *info) = inArguments;
    NSNumber *isScrollableNum = numberArg(info[@"isScrollable"]);
    if (!isScrollableNum) {
        //如果参数信息不包含isScrollable这个键 直接返回
        return;
    }

    BOOL isScroll = [isScrollableNum boolValue];
    //新建一个view，并将其背景设置为红色
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 400, 300, 200)];
    view.backgroundColor = [UIColor redColor];
    if (isScroll) {
        [[self.webViewEngine webScrollView] addSubview:view];
    }else{
        [[self.webViewEngine webView] addSubview:view];
    }
    //插件对象持有此view,方便对其进行移除操作
    self.aView = view;
}

- (void)removeView:(NSMutableArray *)inArguments{
    [self.aView removeFromSuperview];
    self.aView = nil;
}

- (void)presentController:(NSMutableArray *)inArguments{
    if (self.aViewController) {
        return;
    }
    uexDemoPluginViewController *controller = [[uexDemoPluginViewController alloc]initWithEUExObj:self];
    [[self.webViewEngine viewController]presentViewController:controller animated:YES completion:nil];
    self.aViewController = controller;
}


#pragma mark - Public Method


- (void)dismissViewController{
    [self.aViewController dismissViewControllerAnimated:YES completion:^{
        [self.webViewEngine callbackWithFunctionKeyPath:@"uexDemoPlugin.onControllerClose" arguments:nil];
        self.aViewController = nil;
    }];
}

@end
