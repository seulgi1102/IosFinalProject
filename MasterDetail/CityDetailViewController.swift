//
//  ViewController.swift
//  MasterDetail
//
//  Created by SeulgiKim on 2024/06/19.
//

import UIKit

class CityDetailViewController: UIViewController {

    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var countryPickerView: UIPickerView!
    @IBOutlet weak var cityImageView: UIImageView!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewBottomConstraint: NSLayoutConstraint!
    var isShowKeyboard = false
    
    var countries = [
        "Korea", "Greece", "Thailand", "Germany", "Istael", "England", " United State", " France", "Australia"
        ]
    var cityMasterViewController: CityMasterViewController!
    //var cities: [City]!
    var selectedCity: Int?
    //var imagePool: [String: UIImage]!
    
    func initCity(city: City){
        cityImageView.image = cityMasterViewController.imagePool[city.imageName] ?? city.uiImage()
        
        for i  in 0..<countries.count{
            if city.country == countries[i]{
                countryPickerView.selectRow(i, inComponent: 0, animated: true)
                break
            }
        }
        cityNameTextField.text = city.name
        descriptionTextView.text = city.description
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCountryPickerView()
        
        if let selectedCity = selectedCity{
            initCity(city: cityMasterViewController.cities[selectedCity])
        }
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(capturePicture))
        cityImageView.addGestureRecognizer(imageTapGesture)
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(viewTapGesture)
    
    }
    override func viewDidAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: OperationQueue.main){notification in
            if self.isShowKeyboard == false{
                self.isShowKeyboard = true
                self.stackViewTopConstraint.constant -= 250
                self.stackViewBottomConstraint.constant -= 250
            }
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: OperationQueue.main){ notification in
            self.stackViewTopConstraint.constant += 250
            self.stackViewBottomConstraint.constant += 250
            self.isShowKeyboard = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:  UIResponder.keyboardWillHideNotification, object: nil)
    }
    @IBAction func savingCity(_ sender: UIButton) {
        guard let name = cityNameTextField.text, name.isEmpty == false else{return}
        
        let image = cityImageView.image
        let country = countries[countryPickerView.selectedRow(inComponent: 0)]
        let description = descriptionTextView.text
        
        var id = cityMasterViewController.cities.count + 1000
        var imageName = name
        if let selectedCity = selectedCity{
            id = cityMasterViewController.cities[selectedCity].id
            imageName = cityMasterViewController.cities[selectedCity].imageName
        }
        
        let city = City(id: id, name: name, country: country, description: description!, imageName: imageName)
        
        if let selectedCity = selectedCity{
            cityMasterViewController.cities[selectedCity] = city
        }else{
            cityMasterViewController.cities.append(city)
        }
        cityMasterViewController.imagePool[imageName] = image
        
        cityImageView.image = nil; cityNameTextField.text = ""; selectedCity = nil
    }
    
    @objc func dismissKeyboard(Sender: UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func endEditing(sender: UITextField){
        stackViewTopConstraint.constant += 250
        stackViewBottomConstraint.constant += 250
    }
    
    @objc func capturePicture(sender: UITapGestureRecognizer){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePickerController.sourceType = .camera
        }else{
            imagePickerController.sourceType = .savedPhotosAlbum
        }
        
        imagePickerController.sourceType = .savedPhotosAlbum
        present(imagePickerController, animated: true, completion: nil)
    }
}
extension CityDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        cityImageView.image = image
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CityDetailViewController: UIPickerViewDataSource, UIPickerViewDelegate{
    func initCountryPickerView(){
        countryPickerView.dataSource = self
        countryPickerView.delegate = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
}
