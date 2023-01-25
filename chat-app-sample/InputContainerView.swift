import UIKit

protocol InputContainerViewDelegate: AnyObject {
    func didTapSend(text: String)
}

class InputContainerView: UIView {
    var inputTextField: UITextField
    
    let sendButton = UIButton(type: .system)
    
    var delegate: InputContainerViewDelegate?
    
    override init(frame: CGRect) {
        inputTextField = UITextField()
        inputTextField.borderStyle = .roundedRect
        
        super.init(frame: frame)
        
        self.autoresizingMask = .flexibleHeight
        self.backgroundColor = .systemYellow
        
        inputTextField.delegate = self
        
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        
        self.addSubview(inputTextField)
        self.addSubview(sendButton)
        
        sendButton.anchor(
            right: self.trailingAnchor,
            paddingRight: 8,
            width: 50,
            height: 50
        )
        
        inputTextField.anchor(
            top: self.topAnchor,
            left: self.leadingAnchor,
            bottom: self.layoutMarginsGuide.bottomAnchor,
            right: sendButton.leadingAnchor,
            paddingTop: 8,
            paddingLeft: 8,
            paddingBottom: 8,
            paddingRight: 8
        )
    }
    
    func clearInputText() {
        inputTextField.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize.zero
    }
    
    @objc func didTapSend() {
        guard delegate != nil else { return }
        guard let message = inputTextField.text, inputTextField.text != "" else { return }
        delegate?.didTapSend(text: message)
    }
}

extension InputContainerView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
