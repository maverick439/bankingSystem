# bankingSystem

Let’s build a banking system where user can check his account details and transactions.
A user must sign-in to call any apis. Once a user is registered, it undergoes a verification process.
The verification process is a set of rules. Only after the user passes the set of verification rules,
does it get allowed to access further apis.
Once its verified, the user can create transactions and check his balance.

##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Ruby [3.0.1](https://github.com/organization/project-name/blob/master/.ruby-version#L1)
- Rails [6.1.3](https://github.com/organization/project-name/blob/master/Gemfile#L12)

##### 1. Check out the repository

```bash
git clone https://github.com/maverick439/bankingSystem.git
```

##### 2. Create database.yml file

Copy the sample database.yml file and edit the database configuration as required.

```bash
cp config/database.yml.bankingBack_development config/database.yml
```

##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can visit the site with the URL http://localhost:3000
