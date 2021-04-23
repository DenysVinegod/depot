require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  fixtures :products

  test 'Attributes must be not empty' do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test 'product price must be positive' do
    product = Product.new(title: 'My Book Title', description: 'yyy', image_url: 'zzz.jpg')
    product.price = -1
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    Product.new(title: 'My Book Title', description: 'yyy', image_url: image_url, price: 10)
  end

  test 'image_url' do
    ok = %w[fred.gif fred.png fred.jpg FRED.gif FRED.PNG FRED.jpg http://a.b.c/x/y/z/fred.jpg]

    bad = %w[fred.doc fred.gif/more fred.gif.more]

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} should`t be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).invalid?, "#{image_url} shouldn`t be valid"
    end
  end

  test 'Product is invalid without unique title' do
    product = Product.new(title: products(:ruby).title, description: 'yyy', image_url: 'fred.gif', price: 10)
    assert product.invalid?
    assert_equal ['has already been taken'], product.errors[:title]
  end
end
