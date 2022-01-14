#!/usr/bin/python
# -*- encoding: utf-8 -*-
# Only for education and learning

import os, sys, time

# example shortlink : https://tinyurl.com/y3rltmq9
try:
    import requests
    from bs4 import BeautifulSoup
except ImportError as e:
    print("Module requests dan bs4 belom di install !!")
    print("Tolong install dahulu sebelum menggunakan tools ini!!")

class checkShortlink:
    def __init__(self, url):
        self.url = 'http://checkshorturl.com/expand.php'
        self.session = requests.Session()
        self.data = {
            'u': url
        }
        try:
            self.req = self.session.post(self.url, data=self.data, allow_redirects=True)
        except:
            print("ERROR: Jalankan ulang ini program!")
            sys.exit(0)
        self.soup = BeautifulSoup(self.req.text, features='html.parser')
        if "Please, provide a valid shortened URL." in self.soup.find_all('p')[4].get_text():
            print("ERROR : Harap berikan URL singkat yang valid.")
            sys.exit(1)
        elif "Houston, we have a problem..." in self.soup.find_all('p')[4].get_text():
            print("ERROR : URL shortlink bermasalah!!")
            sys.exit(1)
        self.author = self.soup.find_all('td')[19].get_text()
        self.longURL = self.soup.find_all('td')[1].find('a').get('href')
        self.shortURL = self.soup.find_all('td')[5].get_text()
        self.delay = self.soup.find_all('td')[3].get_text()
        self.title = self.soup.find_all('td')[13].get_text()
        self.description = self.soup.find_all('td')[15].get_text()
        self.keywords = self.soup.find_all('td')[17].get_text()
        print("Author : {}".format(self.author))
        print("Long URL : {}".format(self.longURL))
        print("Short URL : {}".format(self.shortURL))
        print("Delay : {}".format(self.delay))
        print("Title : {}".format(self.title))
        print("Description : {}".format(self.description))
        print("Keywords : {}".format(self.keywords))
#
web = input(str('Masukan website : '))
if not web.startswith('http'):
    web = 'http://' + web
checkShortlink(web)
