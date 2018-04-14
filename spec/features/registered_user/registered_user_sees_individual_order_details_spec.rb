require 'rails_helper'

describe 'Registered user' do
  describe 'visits order show page' do
    it 'they see all details for an order' do
      user = create(:user)
      order = user.orders.create!
      item1, item2, item3 = create_list(:item, 3)
      order_item1 = order.order_items.create!(item_id: item1.id, quantity: 3)
      order_item2 = order.order_items.create!(item_id: item2.id, quantity: 1)
      order_item3 = order.order_items.create!(item_id: item3.id, quantity: 2)

      visit order_path(order)

      expect(page).to have_content(order.status)
      expect(page).to have_content(order.created_at)
      expect(page).to have_content(item1.title)
      expect(page).to have_content(item2.title)
      expect(page).to have_content(item3.title)
      expect(page).to have_content(order_item1.quantity)
      expect(page).to have_content(order_item2.quantity)
      expect(page).to have_content(order_item3.quantity)
      expect(page).to have_content(order.item_subtotal(item1))
      expect(page).to have_content(order.total)
    end
  end
end
