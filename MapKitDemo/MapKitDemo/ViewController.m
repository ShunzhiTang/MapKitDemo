//
//  ViewController.m
//  MapKitDemo
//
//  Created by Tsz on 15/11/4.
//  Copyright © 2015年 Tsz. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic ,strong)CLLocationManager *manager;
@end

@implementation ViewController

#pragma mark 懒加载
- (CLLocationManager *)manager{
    if (_manager == nil) {
        _manager = [[CLLocationManager alloc]init];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   //1、获得用户的授权 ，总是 允许
    [self.manager requestAlwaysAuthorization];
    
    //2、定位
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    /*
     MKMapTypeStandard = 0,//标准`
     MKMapTypeSatellite,//卫星
     MKMapTypeHybrid//混合
     */
    //3、设置地图的类型
    self.mapView.mapType = MKMapTypeStandard;
    
    
    
}



@end
