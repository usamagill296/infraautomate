import requests
import json

APP_URL = "http://127.0.0.1:8000/health"
SLACK_WEBHOOK = "https://hooks.slack.com/your-webhook-here"


def send_slack_alert (message):
    try:
        payload={"text": message}
        requests.post(SLACK_WEBHOOK,json=payload)
        print("Alert sent to Slack")
    except:
           print("Could not send Slack Alert")
           
def check_health ():
    
    try:
        response=requests.get (APP_URL)
        if response.status_code == 200:
            print('healthy')
        else:
            print('failed')
            send_slack_alert("⚠️ infraautomate is failing!")
    except:
        print("App is down")
        send_slack_alert("🚨 infraautomate is completely down!")
check_health()



