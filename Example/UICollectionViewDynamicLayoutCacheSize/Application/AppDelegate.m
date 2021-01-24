//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "AppDelegate.h"
#import "BMCollectionViewVC.h"
#import "UICollectionViewDynamicLayoutCacheSize.h"

#import <objc/runtime.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    [UICollectionViewDynamicLayoutCacheSize setDebugLog:YES];
    
    BMCollectionViewVC *vc = BMCollectionViewVC.new;
    vc.histroyArray = [self.class test_histroyArray].mutableCopy;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBar.translucent  = NO;
    nav.navigationBar.hidden       = NO;
    self.window.rootViewController = nav;
    return YES;
}

+ (NSString *)test_arcString {
    int arc2 = arc4random_uniform(5)+3;
    NSMutableString *str = @"".mutableCopy;
    while (arc2--) {
        [str appendString:@"好"];
    }
    if (arc4random_uniform(8) == 0) {
        int arc3 = arc4random_uniform(5)+1;;
        while (arc3--) {
            [str appendString:@"好好好好好好好好好好好好好好好好好好"];
        }
    }
    return str.copy;
}

+ (NSMutableArray <NSString *> *)test_arcArray {
    NSMutableArray *arr = @[].mutableCopy;
    int arc1 = arc4random_uniform(20)+10;
    while (arc1--) {
        [arr addObject:[self test_arcString]];
    }
    return arr;
}

+ (NSMutableArray <NSMutableArray <NSString *> *> *)test_histroyArray {
    int arc = arc4random_uniform(30)+12;
    NSMutableArray *histroyArray = @[].mutableCopy;
    while (arc--) {
        [histroyArray addObject:[self test_arcArray]];
    }
    return histroyArray.mutableCopy;
}

@end
