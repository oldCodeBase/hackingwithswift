//
//  CollectionViewController.swift
//  Project-01 b
//
//  Created by Ibragim Akaev on 30/12/2020.
//

import UIKit

class CollectionViewController: UICollectionViewController,
                                UIImagePickerControllerDelegate,
                                UINavigationControllerDelegate {
    
    private var pictures = [String]()
    private let reuseIdentifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pictures"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addTapped))
        findPictures()
    }
    
    private func findPictures() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        guard let items = try? fm.contentsOfDirectory(atPath: path) else { return }
        
        for item in items {
            if item.hasPrefix("Picture") {
                pictures.append(item)
            }
        }
        pictures.sort()
    }
    
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                            for: indexPath) as? PictureCell else {
            
            fatalError("Fatal Error, Please check your code!")
            
        }
        
        cell.image.image = UIImage(named: "\(pictures[indexPath.item])")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "Detail") as? DetailsViewController {
            let picture = pictures[indexPath.item]
            vc.title = picture
            vc.selectedImage = pictures[indexPath.item]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func addTapped() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info:
                                [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }

            let imageName = UUID().uuidString
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)

            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: imagePath)
            }
        
            pictures.append(imageName)
            collectionView.reloadData()
        
            dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
