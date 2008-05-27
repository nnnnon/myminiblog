class MyMailer < ActionMailer::Base

  def send(sent_at = Time.now)
    @subject    = '这是邮件的标题！'
    @body       = '这是邮件的内容，只是为了测试，没有多少内容！'
    @recipients = 'nnnnon@gmail.com'
    @from       = 'nnnnon@gmail.com'
    @sent_on    = sent_at
    @headers    = {}
  end
end
