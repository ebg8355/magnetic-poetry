//
//  ViewController.swift
//  FridgePoetry
//
//  Created by student on 9/13/16.
//  Copyright © 2016 Erik Gerharter. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate
{
    // MARK: - ivars -
    var words: [String] = []
    var backgroundImage: UIImage?
    let screenSize = UIScreen.main.bounds
    
    // MARK: - Outlets -
    @IBOutlet weak var addWord: UITextField!
    
    // MARK: - Functions -
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        words = WordBank.sharedData.wordLists[SaveState.sharedData.wordList]!
        //backgroundImage = SaveState.sharedData.background
        srandom(UInt32(time(nil)))
        placeWords()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        self.addWord.delegate = self
        addWord.returnKeyType = UIReturnKeyType.done
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*override func prepare(for segue: UIStoryboardSegue,sender: Any?){
        if segue.identifier == "ShowWordSegue"{
            let wordsVC = segue.destination.childViewControllers[0] as! WordsTableVC
            
        }
    }*/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    func placeWords()
    {
        var x: CGFloat = 0.0
        var y: CGFloat = 70.0
        
        view.backgroundColor = UIColor.orange
        
        for i in 0..<words.count {
            
            let l = UILabel()
            l.backgroundColor = UIColor.white
            l.text = words[i]
            l.font = l.font.withSize(screenSize.width * 0.05)
            l.sizeToFit()
            l.frame.size.height = l.frame.size.height + 8.0
            l.frame.size.width = l.frame.size.width + 8.0
            l.textAlignment = .center
            
            x = CGFloat(x + l.frame.size.width / 2 + 8.0)
            
            if x > screenSize.width - l.frame.size.width - 8.0
            {
               x = CGFloat(l.frame.size.width / 2 + 8.0)
               y = y + CGFloat(l.frame.size.height + 8.0)
            }
            
            l.center = CGPoint(x: x, y: y)
            
            x = CGFloat(x + l.frame.size.width / 2)
            
            view.addSubview(l)
            l.isUserInteractionEnabled = true
            
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.doPanGesture(_:)))
            
            l.addGestureRecognizer(panGesture)
        }
    }
    
    func clearCanvas(){
        for v in view.subviews{
            if v is UILabel{
                v.removeFromSuperview()
            }
        }
    }
    
    func doPanGesture(_ panGesture: UIPanGestureRecognizer)
    {
        let label = panGesture.view as! UILabel
        let position = panGesture.location(in: view)
        label.center = position
    }
    
    func dismissKeyboard()
    {
        addWord.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        createNewWord(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func createNewWord(textField: UITextField)
    {
        let l = UILabel()
        l.backgroundColor = UIColor.white
        l.text = textField.text
        l.font = l.font.withSize(screenSize.width * 0.05)
        l.sizeToFit()
        l.frame.size.height = l.frame.size.height + 8.0
        l.frame.size.width = l.frame.size.width + 8.0
        l.textAlignment = .center
        l.center = CGPoint(x: screenSize.width / 2, y: screenSize.height / 2)
        view.addSubview(l)
        l.isUserInteractionEnabled = true
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(ViewController.doPanGesture(_:)))
        l.addGestureRecognizer(panGesture)
    }
    
    // MARK: - Actions -
    @IBAction func unwindToMain(segue:UIStoryboardSegue)
    {
        if segue.identifier == "DoneTapped"
        {
            let wordVC = segue.source as! WordsTableVC
            let category = wordVC.selectedCategory
            let listName = WordBank.sharedData.getKeys()[category]
            words = WordBank.sharedData.wordLists[listName]!
            SaveState.sharedData.wordList = listName
            print(SaveState.sharedData.wordList)
            clearCanvas()
            placeWords()
        }
    }
    
    @IBAction func cameraButtonTapped(_ sender: AnyObject)
    {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        self.present(imagePickerController, animated: true, completion: { imageP in })
    }
    
    @IBAction func share(_ sender: AnyObject)
    {
        let image = self.view.takeSnapshot()
        let textToShare = "Check out the poem I made in dat poet!"
        let objectsToShare: [AnyObject] = [textToShare as AnyObject, image!]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.excludedActivityTypes = [UIActivityType.print]
        let popoverMenuViewController = activityVC.popoverPresentationController
        popoverMenuViewController?.permittedArrowDirections = .any
        popoverMenuViewController?.barButtonItem = sender as? UIBarButtonItem
        self.present(activityVC, animated: true, completion: nil)
    }
    
    // MARK: - UIImagePickerController Delegate Methods -
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        let image:UIImage = info[UIImagePickerControllerEditedImage] as! UIImage
        backgroundImage = image
        (self.view as! UIImageView).contentMode = .center
        (self.view as! UIImageView).image = backgroundImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController)
    {
        picker.dismiss(animated: true, completion: nil)
    }
}

