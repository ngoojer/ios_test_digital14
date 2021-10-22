//
//  ViewController.swift
//  Digital14
//
//  Created by Narendra Goojer on 21/10/21.
//

import UIKit
import Combine
import MotionToastView

class ViewController : UIViewController {
    @IBOutlet weak var table: UITableView!
    private var cancellables = Set<AnyCancellable>()
    private lazy var searchController: UISearchController = { UISearchController(searchResultsController: nil)
    }()
    
    lazy var viewModel =  {
        ListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.handleKeyboardFrame()
        self.setupSearchBarListener()
        self.setupSearchController()
        self.bindViewModel()
        self.viewModel.fetchDataFromServer(string: "Texas rang")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.table.reloadData()
    }
    
    private func setupTableView() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Event List"
        self.table.dataSource = self
        self.table.delegate = self
        self.table.rowHeight = UITableView.automaticDimension
    }
    
    private func bindViewModel()  {
        viewModel.reloadTableHandler.sink { [weak self] (state) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch state {
                case .success (let dataFound):
                    self.table.reloadData()
                    if dataFound == false {
                        self.MotionToast(message: ("No record found"), toastType: .warning, toastGravity: .top)
                    }
                case .failure(let reason):
                    print(reason)
                    self.table.reloadData()
                    self.MotionToast(message: (reason), toastType: .error, toastGravity: .top)
                case .loading:
                    print("Loading")
                }
            }
        }.store(in: &cancellables)
    }
}

extension ViewController {
    
    private func setupSearchController(){
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Events"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupSearchBarListener() {
        let publisher = NotificationCenter.default.publisher(for: UISearchTextField.textDidChangeNotification, object: searchController.searchBar.searchTextField)
        
        publisher.map { ($0.object as! UISearchTextField).text }
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .compactMap{ $0 }
            .sink { (str) in
                let text = str.trimmingCharacters(in:.whitespacesAndNewlines)
                guard text.count > 0 else{
                    return
                }
                self.viewModel.fetchDataFromServer(string: text)
            }.store(in: &cancellables)
        
    }
}

extension ViewController: UITableViewDataSource  {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellVM = viewModel.iteamAtIndexPath(indexPath: indexPath)
        let cell: EventCell = tableView.dequeueReusableCell(for: indexPath)
        cell.loadCell(cellVM: cellVM)
        return cell
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailVC = self.storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController else {return}
        let eventVM = viewModel.iteamAtIndexPath(indexPath: indexPath)
        detailVC.viewModel = eventVM
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

extension ViewController {
    func handleKeyboardFrame()  {
        let keyboardWillOpen = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map{$0.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect}
            .map{$0.height}
        
        let keyboardWillHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map{_ in CGFloat(0)}
        
        Publishers.Merge(keyboardWillOpen, keyboardWillHide)
            .subscribe(on: DispatchQueue.main)
            .assign(to: \UIScrollView.contentInset.bottom, on: self.table)
            .store(in: &cancellables)
    }
}
