//
//  ArchiveData.m
//  ArchiveTestDemo
//
//  Created by 张冠清 on 16/6/16.
//  Copyright © 2016年 张冠清. All rights reserved.
//

#import "ArchiveData.h"
#import "YYModel.h"
@implementation ArchiveData
+ (void)saveValue:(id)value WithKey:(NSString *)key {
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *createPath = [NSString stringWithFormat:@"%@/ArchiveData", pathDocuments];
    NSString *archivePath = [createPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", key]];
    if (![[NSFileManager defaultManager] fileExistsAtPath:createPath]) {
        [fileManager createDirectoryAtPath:createPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archvier = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];

    if ([[value superclass] isEqual:[NSObject class]]) {
        NSDictionary *dict = [self getObjectData:value];
        [archvier encodeObject:dict forKey:key];
        [archvier finishEncoding];
        [data writeToFile:archivePath atomically:YES];
    } else {
        [archvier encodeObject:value forKey:key];
        [archvier finishEncoding];
        [data writeToFile:archivePath atomically:YES];
    }
}
+ (id)takeModelValueWithKey:(NSString *)key WithClass:(NSString *)cls;
{
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *savePath = [NSString stringWithFormat:@"%@/ArchiveData", pathDocuments];
    NSString *archivePath = [savePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", key]];
    NSMutableData *archiveData = [[NSMutableData alloc] initWithContentsOfFile:archivePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archiveData];
    NSDictionary *value = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    const char *className = [cls cStringUsingEncoding:NSASCIIStringEncoding];
    Class classObjc = objc_getClass(className);
    return [classObjc yy_modelWithDictionary:value];
}
+ (id)takeValueWithKey:(NSString *)key {
    NSString *pathDocuments = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *savePath = [NSString stringWithFormat:@"%@/ArchiveData", pathDocuments];
    NSString *archivePath = [savePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.archiver", key]];
    NSMutableData *archiveData = [[NSMutableData alloc] initWithContentsOfFile:archivePath];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archiveData];
    id value = [unarchiver decodeObjectForKey:key];
    [unarchiver finishDecoding];
    return value;
}
+ (NSDictionary *)getObjectData:(id)obj {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    unsigned int propsCount;
    objc_property_t *props = class_copyPropertyList([obj class], &propsCount);
    for (int i = 0; i < propsCount; i++) {
        objc_property_t prop = props[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(prop)];
        id value = [obj valueForKey:propName];
        if (value == nil) {
            value = [NSNull null];
        } else {
            value = [self getObjectInternal:value];
        }
        [dict setObject:value forKey:propName];
    }
    return dict;
}
+ (id)getObjectInternal:(id)obj {
    if ([obj isKindOfClass:[NSString class]] || [obj isKindOfClass:[NSNumber class]] || [obj isKindOfClass:[NSNull class]]) {
        return obj;
    }
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *objarr = obj;
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:objarr.count];
        for (int i = 0; i < objarr.count; i++) {
            [arr setObject:[self getObjectInternal:[objarr objectAtIndex:i]] atIndexedSubscript:i];
        }
        return arr;
    }
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *objdic = obj;
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:[objdic count]];
        for (NSString *key in objdic.allKeys) {
            [dic setObject:[self getObjectInternal:[objdic objectForKey:key]] forKey:key];
        }
        return dic;
    }
    return [self getObjectData:obj];
}
@end
