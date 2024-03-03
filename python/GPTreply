

##############################################################################################################
###### IMPORTS #############################################################################################
##############################################################################################################
from os.path import exists
import subprocess
import json
import os
from time import sleep
import sys
import requests
from datetime import datetime 
apiKey = ''
gptAddr = 'https://api.openai.com/v1/chat/completions'

##############################################################################################################
###### FUNCTION DEFINITIONS ##################################################################################
##############################################################################################################

def msgCmd(type='inbox', limit='1'):
    result = subprocess.run(['termux-sms-list', '-t', type, '-l', limit],
                            capture_output=True,
                            text=True)
    return result

def msgGet():
    rawData = msgCmd()
    formatData = json.loads(rawData.stdout)
    parsedData = formatData[0]
    msg = {
        'time': parsedData['received'],
        'type': parsedData['type'],
        '_id': parsedData['_id'],
        'number': parsedData['number'],
        #'sender': parsedData['sender'],
        'body': parsedData['body'],
        }
    return msg


def newMsgCheck(time):
    while True:
        print("Waiting for new message...")
        sleep(5)
        msgNew = msgGet()
        timeNew = msgNew['time']
        if timeCompare(timeNew, time):
            return msgNew
            break
        else:
            print("No new messages yet...")

def timeCompare(time, timeNew):
    timeParsed = datetime.strptime(time, '%Y-%m-%d %H:%M:%S')
    timeParsedNew = datetime.strptime(timeNew, '%Y-%m-%d %H:%M:%S')
    if timeParsed > timeParsedNew:
        return True

def gptGet(msg, number):
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f'Bearer {apiKey}',
    }

    data = {
        'model': 'gpt-3.5-turbo',
        'messages': [
            {
                'role': 'system',
                'content': msgSender(number)
            },
            {'role': 'user', 'content': msg}]}

    response = requests.post(gptAddr, headers=headers, json=data)
    return response.json()['choices'][0]['message']['content']
    




def mainLoop(msg, time):
        while True:
                msgNew = newMsgCheck(time)
                time = msgNew['time']
                body = msgNew['body']
                number = msgNew['number']
                msg = msgNew
                reply = gptGet(body, number)
                formattedReply = reply.replace("'", "\\'")
                sendCmd = f"termux-sms-send -n {number} {formattedReply}"
                os.system(sendCmd)

def msgSender(number):
        default = 'You are replying to a text message received from your best friend. Generate an informal response, and always make sure to inlude a funny anecdote or joke'
        girlfriend = ''
        gfPrompt = 'You are replying to a text message received from your girlfriend. Generate an informal response, and always make sure to include how much you love her'
        grandmotherNum = ''
        grandmotherPrompt = 'You are replying to a text message received from your grandmother as her favourite grandson'
        if number == girlfriend:
                print("gf prompt")
                return gfPrompt
        if number == grandmotherNum:
                return grandmotherPrompt
        else:
                print("default prompt")
                return default


"""def customPrompt():
    answer = input("Custom prompt JSON (type yes or no)\n")
    if y in answer:
        filepath = input("Enter filepath where JSON is located\n")
            if exists(filepath):

    if n in answer:
"""
##############################################################################################################
###### MAIN ##################################################################################################
##############################################################################################################



msg = msgGet()
time = msg['time']
mainLoop(msg, time)










