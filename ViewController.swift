//
//  ViewController.swift
//  Swift6Camera
//
//  Created by 玉城秀大 on 2020/11/29.
//

import UIKit
import Photos

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    var checkPermission = CheckPermission()
    
    @IBOutlet weak var backImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        checkPermission.checkCamera()
    }

    
    

    @IBAction func camera(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType = .camera
        createImagePicker(sourceType: sourceType)
    }
    
    
    
    
    @IBAction func album(_ sender: Any) {
        let sourceType:UIImagePickerController.SourceType = .photoLibrary
        createImagePicker(sourceType: sourceType)
    }
    
    
    
    @IBAction func share(_ sender: Any) {
        
        let text = "#サービス名"
        let image = backImageView.image?.jpegData(compressionQuality: 0.5)
        var item = [text,image as Any] //何型でも良い
        let activityVC = UIActivityViewController(activityItems: item, applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
    
    
    func createImagePicker(sourceType:UIImagePickerController.SourceType) {
        
        //インスタンス生成
        let cameraPicker = UIImagePickerController()
        cameraPicker.sourceType = sourceType
        
        //cameraPickerで使えるデリゲートメソッドをViewControllerでも使えるようにする
        //引数がUIImagePickerCOntroller型なので、そこで用意されているメソッドが使えるようになる
        cameraPicker.delegate = self
        //編集を許すか
        cameraPicker.allowsEditing = true
        //カメラが立ち上がる
        self.present(cameraPicker, animated: true, completion: nil)
        
        
    }
    
    //撮影（アルバム）のキャンセルボタンがタップされた時
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //空じゃないかを認識
        if let pickerImage = info[.editedImage] as? UIImage {
            backImageView.image = pickerImage
            //閉じる処理
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
}

