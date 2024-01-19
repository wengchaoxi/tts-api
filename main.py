# -*- coding: utf-8 -*-

import os
import base64
import time
import json

from flask import Flask, request
from dotenv import load_dotenv, find_dotenv
_ = load_dotenv(find_dotenv())
app = Flask(__name__)

from tts import AzureTTS
azure_tts = AzureTTS()
 
def response(data, msg=None, cost_time=None):
    data_dic = {
        'msg': msg,
        'data': data,
        'cost': cost_time
    }
    return json.dumps(data_dic, ensure_ascii=False)

@app.route('/v1/azure/', methods=['GET', 'POST'])
def tts():
    if request.method == "GET":
        return 'Hello, World!'
    
    data = request.form.to_dict()
    text = data.get('text')
    voice_name = data.get('voice_name')
 
    begin = time.time()
    audio_data = azure_tts.speak_text(text, voice_name)
    end = time.time()
    if audio_data is None:
        return response(data=None, msg="error", cost_time=end-begin)
    audio_data_base64 = base64.b64encode(audio_data).decode('utf-8')
    return response(data=audio_data_base64, msg="success", cost_time=end-begin)

if __name__ == "__main__":
    app.run(host=os.getenv("HOST", "0.0.0.0"), port=os.getenv("PORT", 9000))
