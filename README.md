# tts-api

TTS API Service

## Azure TTS

Rename `.env.example` to `.env` and fill in `AZURE_SPEECH_KEY`

```bash
docker compose build && docker compose up
```

```python
import requests, base64, json

text = "你好，世界"
voice_name = 'zh-CN-XiaoxiaoNeural'

tmp = requests.post('http://localhost:9000/v1/azure/', data={'text': text, 'voice_name': voice_name})
res = json.loads(tmp.text)

b64_data = res.get('data')
cost = res.get('cost')

file_name = 'result-%.3lfs.wav' % cost
with open(file_name, 'wb') as f:
    f.write(base64.b64decode(b64_data))
```
