# Contact App – Analysis & Reflection

## 1. Data to be stored

The application stores:
- Contact name
- Phone number

Each contact is represented as an object (`Contact`), and all contacts are stored in a list (`_contacts`).

---

## 2. Where the data is stored

The data is stored inside a StatefulWidget (`_ContactPageState`).

This is because:
- The data can change dynamically
- The UI needs to update when the data changes

---

## 3. What happens when "Add Contact" is pressed

When the button is pressed:

1. The app reads input from the TextField
2. Performs simple validation (non-empty)
3. Creates a new Contact object
4. Adds it to the `_contacts` list
5. Calls `setState()` to update the UI
6. Clears the input fields

---

## 4. How the UI updates

The UI updates because of `setState()`.

When `setState()` is called:
- Flutter rebuilds the widget
- The ListView reads the updated `_contacts`
- The new contact appears automatically

This shows that:
> UI is a representation of the underlying data (state)

---

## 5. Components that receive the data

- `ListView.builder` → determines number of items
- `ContactItem` → displays each contact
- Parent widget → manages the state

---

## Reflection: Design System & Component-Based Approach

In the initial implementation, I used a lot of custom styling such as:
- Container-based layouts
- Manual borders, padding, and colors

This approach was influenced by my experience in building web applications without frameworks, where UI is often built from scratch.

However, after learning the "design system first" and bottom-up approach, I realized that:

- Flutter already provides built-in Material widgets such as `Card`, `ListTile`, `TextField`, and `ElevatedButton`
- These components are designed to work consistently together
- Building UI from small reusable components improves readability and maintainability

Therefore, I refactored the application by:

- Replacing custom Container-based UI with Material widgets like `Card` and `ListTile`
- Simplifying input fields using default `InputDecoration`
- Breaking down the UI into smaller components:
  - `AppTextField`
  - `PrimaryButton`
  - `ContactItem`
  - `ContactFormSection`
  - `ContactListSection`

This makes the code more modular, easier to understand, and closer to real-world development practices.

---

## Conclusion

Through this task, I learned that:

- UI should be built from small reusable components (bottom-up)
- It is better to use existing design systems before creating custom styles
- UI is a direct representation of application state

This approach leads to cleaner code, faster development, and more maintainable applications.