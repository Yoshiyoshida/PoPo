//
//  CreatedImagePreview.swift
//  PoPo
//
//  Created by 吉田侑生 on 2019/09/25.
//  Copyright © 2019 吉田侑生. All rights reserved.
//

import Foundation
import UIKit
import DKImagePickerController

class CreatedImagePreview: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addSubview()
    
    }
    func addSubview(){
        var pickerController = DKImagePickerController()
        print("## メインView---------------------")
        
        print("Asset内容 : \(appDelegate.makeAssets)")
        
        let groupDataManagerConfiguration = DKImageGroupDataManagerConfiguration()
        //groupDataManagerConfiguration.fetchLimit = 100//選択できる写真の数
        groupDataManagerConfiguration.assetGroupTypes = [.smartAlbumUserLibrary]

        let groupDataManager = DKImageGroupDataManager(configuration: groupDataManagerConfiguration)

        pickerController = DKImagePickerController(groupDataManager: groupDataManager)//ここでデータが入ってる可能性
        
        pickerController.select(assets: appDelegate.makeAssets)
        
        print("Assets : \(pickerController.selectedAssets)")
        //モーダルの表示形式とViewのデータを統括
        
        pickerController.inline = true
        pickerController.assetType = .allPhotos
        pickerController.sourceType = .photo
        
        let pickerView = pickerController.view!
        
        pickerView.frame = CGRect(x: 0, y: 170, width: self.view.bounds.width, height: 600)//選択した画像の画面設定
        self.title = "選択した画像"
        self.view.addSubview(pickerView)
        
    }
    
    
    @IBAction func saveImage(_ sender: Any) {
        //loadFromNSDefaults()
    }
    
    
    
    
}
