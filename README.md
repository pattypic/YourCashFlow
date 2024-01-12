# YourCashFlow
![Untitled design (3)](https://github.com/pattypic/YourCashFlow/assets/124921178/762a9f7b-82a0-4f75-ab83-0b59c1a9da5e)

(Version 1.0)

YourCashFlow offers a simplified way to track your income and expenses allowing you to stay on top of your finances. 

# Table of Contents
1. Project Overview
2. Files
3. Demo
4. Roadmap




# Project Overview
The goal of this app is twofold: firstly, to enhance my proficiency in SwiftUI, and secondly, to bolster my skills in implementing the MVVM architecture. "YourCashFlow," is designed to assist users in monitoring their finances, employing models that show the financial behaviors characteristic of different economic classes. These models draw inspiration from the principles laid out by Robert Kiyosaki. The app stands out for its simplistic approach, offering a practical resource for financial management while allowing users to compare their financial habits against those of different economic classes.
(Note: Current implementation accounts for Income and expenses, there is still more to add.)

# Files (in progress...)

# Demo
### Launch Screen 


<img width="360" alt="Loeading" src="https://github.com/pattypic/YourCashFlow/assets/124921178/872027c9-a0c9-45eb-b4f5-e1af574a9882">


### Onboarding


<img width="291" alt="Screenshot 2024-01-11 at 11 50 11 PM" src="https://github.com/pattypic/YourCashFlow/assets/124921178/75ce88b2-937a-4c4f-a9f0-0287bb07ccce">


### Home Screen with data (light)


<img width="360" alt="Start" src="https://github.com/pattypic/YourCashFlow/assets/124921178/0a695934-540f-4c5c-aa7a-d3271a527e5a">


### Different Data Filters


<img width="365" alt="Filter1" src="https://github.com/pattypic/YourCashFlow/assets/124921178/5a25ac4a-f0b9-4ac8-9b07-fa7fa8fb3c34"><img width="370" alt="Filter2" src="https://github.com/pattypic/YourCashFlow/assets/124921178/764dde35-2812-432e-91cb-b33100e78876"><img width="362" alt="Filter 3" src="https://github.com/pattypic/YourCashFlow/assets/124921178/d1a01ed8-f6fd-491c-8258-16afcfde38f7">


### Clicking "Plus" to AddTransaction


<img width="365" alt="AddTrans" src="https://github.com/pattypic/YourCashFlow/assets/124921178/511957d7-6346-42a7-897b-f22b32300a12"><img width="363" alt="GestureBar" src="https://github.com/pattypic/YourCashFlow/assets/124921178/5a23293b-267e-4c53-be97-c8cbcb324fd5">


### Inputting Transactions


<img width="350" alt="Tran1" src="https://github.com/pattypic/YourCashFlow/assets/124921178/67c03d7e-6975-46d1-b47f-3893cebff0b9"><img width="351" alt="Tran2" src="https://github.com/pattypic/YourCashFlow/assets/124921178/55383f29-5e4c-447d-a393-72fc2f719abc">


### Updated Data


<img width="363" alt="AfterUpdated" src="https://github.com/pattypic/YourCashFlow/assets/124921178/451fed68-9b56-45b0-b4c6-6a8d7d8f246b">


# Roadmap
### Version 1 (Success)
Model Layer:
* Income Model: Define a simple model with properties like amount, source, and date.
* Expense Model: Similar to the Income model, include properties like amount, category, and date.
* Financial Summary Model: Calculates data points based on Financial models

ViewModel Layer:
* Implement logic to add, edit, delete, and view income and expenses.
* Calculate totals, like total income and total expenses.

View Layer:
* Develop user-friendly forms for adding and editing income and expenses.
* Create list views to display recorded incomes and expenses.
* Optionally, a dashboard view could provide a summary of total income and expenses.

Data Persistence:
* Choose a simple yet effective method to store data, like UserDefaults for basic data or Core Data for more complex data structures.
* Test the app thoroughly to ensure data is correctly managed and displayed.

### Version 2 (in progress...)
Expand Model Layer:
* Add models for Assets and Liabilities, considering the properties you need to track.

Update ViewModel Layer:
* Integrate logic for managing assets and liabilities.

Extend View Layer:
* Add views for adding, editing, and viewing assets and liabilities.

Enhance Data Persistence:
* Ensure your data persistence method can handle the additional complexity.

Advanced Features:
* Consider adding notifications, recurring transaction logic, or other advanced features based on user feedback and your comfort with the technology.







