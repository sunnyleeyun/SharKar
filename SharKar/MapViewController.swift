//
//  MapViewController.swift
//  SharKar
//
//  Created by Mac on 2017/7/27.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    
    var myLocationManager :CLLocationManager!
    var myMapView :MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        
        // 設置委任對象
        myLocationManager.delegate = self
        
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        myLocationManager.distanceFilter =
        kCLLocationAccuracyNearestTenMeters
        
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy =
        kCLLocationAccuracyBest

        
        
        // 取得螢幕的尺寸
        let fullSize = UIScreen.mainScreen.bounds.size
        
        // 建立一個 MKMapView
        myMapView = MKMapView(frame: CGRect(
            x: 0, y: 20,
            width: fullSize.width,
            height: fullSize.height - 20))
        
        // 設置委任對象
        myMapView.delegate = self as! MKMapViewDelegate
        
        // 地圖樣式
        myMapView.mapType = .standard
        
        // 顯示自身定位位置
        myMapView.showsUserLocation = true
        
        // 允許縮放地圖
        myMapView.isZoomEnabled = true
        
        // 地圖預設顯示的範圍大小 (數字越小越精確)
        let latDelta = 0.05
        let longDelta = 0.05
        let currentLocationSpan:MKCoordinateSpan =
            MKCoordinateSpanMake(latDelta, longDelta)
        
        // 設置地圖顯示的範圍與中心點座標
        let center:CLLocation = CLLocation(
            latitude: 25.05, longitude: 121.515)
        let currentRegion:MKCoordinateRegion =
            MKCoordinateRegion(
                center: center.coordinate, 
                span: currentLocationSpan)
        myMapView.setRegion(currentRegion, animated: true)
        
        // 加入到畫面中
        self.view.addSubview(myMapView)
    
    
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // 停止定位自身位置
        myLocationManager.stopUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus()
            == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
                title: "定位權限已關閉",
                message:
                "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟",
                preferredStyle: .alert)
            let okAction = UIAlertAction(
                title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true, completion: nil)
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus()
            == .authorizedWhenInUse {
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 印出目前所在位置座標
        let currentLocation :CLLocation =
            locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
    }
    



}