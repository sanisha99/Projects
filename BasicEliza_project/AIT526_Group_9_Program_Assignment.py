#!/usr/bin/env python
# coding: utf-8

# ## AIT 526_ Group 9

# TEAM-9:
#     Student1:Sanisha Kolanu
#     Student2:Namratha Alapati
#     Student3:Bhanu Rekha Bhogaraju

# In[35]:


#section 3 updated with gibberish and bonus code of appending
import re
import random
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from nltk.stem import WordNetLemmatizer

### Part 1: #Dictionary of 
eliza_dict= {
  "pronoun_transformation": {
    "i": "you",
    "me": "you",
    "my": "your",
    "am": "are",
    "was":"were",
    "you":"me",
    "your" : "my",
    "yours": "mine",
    "i'm"  : "you are",
    "i'd"  : "you would",
    "i've" : "you have",
    "i'll" : "you will",
  },
    "transforms":{
        r'you want (.+)': '{name}, why do you want \\1?',
        r'you are (.+)': 'Why are you \\1?',
        r'you are (.+)': 'Why are you \\1?',
        r'you feel (.+)': 'Why do you feel \\1?',
        r'it were (.+)': 'When was it \\1?',
        r'how are (.+)': 'i am doing great!',
        r'you wish (.+)': 'What would it mean to you if \\1?',
        r'me don\'t want (.+)': 'Why don\'t you want \\1?',
        r'do me think (.+)': 'Why do you ask if \\1?',
        r'why can\'t you (.+)': 'What do you think is stopping you from \\1?',
        r'you cant (.+)': 'Why do you think you can\'t \\1?',
        r'you couldn\'t (.+)': 'Why do you think you couldn\'t \\1?',
        r'can you (.+)': 'Why do you want me to \\1?',
        r'why are (.+)': 'What makes you think \\1?',
        r'you are afraid (.+)': 'Can you tell me more about this fear of \\1?',
        r'you crave (.+)': 'What do you think is causing this craving for \\1?',
        r'life is (.+)': 'What makes you say that life is \\1?',
    },
  "feelings": [
    {
      "question": "happy",
      "answer": [
        "It's great to hear that you're feeling happy. What's making you feel this way?",
        "What has brought this happiness into your life recently?",
        "Feeling happy is wonderful. Would you like to share more?"
      ]
    },
    {
      "question": "sad",
      "answer": [
        "I'm sorry to hear that you're feeling sad. What happened?",
        "It sounds tough. Do you want to talk more about why you're feeling this way?",
        "Being sad can be hard. I'm here for you."
      ]
    },
    {
      "question": "angry",
      "answer": [
        "What has made you feel angry?",
        "It sounds like something has upset you. Would you like to discuss it?",
        "Anger can be tough to manage. Let's talk about what's on your mind."
      ]
    },
    {
      "question": "anxiety anxious",
      "answer": [
        "Anxiety can be overwhelming. What's causing you to feel this way?",
        "Would you like to talk about what's making you anxious?",
        "It sounds like you're going through a tough time. I'm here to listen."
      ]
    },
    {
      "question": "depressed",
      "answer": [
        "I'm sorry you're feeling this way. Let's talk about it.",
        "Depression can be really hard. I'm here to help.",
        "You don't have to go through this alone. Tell me more."
      ]
    },
    
    {
      "question": "family",
      "answer": [
        "Tell me more about your family.",
        "How do you feel about your family?",
        "Family dynamics can be complex. Would you like to share more?"
      ]
    },
    {
      "question": "work",
      "answer": [
        "What's happening at your workplace?",
        "How do you feel about your job?",
        "Work can be both rewarding and challenging. Tell me more about your experiences."
      ]
    },
    {
      "question": "lonely",
      "answer": [
        "It sounds like you're feeling isolated. Want to talk about it?",
        "Loneliness can be tough. I'm here to listen.",
        "Why do you think you're feeling lonely?"
      ]
    },
    {
      "question": "stressed",
      "answer": [
        "Stress can be hard to manage. What's causing you to feel stressed?",
        "Let's talk about what's causing you this stress.",
        "Is there anything specific that's been bothering you lately?"
      ]
    },
    {
      "question": "relationships",
      "answer": [
        "Tell me more about your relationships.",
        "How do you feel about your current relationships?",
        "Relationships can be complicated. Is there something specific on your mind?"
      ]
    },
    {
      "question": "trust",
      "answer": [
        "Has something happened that's affecting your ability to trust?",
        "Trust is a foundational element of any relationship. Let's talk about it.",
        "Why do you think you're having trust issues?"
      ]
    },
    {
      "question": "death",
      "answer": [
        "It sounds like you're feeling distressed regarding the death. Can you tell me more about that?",
        "Feeling lost can be challenging. I'm here to help you navigate out of it.",
        "What do you think about the death of you near and dear!"
      ]
    },
    {
      "question": "lost",
      "answer": [
        "It sounds like you're feeling directionless. Can you tell me more about that?",
        "Feeling lost can be challenging. I'm here to help you navigate.",
        "What do you think led to this feeling?"
      ]
    }, 
    {
      "question": "advice",
      "answer": [
        "Have you considered any Potential Solution or Strategy? It could be helpful.",
        "Many find it helpful to Meditate and yoga everyday. It might be worth a try in your situation.",
        "It's always essential to prioritize your well-being. Perhaps, General Well-being could be beneficial for you."
      ]
    },
    {
      "question": "I'm overwhelmed",
      "answer": [
        "It sounds tough. What's causing you to feel overwhelmed?",
        "Let's break things down and discuss what's on your mind.",
        "Overwhelm can be paralyzing. I'm here to help you work through it."
      ]
    },
    {
      "question": "you need help",
      "answer": [
        "I'm here to help. Tell me what's going on.",
        "Reaching out is the first step. Let's talk.",
        "It's brave of you to acknowledge when you need assistance. Share with me your feelings."
      ]
    },
     {
      "question": "not ok",
      "answer": "Oh That's hard !! Can you describe more about how you feel"
    }, 
    {
        "question" : "not feeling",
        "answer" : "What is the reason for it?"
    },
    {
        "question":"your sleep",
         "answer": [
            "Have you been facing any trouble sleeping.?",
            "Do you sleep too much, yet you are always tired.",
            "Is it been on and off.",
            "DO you have nightmares frequently?."
        ]
          
    },
    {
      "question": "know",
      "answer":[ 
        "Can you give me more info regarding that?",
       "What do you think you might feel uncertain about? Can you explain more?"
     ]
    },
    {
      "question": "See you in next session",
      "answer": "See you then!:) Take care!"
    },
    
    {
      "question": "Say something funny",
      "answer": "Why did the scarecrow win an award? \n Because he was outstanding in his field! 😄"
    },
    {
      "question": "tell me more",
      "answer": "I don't want to preach you anything unless you open up more about your situation"
    },
    {
      "question": "ok",
      "answer": "ok!"
    },
    {
      "question": "yes",
      "answer": "Oh that's great! Can you talk more?"
    },
    {
      "question": "hi",
      "answer": "hey there!"
    },
    {
      "question": "hello",
      "answer": "hey there! :)"
    },
    {
      "question": "great talk",
      "answer": "I am happy to help you anytime! :)"
    },
    {
      "question": "thankyou",
      "answer": [
        "You're welcome! I'm here to help.",
        "It's my pleasure. If you have more questions or concerns, feel free to share.",
        "Always here to support you. Don't hesitate to reach out if you need to talk."
      ]
    },
    {
      "question": "climate",
      "answer": "Its cold outside "
    },
    {
        "question": "mother",
        "answer": [
            "Can you share your beautiful moments with your mother",
            "Do you see your self in your mother?"
        ]
    },
    {
        "question": "father",
        "answer": [
            "Do you like your father?",
            "I would like to know more about your father",
            "what is your favorite moment with your father?"
        ]
    },
    {
        "question": "sister",
        "answer" : [
            "Is your sister elder than you?",
            "Do you like spending time with your sister?"
        ]
    },
    {
        "question" : "problem ",
        "answer" : "I can try to give a solution for this problem!"
    },
    {
        "question" : "sick",
        "answer" : "You can be cured easily, Donot worry!"
    },
    {
        "question" : "food",
        "answer" : [
            "What is your favourite food?",
            "Why do you like that food?"
        ]  
    },
    {
        "question" : "Dreams",
        "answer" : [
            "I would like to know more about your dream! Can you tell me more ?",
            "Yor dream is very surprising to me!, lets me make some points out of it.Can you tell me more ?",
            "Dreams can be very disturbing or can make you feel very happy as well!Can you tell me more ?"
        ]
    },
    {
        "question" : "die",
        "answer" : [
            "Dying is not a solution to anything in this universe!,Please be calm! Can you tell me why do you feel so?",
            "I will help you out from not thinking in this way, please be patient with me.Can you tell me more ?"
        ]
    },
    {
        "question" : "suicide",
        "answer" : [
            "Suicide is not a solution to anything in this universe!, Do you agree?",
            "What makes you think to suicide ?"
        ]
    },
    {
        "question" : "age",
        "answer" : [
            "My age is: You should ask my creator Sam, Nam, BB!",
            "I'm a computer program, Seriously you are asking me this?"
        ]
    },
    {
        "question" : "unstable",
        "answer" : [
            "Can you tell me more about why you feel unstable?"
            
        ]  
    },
    {
        "question" : "psycho",
        "answer" : "The situations might have made you feel like this! When or in what situation do you feel like this?"
    },
    {
        "question" : "alcohol",
        "answer" : "Alcohol,drugs or smoking are injurious to health, you have to keep in mind about your health, Please tell me more so that I can help you reducing it"
    },
    {
        "question" : "sorry",
        "answer" : [
            "Its alright",
            "Its OK, never mind"
        ]
    },
    {
        "question" : "upset",
        "answer" : "Why are you upset?"
    },
    {
        "question" : "tense",
        "answer" : "Do not feel tensed, it only makes you more helpless!,you can try doing Yoga for sometime! Do you want more help?"
    }
  ]
}

### Part 2:
#function to generate response for not meaningful sentences like hshg,nhgs considered as gibberish:

def is_gibberish(tokenized_input):
    meaningful_words = set(stopwords.words('english')).union(set(eliza_dict["pronoun_transformation"].keys()))
    for i in eliza_dict["feelings"]:
        meaningful_words.add(word for word in i["question"].lower())
    return all(word not in meaningful_words for word in tokenized_input)

#function to generate response for transform pattern statements:

def reply_sentence(user_input, name):
    for pattern, response in eliza_dict["transforms"].items():
        if re.search(pattern, user_input):
            return re.sub(pattern, response.format(name=name), user_input)
    return None

#function to find keywords and generate response:

def word_categorization(question_tokens,dictionary_eliza,name,input_text):
    for i in dictionary_eliza["feelings"]:
        question_words = word_tokenize(i["question"].lower())
        if any(token in question_words for token in question_tokens):
            answer = random.choice(i["answer"]) if isinstance(i["answer"], list) else i["answer"]
            return answer
    return None

    
def eliza():
    print("[eliza] Hi, I'm a psychotherapist. What's your name?")
    name = input("=> [user] ").split()[-1].strip('.')

    print(f"-> [eliza] Hi {name}. How can I help you today? ")
    while True:
        input_text = input(f"=> [{name}] ").strip().lower()

        # Exit condition
        if input_text.lower() in ['quit','exit', 'bye', 'goodbye',]:
            print(f"-> [eliza] Goodbye, {name}. Take care!")
            break

### Part 3:
        # Processing the user's input
        input_text = input_text.replace("i'm", "i am")
        tokenized_input = word_tokenize(input_text)
        
        
        # Pronoun transformation
        Pronoun_transformed_input = [eliza_dict["pronoun_transformation"].get(word, word) for word in tokenized_input]
        
        #Removing stop words
        transformed_input = [token for token in Pronoun_transformed_input if token not in stopwords.words('english')]
        
        # Lemmatize the words
        lemmatizer = WordNetLemmatizer()
        transformed_input = [lemmatizer.lemmatize(word) for word in transformed_input]

        reply= word_categorization(transformed_input,eliza_dict,name,input_text) 
        
        if reply:
            print(f'->[eliza] {reply}')
        else :
            transformed_reply = reply_sentence(' '.join(Pronoun_transformed_input), name)
            if transformed_reply:
                print(f'->[eliza] {transformed_reply}')
            else:
                # Check for gibberish
                if is_gibberish(tokenized_input):
                    print(f"->[eliza] Its gibberish!! I quite don't understand. Can you rephrase or type something meaningfull ?")
                    continue
                else:
                    #save unknown statements & reply's for future response generation to same statements
                    print(f'->[eliza-> saving unknown info] I would like to know more about it. Can you tell me?')
                    user_answer = input(f'[{name}] Type the answer or skip: ')
                    if user_answer.lower() != 'skip':
                        eliza_dict["feelings"].append({"question": input_text, "answer": user_answer})
                        print(f'->[eliza] Thank you! I have got the information.Please Explain more about your concern regarding it')

        
        
        
if __name__ == '__main__':
    eliza()


# ### Comments:

# We have added hashtags in the code itself for better understanding of what we have coded by viewers.

# ### Part 1:

# Here we have created a dictionary for Eliza. where it contains three parts in it they are Pronoun_transformation, Transformers, Feelings. In the Pronoun_transformation part we have included words that help in converting the input of user to the output of the robot for example 'I' becomes 'you' etc. Next, is the transformers where we have included the key concepts it changes to questions or conversation to reply back us(Regular Expressions). Then in the final part feelings we have included most of the keywords and common answers to those questions.

# ### Part 2:

# In this part we have written the code for eliza to analyze if the input is gibberish, then we have written code to analyze the transforms pattern statements to understand and return the response. Then, we have given code to find the Keywords(word spotting) from the input to understand the information and give reply back accordingly. At, last in this part we have included the exit words for the user that they can give as an input to exit from the conversation.

# ### Part 3:

# In this part we are processing the users input, performing pronoun transformation, removing stop words and lemmatizing the words. Here we have also included a bonus function if we give an input and that is unknown by eliza then it asks to " I would like to know more about it. Can you tell me?" then we can give an answer or skip. If answer is given it will store for further conversation in that session.

# ### Example:

# For example, if a user says, "I feel sad," ELIZA would recognize the word "sad" and could reply in a manner that acknowledges the user's emotional state like

# => [user] i feel sad 

# ->[eliza] Being sad can be hard. I'm here for you. 

# For example, if a user says, "I have a problem," ELIZA would recognize the word "problem" and could reply in a manner that acknowledges the user's statement like: 

# => [user] I have a problem 

# ->[eliza] I can try to give a solution for this problem! 

# To reflect back statements as questions, the program includes tranforms in eliza_dict to encourage the user to dive deeper into their own thoughts and feelings, simulating a therapeutic conversation.

# For example:if a user says, "i am afraid that {any_sentence}" 

# => [user] i am afraid that my life is full of mess 

# ->[eliza] Why are you afraid that your life is full of mess? 

# => [user] i am a negative thinker 

# ->[eliza] Why are you a negative thinker?

# ### Keywords:

# Some of the Key words that we have used to build a conversation are: happy, sad, depressed, sick, dreams, food,mother, father, sister, sad, angry, sleep, adivce, lost,etc,.
