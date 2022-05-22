//
//  CountryListViewController.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import UIKit
import WebKit

class CountryListViewController: UIViewController, TableFlowDelegate, WKUIDelegate, WebServiceDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
   
     
     @IBOutlet var countryListTableView: UITableView?
     @IBOutlet var countryButton: UIButton?
     @IBOutlet var channelListButton: UIButton?
     
     var webService: WebService?
     var countryName: String = "us"
     let dataSouce = TableDataSource()
     var webView: WKWebView?
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    var listCountries: [String] = ["us", "in", "ae", "ar", "at", "au", "be", "bg", "br", "ca", "ch", "cn"]
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        self.webService = WebService(delegate: self)
        let nib1 = UINib.init(nibName: "NewsTableCellTableViewCell", bundle: nil)
        self.countryListTableView?.register(nib1, forCellReuseIdentifier: "NewsTableCellTableViewCell")
        let nib2 = UINib.init(nibName: "NewsChannelTableViewCell", bundle: nil)
        self.countryListTableView?.register(nib2, forCellReuseIdentifier: "NewsChannelTableViewCell")
        self.dataSouce.delegate = self
        self.countryListTableView?.delegate = dataSouce
        self.countryListTableView?.dataSource = dataSouce
        self.dataSouce.isChannelList = false
        self.fetchCountryNews(country: "in")
    }
     
     override func viewWillAppear(_ animated: Bool) {
         self.countryListTableView?.reloadData()
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
    
     
     func tableCellSelectAction(cell: NewsChannelTableViewCell, index: Int, source: String) {
         DispatchQueue.main.async {
             self.setNavigationBar()
         }
         
         let vc = TopHeadlinesViewController.init(nibName: "TopHeadlinesViewController", bundle: nil)
         vc.countryName = self.countryName
         vc.channelName = source
         self.present(vc, animated: true)
//         let webConfiguration = WKWebViewConfiguration()
//                 webView = WKWebView(frame: .zero, configuration: webConfiguration)
//         webView?.uiDelegate = self
//                 view = webView
//
//         let myURL = URL(string: url)
//         let myRequest = URLRequest(url: myURL!)
//         webView?.load(myRequest)
     }
    
    func tableCellSelectAction(cell: NewsTableCellTableViewCell, index: Int, url: String) {
        let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
                view = webView
        
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView?.load(myRequest)
    }
     
    func handlePagination() {
        // Do nothing
    }
    
    @objc
    func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    func selectCountry() {
        picker = UIPickerView.init()
            picker.delegate = self
            picker.dataSource = self
            picker.backgroundColor = UIColor.white
            picker.autoresizingMask = .flexibleWidth
            picker.contentMode = .center
            picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
            self.view.addSubview(picker)
                    
            toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
            toolBar.barStyle = .blackTranslucent
            toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
            self.view.addSubview(toolBar)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.listCountries.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.listCountries[row]
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.picker.resignFirstResponder()
        self.fetchCountryNews(country: self.listCountries[row])
        self.countryButton?.setTitle("Country - \(self.listCountries[row])", for: .normal)
        self.countryName = self.listCountries[row]
    }

     
    func fetchCountryNews(country: String) {
      self.webService?.performFetchTopHeadlinesWithCountry(country: country)
    }
    
    func fetchChannelList() {
        self.webService?.performFetchTopHeadlinesWithCountry(country: self.countryName)
    }
     
     func actionSuccess(data: ListNewsModel) {
         self.dataSouce.topHeadlineModel = []
         if self.dataSouce.isChannelList {
             for item in data.newsDataModel {
                 var flag = true
                 for value in self.dataSouce.topHeadlineModel {
                     if item.sourceName == value.sourceName {
                         flag = false
                         break
                     }
                 }
                 if flag {
                     self.dataSouce.topHeadlineModel.append(item)
                 }

             }
         } else {
             self.dataSouce.topHeadlineModel = data.newsDataModel
         }
         DispatchQueue.main.async {
             self.countryListTableView?.reloadData()
         }
        
     }
     
     @IBAction func countrySelected(_ sender: Any) {
         self.dataSouce.isChannelList = false
         self.countryListTableView?.reloadData()
         selectCountry()
       //  self.fetchCountryNews()
     }
     
     @IBAction func channelsSelected(_ sender: Any) {
         self.dataSouce.isChannelList = true
         self.fetchChannelList()
     }
     
     

}
