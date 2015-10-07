//
//  ORSStockPriceFetcher.h
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ORSStock;

@interface ORSStockPriceFetcher : NSObject

- (instancetype)initWithStock:(ORSStock *)stock;

@property (nonatomic, strong, readonly) ORSStock *stock;

@end
