import UIKit
import RealmSwift

protocol ItemDelegate {
    func call()
}

class RegisterViewController: UIViewController {
    
    var item = Item()
    var realm = try! Realm()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var savedDate : String = ""
    
    var delegate:ItemDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        let datefommater = DateFormatter()
        datefommater.dateStyle = .medium
        datefommater.timeStyle = .medium
        item.date = datefommater.string(from: datePicker.date)
        // Do any additional setup after loading the view.
    }

    @IBAction func saveList(_ sender: UIButton) {
        item.title = titleTextField.text ?? "title"
        item.subtitle = detailTextField.text ?? "subtitle"
        do{
            try realm.write{
                realm.add(item)
                print("complete save")
            }
        }catch{
            print("Error saving categories \(error)")
        }
        dismiss(animated: true, completion: {
            self.delegate?.call()
        })
    }
    
    @IBAction func cancelButton(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func handleDatePicker(_ sender: UIDatePicker) {
        let datefommater = DateFormatter()
        datefommater.dateStyle = .medium
        datefommater.timeStyle = .medium
        item.date = datefommater.string(from: datePicker.date)
    }
    
}
