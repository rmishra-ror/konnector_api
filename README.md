# README

## Environment Setup

### Prerequisites
To run this application in development you will either want to have
- Ruby 3.1.4
- Mysql 8.2.0
- Rails 7.1.3

You may need to change the credentials for Mysql according to your specific configuration.

###### To setup DB Run:
* `rake db:create`
* `rake db:migrate`

###### To seed default data for users:
* `rake db:seed`

###### Run rails app using
* `rails s`

###### Run Test case using
* `rspec`

#### Instruction to run app using Docker:

Run Below CMDs:
1) `docker-compose build` # build images
2) `docker-compose run web bundle exec rake db:create` # create db
3) `docker-compose run web bundle exec rake db:migrate` # run migration
4) `docker-compose run web bundle exec rake db:seed` # to seed users data
4) `docker-compose up` # run app
5) `docker-compose run web rspec` # to run test cases 

#### Test Coverage Report

visit http://18.117.88.241/coverage/index.html for coverage report

**Sample Curl URL to GET/CREATE/FILTER users**
### GET Users
```
curl --location 'http://18.117.88.241/users' \
--header 'Content-Type: application/json'
```
### CREATE USERS
```
curl --location 'http://18.117.88.241/users' \
--header 'Content-Type: application/json' \
--data-raw '{
  "name": "Rahul",
  "email": "rahul@gmail.com",
  "campaigns_list": [{"campaign_name": "rm1", "campaign_id": "rm1"}]
}
'
```
### FILTER USERS
```
curl --location 'http://18.117.88.241/users/filter?campaign_names=cam1%2Ccam2' \
--header 'Content-Type: application/json'
```

POSTMAN COLLECTION LINK:  https://documenter.getpostman.com/view/27421219/2sA3kUF1eK#2f9a1740-c0dc-4958-989c-428adbbf6556


**TEST COVERAGE STATUS:**
<img width="1495" alt="Screenshot 2024-07-19 at 3 08 57 PM" src="https://github.com/user-attachments/assets/ad2cae0e-555a-494d-a0cd-cf984b9e4ac5">

