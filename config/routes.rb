# Check out https://github.com/joshbuddy/http_router for more information on HttpRouter
HttpRouter.new do
  add('/events').to(HomeAction)
  add('/').static('public/index.html') 
end
