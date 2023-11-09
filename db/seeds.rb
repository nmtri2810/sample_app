User.create!(name: "Example User",
             email: "test@gmail.com",
             password: "111111",
             password_confirmation: "111111",
             date_of_birth: "10-10-2002",
             gender: "male",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

30.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  dob = Time.now
  # gender = Faker::Gender.gender
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               date_of_birth: dob,
               gender: "male",
               activated: true,
               activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)

30.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# Following relationships
users = User.all
user = users.first
following = users[2..20]
followers = users[3..15]
following.each{|followed| user.follow(followed)}
followers.each{|follower| follower.follow(user)}
