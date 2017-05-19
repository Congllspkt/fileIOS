//
//  ViewController.swift
//  5
//
//  Created by Cntt27 on 5/19/17.
//  Copyright © 2017 Cntt27. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var fileManagaer:FileManager?
    var documentDir:NSString?
    var filePath:NSString?

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        fileManagaer=FileManager.default
        var dirPaths:NSArray=NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        documentDir=dirPaths[0] as? NSString
        print("path : \(documentDir)")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnCreateFileClicked(_ sender: UIButton) {
        
        var error: NSError? = nil
        filePath=documentDir?.appendingPathComponent("file1.txt") as! NSString
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        filePath=documentDir?.appendingPathComponent("file2.txt") as! NSString
        fileManagaer?.createFile(atPath: filePath! as String, contents: nil, attributes: nil)
        
        self.showSuccessAlert("Success", messageAlert: "File created successfully")
        
    }
    
    func showSuccessAlert(_ titleAlert:NSString,messageAlert:NSString)
    {
        let alert:UIAlertController=UIAlertController(title:titleAlert as String, message: messageAlert as String, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
        }
        alert.addAction(okAction)
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCreateDirectoryClicked(_ sender: UIButton) {
        
        do {
            try filePath=documentDir?.appendingPathComponent("/folder1") as! NSString
            try fileManagaer?.createDirectory(atPath: filePath as! String, withIntermediateDirectories: false, attributes: nil)
            try self.showSuccessAlert("Success", messageAlert: "Directory created successfully")
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func writefile(_ sender: UIButton) {
        
        let content:NSString=NSString(string: "helllo how are you?")
        let fileContent:Data=content.data(using: String.Encoding.utf8.rawValue)!
        try? fileContent .write(to: URL(fileURLWithPath: documentDir!.appendingPathComponent("file1.txt")), options: [.atomic])
        self.showSuccessAlert("Success", messageAlert: "Content written successfully")
    }
    
    
    @IBAction func readfile(_ sender: UIButton) {
        
        filePath=documentDir?.appendingPathComponent("/file1.txt") as! NSString
        var fileContent:Data?
        fileContent=fileManagaer?.contents(atPath: filePath! as String)
        let str:NSString=NSString(data: fileContent!, encoding: String.Encoding.utf8.rawValue)!
        self.showSuccessAlert("Success", messageAlert: "data : \(str)" as NSString)
        
    }
    
    
    @IBAction func movefile(_ sender: UIButton) {
        
        do {
            var oldFilePath:String=documentDir!.appendingPathComponent("file1.txt") as String
            var newFilePath:String=documentDir!.appendingPathComponent("/folder1/file1.txt") as String
            var err :NSError?
            try fileManagaer?.moveItem(atPath: oldFilePath, toPath: newFilePath)
            if((err) != nil)
            {
                print("errorrr \(err)")
            }
            self.showSuccessAlert("Success", messageAlert: "File moved successfully")
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func coppy(_ sender: UIButton) {
        do {
            var originalFile=documentDir?.appendingPathComponent("file1.txt")
            var copyFile=documentDir?.appendingPathComponent("copy.txt")
            try fileManagaer?.copyItem(atPath: originalFile!, toPath: copyFile!)
            try self.showSuccessAlert("Success", messageAlert:"File copied successfully")
        }
        catch {
            print(error)
        }
        
    }
    
    @IBAction func permission(_ sender: UIButton) {
        
        filePath=documentDir?.appendingPathComponent("file1.txt") as! NSString
        var filePermissions:NSString = ""
        
        if((fileManagaer?.isWritableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is writable. ") as NSString
        }
        if((fileManagaer?.isReadableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is readable. ") as NSString
        }
        if((fileManagaer?.isExecutableFile(atPath: filePath! as String)) != nil)
        {
            filePermissions=filePermissions.appending("file is executable.") as NSString
        }
        self.showSuccessAlert("Success", messageAlert: "\(filePermissions)" as NSString)
    }
    
    @IBAction func qual(_ sender: UIButton) {
        
        let filePath1=documentDir?.appendingPathComponent("file1.txt")
        let filePath2=documentDir?.appendingPathComponent("file2.txt")
        
        if((fileManagaer? .contentsEqual(atPath: filePath1!, andPath: filePath2!)) != nil)
        {
            self.showSuccessAlert("Message", messageAlert: "Files are equal.")
        }
        else
        {
            self.showSuccessAlert("Message", messageAlert: "Files are not equal.")
        }
    }
    
    @IBAction func constrain(_ sender: UIButton) {
        
        do {
            var error: NSError? = nil
            var arrDirContent = try fileManagaer!.contentsOfDirectory(atPath: documentDir! as String)
            try self.showSuccessAlert("Success", messageAlert: "Content of directory \(arrDirContent)" as NSString)
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func remove(_ sender: UIButton) {
        
        do {
            try filePath=documentDir?.appendingPathComponent("file1.txt") as! NSString
            try fileManagaer?.removeItem(atPath: filePath! as String)
            try self.showSuccessAlert("Message", messageAlert: "File removed successfully.")}
        catch {
            print(error)
        }
    }

}

