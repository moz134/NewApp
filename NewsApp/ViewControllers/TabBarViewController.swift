//
//  TabBarViewController.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import UIKit


enum APIFlow {
    case topHeadline
    case channelLists
    case byCountryNews
    case searchNews
}

class TabBarViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
    }
    
    func setUpUI() {
        let countryTab = UITabBarItem(title: "Country",
                                          image: nil, selectedImage: nil)
        
        let topHeadlinesTab = UITabBarItem(title: "Headlines",
                                          image: nil, selectedImage: nil)
        
        let searchBarTab = UITabBarItem(title: "Search",
                                          image: nil, selectedImage: nil)
        
        
        let topHeadlinesVC = TopHeadlinesViewController()
        topHeadlinesVC.countryName = nil
        topHeadlinesVC.tabBarItem = topHeadlinesTab
        
        let countryVC = CountryListViewController()
        countryVC.tabBarItem = countryTab
        
        let searchVC = SearchBarViewController()
        searchVC.tabBarItem = searchBarTab
        
        self.viewControllers = [topHeadlinesVC, countryVC, searchVC]
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5)
        self.tabBar.backgroundColor = .white
    }


}
