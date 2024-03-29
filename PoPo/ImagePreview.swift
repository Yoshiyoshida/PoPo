//
//  ImagePreview.swift
//  PoPo
//
//  Created by 吉田侑生 on 2019/09/23.
//  Copyright © 2019 吉田侑生. All rights reserved.
//

import UIKit
import Photos
import DKImagePickerController

class imagePreview: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
        
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
        //選択した画像List
    var DKAssets = [DKAsset]()
    
    var pickerController = DKImagePickerController()
        
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("To next page of image preview")
        print("# モーダルに関する関数")
        didSelectAssets()//モーダル表示する
        print(DKAssets)
        
        //print("# メインView")
        //addSubview()
        
        print("# viewDidLoad finish")
    }
    
    

    
        
    
        //モーダルViewで選択したら呼ばれる関数
        func didSelectAssets(){
            print("## モーダルViewに関する関数-----------")
            
            //選択したら呼ばれる関数
            pickerController.didSelectAssets = { (assets: [DKAsset]) in
                
                print("### 写真を選択する")
                print("asset配列 : \(assets)")
                print("選択した写真の枚数 : \(assets.count)")
                
                for asset in assets{
                    print("asset : \(asset)")
                    self.DKAssets.append(asset)
                    print(self.DKAssets)
                    
                }
                print("Asset数 : \(self.DKAssets.count)")
                
                //print("# メインView")
                self.addSubview()
                

            }
            
            //モーダルを閉じる
            self.present(pickerController, animated: true) {}
            
        }
        
    
        
    
        //モーダルの下の画面
        func addSubview(){
            print("## メインView---------------------")
            
            print("Asset内容 : \(self.pickerController.selectedAssets)")
            
            let groupDataManagerConfiguration = DKImageGroupDataManagerConfiguration()
            //groupDataManagerConfiguration.fetchLimit = 100//選択できる写真の数
            groupDataManagerConfiguration.assetGroupTypes = [.smartAlbumUserLibrary]

            let groupDataManager = DKImageGroupDataManager(configuration: groupDataManagerConfiguration)

            self.pickerController = DKImagePickerController(groupDataManager: groupDataManager)//ここでデータが入ってる可能性
            
            print("Asset数 : \(self.DKAssets.count)")
            pickerController.select(assets: self.DKAssets)
            
            appDelegate.makeAssets = self.DKAssets
            //モーダルの表示形式とViewのデータを統括
            
            pickerController.inline = true
            pickerController.assetType = .allPhotos
            pickerController.sourceType = .photo
            
            let pickerView = pickerController.view!
            
            pickerView.frame = CGRect(x: 0, y: 170, width: self.view.bounds.width, height: 600)//選択した画像のひ画面設定

            self.title = "選択した画像"
            self.view.addSubview(pickerView)
            
        }
    
}
    /*
    var myCollectionView: UICollectionView!
    var imageArray = [UIImage]()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Start")
        //CollectionViewのレイアウトを定義??
        
        let layout = UICollectionViewFlowLayout()
        print("layout")
        
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        myCollectionView.register(PhotoItemCell.self, forCellWithReuseIdentifier: "imageCell")
        myCollectionView.backgroundColor = UIColor.white
        self.view.addSubview(myCollectionView)
        self.view.bringSubviewToFront(toolBar as! UIView)
        
        myCollectionView.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.RawValue(UInt8(UIView.AutoresizingMask.flexibleWidth.rawValue) | UInt8(UIView.AutoresizingMask.flexibleHeight.rawValue)))
        
        
        grabPhotos()
        print("111")
    }
    
    // モーダルを閉じて前の画面へ戻る
    @IBAction func backBtnPushed() {
        print("backBtnPushed is called")
        self.dismiss(animated: true, completion: nil)
    }
    
    //セルの数を定義
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    //セルの中身を定義
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PhotoItemCell
        cell.img.image = imageArray[indexPath.item]
        return cell
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        //        if UIDevice.current.orientation.isPortrait {
        //            return CGSize(width: width/4 - 1, height: width/4 - 1)
        //        } else {
        //            return CGSize(width: width/6 - 1, height: width/6 - 1)
        //        }
        if DeviceInfo.Orientation.isPortrait {
            return CGSize(width: width/4 - 1, height: width/4 - 1)
        } else {
            return CGSize(width: width/6 - 1, height: width/6 - 1)
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    //アルバムから写真[UIImage]を撮る
    func grabPhotos(){
        imageArray = []
        
        DispatchQueue.global(qos: .background).async {
            print("This is run on the background queue")
            let imgManager=PHImageManager.default()
            
            let requestOptions=PHImageRequestOptions()
            requestOptions.isSynchronous=true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions=PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            print(fetchResult)
            print(fetchResult.count)
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count{
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500),contentMode: .aspectFill, options: requestOptions, resultHandler: { (image, error) in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("You got no photos.")
            }
            print("imageArray count: \(self.imageArray.count)")
            
            DispatchQueue.main.async {
                print("This is run on the main queue, after the previous code in outer block")
                self.myCollectionView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func backTapped() {
    }
    
    @IBAction func selectRelece() {
    }
    
    
}//クラス終わり


//セルの中身を定義するクラス->collectionView
class PhotoItemCell: UICollectionViewCell{
    var img = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        img.clipsToBounds = true
        self.addSubview(img)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        img.frame = self.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}//クラス終わり

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.statusBarOrientation.isLandscape
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.statusBarOrientation.isPortrait
            }
        }
    }
 */

