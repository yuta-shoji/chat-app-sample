import UIKit

class ChatViewController: UIViewController {
    
    var tableView = UITableView()
    
    var messages = [String]()
    
    override var canBecomeFirstResponder: Bool { return true }
    private var inputContainerView: ChatInputAccessoryView!
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "chat"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        tableView.dataSource = self
        
        inputContainerView = ChatInputAccessoryView(frame: CGRect(
            x: 0,
            y: 0,
            width: view.frame.width,
            height: 50
        ))
        inputContainerView.delegate = self
        
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

extension ChatViewController: ChatInputAccessoryViewDelegate {
    func didTapSend(text: String) {
        messages.append(text)
        inputContainerView.clearInputText()
        tableView.reloadData()
    }
}
