require File.dirname(__FILE__) + '/../test_helper'

class MyMailerTest < ActionMailer::TestCase
  tests MyMailer
  def test_send
    @expected.subject = 'MyMailer#send'
    @expected.body    = read_fixture('send')
    @expected.date    = Time.now

    assert_equal @expected.encoded, MyMailer.create_send(@expected.date).encoded
  end

end
