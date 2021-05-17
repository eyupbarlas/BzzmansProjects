import selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from time import sleep
import random

# start 
print("                                            ")
print("""
          .-.         .--''-.
        .'   '.     /'       `.
        '.     '. ,'          |
     o    '.o   ,'        _.-'
      \.--./'. /.:. :._:.'
     .'    '._-': ': ': ': ':
    :(#) (#) :  ': ': ': ': ':>-
     ' ____ .'_.:' :' :' :' :'
      '\__/'/ | | :' :' :'
            \  \ \
            '  ' '      


""")

print("**************    TorpilBot    **************")

usernameEntry = input("Email ya da telefon numarası giriniz: ")  # kullanıcı bilgileri
passwordEntry = input("Şifrenizi giriniz: ")

accountName = input("Yorum atılacak hesabın adını giriniz: ") 
commentCountEntry = int(input("Atılacak yorum sayısını giriniz: ")) 

comment = ["Torpil?"]
print("\nKullanıcı girişi yapılıyor.....\n")

browser = webdriver.Firefox()
alertObj = browser.switch_to_alert

browser.get("https://www.instagram.com/")

random_sleep1 = random.uniform(1,4)
random_sleep2 = random.uniform(1,3)
random_sleep3 = random.uniform(1,3)

sleep(random_sleep1)

wait = WebDriverWait(browser, 10)

username = browser.find_element_by_name("username")  
password = browser.find_element_by_name("password")

username.send_keys(usernameEntry)
password.send_keys(passwordEntry)  

# login işlemleri
login = browser.find_element_by_xpath("/html/body/div[1]/section/main/article/div[2]/div[1]/div/form/div/div[3]/button/div")
sleep(random_sleep1)
login.click() 
sleep(random_sleep2)
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[1]/section/main/div/div/div/div/button"))).click() # beni hatırla
sleep(random_sleep3)
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[4]/div/div/div/div[3]/button[2]"))).click() # bildirimleri kapat

# yorum atılacak hesaba gidiş
searchbox = browser.find_element_by_xpath("/html/body/div[1]/section/nav/div[2]/div/div/div[2]/input")
searchbox.send_keys(accountName)
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[1]/section/nav/div[2]/div/div/div[2]/div[3]/div/div[2]/div/div[1]/a/div/div[2]/div[1]/div/div"))).click()
sleep(random_sleep2)

# son posta gidiş
lastPost = browser.find_element_by_xpath("/html/body/div[1]/section/main/div/div[3]/article/div[1]/div/div[1]/div[1]/a/div[1]/div[2]") 
lastPost.click() 
sleep(random_sleep1)

for i in range(0, commentCountEntry):
    # yorum kısmı
    postingComment = browser.find_element_by_xpath("/html/body/div[5]/div[2]/div/article/div[3]/section[3]/div/form/button[2]")
    commentingButton = browser.find_element_by_xpath("/html/body/div[5]/div[2]/div/article/div[3]/section[1]/span[2]/button")
    commentingButton.click() 
    sleep(random_sleep1) 

    commentBar = browser.find_element_by_xpath("/html/body/div[5]/div[2]/div/article/div[3]/section[3]/div/form/textarea")

    commentBar.send_keys(comment) 
    sleep(random_sleep1) 

    postingComment.click() # yorum atıldı   

    print("Yorum sayısı: {}".format(i+1))
    sleep(10)

    i = i+1

print("\nProgram başarılı...\n")

browser.close()
