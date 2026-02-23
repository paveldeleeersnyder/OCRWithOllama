# OCR binnen Ollama

Dit is de voorbeeldrepo om gebruik te maken van ollama en lokale modellen voor OCR.

Alle code kan je vinden in de main.py file.  
Om deze code lokaal uit te voeren zal je poppler nodig hebben, het uitvoeren kan met het volgende commando: `python main.py`.

Als alternatief kan je de containerfile gebruiken.  
een simpele `docker build -t ocr-with-ollama . && docker run -d -p 5000:5000 ocr-with-ollama` volstaat hier.

Als je Ollama niet kan aanspreken via localhost:11434 moet je de code lichtjes aanpassen.

```python
ocr = OCRProcessor(model_name='ministral-3:3b')
 |
 v
ocr = OCRProcessor(model_name='ministral-3:3b', base_url="<your-base-url/api/generate>")
```

Ook de dpi kan je aanpassen vanboven in de code, dit is enkel nodig als je een document wilt inlezen met uitzonderlijk kleine letters.  
Het is best om de dpi niet te hoog te leggen, anders zal het enorm lang duren/kostelijk zijn om een document in te scannen.

Deze code zal een webserver aanmaken om aan te spreken, hiernaar kan je op poort 5000 aan de root een post request sturen met een json body die een property url heeft.
