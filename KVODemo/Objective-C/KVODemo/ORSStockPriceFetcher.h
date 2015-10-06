//
//  ORSStockPriceFetcher.h
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ORSStockPriceFetcher : NSObject

- (void)fetchPriceOf:(NSString *)stockName completion:(void(^)(float price))completionBlock;

@end
