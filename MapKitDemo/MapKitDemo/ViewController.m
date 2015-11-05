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
@interface ViewController () <MKMapViewDelegate>
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
    
    //4、 遵守协议
    self.mapView.delegate = self;
}

#pragma mark: 实现 MKMapViewDelegate 
/**
 *  更新到当前用户的位置就会调用
 *
 *  @param mapView      mapView
 *  @param userLocation 用户位置
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //1、 MKUserLocation  遵守大头针的协议 决定了蓝色大头针视图显示的内容
    
    userLocation.title = @"北京";
    userLocation.subtitle = @"首都啊 ";
    
    /*
     中国中心点的纬度是（3 + 53）/ 2 = 北纬28度
     中国中心点的经度是（73 + 135）/ 2 = 东经104度
     中国纬度跨度是53 - 3 = 50度
     中国经度跨度是135 - 73 = 62度
     */
    
    /*
    //1、计算跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(50,62);
    
    //2、 设置 中心点的经纬度
   CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28,104);
    //3、表示 一块区域  ，以coordinate 为中心， span 为跨度
    MKCoordinateRegion regoin = MKCoordinateRegionMake(coordinate, span);
  [self.mapView setRegion:regoin animated:YES];
    
    //结果是显示 一个 中国的地图
     */
}

#pragma mark 改变跨度显示
- (IBAction)changeSpan:(id)sender {
    
    //1、设置跨度
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 60);
    
    //2、设置跨度的区域 ，以当前位置为中心点
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(28,104);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    
    [self.mapView setRegion:region animated:YES];
}

/**
 *  区域发生改变的时候就会调用
 *   应用场景:  加载当前屏幕范围内最新的数据
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    NSLog(@"regionDidChangeAnimated");
    NSLog(@"%f   %f ",self.mapView.region.span.latitudeDelta,self.mapView.region.span.longitudeDelta);
}

/**
 *点击位置大头针的时间调用
 */
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    NSLog(@"%s",__func__);
}
/**
 * 地图下载完毕调用
 */

-(void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
     NSLog(@"%s",__func__);
}

@end
