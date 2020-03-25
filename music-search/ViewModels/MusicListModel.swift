import Foundation
import UIKit
import AwaitKit
import PromiseKit
import RxSwift
import RxCocoa

class MusicListModel {
    var searchResultList: BehaviorRelay<[MusicItemDTO]> = BehaviorRelay(value: [])
    
    func loadResults(query: String) -> Promise<Void> {
        return async {
            if let resultList = try? await(ApiService.shared.getMusicList(query: query)) {
                self.searchResultList.accept(resultList.items)
            }
        }
    }
}
