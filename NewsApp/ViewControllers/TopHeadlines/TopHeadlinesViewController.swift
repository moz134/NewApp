//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import UIKit
import WebKit

class TopHeadlinesViewController: UIViewController, WebServiceDelegate, WKUIDelegate, TableFlowDelegate, WKNavigationDelegate {
    
    
    @IBOutlet var topHeadlinesTableView: UITableView?
    var topHeadlineModel: [NewsDataModel] = []
    var webView: WKWebView?
    var countryName: String?
    var channelName: String?
    let dataSouce = TableDataSource()
    var webService: WebService?
    
    var pageIndex: Int = 1
    
    var apiCall: APIFlow = .topHeadline
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.webService = WebService(delegate: self)
        let nib = UINib.init(nibName: "NewsTableCellTableViewCell", bundle: nil)
        self.topHeadlinesTableView?.register(nib, forCellReuseIdentifier: "NewsTableCellTableViewCell")
        self.dataSouce.delegate = self
        self.topHeadlinesTableView?.delegate = dataSouce
        self.topHeadlinesTableView?.dataSource = dataSouce
        self.dataSouce.isChannelList = false
        self.callAPI()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.topHeadlinesTableView?.reloadData()
        setNavigationBar()
        super.viewWillAppear(true)
    }
    
    func setNavigationBar() {
        
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 44))
        view.addSubview(navBar)
        
        navBar.backItem?.hidesBackButton = false
        
        navBar.backItem?.title = "Back"

        if #available(iOS 13.0, *) {
                  navigationController?.navigationBar.setNeedsLayout()
             }
        
    }
    
    @objc
    func backButtonClick() {
        // goes back
    }
    
    func tableCellSelectAction(cell: NewsTableCellTableViewCell, index: Int, url: String) {
        DispatchQueue.main.async {
            self.setNavigationBar()
            let backButton = UIBarButtonItem (title: "Back", style: .plain, target: self, action: #selector(self.backButtonClick))
            backButton.tintColor = .gray
            self.navigationItem.leftBarButtonItem = backButton
        }
        
        webView?.navigationDelegate = self
        let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
                view = webView
                
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
    }
    
    
    func handlePagination() {
        callAPI()
    }
    
  
    func callAPI() {
        if let channel = self.channelName {
            self.apiCall = .channelLists
            self.webService?.performFetchByChannels(sources: channel)
        } else if let country = self.countryName {
            self.apiCall = .byCountryNews
            self.webService?.performFetchTopHeadlinesWithCountry(country: country)
        } else {
            self.apiCall = .topHeadline
            self.webService?.performFetchTopHeadlines(pageIndex: self.pageIndex)
        }
    }

    
    func actionSuccess(data: ListNewsModel) {
        self.dataSouce.topHeadlineModel = []
        switch self.apiCall {
        case .topHeadline:
            pageIndex += 1
            self.topHeadlineModel.append(contentsOf: data.newsDataModel)
            self.dataSouce.topHeadlineModel = self.topHeadlineModel
        case .channelLists:
            self.dataSouce.topHeadlineModel = data.newsDataModel
        case .byCountryNews:
            self.dataSouce.topHeadlineModel = data.newsDataModel
        default:
            print("default")
        }
        DispatchQueue.main.async {
            self.topHeadlinesTableView?.reloadData()
        }
       
    }
    
    func actionFailed(error: NewsErrorModel) {
        //
    }
    
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
