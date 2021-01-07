import selenium
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from time import sleep
import random
from random import choice


# randomizing sleeptime
random_sleep1 = random.uniform(1,7)
random_sleep2 = random.uniform(1,6)
random_sleep3 = random.uniform(1,4)

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
            '  ' '      The Bzzman.


""")
print("**************   Welcome To The Bzzman's Comment Machine(Beta v0.9)  ******************")
print("""
    This is a draw winning bot made by Bzzman. This is a beta version.
    Fixed bugs(Beta v0.9):
        * Scrolls through the 'Following' pop up page.
        * UI improved. Taking information from user.
        * Commenting system is completed.
    Remaining bugs(Beta v0.9):
        * Cancels the 'Unfollow' pop up window. Only part left is following accounts.
        * Keep checking comment blocks and note them.
    To do(Beta v0.9):
        * Following system.
        * Reducing the time waits inside comment loop

    Bzzman. The protector of worlds.
""")

usernameEntry = input("Enter email or phone number: ")  # specifying credentials
passwordEntry = input("Enter your password: ")

accountName = input("Please enter the account name to search: ")
commentCountEntry = int(input("Please enter the number of comments: "))
commentCountToRandomize = int(input("Please enter the number of comments to randomize: "))

comments = []
for i in range(0,commentCountToRandomize):
    comment = input("Enter comment {}: ".format(i+1))
    comments.append(comment)
    i = i+1
print(comments)
print("\n")
print("Wait for the credential entry.....")
print("\n") 

browser = webdriver.Firefox()
alertObj = browser.switch_to_alert

browser.get("https://www.instagram.com/")  # going to the web page with firefox

sleep(random_sleep1)

wait = WebDriverWait(browser, 10)

username = browser.find_element_by_name("username")  
password = browser.find_element_by_name("password")

username.send_keys(usernameEntry)
password.send_keys(passwordEntry)  # sending credential info


login = browser.find_element_by_xpath("/html/body/div[1]/section/main/article/div[2]/div[1]/div/form/div/div[3]/button/div")
sleep(random_sleep1)
login.click()  # login the homepage
sleep(random_sleep2)
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[1]/section/main/div/div/div/div/button"))).click()    #dont save info
sleep(random_sleep3)
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[4]/div/div/div/div[3]/button[2]"))).click() # don't open notifications

sleep(random_sleep1)

# now we will search the name of the user
searchbox = browser.find_element_by_xpath("/html/body/div[1]/section/nav/div[2]/div/div/div[2]/input")
searchbox.send_keys(accountName)
# now we will go to the account's main page
WebDriverWait(browser, 10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[1]/section/nav/div[2]/div/div/div[2]/div[3]/div[2]/div/a[1]/div/div[2]/div/span"))).click()
sleep(random_sleep2)

# scrolling 5 times in user page.
fBody = browser.find_element_by_xpath("/html")
scroll = 0
while scroll < 0.01: # scroll 0.01 times
    browser.execute_script('arguments[0].scrollTop = arguments[0].scrollTop + arguments[0].offsetHeight;',fBody)
    sleep(random_sleep1)
    scroll += 1
fList = browser.find_elements_by_xpath("/html//li")
print("fList len is {}".format(len(fList)))
print("ended")

lastPost = browser.find_element_by_xpath("/html/body/div[1]/section/main/div/div[3]/article/div/div/div[1]/div[1]/a/div/div[2]") 
lastPost.click() # last post clicked
sleep(random_sleep1)

likePost = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[1]/span[1]/button")
likePost.click() # last post liked
sleep(random_sleep1)

savePost = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[1]/span[3]/div/div/button")
savePost.click() # saving the post
sleep(random_sleep2)
"""
for i in range(0,commentCountEntry): 
    random_sleep4 = random.uniform(10,15)
    random_sleep5 = random.uniform(1,3)
    random_sleep6 = random.uniform(35,40)
    if (i%5 == 0) and (i>0):
        print("5 post delay: {}".format(random_sleep6))
        sleep(random_sleep6)
        
    else:
        commentingButton = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[1]/span[2]/button")
        commentingButton.click() # going for commenting
        sleep(random_sleep5)  
    
        commentBar = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/textarea")
        commentBar.send_keys(choice(comments))  
        sleep(random_sleep5) 

        postingComment = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/button")
        postingComment.click() # posting comment
        sleep(random_sleep4)
        
        
        # /html/body/div[3]/div/div/div/p  --> çıkan yazının xpathi
        # /html/body/div[3]/div/div/button
        # if WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).is_displayed():
        #     WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).click()
        #     sleep(random_sleep6) # development phase test
     

    i = i+1
"""
#todo  ---> retry button problem
# /html/body/div[3]

    #retryElement = browser.find_element_by_xpath("/html/body/div[3]/div/div/button")
for i in range(0,commentCountEntry): 
    random_sleep4 = random.uniform(10,15)
    random_sleep5 = random.uniform(1,3)
    random_sleep6 = random.uniform(50,60)
    random_sleep7 = random.uniform(35,45)
    if i>0:
        if i%5 == 0:
            print("5 post delay: {}".format(random_sleep7))
            sleep(random_sleep6)
        elif i%19 == 0:
            print("19 post delay: {}".format(random_sleep6))
        
        
    postingComment = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/button")
    commentingButton = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[1]/span[2]/button")
    commentingButton.click() # going for commenting
    sleep(random_sleep5)  
    
    commentBar = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/textarea")
        #if not commentBar.is_enabled: #todo--> burada entry girilemeyen classı belirtelim
        # if commentBar.get_attribute("Ypffh focus-visible").is_enabled():
        #     print(":)")
        #     postingComment.click()
        #     print("Comment Count: {}".format(i+1))
        #     sleep(random_sleep6)
        # else:
    commentBar.send_keys(choice(comments))  #todo --> when box is full, cant select the comments button
    sleep(random_sleep5) 

    postingComment.click() # posting comment 

            # commentingButton = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[1]/span[2]/button")
            # postingComment = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/button")
            # commentBar = browser.find_element_by_xpath("/html/body/div[4]/div[2]/div/article/div[3]/section[3]/div/form/textarea")
            
            # if not(commentBar.is_enabled()):
            #     postingComment.click()
            #     print("Comment Count: {}".format(i+1))
            #     sleep(random_sleep4)
            
            # else:
            #     commentingButton.click() # going for commenting
            #     sleep(random_sleep5)  
            
            #     commentBar.send_keys(choice(comments))  #todo --> when box is full, cant select the comments button
            #     sleep(random_sleep5) 

            #     postingComment.click() # posting comment
            #todo --> 15. post sonrası yeniden click yap // retry sonrasında sadece post tuşuna bas
            # if (i%15 == 0) and (i>0):
            #     print("15 post delay: {}".format(random_sleep6))
            #     sleep(random_sleep6)    
    print("Comment Count: {}".format(i+1))
    sleep(random_sleep4)

    # try:
    #     retryElement = browser.find_element_by_class_name("Ypffh focus-visible")
    #     if retryElement.is_displayed():
    #                 # retryElement.click() # this will click the element if it is there
    #         print(":)")
    #         sleep(random_sleep6)
    # except selenium.common.exceptions.ElementNotInteractableException:
    #     print(":(")

    i = i+1

    # if WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).is_enabled():
    #     WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).click()
    #     print(":)")
    #     sleep(random_sleep6)
    
        
        # /html/body/div[3]/div/div/div/p  --> çıkan yazının xpathi
        # /html/body/div[3]/div/div/button
        # if WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).is_displayed():
        #     WebDriverWait(browser,10).until(EC.element_to_be_clickable((By.XPATH, "/html/body/div[3]/div/div/button"))).click()
        #     sleep(random_sleep6) # development phase test
    # if browser.find_element_by_xpath("/html/body/div[3]/div/div/button").is_enabled():
    #     print(":)")
    #     browser.find_element_by_xpath("/html/body/div[3]/div/div/button").click()
    #     sleep(random_sleep6)
    # .HGN2m > button:nth-child(2) --> css 

    
print("Commenting successful...")
print("\n")
print("A Bzzman production.")

browser.close
