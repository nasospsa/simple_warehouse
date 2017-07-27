require_relative './test_helper'
require_relative '../app/store'

describe 'Store' do
  before(:each) do
    @store = Store.new 2, 2
  end

  it "should have proper commands" do
    assert @store.respond_to?('store')
    assert @store.respond_to?('locate')
    assert @store.respond_to?('remove')
    assert @store.respond_to?('view')
  end

  it "should store a crate" do
    @store.store(0, 0, 1, 1, 'P')
    @store.store(0, 1, 1, 1, 'A')
    arr = @store.instance_variable_get :@arr
    assert_equal arr[0][0], 'P'
    assert_equal arr[1][0], 'A'
  end

  it "should raise an error if out of bounds" do
    exception = assert_raises do
      @store.store(2, 2, 1, 1, 'P')
    end
    assert_equal exception.message, 'Position doesn\'t exist.'
  end

  it "should raise an error if product too big" do
    exception = assert_raises do
      @store.store(0, 0, 3, 3, 'P')
    end
    assert_equal exception.message, 'Product doesn\'t fit.'
  end

  it "should raise an error if no room available" do
    @store.store(0, 0, 1, 1, 'P')
    exception = assert_raises do
      @store.store(0, 0, 2, 2, 'P')
    end
    assert_equal exception.message, 'Product doesn\'t fit.'
  end

  it "should locate the product if exists" do
    @store.store(0, 1, 1, 1, 'P')
    found = @store.locate 'P'
    found_error = @store.locate 'PP'

    assert found.size > 0
    assert found_error.size == 0
    assert_equal found[0], [1, 0]
  end

  it "should remove a crate if exists" do
    @store.store(0, 1, 1, 1, 'P')
    arr = @store.instance_variable_get :@arr

    assert_equal arr[1][0], 'P'

    @store.remove 0, 1
    assert_equal arr[0][0], '-'
  end

  it "should not remove a crate if doesn't exist" do
    arr = @store.instance_variable_get :@arr

    assert_raises do
      @store.remove 0, 1
    end
  end

  it "should output rows" do
    assert_output("-\t-\n-\t-\n") { @store.view }
    @store.store(0, 1, 1, 1, 'P')
    assert_output("-\t-\nP\t-\n") { @store.view }
  end
end

