//
//  ViewController.swift
//  testAPI
//
//  Created by user on 2021/12/04.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mockResponseData = DataProvider.jsonData(from: "MockSearchPage1")
        
        let repositories: Repositories = try! JSONDecoder().decode(Repositories.self, from: mockResponseData!)
        
        let aaa = repositories.items
        
        // URLSessionConfiguration の設定をする
        let config = URLSessionConfiguration.default

        // URLSession セッションのインスタンスを生成
        let session = URLSession(configuration: config)

        // URLを作成
        let searchValue = "ios"
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.github.com"
        urlComponents.path = "/search/repositories"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "\(searchValue)"),
//            URLQueryItem(name: "order", value: "desc"),
//            URLQueryItem(name: "page", value: "\(currentPage)"),
//            URLQueryItem(name: "per_page", value: "100"),
        ]
        let url = urlComponents.url
        
//        var request = URLRequest(url: url!)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = nil
        

        // GET通信を実行
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
        
//        let task = session.dataTask(with: url!) { data, response, error in
          if let error = error {
            print("###1", error.localizedDescription)
            return
          }

          guard let data = data, let response = response as? HTTPURLResponse else {
            print("###2", "データがありませんでした。")
            return
          }

          if response.statusCode == 200 {
            do {
              let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
              print("###3" , json)
            } catch {
              print("###4" , "不正なデータです")
            }
            // 処理...
          }
        }.resume()
    }


}

