class ClearTable < ActiveRecord::Migration[5.0]
      def up
          drop_table :products
      end
      def down
          create_table :products do |t|
              t.string :title
              t.text :description
              t.float :price
              t.timestamps
          end
      end
end
