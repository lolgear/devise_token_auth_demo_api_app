# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
users = [
	{
		'email' => 'user@user.com',
		'password' => 'password',
		'provider' => :email
	}
]

managers = [
	{
		'email' => 'manager@manager.com',		
		'password' => 'password',
		'provider' => :email
	}
]

new_users = User.create(users)
new_managers = Manager.create(managers)