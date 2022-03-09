import UIKit

final class AddImageNamegiverTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "AddImageNamegiverTableViewCell"
    
    // MARK: - Properties
    
    // MARK: Private
    
    private let addPersonImageStackView: PersonImageStackView = .init()
    
    // MARK: - LIfecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addPersonImageStackView.translatesAutoresizingMaskIntoConstraints = false
        addPersonImageStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        addPersonImageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        addPersonImageStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        addPersonImageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        contentView.addSubview(addPersonImageStackView)
    }
    
    private func addSetups() {
        contentView.backgroundColor = Colors.xLight
    }
}
