//
//  ViewController.m
//  ArchiveDemo
//
//  Created by 张冠清 on 16/6/16.
//  Copyright © 2016年 张冠清. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //=======================Model========================
    Model *model = [[Model alloc] init];
    model.name = @"zhangsan";
    model.age = 100;
    model.weight = 100.99;
    model.value = @10;
    model.mutableArray = [[NSMutableArray alloc] initWithObjects:@"zhangsan", @"lisi", @"wangwu", nil];
    model.dict = @{ @"name": @"zhaolasdasdsadiu" };
    [ArchiveData saveValue:model WithKey:@"model"];

    Model *archiveModel = [ArchiveData takeModelValueWithKey:@"model" WithClass:@"Model"];
    NSLog(@"%@,%d,%f,%@,%@,%@", archiveModel.name, archiveModel.age, archiveModel.weight, archiveModel.value,
          archiveModel.mutableArray, archiveModel.dict);

    //=======================Dict========================
    NSDictionary *dict = @{ @"zhangsan": @"lisi" };
    [ArchiveData saveValue:dict WithKey:@"dict"];
    NSDictionary *archiveDict = [ArchiveData takeValueWithKey:@"dict"];
    NSLog(@"archiveDict=%@", archiveDict);

    //=======================String========================
    NSString *string = @"password";
    [ArchiveData saveValue:string WithKey:@"string"];
    NSString *archiveString = [ArchiveData takeValueWithKey:@"string"];
    NSLog(@"archiveString=%@", archiveString);

    //=======================Number========================
    NSNumber *number = @100;
    [ArchiveData saveValue:number WithKey:@"number"];
    NSNumber *archiveNumber = [ArchiveData takeValueWithKey:@"number"];
    NSLog(@"archiveNumber=%@", archiveNumber);
}

@end
