import UIKit

final class NamegiverStackView: UIStackView {
    // MARK: - Properties

    // MARK: Private

    private let personImageView: UIImageView = .init()
    private let nameAndDateStackView: UIStackView = .init()
    private let nameLabel: UILabel = .init()
    private let dateLabel: UILabel = .init()
    private let dateForBirthdayView: UIView = .init()
    private let dateFBLabel: UILabel = .init()
    private let dateFBImage: UIImageView = .init()
    
    // MARK: - LIfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addPersonImageViewSetups()
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func set(_ image: UIImage, _ name: String, _ date: Date, _ dateForBirthday: String, _ yearsOld: Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        personImageView.image = image
        nameLabel.text = name
        dateLabel.text = dateFormatter.string(from: date) + " • \(yearsOld) Years"
        dateFBLabel.text = dateForBirthday
    }
    
    func hiddenForBirthdayImage() {
        dateFBLabel.isHidden = false
        dateFBImage.isHidden = true
    }
    
    func hiddenForBirthdayLabel() {
        dateFBImage.isHidden = false
        dateFBLabel.isHidden = true
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addConstraints() {
        addPersonImageViewConstraints()
        adddateForBirthdayViewConstraints()
        addDateFBLabelConstraints()
        addDateFBImageConstraints()
    }
    
    private func addPersonImageViewConstraints() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.widthAnchor.constraint(equalToConstant: 55).isActive = true
        personImageView.heightAnchor.constraint(equalToConstant: 55).isActive = true
    }
    
    private func adddateForBirthdayViewConstraints() {
        dateForBirthdayView.translatesAutoresizingMaskIntoConstraints = false
        dateForBirthdayView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
    }
    
    private func addDateFBLabelConstraints() {
        dateFBLabel.translatesAutoresizingMaskIntoConstraints = false
        dateFBLabel.centerXAnchor.constraint(equalTo: dateForBirthdayView.centerXAnchor).isActive = true
        dateFBLabel.centerYAnchor.constraint(equalTo: dateForBirthdayView.centerYAnchor).isActive = true
    }

    private func addDateFBImageConstraints() {
        dateFBImage.translatesAutoresizingMaskIntoConstraints = false
        dateFBImage.centerXAnchor.constraint(equalTo: dateForBirthdayView.centerXAnchor).isActive = true
        dateFBImage.centerYAnchor.constraint(equalTo: dateForBirthdayView.centerYAnchor).isActive = true
        dateFBImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        dateFBImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    // MARK: - Setups

    // MARK: Private

    private func addSubviews() {
        addArrangedSubviews(personImageView, nameAndDateStackView)
        nameAndDateStackView.addArrangedSubviews(nameLabel, dateLabel)
        addArrangedSubview(dateForBirthdayView)
        dateForBirthdayView.addSubviews(dateFBLabel, dateFBImage)
    }

    private func addSetups() {
        addNamegiverStackViewSetups()
        addNameAndDateStackView()
        addNameLabelSetups()
        addDateLabelSetups()
        addDateFBLabelSetups()
        addDateFBImageSetups()
    }

    private func addNamegiverStackViewSetups() {
        axis = .horizontal
        alignment = .center
        distribution = .fillProportionally
        spacing = 10
    }
    
    private func addNameAndDateStackView() {
        nameAndDateStackView.axis = .vertical
        nameAndDateStackView.alignment = .leading
        nameAndDateStackView.distribution = .fill
        nameAndDateStackView.spacing = 5
    }
    
    private func addPersonImageViewSetups() {
        personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        personImageView.clipsToBounds = true
        personImageView.contentMode = .scaleAspectFill
    }
    
    private func addNameLabelSetups() {
        nameLabel.font = .altone(18, .bold)
        nameLabel.textColor = .black
    }
    
    private func addDateLabelSetups() {
        dateLabel.font = .altone(15, .semiBold)
        dateLabel.textColor = .lightGray
        dateLabel.numberOfLines = 2
    }
    
    private func addDateFBLabelSetups() {
        dateFBLabel.font = .altone(20, .semiBold)
        dateFBLabel.textColor = .lightGray
        dateFBLabel.numberOfLines = 2
        dateFBLabel.textAlignment = .center
    }
    
    private func addDateFBImageSetups() {
        dateFBImage.image = UIImage(named: "cake")
    }
}
