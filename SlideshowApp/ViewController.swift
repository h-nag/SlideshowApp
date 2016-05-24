//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Hilarion on 2016/05/20.
//  Copyright © 2016年 hidenori.nagasawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // イメージ表示部
    @IBOutlet private weak var imageView: UIImageView!
    // 前へ ボタン
    @IBOutlet private weak var prevButton: UIButton!
    // 後へ ボタン
    @IBOutlet private weak var playButton: UIButton!
    // 再生停止 ボタン
    @IBOutlet private weak var nextButton: UIButton!
    // 画像ファイルパス配列
    private var filePaths: [String] = []
    // 表示されている画像のインデックス
    private var index = 0
    // 画像表示初期インデックス
    private let initIndex = 0
    // imagesフォルダパス
    private let imagesPath = "/Users/nagasawahidenori/Documents/workspace/techacademy/SlideshowApp/SlideshowApp/images/"
    // スライドショータイマー
    private var timer: NSTimer!
    // スライドショー実行フラグ
    private var slshFlg: Bool = false
    // スライドショー実行間隔（2秒）
    private let slshPeriod: NSTimeInterval = 2
    
    
    @IBAction func showNextImage(sender: AnyObject) {
        // 次の画像を表示
        slideNext()
    }
    
    @IBAction func showPrevImage(sender: AnyObject) {
        // 前の画像を表示
        slidePrev()
    }
    
    @IBAction func playSlideshwo(sender: AnyObject) {
        // 次へ、後へボタンの無効化
        if !slshFlg {
            nextButton.enabled = false
            nextButton.alpha = 0.5
            prevButton.enabled = false
            prevButton.alpha = 0.5
            playButton.setTitle("Pause", forState: UIControlState.Normal)
            
            // スライドショータイマー生成
            timer = NSTimer.scheduledTimerWithTimeInterval(slshPeriod, target: self, selector: #selector(self.slideNext), userInfo: nil, repeats: true)
            slshFlg = timer.valid
            
        } else {
            nextButton.enabled = true
            nextButton.alpha = 1.0
            prevButton.enabled = true
            prevButton.alpha = 1.0
            playButton.setTitle("Play", forState: UIControlState.Normal)
            
            // スライドショータイマー停止
            timer.invalidate()
        }
        
    }
    
    // ???: 以下は画面ロード時にフォルダから画像ファイルを検索して表示
    // フォルダ検索がうまく行かない
//    override func loadView() {
//        
//        let flMngr = NSFileManager()
//        do {
//            // 画像ファイル名取得
//            filePaths = try flMngr.contentsOfDirectoryAtPath(imagesPath)
//            print(filePaths)
//            
//            filePaths = filePaths.map{
//                (val) -> String in
//                return imagesPath + val
//            }
//            print(filePaths)
//            // 取得したファイルの中で一番初めのものを表示
//            filePaths = ["RIMG0716.JPG", "RIMG0720.JPG", "RIMG1372.JPG", "RIMG1375.JPG", "RIMG1361.JPG"]
//            print(filePaths[initIndex])
//            // imageView.image = UIImage(named: filePaths[initIndex])
//            
//            let initImage: UIImage? = UIImage(named: filePaths[initIndex])
//            imageView = UIImageView(image: initImage)
//            
//        } catch let error as NSError {
//            print(error)
//        }
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 取得したファイルの中で一番初めのものを表示
        filePaths = ["RIMG0716.JPG", "RIMG0720.JPG", "RIMG1372.JPG", "RIMG1375.JPG", "RIMG1361.JPG"]
        print(filePaths[initIndex])
        // imageView.image = UIImage(named: filePaths[initIndex])
        imageView = UIImageView()
        let initImage: UIImage? = UIImage(named: filePaths[initIndex])
        if let validImg = initImage {
            imageView = UIImageView(image: validImg)
        } else {
            print("No image file")
        }
        
        // 画像をタップされたら拡大画像へ遷移する
        // let gesture = UITapGestureRecognizer(target: self, action: #selector(self.tapImageView))
        // imageView.addGestureRecognizer(gesture)
        // ???: 以下の行でエラー unexpectedly found nil と表示される
        imageView.userInteractionEnabled = true
        self.view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let imgTouch = touches.first
        if imgTouch?.tapCount == 1 {
            
        }
    }

    
    func slideNext() {
        if index != filePaths.count - 1 {
            imageView.image = UIImage(named: filePaths[index + 1])
            index += 1
        } else {
            imageView.image = UIImage(named: filePaths[initIndex])
            index = initIndex
        }
    }
    
    func slidePrev() {
        if index != initIndex {
            imageView.image = UIImage(named: filePaths[index - 1])
            index -= 1
        } else {
            imageView.image = UIImage(named: filePaths[filePaths.count - 1])
            index = filePaths.count - 1
        }
    }
    
    func tapImageView(){
        if let naviCon = self.navigationController {
            let wiCon: WideImageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("wiViewController") as! WideImageViewController
            wiCon.imageView.image = UIImage(named: filePaths[index])
            naviCon.pushViewController(wiCon, animated: true)
            
        }
    }

}

