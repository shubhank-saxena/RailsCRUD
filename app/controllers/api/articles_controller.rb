module Api
    class ArticlesController < ApplicationController
        def index
            articles = Article.order('created_at DESC');
            render json: {status:'SUCCESS', message:'Loaded Articles', data:articles}, status: :ok
        end

        def show 
            article = Article.find(params[:id])
            render json: {status:'SUCCESS', message:'Loaded Article', data:article}, status: :ok
        end

        def create 
            article = Article.new(article_params)
            if article.save
                render json: {status:'SUCCESS', message:'Article Saved', data:article}, status: :ok
            else
                render json: {status:'ERRORED', message:'Article Not Saved', data:article.errors}, status: :unprocessable_entry
            end
        end

        def destroy
            article = Article.find(params[:id])
            article.destroy
            render json: {status:'SUCCESS', message:'Deleted Article', data:article}, status: :ok
        end

        def update
            article = Article.find(params[:id])
            if article.update_attributes(article_params)
                render json: {status:'SUCCESS', message:'Article Edited', data:article}, status: :ok
            else
                render json: {status:'ERRORED', message:'Article Not Edited', data:article.errors}, status: :unprocessable_entry
            end
        end

        private
        def article_params
            params.permit(:title, :body)
        end
    end
end