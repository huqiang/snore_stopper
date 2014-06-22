//
//  ViewController.swift
//  Snore Stoper
//
//  Created by Hu Qiang on 22/6/14.
//  Copyright (c) 2014 Hu Qiang. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation

class ViewController: UIViewController {
    var recorder : AVAudioRecorder
    
    @IBOutlet var level : UITextField
    
    init(coder aDecoder: NSCoder!) {
        let DOCUMENTS_FOLDER = NSHomeDirectory()+"/Documents/record.acc"
        println(DOCUMENTS_FOLDER);
    
        AVAudioSession.sharedInstance().requestRecordPermission({(granted:Bool)->Void in println(granted)});
        //        let settings:NSDictionary = NSDictionary.
        let settings:NSDictionary = [AVSampleRateKey:44100, AVFormatIDKey:kAudioFormatAppleLossless, AVNumberOfChannelsKey:1, AVEncoderAudioQualityKey:AVAudioQuality.High.toRaw()] as NSDictionary
        //        [AVSampleRateKey:44100, "AVFormatIDKey":kAudioFormatAppleLossless, "AVNumberOfChannelsKey":1, "AVEncoderAudioQualityKey":AVAudioQuality.Max]
        let url:NSURL = NSURL.URLWithString(DOCUMENTS_FOLDER)// NSURL(fileURLWithPath: DOCUMENTS_FOLDER)
        var error:NSError = NSError()
        //        var recorder = AVAudioRecorder()
        //        recorder.url = url
        //        recorder.settings= settings
        
        
        recorder = AVAudioRecorder(URL: url, settings: settings, error: nil)

        super.init(coder: aDecoder)
        // Custom initialization
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
            }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startRecording(){
       

        recorder.prepareToRecord()
        
        var err:NSError
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
//        var ASRoute = kAudioSessionOverrideAudioRoute_Speaker
        audioSession.setCategory("kAudioSessionProperty_OverrideAudioRoute", error: nil)
//        audioSession.setCategory(kAudioSessionProperty_OverrideAudioRoute, error: nil)
//        AudioSessionProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(ASRoute), ASRoute)
        
        audioSession.setActive(true, error: nil)
        recorder.recordForDuration(5)
        recorder.meteringEnabled=true
        let result=recorder.record()
        println(result)
    }
    
    func start_Recording(){
        let session = AVAudioSession.sharedInstance()
        if (AVAudioSession.sharedInstance().respondsToSelector("requestRecordPermission:")) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    println("granted")
                    session.setCategory(AVAudioSessionCategoryPlayAndRecord, error: nil)
                    session.setActive(true, error: nil)
                    var result = self.recorder.record()
                    println(result)
                } else{
                    println("not granted")
                }
                })
            
        }
    }
    
    func stopRecording(){
        println(recorder.stop())
    }
    
    
    @IBAction func start_button(sender : UIButton) {
        if let what_to_do = sender.currentTitle{
            println(what_to_do)
            if what_to_do == "Start"{
                sender.setTitle("Stop", forState: UIControlState.Normal)
                start_Recording()
            }else if what_to_do == "Stop"{
                sender.setTitle("Start", forState: UIControlState.Normal)
                stopRecording()
            }
        }
    }
    
}

