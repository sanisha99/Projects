#!/usr/bin/env python
# coding: utf-8

# In[1]:


import numpy as np # linear algebra
import pandas as pd # data processing, CSV file I/O (e.g. pd.read_csv)
import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import os
for dirname, _, filenames in os.walk('/Users/sanishareddy/Downloads/Airline Dataset.csv'):
    for filename in filenames:
        print(os.path.join(dirname, filename))


# In[2]:


df=pd.read_csv("/Users/sanishareddy/Downloads/Airline Dataset.csv", parse_dates=["Departure Date"])


# In[3]:


df.head(11)


# In[4]:


df.info() 


# In[5]:


df.isnull().sum().sum() #Checking if Null value is present


# In[6]:


df.isna()


# In[7]:


df['Gender']=df['Gender'].astype('category')
df['Age']=df['Age'].astype(int)


# In[8]:


df.describe()


# In[9]:


corrdata=df.corr()
plt.figure()
sns.heatmap(corrdata,annot=True)


# In[10]:


# Create a bar plot to visualize flight punctuality by gender
plt.figure(figsize=(8, 6))
sns.countplot(data=df, x='Gender', hue='Flight Status')
plt.title('Flight Punctuality by Gender')
plt.xlabel('Gender')
plt.ylabel('Count')
plt.legend(title='Flight Status')
plt.show()


# In[11]:


# Create a box plot to visualize flight punctuality by age
plt.figure(figsize=(8, 6))
sns.boxplot(data=df, x='Flight Status', y='Age')
plt.title('Flight Punctuality by Age')
plt.xlabel('Flight Status')
plt.ylabel('Age')
plt.show()


# In[12]:


import matplotlib.pyplot as plt

# Calculate passenger counts by gender
gender_passenger_counts = df['Gender'].value_counts()

# Create a bar chart
plt.figure(figsize=(8, 6))
gender_passenger_counts.plot(kind='bar', color=['lightblue', 'lightpink'])

# Set the chart title and labels
plt.title('Travelers by Gender')
plt.xlabel('Gender')
plt.ylabel('Passenger Count')

# Show the chart
plt.show()


# In[16]:


# Creating Age Groups Based on Age:
bins = [0, 18, 35, 60, 100]  # Define the age groups
labels = ['0-18', '19-35', '36-60', '61+']  # Define group names
df['Age_Group'] = pd.cut(df['Age'], bins=bins, labels=labels)  # Create a new age group column


# In[18]:


import matplotlib.pyplot as plt

# Calculate passenger counts by gender
gender_passenger_counts = df['Age_Group'].value_counts()

# Create a bar chart
plt.figure(figsize=(8, 6))
gender_passenger_counts.plot(kind='bar', color=['lightblue', 'lightpink'])

# Set the chart title and labels
plt.title('Travelers by Age')
plt.xlabel('Age Group')
plt.ylabel('Passenger Count')

# Show the chart
plt.show()


# In[ ]:




