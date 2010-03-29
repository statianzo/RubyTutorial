# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_meh_session',
  :secret      => '19fca1854ecceedf0a8277f198bc48051c1bac08d3c835bd64e8bde7c99691cdf347c34238527d8b10ecba39c036e7235781a9edaf41b40c064eaa100a56c6d9'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
