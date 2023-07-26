//
//  ViewController.swift
//  ContactsApp
//
//  Created by Gökçe Pınar Yıldız on 22.07.2023.
//

import UIKit

struct ContactsModel {
    var title: String
    var contactType: ContactType
    var genderImage : GenderImage
    
}


enum GenderImage: CaseIterable {
    case female
    case male
    
    var genderImage: String {
        switch self {
        case .female:
            return "female"
        case .male:
            return "male"
        }
    }
    
}
enum ContactType: CaseIterable {
    case allContacts
    case family
    case friends
    case work


    
    var contactType: String {
        switch self {
            
        case .allContacts:
            return "AllContacts"
        case .family:
            return "Family"
        case .friends:
            return "Friends"
        case .work:
            return "Work"

        }
        }
    }

class Contacts {
    static let contacts: [ContactsModel] = [
        ContactsModel(title: "Emre", contactType: .friends,genderImage: .male),
        ContactsModel(title: "Bengi", contactType: .work,genderImage:.female),
        ContactsModel(title: "Annem", contactType: .family,genderImage:.female),
        ContactsModel(title: "Babam", contactType: .family,genderImage:.male),
        ContactsModel(title: "Arda", contactType: .family,genderImage:.male),
        ContactsModel(title: "Hulya", contactType: .friends,genderImage: .female),
        ContactsModel(title: "Fatih Bey", contactType: .work,genderImage:.male),
        ContactsModel(title: "Gamze", contactType: .friends,genderImage:.female),
        ContactsModel(title: "Deniz", contactType: .friends,genderImage:.female)
    ]
    
}
class ViewController: UIViewController {
    

    @IBOutlet weak var contactTableView: UITableView!
    
    private var selectedContactType: ContactType? {
        didSet {
            contactTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactTableView.delegate = self
        contactTableView.dataSource = self
        
        let filterButton = UIBarButtonItem(image:UIImage(systemName: "line.3.horizontal.decrease.circle.fill"),style: .done,target: self,action: #selector(filterButtonAct))
        navigationItem.rightBarButtonItem = filterButton
    }
    @objc private func filterButtonAct() {
        let storyboard = UIStoryboard(name: "PickerViewController", bundle: nil)
        
        if let vc = storyboard.instantiateViewController(identifier: "PickerViewController") as?
            PickerViewController{
            vc.delegate = self
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc,animated: true)
        }
    }
    
}

//MARK: - PickerViewController Delegate Methods
extension ViewController: PickerViewControllerDelegate {
    func didSelectContactType(_ type: ContactType) {
        selectedContactType = type
    }
}

//MARK: - ViewController Delegate Methods
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return setSections().count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return setSections()[section].contactType
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterContacts(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell") as! ContactsTableViewCell
        print(filterContacts(indexPath.section)[indexPath.row].genderImage.genderImage)
        cell.cellImageView.image = UIImage(named: filterContacts(indexPath.section)[indexPath.row].genderImage.genderImage)
        cell.cellTitleLabel.text = filterContacts(indexPath.section)[indexPath.row].title

        return cell
    }



    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        let selectedContact = filterContacts(indexPath.section)[indexPath.row]
//
//        let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
//        if let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
//            vc.selectedContact = selectedContact
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

            let filterbyGroupContacts = filterContacts(indexPath.section).filter({$0.title != filterContacts(indexPath.section)[indexPath.row].title})
       

            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            let collectionVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        collectionVC.selectedTitle = filterContacts(indexPath.section)[indexPath.row].title
        collectionVC.selectedContactType = filterContacts(indexPath.section)[indexPath.row].contactType.contactType
        collectionVC.selectedRelated = filterbyGroupContacts
        collectionVC.selectedGenderImage = filterContacts(indexPath.section)[indexPath.row].genderImage.genderImage
        

//            collectionVC.selectedContactNameStr = filterContacts(indexPath.section)[indexPath.row].name
//            collectionVC.selectedImageName = String(describing: filterContacts(indexPath.section)[indexPath.row].imageName!)
//            collectionVC.selectedContacts = filterbyGroupContacts
//            collectionVC.selectedGroup = filterContacts(indexPath.section)[indexPath.row].group
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Contacts", style: .plain, target: nil, action: nil)
            self.navigationController?.pushViewController(collectionVC, animated: true)

        }
    private func setSections() -> [ContactType] {
        
        if  selectedContactType == nil || selectedContactType == .allContacts {
            return ContactType.allCases
        } else {
            return [selectedContactType!]
        }
    }
    private func filterContacts(_ sectionIndex: Int) -> [ContactsModel] {
        if selectedContactType == nil || selectedContactType == .allContacts {
            return Contacts.contacts.filter({$0.contactType == ContactType.allCases[sectionIndex]})
        } else {
            return Contacts.contacts.filter({$0.contactType == selectedContactType})
        }
        
        

    }
}
