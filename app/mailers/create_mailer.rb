class CreateMailer < ApplicationMailer
 def create_blog_mail(create)
  @create = create

  mail to: @create.user.email, subject: 'ブログ作成の確認メール'
 end
end
