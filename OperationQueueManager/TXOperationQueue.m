//
//  TXOperationQueue.m
//  OperationQueueManager
//
//  Created by kevin on 2017/5/8.
//  Copyright © 2017年 tencent. All rights reserved.
//

#import "TXOperationQueue.h"

@interface TXOperationQueue ()

@property (strong) NSOperationQueue *operationQueue;

@property (copy) void(^queueCompletionBlock)(BOOL);

@end

@implementation TXOperationQueue

- (id)init
{
    self = [super init];
    if (self)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        
        [_operationQueue addObserver:self forKeyPath:@"operationCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}

- (TXOperationQueue *)initWithCompletionBlock:(void(^)(BOOL))completionBlock
{
    TXOperationQueue *queue =[[[self class] alloc] init];
    
    queue.queueCompletionBlock = completionBlock;
    
    return queue;
}

- (void)addOperation:(NSOperation *)operation
{
    [self.operationQueue addOperation:operation];
}

- (NSUInteger)operationCount
{
    return self.operationQueue.operationCount;
}

- (void)setMaxConcurrentOperationCount:(NSInteger)maxConcurrentOperationCount
{
    self.operationQueue.maxConcurrentOperationCount = maxConcurrentOperationCount;
}

- (NSInteger)maxConcurrentOperationCount
{
    return self.operationQueue.maxConcurrentOperationCount;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    
    if (object == self.operationQueue && [keyPath isEqualToString:@"operationCount"])
    {
        if (self.operationQueue.operationCount == 0)
        {
            if (self.queueCompletionBlock)
            {
                self.queueCompletionBlock(false);
            }
        }
    }
    else
    {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)setOperationQueueCompletionBlock:(void(^)(BOOL))completionBlock
{
    self.queueCompletionBlock = completionBlock;
}

@end
