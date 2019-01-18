require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, { adapter: 'sqlite3', database: 'test.db' } 

class Question < ActiveRecord::Base
end

get '/questions' do 
    @questions = Question.all
    erb :questions
end

get '/questions/new' do 
    erb :new
end

##post method saves a row to the database
## /questions post is not the same as /questions get because the former inserts 
## a row into the db, the later gets all the questions
post '/questions' do
 question = Question.new
 question.question = params[:question]
 question.answer = params[:answer]
 question.flag = params[:flag]
 question.save
 redirect '/questions'
end

get '/questions/edit' do #load edit form
    @question = Question.find(params[:id])
    erb :edit
end

patch '/questions/:id' do #edit action
    @question = Question.find(params[:id])
    @question.question = params[:question]
    @question.answer = params[:answer]
    @question.flag = params[:flag]
    @question.save
    redirect "/questions"
end

get '/guess' do
    @questions = Question.all
    index = rand(@questions.length)
    @question = @questions[index]
    erb :guess
end