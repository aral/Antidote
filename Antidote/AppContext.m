//
//  AppContext.m
//  Antidote
//
//  Created by Dmytro Vorobiov on 19.05.15.
//  Copyright (c) 2015 dvor. All rights reserved.
//

#import "AppContext.h"
#import "AppearanceManager.h"
#import "AvatarsManager.h"
#import "ErrorHandler.h"
#import "UserDefaultsManager.h"
#import "AppDelegate.h"
#import "Helper.h"
#import "FriendsViewController.h"

@interface AppContext ()

@property (strong, nonatomic, readwrite) AppearanceManager *appearance;
@property (strong, nonatomic, readwrite) AvatarsManager *avatars;
@property (strong, nonatomic, readwrite) ErrorHandler *errorHandler;
@property (strong, nonatomic, readwrite) UserDefaultsManager *userDefaults;

@end

@implementation AppContext

#pragma mark -  Lifecycle

- (id)init
{
    return nil;
}

- (id)initPrivate
{
    self = [super init];

    if (! self) {
        return nil;
    }

    return self;
}

+ (instancetype)sharedContext
{
    static AppContext *instance;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        instance = [[AppContext alloc] initPrivate];
    });

    return instance;
}

#pragma mark -  Properties

- (AppearanceManager *)appearance
{
    if (_appearance) {
        return _appearance;
    }

    AppearanceManagerColorscheme colorscheme = self.userDefaults.uCurrentColorscheme.unsignedIntegerValue;
    _appearance = [[AppearanceManager alloc] initWithColorscheme:colorscheme];

    return _appearance;
}

- (AvatarsManager *)avatars
{
    if (_avatars) {
        return _avatars;
    }

    _avatars = [AvatarsManager new];

    return _avatars;
}

- (ErrorHandler *)errorHandler
{
    if (_errorHandler) {
        return _errorHandler;
    }

    _errorHandler = [ErrorHandler new];

    return _errorHandler;
}

- (UserDefaultsManager *)userDefaults
{
    if (_userDefaults) {
        return _userDefaults;
    }

    _userDefaults = [UserDefaultsManager new];
    [self createUserDefaultsValuesAndRewrite:NO];

    return _userDefaults;
}

#pragma mark -  Public

- (void)restoreDefaultSettings
{
    [self createUserDefaultsValuesAndRewrite:YES];

    // FIXME
    // self.profileManager = nil;

    [self recreateAppearance];
    [self recreateTabBarController];
}

- (void)recreateAppearance
{
    self.appearance = nil;
    self.avatars = nil;

    // FIXME
    //    [self.notification resetAppearance];
    // [self.profileManager updateInterface];
}

- (void)recreateTabBarController
{
    // FIXME
    // self.tabBarController = nil;

    // RBQFetchedResultsController *chats = [Helper createFetchedResultsControllerForType:OCTFetchRequestTypeChat delegate:nil];
    // RBQFetchedResultsController *friends = [Helper createFetchedResultsControllerForType:OCTFetchRequestTypeFriend delegate:nil];
    // RBQFetchedResultsController *friendRequests = [Helper createFetchedResultsControllerForType:OCTFetchRequestTypeFriendRequest delegate:nil];

    // if ([chats numberOfRowsForSectionIndex:0]) {
    //     self.tabBarController.selectedIndex = TabBarViewControllerIndexChats;
    // }
    // else if ([friends numberOfRowsForSectionIndex:0] ||
    //          [friendRequests numberOfRowsForSectionIndex:0]) {
    //     self.tabBarController.selectedIndex = TabBarViewControllerIndexFriends;
    // }
    // else {
    //     self.tabBarController.selectedIndex = TabBarViewControllerIndexProfile;
    // }

    // AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // delegate.window.rootViewController = self.tabBarController;
    // [self.profileManager updateInterface];
}

#pragma mark -  Private

- (void)createUserDefaultsValuesAndRewrite:(BOOL)rewrite
{
    if (rewrite || ! _userDefaults.uShowMessageInLocalNotification) {
        _userDefaults.uShowMessageInLocalNotification = @(YES);
    }

    if (rewrite || ! _userDefaults.uIpv6Enabled) {
        _userDefaults.uIpv6Enabled = @(1);
    }

    if (rewrite || ! _userDefaults.uUDPEnabled) {
        _userDefaults.uUDPEnabled = @(1);
    }

    if (rewrite || ! _userDefaults.uCurrentColorscheme) {
        _userDefaults.uCurrentColorscheme = @(AppearanceManagerColorschemeIce);
    }
}

@end
