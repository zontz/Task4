
import UIKit
import SnapKit

struct Model {
    let id: Int
    var isSelected: Bool
}

class ViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()

    private var items: [Model] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigation()
        setupConstraints()
    }

    private func setupViews() {
        for i in 0...30 {
            items.append(Model(id: i, isSelected: false))
        }
        title = "Task 4"
        view.backgroundColor  = .white
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigation() {
        let btn = UIButton()
        btn.setTitle("Shuffle", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.frame = CGRect(x: 0, y: 0, width: 50, height: 30)
        btn.addTarget(self, action: #selector(buttonDidTap), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn)
        self.navigationItem.setRightBarButton(item1, animated: true)
    }

    private func shuffleCells() {
        items.shuffle()
        tableView.reloadRows(at: items.map { IndexPath(row: $0.id, section: 0 )}, with: .middle)
    }

    @objc
    private func buttonDidTap() {
        shuffleCells()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        if items[indexPath.row].isSelected {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            return
        }
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "\(items[indexPath.row].id)"
        cell.accessoryType = items[indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
}


