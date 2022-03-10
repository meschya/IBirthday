import UIKit

final class InfoView: UIView {
    // MARK: - Properties
    
    // MARK: Private

    private var namegiver: Namegiver = .init()
    private var personImage: UIImage = .init()
    private let mainStackView: UIStackView = .init()
    private let nameTextField: InfoTextField = .init()
    private let phoneNumberTextField: InfoTextField = .init()
    private let dateTextField: InfoTextField = .init()
    private let saveButton: UIButton = .init()
    private let datePicker: UIDatePicker = .init()
    
    // MARK: - LIfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addContraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addSubview(mainStackView)
        mainStackView.addArrangedSubviews(nameTextField,
                                          phoneNumberTextField,
                                          dateTextField,
                                          saveButton)
    }
    
    private func addSetups() {
        addMainStackViewSetups()
        addTextFieldsSetups()
        addSaveButtonSetups()
        createDatePicker()
    }
    
    private func addMainStackViewSetups() {
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fillEqually
        mainStackView.spacing = 20
    }
    
    private func addTextFieldsSetups() {
        nameTextField.configurator("bb", "Name")
        nameTextField.isAutoCorrectionEnabled = false
        phoneNumberTextField.configurator("phone", "Number phone", .phonePad)
    }
    
    private func addSaveButtonSetups() {
        saveButton.backgroundColor = .white
        saveButton.addShadow()
        saveButton.layer.cornerRadius = 15
        saveButton.setTitle("Save", for: .normal)
        saveButton.titleLabel?.font = .altone(18, .bold)
        saveButton.setTitleColor(.black, for: .normal)
        saveButton.addTarget(self, action: #selector(saveNamegiver), for: .touchUpInside)
    }
    
    private func createDatePicker() {
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonClick))
        doneBtn.tintColor = .systemOrange
        toolBar.setItems([doneBtn], animated: true)
        dateTextField.date("date", toolbar: toolBar, inputView: datePicker)
        dateTextField.text = formatter(.medium).string(from: datePicker.date)
    }
    
    // MARK: - Helpers
    
    // MARK: Private
    
    private func isEmptyFields() -> Bool {
        if nameTextField.text != "",
           phoneNumberTextField.text != "",
           dateTextField.text != ""
        {
            return false
        }
        return true
    }
    
    private func formatter(_ style: DateFormatter.Style) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = style
        formatter.timeStyle = .none
        return formatter
    }
    
    private func showAllert(_ msg: String) {
        let alert = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    private func clearAllFields() {
        personImage = UIImage(named: "1")!
        nameTextField.text.removeAll()
        phoneNumberTextField.text.removeAll()
        dateTextField.text = formatter(.medium).string(from: Date.now)
    }
    
    // MARK: - Actions
    
    // MARK: Private
    
    @objc private func doneButtonClick() {
        dateTextField.text = formatter(.medium).string(from: datePicker.date)
        endEditing(true)
    }
    
    @objc private func saveNamegiver() {
        personImage = PersonImageStackView.image
        let date = formatter(.medium).date(from: dateTextField.text)!
        if isEmptyFields() == false {
            CoreDataManager.instance.saveNamegiver(namegiver,
                                                   nameTextField.text,
                                                   phoneNumberTextField.text,
                                                   date,
                                                   personImage,
                                                   Int16(Date.now.daysUntil(to: date)))
            clearAllFields()
        } else {
            print("Please fill in all fields!")
        }
    }
}
