class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
    	t.integer 	:article_id
    	t.string  	:image_file_name
    	t.string  	:image_content_type
    	t.integer  	:image_file_size
    	t.datetime 	:image_updated_at
      t.timestamps null: false
    end
    remove_column :articles, :image_file_name
    remove_column :articles, :image_content_type
    remove_column :articles, :image_file_size
    remove_column :articles, :image_updated_at
  end
end
