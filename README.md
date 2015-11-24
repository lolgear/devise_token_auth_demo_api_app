Suppose, that you need to build a simple app that fit your needs.

It should have an API and also it should have an Authorization.

This app is a demo for such a simple task.

First of all, we need to identify with which entities we would work.

This app uses entity user and entity manager.

According to [device_token_auth documentation](https://github.com/lynndylanhurley/devise_token_auth):

run these lines to generate necessary items for devise_token_auth setup

`rails g devise_token_auth:install User auth`

`rails g devise_token_auth:install Manager managers`

Also we need an external api for usage.

It will have a routes as 'api/external/something(.:format)'

And, for example, we want to look at current user and current manager.

And we have API routes as:

/api/external/users/current(.:format)
/api/external/managers/current(.:format)

let's create necessary controllers for external api.

`mkdir -p app/api/external`

`touch app/api/api_controller.rb`

I think that this is necessary to stop here.

It is necessary to understand what should be done at auth layer.

DeviseTokenAuth will authenticate user at path auth/users/sign_in.json and put user inside ApplicationController.

If we try to use ApiController without ApplicationController, we will be unauthorized.

So, now we have an api structure:

`ApplicationController` - main controller

`Api::ApiController` - main api controller, inherited from ApplicationContoller ( see Auth reasons )

`Api::External::V1::UsersController` - UsersController for external api with version number one, inherited from Api::ApiController

`Api::External::V1::ManagersController` - ManagersController for external api with version number one, inherited from Api::ApiController

Now, suppose, that we want to build new api.

Suppose, that we want to build external api version 2.

Also, we want to move authorization under api scope.

Now we have routes:

`/api/external/v2/auth/users` - authorization for users

`/api/external/v2/auth/managers` - authorization for managers

`/api/external/v2/users/current.json` - current user

`/api/external/v2/managers/current.json` - current manager

But now we have different controller hierarchy.

`ApplicationController` - main controller

`Api::External::V2::AuthGuardController` - authorization controller as a middle man between devise token auth helpers and functional controllers

`Api::External::V2::UsersController` - UsersController for external api with version number two, inherited from Api::External::V2::AuthGuardController

`Api::External::V2::ManagersController` - ManagersController for external api with version number two, inherited from Api::External::V2::AuthGuardController

But we want new v3 api.

And now we want to split authorization and functional controllers.

We have routes:

`/auth/users` - authorization for users ( as in v1 )

`/auth/managers` - authorization for managers ( as in v1 )

`/api/external/v2/users/current.json` - current user

`/api/external/v2/managers/current.json` - current manager

And again, we have different controller hierarchy.

`Api::External::V3::AuthGuardController` - authorization controller as a middle man between devise token auth helpers and functional controllers

`Api::External::V3::UsersController` - UsersController for external api with version number two, inherited from Api::External::V3::AuthGuardController

`Api::External::V3::ManagersController` - ManagersController for external api with version number two, inherited from Api::External::V3::AuthGuardController

Again, pretty normal.
