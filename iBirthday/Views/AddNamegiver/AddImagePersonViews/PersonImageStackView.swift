import UIKit

final class PersonImageStackView: UIStackView {
    // MARK: - Properties
    
    // MARK: Public
    
    static var image: UIImage = .init()
    
    // MARK: Private
    
    private let personImageView: UIImageView = .init()
    private let selectView: UIView = .init()
    private let selectCollectionView: UICollectionView = .init(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    private let layout = UICollectionViewFlowLayout()
    private let massImage = Array(0 ... 19)
    
    // MARK: - LIfecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        addSetups()
        addContraints()
        PersonImageStackView.image = UIImage(named: "1")!
    }

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addPersonImageViewSetups()
    }
    
    // MARK: - Constraints
    
    // MARK: Private
    
    private func addContraints() {
        addPersonImageViewConstraints()
        addSelectViewConstraints()
        addSelectCollectionViewConstraints()
    }
    
    private func addPersonImageViewConstraints() {
        personImageView.translatesAutoresizingMaskIntoConstraints = false
        personImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        personImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addSelectViewConstraints() {
        selectView.translatesAutoresizingMaskIntoConstraints = false
        selectView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        selectView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        selectView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    private func addSelectCollectionViewConstraints() {
        selectCollectionView.translatesAutoresizingMaskIntoConstraints = false
        selectCollectionView.topAnchor.constraint(equalTo: selectView.topAnchor).isActive = true
        selectCollectionView.leadingAnchor.constraint(equalTo: selectView.leadingAnchor).isActive = true
        selectCollectionView.trailingAnchor.constraint(equalTo: selectView.trailingAnchor).isActive = true
        selectCollectionView.bottomAnchor.constraint(equalTo: selectView.bottomAnchor).isActive = true
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {
        addArrangedSubviews(personImageView, selectView)
        selectView.addSubview(selectCollectionView)
    }
    
    private func addSetups() {
        addImageStackViewSetups()
        addSelectCollectionViewSetupsUI()
        selectCollectionViewSetup()
    }
    
    private func addImageStackViewSetups() {
        axis = .vertical
        alignment = .center
        distribution = .fillProportionally
        spacing = 20
    }
    
    private func addPersonImageViewSetups() {
        personImageView.layer.cornerRadius = personImageView.frame.size.width / 2
        personImageView.clipsToBounds = true
        personImageView.contentMode = .scaleAspectFill
        personImageView.image = UIImage(named: "1")
    }
    
    private func addSelectCollectionViewSetupsUI() {
        selectCollectionView.layer.cornerRadius = 15
        selectCollectionView.backgroundColor = .white
        selectCollectionView.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        selectView.backgroundColor = .white
        selectView.layer.cornerRadius = 15
        selectView.addShadow()
    }
    
    private func selectCollectionViewSetup() {
        selectCollectionView.delegate = self
        selectCollectionView.dataSource = self
        selectCollectionView.register(SelectImageCollectionViewCell.self, forCellWithReuseIdentifier: SelectImageCollectionViewCell.identifier)
    }
}

extension PersonImageStackView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return massImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = selectCollectionView.dequeueReusableCell(withReuseIdentifier: SelectImageCollectionViewCell.identifier, for: indexPath) as? SelectImageCollectionViewCell {
            cell.set(String(massImage[indexPath.item]))
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if massImage[indexPath.item] != 0 {
            personImageView.image = UIImage(named: String(massImage[indexPath.item]))
            PersonImageStackView.image = personImageView.image!
        } else {
            print("Add image")
        }
    }
}
