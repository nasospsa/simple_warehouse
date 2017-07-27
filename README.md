#simple warehouse


### Command to run app:

`ruby runner.rb`



### Command for tests:

`ruby test/test.rb`


## Commands
| Command         |                                                                                                        |
|-----------------|--------------------------------------------------------------------------------------------------------|
| help            | Shows this help message                                                                                |
| init W H        | (Re)Initialises the application as a W x H warehouse, with all spaces empty.                           |
| store X Y W H P | Stores a crate of product number P and of size W x H at position X,Y.                                  |
| locate P        | Show a list of positions where product number can be found.                                            |
| remove X Y      | Remove the crate at positon X,Y.                                                                       |
| view            | Show a representation of the current state of the warehouse, marking each position as filled or empty. |
| exit            | Exits the application.                                                                                 |
