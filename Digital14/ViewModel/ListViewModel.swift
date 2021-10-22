//
//  ListViewModel.swift
//  Digital14
//
//  Created by Narendra Goojer on 21/10/21.
//

import Foundation
import Combine

class ListViewModel : SeatGeekServiceProtocol {
    var apiSession: APIServiceProtocol
    
    //@Published var searchText = ""
    private (set) var cellViewModels = [CellViewModel]()
    private (set) var subscriptions = Set<AnyCancellable>()
    
    enum ViewLoadingState {
        case loading
        case success(dataFound: Bool)
        case failure(reason: String)
    }
    
    let reloadTableHandler = PassthroughSubject<ViewLoadingState, Never>()
    var searchText = PassthroughSubject<String, Never>()

    init(apiSession: APIServiceProtocol = APISession()) {
        self.apiSession = apiSession
        
        self.searchText.sink { (text) in
            print(text)
        }.store(in: &subscriptions)
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        cellViewModels.count
    }
    
    func iteamAtIndexPath(indexPath: IndexPath) -> CellViewModel {
        cellViewModels[indexPath.row]
    }
    
    func fetchDataFromServer(string:String) {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        self.reloadTableHandler.send(.loading)
        self.fetchEvents(for: string)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    self.cellViewModels.removeAll()
                    self.reloadTableHandler.send(.failure(reason: error.localizedDescription))
                case .finished:
                    print("Request Finished")
                }
            } receiveValue: { [weak self] (response) in
                guard let self = self else { return }
                self.cellViewModels = response.events.map { CellViewModel.init(element: $0) }
                self.reloadTableHandler.send(.success(dataFound: self.cellViewModels.count > 0))
            }
            .store(in: &subscriptions)
    }
}



