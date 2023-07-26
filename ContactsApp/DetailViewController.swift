//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by Gökçe Pınar Yıldız on 23.07.2023.
//

import UIKit

class  DetailViewController: UIViewController {
    var selectedContact: ContactsModel?
    
    
    @IBOutlet weak var collectionDetailView: UICollectionView!
    
    @IBOutlet weak var imageDetailView: UIImageView!
    
    @IBOutlet weak var labelContactType: UILabel!

    @IBOutlet weak var labelTitle: UILabel!
    
    var selectedTitle : String?
    var selectedContactType : String?
    var selectedGenderImage : String?
    var selectedRelated : [ContactsModel] = [ContactsModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionDetailView.delegate = self
        collectionDetailView.dataSource = self
        
        labelTitle.text = selectedTitle
        labelContactType.text = selectedContactType
        
        imageDetailView.image = UIImage(named:selectedGenderImage!)
        
        let design:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
                let viewWidth = self.collectionDetailView.frame.size.width
                design.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5)
                design.itemSize = CGSize(width: (viewWidth-30)/2, height: (viewWidth-30)/2)
                design.scrollDirection = .horizontal
        collectionDetailView.collectionViewLayout = design
    }
    
    
    private func getContactByType() -> [ContactsModel] {
        return Contacts.contacts.filter({ $0.contactType == selectedContact?.contactType })
    }
    
}

extension DetailViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedRelated.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
//        cell.imageCell.image = UIImage(named: String(describing: selectedRelated[indexPath.section][indexPath.row].genderImage.genderImage.lowercased()))
        cell.imageCell.image = UIImage(named: String(describing: selectedRelated[indexPath.row].genderImage))
        
        cell.labelCell.text = selectedRelated[indexPath.row].title
//        cell.contactName.text = selectedContacts[indexPath.row].name
//        cell.contactImage.image = UIImage(named: String(describing: selectedContacts[indexPath.row].imageName!))
        return cell
    }
    
    
    
}
