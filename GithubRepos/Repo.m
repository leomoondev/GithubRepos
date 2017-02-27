//
//  Repo.m
//  GithubRepos
//
//  Created by Hyung Jip Moon on 2017-02-27.
//  Copyright © 2017 leomoon. All rights reserved.
//

#import "Repo.h"

@implementation Repo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.repo = [NSDictionary dictionary];

    }
    return self;
}
@end
