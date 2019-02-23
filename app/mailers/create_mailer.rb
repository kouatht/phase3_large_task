class CreateMailer < ApplicationMailer
 def create_blog_mail(create)
  @create = create

  mail to: "km0810jtp@gmail.com", subject: 'ブログ作成の確認メール'
 end
end
