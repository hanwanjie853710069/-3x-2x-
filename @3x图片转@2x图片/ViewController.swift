//
//  ViewController.swift
//  @3x图片转@2x图片
//
//  Created by 王木木 on 16/9/26.
//  Copyright © 2016年 王木木. All rights reserved.

/*
 
 3倍图片  转换到 2倍图片  
 path 要转换图片的文件夹路径 
 转换完成之后 会直接在 path这个路径下的文件显示 转化完成之后的2倍图片
 
 */
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = "/Users/wangmumu/Desktop/未命名文件夹"
         
        inputFolderPath(folderPath: path )
        
    }
    
    func inputFolderPath(folderPath: String){
        
        let fileManager = FileManager.default
        
        let enumerator:FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: folderPath)!
        
        for temp in enumerator {
            
            let threeImage = (temp as! String)
            
            if threeImage.hasSuffix("@3x.png") {
                
                let pathString = folderPath + "/" + threeImage
                
                threeTimesThePicturesTwoTimes(pathFile: pathString)
                
            }
            
        }
        
    }
    
    
    func threeTimesThePicturesTwoTimes(pathFile: String){
        
        let arrayString = pathFile.components(separatedBy: "/")
        
        let temp = arrayString[arrayString.count - 1]
        
        let nsstr = temp as NSString
        
        let pathS = pathFile as NSString
        
        let han =  nsstr.replacingOccurrences(of: "@3x", with: "@2x")
        
        let imageName = pathS.replacingOccurrences(of: temp, with: han)
        
        let nsd = NSData.init(contentsOfFile: pathFile)
        
        let img = UIImage(data: nsd as! Data)
        
        let width = (img?.size.width)! / 3 * 2
        
        let height = (img?.size.height)! / 3 * 2
        
        let sizeChange = CGSize(width: width,height: height)
        
        let imageDate = img?.reSizeImage(reSize: sizeChange)
        
        let filePath:String = imageName as String
        
        let data:NSData = UIImagePNGRepresentation(imageDate!)! as NSData
        
        data.write(toFile: filePath, atomically: true)
        
    }
    
}


extension UIImage{
    
    func reSizeImage(reSize:CGSize)->UIImage {
        
        UIGraphicsBeginImageContextWithOptions(reSize,false,1)
        
        self.draw(in: CGRect(x: 0, y: 0, width: reSize.width, height: reSize.height))
        
        let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return reSizeImage
        
    }
    
}
