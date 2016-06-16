//
//  ArchiveData.h
//  ArchiveTestDemo
//
//  Created by 张冠清 on 16/6/16.
//  Copyright © 2016年 张冠清. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface ArchiveData : NSObject
/*!
 *  @brief 对传入的数据进行归档
 *  @param value 归档的对象
 *  @param key 归档键值
 */
+ (void)saveValue:(id)value WithKey:(NSString *)key;
/*!
 *  @brief 通过键值解档(基本数据类型)
 *  @param key 键值
 *  @return 返回一个id类型
 */
+ (id)takeValueWithKey:(NSString *)key;
/*!
 *  @brief 对Model类进行解档
 *  @param key 键值
 *  @param cls Model类Name
 *  @return model对象
 */
+ (id)takeModelValueWithKey:(NSString *)key WithClass:(NSString *)cls;
@end
