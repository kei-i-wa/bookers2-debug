class Relationship < ApplicationRecord
    belongs_to:follower,class_name:"User"
    belongs_to:followed,class_name:"User"
    #follower_idのカラムの値からuserテーブルのレコードを参照できる
end
