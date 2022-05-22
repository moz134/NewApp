# NewApp

News App

First screen is TabBarViewController, it has three 3 tabs

1. With top headlines (Headlines) --- TopHeadlineViewController
        1. Pagination     
        2. Click to expand news
    2. List major countries (Countries)  - CountryListViewController
        1. Two tabs at top 
            1.  Headlines - Country 
                1. Click to detailed news
            2. News channel Lists - Country
                1. News channel list
                2. Click news Channel to get news belongs to that channel - List view
                3. News click to detailed news 
    3. General search (Search) - SearchBarViewController
        1. Pagination news
        2. Click news to detailed one


By default TopHeadlineViewController is loaded for the first time, it shows the displays top news. It supports pagination.

Country Tab - It has two tabs on top with displays country wise news and Channel list of that country

Search Tab: News can be searched. Pagination supported

If there is no data coming in articles array then blank screen will be shown


Endpoints
1. v2/top-headlines
2. v2/everything




