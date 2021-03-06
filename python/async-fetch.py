# need to 'pip install grequests'
import grequests
from html.parser import HTMLParser

class FetchTitleTag(HTMLParser):
    def __init__(self):
        HTMLParser.__init__(self)
        self.inTitle = False
    def handle_starttag(self, tag, attrs):
        if tag == 'title':
            self.inTitle = True
    def handle_endtag(self, tag):
        if tag == 'title':
            self.inTitle = False
    def handle_data(self, data):
        if self.inTitle:
            print('title: "%s"' % data.strip())

urls = [
    'https://google.com',
    'https://github.com'
]

# version using grequests (https://github.com/kennethreitz/grequests)
# same api as requests, mostly (https://docs.python-requests.org/en/master/)
requests_unsent = (grequests.get(u) for u in urls)
# like map, but returns generator
requests_iterable = grequests.imap(requests_unsent)

parser = FetchTitleTag()

# this is done synchronously -- can also potentially do on a queue
for response in requests_iterable:
    parser.feed(response.text)
    # prints text of the response (just an html page)
    # print(response.text)
    # prints the status code of the response (should be 200)
    print(response.status_code)

# can also potentially do this with asyncio/aiohttp, but more annoying to set up
