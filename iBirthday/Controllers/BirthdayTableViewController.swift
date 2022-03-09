import CoreData
import UIKit

final class BirthdayTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    // MARK: - Properties

    // MARK: Private

    private var namegivers: [Namegiver] = []
    private var fetchResultController: NSFetchedResultsController<Namegiver>!

    // MARK: - LIfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        addSetups()
        coreDataSetups()
    }

    // MARK: - CoreData

    private func coreDataSetups() {
        let fetchRequest: NSFetchRequest<Namegiver> = Namegiver.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "dayForBirthday", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil)
            fetchResultController.delegate = self
            do {
                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    namegivers = fetchedObjects
                    for namegiver in namegivers {
                        let date = Int16(Date.now.daysUntil(to: namegiver.date!))
                        namegiver.setValue(date, forKey: "dayForBirthday")
                    }
                }
            } catch {
                print(error)
            }
        }
    }

    // MARK: - Setups

    // MARK: Private

    private func addSetups() {
        addNavBarSetups()
        addTableViewSetups()
    }

    private func addNavBarSetups() {
        title = "Birthday Reminder"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(showAddNameGiver))
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .trash, target: self,
            action: nil)
        navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        navigationItem.leftBarButtonItem?.tintColor = .systemRed
    }

    private func addTableViewSetups() {
        tableView.backgroundColor = Colors.xLight
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.register(NamegiverTableViewCell.self, forCellReuseIdentifier: NamegiverTableViewCell.identifier)
    }

    // MARK: - Actions

    // MARK: Private

    @objc private func showAddNameGiver() {
        let addNamegiverVC = AddNamegiverTableViewController()
        navigationController?.pushViewController(addNamegiverVC, animated: true)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namegivers.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: NamegiverTableViewCell.identifier, for: indexPath) as? NamegiverTableViewCell {
            let image = UIImage(named: "1")
            let imagedata = image?.pngData()
            let namegiver = namegivers[indexPath.row]
            cell.set(UIImage(data: namegiver.image ?? imagedata! as Data)!,
                     namegiver.name!,
                     namegiver.date!,
                     "\(namegiver.dayForBirthday)\nDays",
                     namegiver.date!.years())
            return cell
        }
        return UITableViewCell()
    }

    // MARK: Fetch request methods

    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            namegivers = fetchedObjects as! [Namegiver]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: Add Delete button to TableView

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard let appDelegate = (UIApplication.shared.delegate as? AppDelegate) else { return }
        let context = appDelegate.persistentContainer.viewContext
        let movieDelete = fetchResultController.object(at: indexPath)
        if editingStyle == .delete {
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            context.delete(movieDelete)
            appDelegate.saveContext()
            tableView.endUpdates()
        }
    }
}
