//
//  ORSStockPriceFetcher.m
//  KVODemo
//
//  Created by Andrew Madsen on 10/6/15.
//  Copyright © 2015 Open Reel Software. All rights reserved.
//

#import "ORSStockPriceFetcher.h"

@implementation ORSStockPriceFetcher

- (void)fetchPriceOf:(NSString *)stockName completion:(void(^)(float))completionBlock
{
	completionBlock = completionBlock ?: ^(float f){};
	NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.google.com/finance/info?q=%@", stockName]];
	NSURLRequest *request = [NSURLRequest requestWithURL:url];
	[[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		if (error) {
			NSLog(@"Error fetching price of %@: %@", stockName, error);
			completionBlock(-1.0);
			return;
		}
		
		NSError *localError = nil;
		NSDictionary *priceInfo = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
		if (!priceInfo) {
			NSLog(@"Error parsing stock price info for %@: %@", stockName, error);
			completionBlock(-1.0);
			return;
		}
		
		NSLog(@"price info: %@", stockName);
		completionBlock(0);
	}] resume];
}

@end
