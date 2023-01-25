import UIKit

class ChatViewController: UIViewController {
    
    var tableView = UITableView()
    
    var messages = [String]()
    
    
    override var canBecomeFirstResponder: Bool { return true }
    
    var inputContainerView: InputContainerView!
    
    override var inputAccessoryView: UIView? {
        if inputContainerView == nil {
            inputContainerView = InputContainerView()
            inputContainerView.delegate = self
        }
        return inputContainerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "chat"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        
        view = tableView
    }
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = messages[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

extension ChatViewController: InputContainerViewDelegate {
    func didTapSend(text: String) {
        messages.append(text)
        inputContainerView.clearInputText()
        tableView.reloadData()
    }
}
