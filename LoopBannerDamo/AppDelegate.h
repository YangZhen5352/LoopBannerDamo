//
//  AppDelegate.h
//  LoopBannerDamo
//
//  Created by edz on 2017/4/24.
//  Copyright © 2017年 edz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

