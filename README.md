# MossStone
A Todo list flutter app that uses Drift.


## Purpose
In flutter, I have explored state management using riverpod. But riverpod manages state only in runtime. The state is temporarily stored in the RAM. But what if we want to store state event when the app is closed. I learned that Drift can solve this problem. And I wanted to try it out. I want to create a simple todo list app that can save my tasks, even when closed. When I open it again, I want to see the tasks that I wrote. Basically, I want to achieve persistence. 


### Persistence
```
Saving data in the app such that it remains available even after the app is closed or the system is restarted.  
```

## Drift
Drift is a package in flutter that gives mastery over SQLite Databases within flutter. It is a persistence library. How it works is by creating a SQLite database on the user's own phone. This package then further allows writing queries in dart or sql to manage this database. There is a special object called Streams. Streams automatically updates UI when the underlying data in the SQL database changes. 

## Use cases of Drift:
1. Offline first applications: Stores entries locally when offline. Sync with server when back online. Logging applications are good applications.
2. POS Systems: When transactions happen, it's good to keep a secured local record of the transaction. Imagine the app crashes just after the transaction happens. The user would wish that their transaction is securely saved.
3. My own guess: But to save user preferences locally on the user's device.

### To Do List App

I am going to build a simple one screen todo list. I will add tasks using a form. Then I will list the tasks to be displayed. Tasks are stored locally in Drift. I will also use stream builder to to auto-update the UI as my tasks change.


