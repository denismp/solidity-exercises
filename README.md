# solidity-exercises
Solidity exercises from Kingslanding.

Problem 1.	Simple Storage Contract
Write a simple contract in Solidity that keeps in the blockchain an integer variable and provides public functions to read it and to change it. 

Problem 2.	Incrementor Contract
Write a Solidity contract, as described below:
•	The contract holds a certain value
o	value (uint) -> not accessible outside the contract
•	Anyone can see the function and read the value
o	Returns uint
o	Not modifying the state of blockchain!
•	Anyone can increment the value
o	increment(uint delta) 
o	No output!
•	Test and play around with the contract

Problem 3.	Previous Invoker
Write a Solidity contract as described below:
o	Keep the address of its previous invoker in the persistent storage -> not accessible outside the contract
•	getLastInvoker()  returns (bool, address)
•	true / false – if a previous invoker exists or not
•	The address that has invoked the contract before you
•	Accessible from outside the contract
Add appropriate Events for the functions (http://solidity.readthedocs.io/en/v0.4.21/contracts.html#events)
Test and play around with the contract

Problem 4.	Registry of Certificates
Write a simple contract in Solidity that represents a registry of certificates.
•	Each certificate has its owner and content calculated as hash
•	The registry holds of all valid certificate hashes stored on the blockchain (as string)
•	Only the owner can add certificate hashes: add(hash)
•	You may use this tool https://emn178.github.io/online-tools/sha3_512.html to calculate hashes
•	Anyone can verify а certificate by its hash: verify(hash)
Add appropriate events for the functions
Test and play around with the contract

Problem 5.	Simple Token
Write a contract that represents a simple token
o	The initial supply must be set at contract’s creation 
	This amount must be allocated to the address that creates the contract
o	You should store the balances of the addresses -> mapping
o	Add a functionality that allows for transfer(to, value) of tokens between the address of the contract’s creator and other addresses
	The number of tokens for transfer must be bigger than 0
	Check for overflow
Add appropriate events for the functions
Test and play around with the contract

Problem 6.	 The Diary
 
Alice loves to document facts. In fact, every night before she goes to sleep she loves to remember all the thing which has happened through the day and to write them down in her diary.
Create a Diary contract in Solidity which:
•	Keep in the blockchain a string array of facts and the contract owner
•	Only contract owner (creator) can
o	Add facts (string fact) -> accessible outside the contract
•	Only people who are approved can read the facts
o	getFact(index) – returns specified fact by index [0…count-1]
o	Solidity cannot return all facts at once (array of strings)
o	Approved addresses are hardcoded in the contract
•	Everyone can see how many facts there are in the diary 
o	count() – returns the count of facts -> not change the state of the contract
•	Nobody can delete facts or destroy the contract	
Use modifiers where it is appropriate.
Add appropriate events for the functions.
Test and play around with the contract.

Problem 7.	Planet Earth Contract
Create contract that:
•	Declares all continents (Europe, Asia, etc..). Use the best way to declare them – we know that there are fixed amount of continents and we know their names
•	Declares a data representing a single country (name, continent, population)
•	Keep track of each country’s capital, so people can check country’s capital by simply giving a name
•	Store only European countries
•	Have a function to add country (should accept only European countries). The function accepts all countrie’s properties (name, continent, population)
•	Have function to add a capital to a single country (No duplicates – i.e. Sofia cannot be a capital of both Bulgaria and Romania)
•	Have a function that gives the capital by a given country name
•	Have a function to remove a capital
•	Have a function that returns the string representation of each continent (i.e. I receive “Asia”, “Europe”, etc.)
•	Have a function that returns all European countries

Problem 8.	Students Info Tracker
 
In the first Blockchain Secondary School every lecturer should store the students’ information. The information should be public and everyone could see it.  
o	Write a simple contract in Solidity that keeps track of students’ names, addresses(eth), array of marks and number in class:
•	Only the owner of the contract (lecturer) can create students profile and give marks it does not matter the class/lecture (should be store in appropriate data structure)
	Hint -> use struct
	Students profile should be stored in an array -> Students[]
•	Everyone can get the information -> get(index) 
Use modifiers where it is appropriate.
Add appropriate events for the functions.
Test and play around with the contract.

Problem 9.	(Optional) Crowdsale for Lambo -- I did not do this one.
 
Nowadays everyone makes Crowdsales which means everyone gives you money because you just give them promises about better world. Then you just withdraw the money and go to Bali or buy a Lambo. Let’s make one! Let’s buy Lambo and go to Bali!
Write a Solidity contract that has a function through which anyone can send it ethers:
•	Function deposit() should store ethers to the contract balance
	Hint -> use payable
•	Only the owner of the contract can check the current balance of the contract 
	Contract balance -> this.balance
•	When the owner wants, he can withdraw the ethers and then kill the contract
	Hint -> address.transfer(amount)
	Hint -> suicide(owner)
Use modifiers where it is appropriate.
Add appropriate events for the functions.
Test and play around with the contract.
