//
//  ZYRequest.m
//  网络请求框架
//
//  Created by 王志盼 on 2017/12/21.
//  Copyright © 2017年 王志盼. All rights reserved.
//

#import "ZYRequest.h"

@interface ZYRequest()
@property (nonatomic, assign, readwrite) int retryCount;
@end

@implementation ZYRequest

- (instancetype)init
{
    if (self = [super init])
    {
        self.retryCount = 3;
    }
    return self;
}

- (void)setType:(enum ZYRequestReliability)type
{
    _type = type;
    
    if (type == ZYRequestReliabilityNormal)
    {
        _retryCount = 1;
    }
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.requestId forKey:@"requestId"];
    [aCoder encodeObject:self.urlStr forKey:@"urlStr"];
    [aCoder encodeInt:self.type forKey:@"type"];
    [aCoder encodeInt:self.retryCount forKey:@"retryCount"];
    [aCoder encodeObject:self.cacheKey forKey:@"cacheKey"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.params options:NSJSONWritingPrettyPrinted error:nil];
    NSString *ParamsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [aCoder encodeObject:ParamsStr forKey:@"params"];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.requestId = [aDecoder decodeObjectForKey:@"requestId"];
        self.urlStr = [aDecoder decodeObjectForKey:@"urlStr"];
        self.type = [aDecoder decodeIntForKey:@"type"];
        self.retryCount = [aDecoder decodeIntForKey:@"retryCount"];
        self.cacheKey = [aDecoder decodeObjectForKey:@"cacheKey"];
        
        NSString *paramStr = [aDecoder decodeObjectForKey:@"params"];
        NSData *data = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
        self.params = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }
    return self;
}
@end
