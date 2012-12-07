require 'rubygems'
require 'pp'
require 'jira'
require 'net/https'

options = {
            :username => 'crc83',
            :password => 'foobar',
            :site     => 'http://if018:2990',
            :context_path => '/jira',
            :auth_type => :basic,
            :use_ssl => false,
          }

options_adm = {
            :username => 'admin',
            :password => 'admin',
            :site     => 'http://if018:2990',
            :context_path => '/jira',
            :auth_type => :basic,
            :use_ssl => false,
          }


options_serv = {
            :username => 'sbelei',
            :password => 'Babylon5',
            :site     => 'https://jira.softserveinc.com',
            :context_path => '/',
            :auth_type => :basic,
            :use_ssl => false,
          }



# Show all projects
def list_projects
	projects = @client.Project.all

	projects.each do |project|
	  puts "Project -> key: #{project.key}, name: #{project.name}"
	end
end

# change_description_of_issue "FIR-1", "EVEN MOAR NINJA!"
def change_description_of_issue(issue_name, description_text)
	issue = @client.Issue.find(issue_name)
	issue.save({"fields"=>{"description"=>description_text}})
end

# change_name_of_issue "FIR-1", "Very important issue"
def change_name_of_issue(issue_name, name_text)
	issue = @client.Issue.find(issue_name)
	issue.save({"fields"=>{"summary"=>name_text}})
end

# change_type_of_issue "FIR-1", 3
# 	5       Sub-task
# 	4       Improvement
# 	3       Task
# 	1       Bug
# 	2       New Feature
def change_type_of_issue(issue_name, new_type_id)
	issue = @client.Issue.find(issue_name)
	issue.save({"fields"=>{"issuetype"=>{"id"=>new_type_id}}})
end

# defaults are
# 	5       Sub-task
# 	4       Improvement
# 	3       Task
# 	1       Bug
# 	2       New Feature
def list_possible_type_ids
	issuetypes = @client.Issuetype.all
	issuetypes.each do |issue|
		puts "#{issue.id}\t#{issue.name}"
	end
end

# defaults are
# 1       Open
# 3       In Progress
# 4       Reopened
# 5       Resolved
# 6       Closed

def list_possible_status_ids
	statustypes = @client.Status.all
	statustypes.each do |status|
		puts "#{status.id}\t#{status.name}"
	end
end

# doesn't work now
def change_status_of_issue(issue_name, new_status_id)
	issue = @client.Issue.find(issue_name)
	issue.save({"fields"=>{"status"=>{"id"=>new_status_id}}})
end

# add_comment_to_issue "FIR-1", "mega comment"
def add_comment_to_issue(issue_name, comment_text)
	issue = @client.Issue.find(issue_name)
	comment = issue.comments.build
	comment.save!(:body => comment_text)
end

def print_issue_comments(issue_name)
	issue = @client.Issue.find(issue_name)
	issue.comments.each do |item|
		author = item.author 
		puts " #{author["displayName"]} :\t #{item.body}"
	end
end

#doesn't work
def list_users
	puts @client.Issue
end

# doesn't work
# assign_to_issue "FIR-1", "admin"
def assign_to_issue(issue_name, user_name)
	issue = @client.Issue.find(issue_name)
	issue.save({"fields"=>{"assignee"=>{"name"=>user_name}}})
	# issue.save({"fields"=>{"assignee"=>{"emailAddress"=>user_name}}})
end

def print_issue_changelog(issue_name)
	issue = @client.Issue.find(issue_name)
	issue.worklogs.each do |item|
		puts item
	end
end

def print_possible_transitions_of_issue(issue_name)
	transitions = @client.Transition.find(issue_name)
	# puts issue
	puts transitions
end

@client = JIRA::Client.new(options_adm)
# result = assign_to_issue "FIR-1", "User"
# if result
#   puts "OK"
# else
#   puts "error"
# end
print_possible_transitions_of_issue "FIR-1"
