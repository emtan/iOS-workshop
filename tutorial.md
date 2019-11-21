# Tutorial

A step-by-step beginner's guide to building the demo My Journal app.

### Creating a New Project
1. Open Xcode &rarr; File &rarr; New &rarr; New Project
2. Your new project will be a basic app, not pre-formatted in any special way: select "Single View App" &rarr; Next
3. Give your app a name: "My Journal" &rarr; Next
4. Save the app in a chosen location &rarr; Create

Congrats! You've just created your first app ... it's just blank.

### Familiarizing with Xcode and UIKit components
A great aspect of iOS programming is the level of abstraction Xcode's interface builder provides. Buttons, labels, and other user interface components are called **UI elements**. To add a UI element, we simply drag it onto our app interface. Think about the design of iOS apps you've used before and brainstorm the UI elements we need for a simple journal/notes app:
* A **Label** to display the app title "My Journal"
* A **Table** of some sort to display the list of entries
* A **Buttons** to let us *compose* and *save* a new journal draft 
* A **Button** to *cancel* our draft of in case we start typing and change our minds
* **Text Fields** and **Labels** to let us type and display our entries
* Two more additional "Screens" to transition to: one for writing a journal entry, one for reading a journal entry after we select it from our list

Great, let's add these to our app! (For now, just drag them onto the screen and do not worry about sizing and placement yet)

5. Open up __Main.storyboard__ from the project navigator (on the left side of the screen)
6. Click on the Library button (it's a button at the top center-left with a square inside a circle) and search `UIViewController`. Drag two onto the storyboard. One will be our "Compose" screen, and one will be the "Details" screen where we can see what we've written. Our current ViewController will be the table of entries.
7. Drag a `UITableView` onto our initial ViewController and drag a `UITableViewCell` onto the `UITableView`
8. Drag a `UILabel` onto the `UITableView` and change its text to "My Journal". *(Note: make sure the label is above the cell in the hierachy of UI elements as seen in the navigator on the left).* We can play around with the font and sizing of the text of the label by opening up the **Identity Inspector** (arrow button with a line through the middle on the right side of screen).
9. Drag a `UINavigationBar` onto the top of one of the other two ViewControllers. Add a `UIBarButtonItem` to the left and the right of the Bar. In the Identity Inspector, change the type of the left bar button item to "Cancel" and the right one to "Done". Also add a `UILabel` onto this ViewController and a `UITextField` onto the other newly created ViewController.
10. Drag a `UITextView` onto each of the two newly created ViewControllers. 

**Navigation:**

In Swift, **Segues** allow us to transition from "screen" to "screen" (i.e., ViewController to ViewController). Again, Xcode has a helpful abstraction for us -- the Navigation Controller. Let's add these transitions:

11. **CTRL + Drag** from the `UITableViewCell` to the ViewController *without* a Navigation Bar. Select **"Push"** segue. In the Identity Inspector, change the identifier of this segue to "ToDetailSegue".

Next, embed a Navigation Controller into our root (initial) ViewController: 

Select the ViewController &rarr; Editor &rarr; Embed In &rarr; Navigation Controller

You should see that we now have an "invisible" Navigation Controller on the storyboard and that a navigation bar and "Back" button automatically appeared on top of the ViewController that we "Push" segued to. Also, note that there is now a navigation bar on our root ViewController too. 

12. Add a `UIBarButtonItem` to the navigation bar of our root ViewController and change its type to "Compose". **CTRL + Drag** from this "Compose" button to the other ViewController with the "Cancel" and "Done" bar buttons and select **"Modal"** segue. 

For the transitions caused by the "Done" and "Cancel" buttons, we will use **unwind segues** -- almost like we want to *unwind* back to our root ViewController. We will discuss these later on in the tutorial -- sit tight for now.

Finally, let's talk about the *placement* of these UI elements.

**Constraints:**

Because there are many different "sizes" and "orientations" of iOS devices (e.g., different versions of iPhones, iPads, and being able to flip them around), the size and location of UI elements on the screen need to be constrained *relative* to other elements and/or the border of the screen. This way, our UI won't change in "appearance" when the size and/or orientation of the screen changes. Let's go back and add our constraints. 

To add a constraint, first click on a UI element and then clicking the constraints button at the bottom right corner of the storyboard screen (it looks like a square connected on the left and right to vertical lines). Let's add constraints to each UI element as how we see fit/aesthetic.
  
Phew! It *looks* like everything seems to look like how we want our app to appear. If we run the app right now on our **Simulator** (click the "Play" arrow button at the top left corner of Xcode), we should see our starting ViewController with a table view, cells, "My Journal" displayed and the "Compose" button.

### Understanding MVC
The architectural design of an app can be divided into the **Model** - **View** - **Controller** ("MVC"). Simply put: The Model holds the data; the View holds the visuals; the Controller acts as the intermediary. The UI work we did in the previous section constructed parts of the **View**. Now we need the other two.

Let's start with the Model since it only needs to speak to the Controllers. Note that generally in commercial apps, the Model is a remote database. However, for learning and simplicity purposes, we will build it ourselves.

**The Model:**

If we are storing journal entries, we will need to define:
* What is a journal *Entry*
* How we *store* entries

Let's create two new files, one titled **Entry** and **EntryDatabase**: 

File &rarr; New &rarr; File &rarr; Swift &rarr; Next &rarr; Name your files

**Entry.swift:** 
13. Create an Entry *Struct*. We use a *Struct* as opposed to a *Class* because Structs are value types whereas Classes are reference types. If we create additional copies of Structs, they point to individual and separate "copies". Two copies of a Class have the same pointer.
14. An Entry needs a "Title" property and a "Message" property, both of which are of type `String` *(Note: you will have to use* `String!` *due to Swift's optional typing)*. Add these two constant properties using the `let` keyword. Also add an initializer for the type Entry using the `init()` function.

**EntryDatabase.swift:**
Our database will store a collection of Entries and needs to have insertion and removal abilities. Let's use an *Array* to represent this collection.

15. Create an EntryDatabase *Class* that is a subclass of: `NSObject`. Add a `static variable journal` of type Array and functions `static func addEntry(e: Entry) -> ()` and `static func deleteEntry(row: Int) -> Entry` that inserts and removes from the journal array.

**Controllers:**

In order for the Controller to pass information from the Model to display on the View and pass inputs from the View to reflect changes in the Model, we need to link our UI elements to Controllers. To do so, we utilize **IBOutlets** and **IBActions**.

First, we create controllers for each of our app's "Views" (i.e., screens). Create two new files, one for each of the new view controllers we dragged onto the storyboard previously. Note that these two new files will be Cocoa Touch files (and not "Swift" file like the ones we created for the Model). Cocoa Touch files allow for interaction with UI components, which is exactly what a Controller needs to do, while Swift files do not.

16. File &rarr; New &rarr; File &rarr; Cocoa Touch Class (subclass of `UIViewController`) &rarr; Next &rarr; Name one file **DetailViewController** and the other **ComposeViewController**.
17. To link the files to their storyboard counterparts, go to the Identity Inspector section of each ViewController but instead select the Attributes button (it looks like a postcard). Select the corresponding name of the ViewControllers in the drop down under "Class".
18. Similarly, create a new Cocoa Touch Class file that is a subclass of `UITableViewCell` and name it "MyTableViewCell". Link the table view cell on the storyboard to this class. In addition, change the name of the table view cell in the storyboard navigator to "MyTableViewCell".
19. Now, we can use the **CTRL + Drag** functionality to connect each of the UI elements on the storyboard to the controller files they correspond and create IBOutlets. To do so, first open up the **Assistant Editor** that allows you to open two files at the same time next to each other (a button at the top right of the workspace that looks like overlapping circles). Name each IBOutlet appropriately. Make sure to connect IBOutlets *above* the `viewDidLoad()` function. 

Let's also return to our "Cancel" and "Done" unwind segues and add IBActions to them. However, the key thing to note about unwind segues: the action needs to be written in the *destination controller*. 
* Since we are unwinding back to our root ViewController, we write in there two functions: `@IBAction func saveDraft(segue: UIStoryboardSegue)` and `@IBAction func cancelDraft(segue: UIStoryboardSegue)`.
* Next, **CTRL + Drag** from each of the buttons to the **Exit** icon at the top of the ComposeViewController (it looks like a red opening door with an arrow leaving) and select the correct function names.

Now if we run the app and click the "Compose" button, we should be able to transition to our Compose screen and clicking either "Cancel" or "Done" will transition us back.

### Protocols and Delegates/Data Source

Protocols in iOS are just "rules" or "blueprints" (like functions) that objects/classes need to implement. Delegates are just that: the delegates of information -- they pass information to the UI. The Data Source is like a Delegate, but instead of communicating with the UI, the Data Source communicates with our Data (the "Model"). In our case, the root ViewController is acting as both the Delegate of our table view *and* the Data Source of our table view. 

20. So, we extend our ViewController as a subclass of `UITableViewDelegate` and `UITableViewDataSource` and in our `viewDidLoad()` function, we set the `tableView.delegate` and `tableView.datasource` both equal to `self`.

At this point, you'll probably notice that Swift is yelling at us that `ViewController` is missing the necessary protocols ... so let's add them. For table views, there are two must-have protocols for functionality:
* Number of rows in each section: `numberOfRowsInSection()` &rarr; this is just the number of entries we have stored in our database so we return `EntryDatabase.journal.count`
* What the cell is in each row: `cellForRowAt()` &rarr; this is a little more complicated: 

  i. First, we have to "extract" the cell itself: we **deque** the respective cell of the table view at the indicated index path row. We can do so with the function `tableView.dequeueReusableCell()`
  
  ii. Then, we have to configure the cell to what we want to represent: in our case, this is modifying the label of the cell to be the "title" of the corresponding journal entry in our EntryDatabase
  
  iii. Return the extracted the cell
  
With our table view set up, we can move onto adding things to it. In our ComposeViewController, everytime we click "Done", we want to be able to store what we've written into the EntryDatabase and have the information also appear on our table view. Let's revisit the `saveDraft()` function:

21. Create an instance Entry variable `newEntry` in ComposeViewController to represent the new Entry object we are "composing". Each time we click "Save" we want to so we create an instance of our segue source ("ComposeViewController") and set `newEntry` to a new addition into our database at row 0 (i.e., the front of our database) each time we segue. 
22. Then, on the View side, we also insert a new row into our table view using the function `tableView.insertRows()` at an indexPath of row: 0 and section: 0 since our table view only has one section and we are inserting into the top.

Now if we run our app, we should be able to click the Compose button, type a message, Save and see it appear on our table view of journal entries. Yayayaya!

Okay, one last step: selecting and opening a journal entry from the list. Let's add another protocol to our table view: `didSelectRowAt()` and along with another `override func prepare()` for segue function in our root ViewController. If we select a row, we want to perform our "ToDetailSegue". However, we only want to segue to a specific journal entry. 

23. Therefore, first we identify the correct journal entry that was selected: `EntryDatabase.journal[indexPath.row]` and then we call the function `peformSegue()` specifically with this journal entry. But we're not done yet ... because we need to also pass the data that corresponds the selected entry alongside the actual UI segue.
24. Set an instance variable: `journalEntry` of type Entry in DetailViewController that represents the particular entry that the DetailViewController is displaying. Then, in the `prepare()` for segue function, set the "sender Entry (i.e., the one selected in the previous step)" as the "destination Entry (i.e., the `journalEntry` var in the segue's destination controller)".

Run the app now. and ... if we did everything correctly above, it should work as we think! :) 


### Helpful Additional Resources

* Take CIS195-iOS with Dominic Holmes.
* [Apple's developer docs](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/BuildABasicUI.html)
* [Ray Wenderlich tutorials](https://www.raywenderlich.com/)
