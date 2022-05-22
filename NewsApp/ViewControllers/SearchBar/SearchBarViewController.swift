//
//  SearchBarViewController.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import UIKit
import WebKit

class SearchBarViewController: UIViewController, UISearchBarDelegate, TableFlowDelegate, WebServiceDelegate, WKUIDelegate

{
                                
    
    @IBOutlet var searchNewsTableView: UITableView?
    @IBOutlet var searchBar: UISearchBar!
    
    
    var webService: WebService?
    let dataSouce = TableDataSource()
    var webView: WKWebView?
    private var searchNewsModel: [NewsDataModel] = []
    private var pageIndex: Int = 1
     
     override func viewDidLoad() {
        super.viewDidLoad()
       //  setNavigationBar()
         self.navigationController?.isToolbarHidden = true
         searchBar?.delegate = self
         searchBar?.placeholder = "Search new"
         self.webService = WebService(delegate: self)
         let nib1 = UINib.init(nibName: "NewsTableCellTableViewCell", bundle: nil)
         self.searchNewsTableView?.register(nib1, forCellReuseIdentifier: "NewsTableCellTableViewCell")
        
         self.dataSouce.delegate = self
         self.searchNewsTableView?.delegate = dataSouce
         self.searchNewsTableView?.dataSource = dataSouce
         self.dataSouce.isChannelList = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
     //   setNavigationBar()
        super.viewWillAppear(animated)
    }
    
    
    func handlePagination() {
        apiCall(searchText: searchBar.text ?? "")
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.pageIndex = 1
        searchBar.resignFirstResponder()
        if !(searchBar.text?.isEmpty ?? true) {
            self.apiCall(searchText: searchBar.text ?? "")
        }
    }
    
    func apiCall(searchText: String) {
        self.webService?.performSearchNews(searchText: searchText, pageIndex: self.pageIndex)
    }
    
    func tableCellSelectAction(cell: NewsTableCellTableViewCell, index: Int, url: String) {
        DispatchQueue.main.async {
            self.setNavigationBar()
        }
        let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
                view = webView
        webView?.allowsBackForwardNavigationGestures = true
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
    }
    
    func actionSuccess(data: ListNewsModel) {
        pageIndex += 1
        self.dataSouce.topHeadlineModel = []
        self.searchNewsModel.append(contentsOf: data.newsDataModel)
        self.dataSouce.topHeadlineModel = self.searchNewsModel
        DispatchQueue.main.async {
            self.searchNewsTableView?.reloadData()
        }
       
    }
    

}
