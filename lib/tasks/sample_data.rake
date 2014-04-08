namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(username: "Example User",
                         email: "example@railstutorial.org",
                         password: "foobar",
                         password_confirmation: "foobar",
                         admin: true)
  end
end