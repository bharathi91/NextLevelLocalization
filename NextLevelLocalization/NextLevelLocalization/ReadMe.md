This project is just a tutorial for those who like to implement localization both online and offline.

Here i have used a custom JSON object , retrieved from server and store itr internally in a custom bundle.

Look at the helper methods to check how the language change is implemented.

Thanks.


Sample JSON response :

JSON
languages
0
code : "en"
translations
key1 : "It's only after we've lost everything that we're free to do anything."
key2 : "There's no escape. I'm God's lonely man."
key3 : "It's an old habit. I spent my whole life trying not to be careless. Women and children can afford to be careless, but not men."
key4 : "Sometimes I wonder... will God ever forgive us for what we've done to each other? Then I look around and I realize... God left this place a long time ago."
key5 : "Sometimes it's the very people who no one imagines anything of who do the things no one can imagine."
key6 : "Mike McDermott: Listen, here's the thing. If you can't spot the sucker in your first half hour at the table, then you ARE the sucker."
key7 : "Rudy Baylor: What's the difference between a lawyer and a hooker? A hooker'll stop screwing you when you're dead."
key8 : "I was having this awful nightmare that I was 32. And then I woke up and I was 23. So relieved. And then I woke up I was 32."
key9 : "Why do I fall in love with every woman I see who shows me the least bit of attention."
key10 : "He is the silent hero, a watchful protector! The Batman!"
1
code : "ta"
translations
key1 : "எல்லாவற்றையும் இழந்த பின்னரே நாங்கள் எதையும் செய்ய சுதந்திரமாக இருக்கிறோம்."
key2 : "தப்பிக்க முடியாது. நான் கடவுளின் தனிமையான மனிதன்."
key3 : "இது ஒரு பழைய பழக்கம். கவனக்குறைவாக இருக்க முயற்சிக்காமல் என் வாழ்நாள் முழுவதும் கழித்தேன். பெண்கள் மற்றும் குழந்தைகள் கவனக்குறைவாக இருக்க முடியும், ஆனால் ஆண்கள் அல்ல."
key4 : "சில நேரங்களில் நான் ஆச்சரியப்படுகிறேன் ... நாம் ஒருவருக்கொருவர் செய்ததற்கு கடவுள் எப்போதாவது மன்னிப்பாரா? பின்னர் நான் சுற்றிப் பார்க்கிறேன், நான் உணர்கிறேன் ... கடவுள் இந்த இடத்தை வெகு காலத்திற்கு முன்பு விட்டுவிட்டார்."
key5 : "சில நேரங்களில் யாரும் கற்பனை செய்ய முடியாத விஷயங்களை யார் செய்கிறார்கள் என்று யாரும் கற்பனை செய்யாதவர்கள் தான்."
key6 : "மைக் மெக்டெர்மொட்: கேளுங்கள், இங்கே விஷயம். உங்கள் முதல் அரை மணி நேரத்தில் மேஜையில் உறிஞ்சுவதைக் கண்டுபிடிக்க முடியாவிட்டால், நீங்கள் உறிஞ்சுவீர்கள்."
key7 : "ரூடி பேலர்: ஒரு வழக்கறிஞருக்கும் ஹூக்கருக்கும் என்ன வித்தியாசம்? நீங்கள் இறந்தவுடன் ஒரு ஹூக்கர் உங்களை திருகுவதை நிறுத்துவார்."
key8 : "எனக்கு 32 வயதாக இருந்த இந்த மோசமான கனவு எனக்கு இருந்தது. பின்னர் நான் எழுந்தேன், எனக்கு 23 வயதாக இருந்தது. பின்னர் நான் 32 வயதாக இருந்தேன்."
key9 : "நான் கவனிக்கும் ஒவ்வொரு பெண்ணையும் நான் ஏன் காதலிக்கிறேன்?"
key10 : "அவர் அமைதியான ஹீரோ, கவனமாகப் பாதுகாப்பவர்! பேட்மேன்!"
2
code : "hi"
translations
key1 : "यह केवल तब ही है जब हमने वह सब कुछ खो दिया है जो हम कुछ भी करने के लिए स्वतंत्र हैं।"
key2 : "कोई बचने वाला नहीं है। मैं भगवान का अकेला आदमी हूं।"
key3 : "यह एक पुरानी आदत है। मैंने अपना पूरा जीवन लापरवाह न बनने की कोशिश में बिताया। महिलाएं और बच्चे लापरवाह हो सकते हैं, लेकिन पुरुष नहीं।"
key4 : "कभी-कभी मुझे आश्चर्य होता है ... क्या भगवान ने हमें एक-दूसरे के लिए जो कुछ किया है, उसके लिए हमें माफ कर देंगे? फिर मैं चारों ओर देखता हूं और मुझे एहसास होता है ... भगवान ने इस जगह को बहुत पहले छोड़ दिया था।"
key5 : "कभी-कभी यह बहुत ही लोग होते हैं, जो कोई भी ऐसी चीज़ की कल्पना नहीं करता है जो कोई भी करता है जो कोई कल्पना नहीं कर सकता है।"
key6 : "माइक मैकडरमॉट: सुनो, यहां बात है। यदि आप मेज पर अपने पहले आधे घंटे में चूसने वाले को नहीं देख सकते हैं, तो आप चूसने वाले हैं।"
key7 : "रूडी बायलर: एक वकील और एक हूकर के बीच अंतर क्या है? जब आप मर जाते हैं तो एक हुकर आपको रोकना शुरू कर देगा।"
key8 : "मैं इस भयानक दुःस्वप्न में था कि मैं 32 साल का था। और फिर मैं उठा और मैं 23 साल का था। इसलिए मुझे राहत मिली। और फिर मैं जाग गया मैं 32 था।"
key9 : "मुझे हर महिला से प्यार क्यों होता है, मैं देखता हूं कि कौन मुझे सबसे कम ध्यान देता है।"
key10 : "वह मूक नायक, एक चौकस रक्षक है! बैटमेन!"
