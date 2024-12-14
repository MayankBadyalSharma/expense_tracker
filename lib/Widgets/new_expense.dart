import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {

 /* var _enteredTitle = '';  // variable to store the text entered by the user

// function to store the user entered text and then show it on 'onchanged Method' from the Text field ("Title")
  void _saveTitleInput(String inputValue){
          _enteredTitle = inputValue;
  }
  */

  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  // function to show the date when user click on calender icon

  void _presentDatePicker() async{
      final now = DateTime.now();
      final firstDate = DateTime(now.year - 1, now.month, now.day);
      final _pickedDate = await showDatePicker(context: context, 
      initialDate: now, 
      firstDate: firstDate , 
      lastDate: now);
      // showdatepicker is inbuilt method of flutter to show years,months and days in form of calendar 

      setState(() {
        _selectedDate = _pickedDate;
      });
  }

  void _submitExpenseData(){
    final enteredAmount = double.tryParse(_amountcontroller.text); // tryparse method return string values as null and return double values as double
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if(_titlecontroller.text.trim().isEmpty || amountIsInvalid || _selectedDate == null){
      showDialog(context: context, 
      builder: (ctx) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text('Please enter a valid title, amount, date and category'),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(ctx);
          }, 
          child: const Text('Okay'))
        ],
      ),
      );
      return;
    }
    widget.onAddExpense(Expense
    (title: _titlecontroller.text, 
    amount: enteredAmount,
     date: _selectedDate!, 
     category: _selectedCategory));
     Navigator.pop(context);
  }

// to dispose the controller when textediting controller is not in use
  @override
  void dispose() {
    _titlecontroller.dispose();  
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        padding:  EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
        child: Column(
          children: [
            TextField(
              controller: _titlecontroller,
              maxLength: 50,
              decoration: const InputDecoration(
                label: Text('Title'),
              ),
            ),
      
            Row(
              children: [
                Expanded(child: TextField(
              controller: _amountcontroller,
             keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                prefixText: '\$',
                label: Text('Amount'),
              ),
            ),),
      
           const SizedBox(width: 16,),
      
           Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
               Text(_selectedDate == null ?'No Date Selected' : formatter.format(_selectedDate!),),
              IconButton(
                onPressed: () {
                        _presentDatePicker(); // method to show date, month and years
                },
                icon : const Icon(
                  Icons.calendar_month),
              ),
      
            ],
           ))
              ],
            ),
              
              SizedBox(height: 16),
            
      
            Row(
              children: [
                DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                  .map(
                    (category) => DropdownMenuItem(
                      value : category,
                      child: 
                      Text(category.name.toUpperCase()))).toList(), 
                onChanged: (value){
                    if(value == null){
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                }),
      
                const Spacer(),
      
      
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: const Text("Cancel")),
                ElevatedButton(onPressed: () {
                   _submitExpenseData();
                }, 
                child: const Text('Save Expense')),
      
                
              ],
            )
          ],
        ),
      ),
    );
  }
}