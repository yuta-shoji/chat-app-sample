import UIKit

protocol ChatInputAccessoryViewDelegate: AnyObject {
    func didTapSend(text: String)
}

class ChatInputAccessoryView: UIView {
    let inputTextField = UITextField()
    
    let sendButton = UIButton(type: .system)
    
    var delegate: ChatInputAccessoryViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemYellow
        
        setupInputTextField()
        setupSendButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInputTextField() {
        inputTextField.frame = CGRect(
            x: 8,
            y: 8,
            width: self.frame.width - 50 - 16,
            height: self.frame.height - 16
        )
        inputTextField.borderStyle = .roundedRect
        self.addSubview(inputTextField)
    }
    
    private func setupSendButton() {
        sendButton.frame = CGRect(x: self.frame.width - 50, y: 0, width: 50, height: self.frame.height)
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        self.addSubview(sendButton)
    }
    
    func clearInputText() {
        inputTextField.text = ""
    }
    
    @objc func didTapSend() {
        guard delegate != nil else { return }
        guard let message = inputTextField.text, inputTextField.text != "" else { return }
        delegate?.didTapSend(text: message)
    }
}
