import UIKit

final class AddNamegiverTableViewController: UITableViewController {
    // MARK: - Properties
    
    // MARK: Public
    
    static let settings = AddNamegiverTableViewController()
    
    // MARK: - LIfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSetups()
    }
    
    // MARK: - Setups
    
    // MARK: Private
    
    private func addSubviews() {}
    
    private func addSetups() {
        addNCSetups()
        addTableViewSetups()
    }
    
    private func addNCSetups() {
        title = "Add birthday person"
        navigationController?.navigationBar.tintColor = .systemOrange
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    private func addTableViewSetups() {
        tableView.backgroundColor = Colors.xLight
        tableView.separatorStyle = .none
        tableView.alwaysBounceVertical = false
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 1
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 230
        } else if indexPath.section == 1 {
            return 350
        }
        return 210
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.register(AddImageNamegiverTableViewCell.self, forCellReuseIdentifier: AddImageNamegiverTableViewCell.identifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddImageNamegiverTableViewCell.identifier, for: indexPath) as? AddImageNamegiverTableViewCell {
                return cell
            }
        } else if indexPath.section == 1 {
            tableView.register(AddInfoNamegiverTableViewCell.self, forCellReuseIdentifier: AddInfoNamegiverTableViewCell.identifier)
            if let cell = tableView.dequeueReusableCell(withIdentifier: AddInfoNamegiverTableViewCell.identifier, for: indexPath) as? AddInfoNamegiverTableViewCell {
                return cell
            }
        }
        return UITableViewCell()
    }
}
