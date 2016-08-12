//
//  LoCoWiFi.m
//  ONELoCo
//
//  Created by NonMac on 16/8/12.
//
//

#import "LoCoWiFi.h"

#import <ifaddrs.h>
#import <net/if.h>
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation LoCoWiFi

+ (void)ONELoCo_settingWiFi {
    
}

+ (void)ONELoCo_judgeTheWiFiIsOpen {
    
}

+ (void)ONELoCo_FetchSSID {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if (info && [info count]) { break; }
    }
//    self.wifiName = info[@"BSSID"];
//    return info;
}

- (BOOL) isWiFiEnabled {
    
    NSCountedSet * cset = [NSCountedSet new];
    
    struct ifaddrs *interfaces;
    
    if( ! getifaddrs(&interfaces) ) {
        for( struct ifaddrs *interface = interfaces; interface; interface = interface->ifa_next) {
            if ( (interface->ifa_flags & IFF_UP) == IFF_UP ) {
                [cset addObject:[NSString stringWithUTF8String:interface->ifa_name]];
            }
        }
    }
    
    return [cset countForObject:@"awdl0"] > 1 ? YES : NO;
}


@end
