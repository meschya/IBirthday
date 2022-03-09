import UIKit

final class AddInfoNamegiverTableViewCell: UITableViewCell {
    // MARK: - Identifier
    
    static let identifier = "AddInfoNamegiverTableViewCell"
    
    // MARK: - Properties
    
    private let infoView: InfoView = .init()
    
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
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        contentView.addSubview(infoView)
    }
    
    private func addSetups() {
        contentView.backgroundColor = Colors.xLight
        infoView.layer.cornerRadius = 15
        infoView.addShadow()
    }
}
