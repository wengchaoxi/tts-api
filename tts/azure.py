# -*- coding: utf-8 -*-

import os
from azure.cognitiveservices.speech import SpeechConfig, SpeechSynthesizer
from azure.cognitiveservices.speech.audio import AudioOutputConfig

class AzureTTS(object):
    def __init__(self):
        speech_key = os.getenv('AZURE_SPEECH_KEY', None)
        if speech_key is None:
            raise ValueError("Require `AZURE_SPEECH_KEY`")
        service_region = os.getenv('AZURE_SPEECH_REGION', "eastasia")
        self.speech_config = SpeechConfig(subscription=speech_key, region=service_region)
        self.audio_config = AudioOutputConfig(use_default_speaker=True)

    def speak_text(self, text, voice_name='zh-CN-XiaoxiaoNeural'):
        self.speech_config.speech_synthesis_voice_name = voice_name
        synthesizer = SpeechSynthesizer(speech_config=self.speech_config, audio_config=self.audio_config)
        speech_synthesis_result = synthesizer.speak_text(text)
        return speech_synthesis_result.audio_data
