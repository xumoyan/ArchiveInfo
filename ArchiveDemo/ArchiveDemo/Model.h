//
//  Model.h
//  ArchiveDemo
//
//  Created by 张冠清 on 16/6/15.
//  Copyright © 2016年 张冠清. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Model : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ads;

@property (assign, nonatomic) int age;
@property (assign, nonatomic) float weight;
@property (assign, nonatomic) id value;
@property (strong, nonatomic) NSMutableArray *mutableArray;
@property (strong, nonatomic) NSDictionary *dict;



@end
