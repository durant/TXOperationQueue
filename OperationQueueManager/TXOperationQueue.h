//
//  TXOperationQueue.h
//  OperationQueueManager
//
//  Created by kevin on 2017/5/8.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXOperationQueue : NSObject

@property (readonly) NSUInteger operationCount ;

@property (assign)  NSInteger maxConcurrentOperationCount;

- (TXOperationQueue *)initWithCompletionBlock:(void(^)(BOOL))completionBlock;

- (void)addOperation:(NSOperation *)operation;

- (void)setOperationQueueCompletionBlock:(void(^)(BOOL))completionBlock;

@end
