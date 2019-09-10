class ChangePostSubsToPostsubs < ActiveRecord::Migration[5.2]
  def change
    rename_table :post_subs, :postsubs
  end
end
