import Foundation
import Alamofire
import PromiseKit
import AwaitKit
import UIKit

class ApiService{
    static let shared = ApiService()
    
    private let domain = "https://itunes.apple.com"
    
    private enum ApiPath: String {
        case search = "/search"
    }
    
    func getMusicList(query: String) -> Promise<MusicListDTO> {
        let params = ["term":query, "entity": "musicTrack"]
        return Promise { resolver in
            AF.request(buildURL(for: .search, params: params))
                .validate()
                .responseString { (response) in
                    
                    let decoder = JSONDecoder()
                    do {
                        let resultList = try decoder.decode(MusicListDTO.self, from: response.value?.data(using: .utf8) ?? Data())
                        resolver.fulfill(resultList)
                        debugPrint(resultList)
                    }
                    catch(let error){
                        resolver.reject(error)
                        debugPrint(error)
                    }
            }
        }
    }
    private func buildURL(for path: ApiPath, params: [String: String]? = nil) -> URL {
        return buildURL(for: path.rawValue, params: params)
    }
    
    private func buildURL(for path: String, params: [String: String]? = nil) -> URL {
        print("Build url for: \(domain + path).")
        var urlRequest = URLComponents(string: domain + path)
        
        if let params = params {
            urlRequest?.queryItems = []
            params.forEach {
                urlRequest?.queryItems?.append(URLQueryItem(name: $0.key, value: $0.value))
            }
        }
        return urlRequest!.url!
    }
}
