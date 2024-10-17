[DONE]

It is necessary to create a web application using:
- Ruby on Rails 7 framework. 
- Database: PostgreSQL or MariaDB. Users can register. 
- For user management, use the Devise 4.9 library.

[TODO]

Users can _create text **posts**_, _**follow** each other_, and _read posts_ from those they follow in _**chronological**_ order in a feed.

Users can comment on each other's posts. Comments form a tree structure—_**each comment relates either to the original post or to another comment**_.

---

Post
- creator: reference User 
- body:text
- created_at

Comment
- commenter: reference User
- commented_to: reference Comment | Post
- created_at

Subscriptions
- user: reference User
- follows: reference User (many)
- followers: reference User (many)
