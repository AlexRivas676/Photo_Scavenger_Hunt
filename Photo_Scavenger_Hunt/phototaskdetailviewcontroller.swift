//
//  ViewController1.swift
//  Photo_Scavenger_Hunt
//
//  Created by Alex Rivas on 2/16/23.
//

import UIKit
import PhotosUI
import MapKit

class phototaskdetailviewcontroller: UIViewController, PHPickerViewControllerDelegate, MKMapViewDelegate {
    var phototask: photohunttask!
    @IBOutlet weak var completelabel:UILabel!
    @IBOutlet weak var completedtaskimageview:UIImageView!
    @IBOutlet weak var tasklabel: UILabel!
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var attachtaskphotobutton: UIButton!
    
    @IBOutlet weak var desclabel:UILabel!
    override func viewDidLoad() {
        mapview.register(pictaskannotationview.self, forAnnotationViewWithReuseIdentifier: pictaskannotationview.identifier)
        mapview.delegate = self
        super.viewDidLoad()
        mapview.layer.cornerRadius = 12
        updatingui()
        updatingmapview()

        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func buttontapped(_ sender: Any) {
        if PHPhotoLibrary.authorizationStatus(for:.readWrite) != .authorized{
            
            PHPhotoLibrary.requestAuthorization(for:.readWrite){[weak self] status in switch status{
            case .authorized:
                DispatchQueue.main.async{
                    self?.presentphpicker()
                }
            default:
                DispatchQueue.main.async {
                    self?.presentphotosettingsAlrt()
                    
                }//mainasync
            }//switch
        }//2ndphphotolibrary
    }//if statement
        else{
            presentphpicker()
        }
}//func
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let  annotationview =  mapview.dequeueReusableAnnotationView(withIdentifier: pictaskannotationview.identifier, for: annotation) as? pictaskannotationview else{ fatalError("unable to dequeue pictaskannotationview")}
        annotationview.configure(with: phototask.photo)
        return annotationview
    }
        
                
    
    private func presentphpicker(){
        var pickerconfig = PHPickerConfiguration(photoLibrary:PHPhotoLibrary.shared())
        pickerconfig.filter = .images
        pickerconfig.preferredAssetRepresentationMode = .current
        pickerconfig.selectionLimit = 5
        let photopicker = PHPickerViewController(configuration: pickerconfig)
        photopicker.delegate = self
        present(photopicker,animated: true)
        
        
    }
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        let picresult = results.first
        guard let assetid = picresult?.assetIdentifier,
              let loc = PHAsset.fetchAssets(withLocalIdentifiers: [assetid], options: nil).firstObject?.location else{
            return
        }
        print("📍 Image Location:\(loc.coordinate)")
        
        guard let imageprovider = picresult?.itemProvider,
              imageprovider.canLoadObject(ofClass:UIImage.self) else{return}
        imageprovider.loadObject(ofClass:UIImage.self) { [weak self] object,error in
            if let picprovidererror = error{
                DispatchQueue.main.async {[weak self] in self?.showingErrorAlert(for:picprovidererror)
                }
            }//if
            guard let pic = object as? UIImage else{return}
            print(" we have an image")
            DispatchQueue.main.async { [weak self] in
                self?.phototask.setphoto(image: pic, with: loc)
                self?.updatingui()
                
            }
                
            }
        }
   private  func updatingui(){
       tasklabel.text = phototask.title
       desclabel.text = phototask.desc
       let completedtaskimage = UIImage(systemName: phototask.taskcomplete ? " circle.inset.filled" : "circle")
       
       completedtaskimageview.image = completedtaskimage?.withRenderingMode(.alwaysTemplate)
       completelabel.text = phototask.taskcomplete ? "Complete" : "Incomplete"
       let uicolor: UIColor = phototask.taskcomplete ? .systemGreen : .tertiaryLabel
       completedtaskimageview.tintColor = uicolor
       mapview.isHidden = !phototask.taskcomplete
       attachtaskphotobutton.isHidden = phototask.taskcomplete
    }
    func updatingmapview(){
        guard let  picloc = phototask.photoloc else{return}
        let piccoordinate = picloc.coordinate
        let region = MKCoordinateRegion(center: piccoordinate, span:MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) )
        mapview.setRegion(region, animated: true)
        let mapannotation = MKPointAnnotation()
        mapannotation.coordinate = piccoordinate
        mapview.addAnnotation(mapannotation)
       
        
    }
    func presentphotosettingsAlrt (){
        let photoAlert = UIAlertController(title:"Photo access", message: "WE Need access to your photos to complete a task/post a photo.Access can be changed in Settings", preferredStyle:.alert)
        let settingsAct = UIAlertAction(title: "Settings", style: .default) { _ in
            guard let settingslink = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingslink) {
                UIApplication.shared.open(settingslink)
            }
        }

        photoAlert.addAction(settingsAct)
        let cancelAct = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        photoAlert.addAction(cancelAct)

        present(photoAlert, animated: true, completion: nil)
    }

    /// Show an alert for the given error
    private func showingErrorAlert(for error: Error? = nil) {
        let erroralert = UIAlertController(
            title: "Oops...",
            message: "\(error?.localizedDescription ?? "Please try again...")",
            preferredStyle: .alert)

        let act = UIAlertAction(title: "OK", style: .default)
        erroralert.addAction(act)

        present(erroralert, animated: true)
    }

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

