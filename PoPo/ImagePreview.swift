//
//  ImagePreview.swift
//  PoPo
//
//  Created by 吉田侑生 on 2019/09/23.
//  Copyright © 2019 吉田侑生. All rights reserved.
//

import UIKit
import Photos

class imagePreview: UIViewController, UICollectoinViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate{
    
    var myCollectionView: UICollectionView!
    var imageArray = [UIImage]()
    
    
    
    
    //セルの数を指定
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! PhotoItemCell
        cell.img.image = imageArray[indexPath.item]
        return cell
        
    }
    
    
    
}


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
}
