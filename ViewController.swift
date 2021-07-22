import UIKit

class ViewController: UIViewController {
    // MARK: - Variables
    var tableViewData  = [[String]]()
    var hiddenSections = Set<Int>()
    
    // Views
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    
    // MARK: - Main methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableViewData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = self.view.frame
    }
    
    // MARK: - Setup Methods
    private func setupTableViewData() {
        tableViewData = [
            ["This is test message..."],
            ["Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentiall unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."],
            ["printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960"]
        ]
    }
    
    fileprivate func setupUI() {
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        
        self.view.addSubview(tableView)
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if hiddenSections.contains(section) {
            return 0
        } else {
            return tableViewData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = tableViewData[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    
    // header of TableView
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
            let sectionButton = UIButton()
            
        // 2
        sectionButton.setTitle(String(section),
                               for: .normal)
        
        // 3
        sectionButton.backgroundColor = .systemOrange
        
        // 4
        sectionButton.tag = section
        
        // 5
        sectionButton.addTarget(self,
                                action: #selector(self.hideSection(_:)),
                                for: .touchUpInside)

        return sectionButton
    }
    
    @objc
    private func hideSection(_ sender: UIButton) {
        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.tableViewData[section].count {
                indexPaths.append(IndexPath(row: row, section: section))
            }
            
            return indexPaths
        }
        
        if self.hiddenSections.contains(section) {
            self.hiddenSections.remove(section)
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.insert(section)
            self.tableView.deleteRows(at: indexPathsForSection(),
                                      with: .fade)
        }
    }
    
    // selecting row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let textValueOfCell = tableViewData[indexPath.section].first!
        
        let height = textValueOfCell.heightWithConstrainedWidth(width: tableView.frame.width, font: UIFont.boldSystemFont(ofSize: 14))
        
        return height
    }
}


extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}
