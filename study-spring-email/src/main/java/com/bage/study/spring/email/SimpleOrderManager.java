package com.bage.study.spring.email;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Component;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;

@Component
public class SimpleOrderManager implements OrderManager {

@Autowired
        private MailSender mailSender;
    @Autowired
        private SimpleMailMessage templateMessage;


        public void placeOrder(Order order) {

            // Do the business calculations...

            // Call the collaborators to persist the order...

            // Create a thread safe "copy" of the template message and customize it
            SimpleMailMessage msg = new SimpleMailMessage(this.templateMessage);
            msg.setTo(order.getCustomer().getEmailAddress());
            msg.setText(
                    "Dear " + order.getCustomer().getFirstName()
                            + order.getCustomer().getLastName()
                            + ", thank you for placing order. Your order number is "
                            + order.getOrderNumber());
            try{
                this.mailSender.send(msg);
            }
            catch (MailException ex) {
                // simply log it and go on...
                System.err.println(ex.getMessage());
            }
        }
/*
        // Do the business calculations...
        // Call the collaborators to persist the order...

        MimeMessagePreparator preparator = new MimeMessagePreparator() {
            public void prepare(MimeMessage mimeMessage) throws Exception {
                mimeMessage.setRecipient(Message.RecipientType.TO,
                        new InternetAddress(order.getCustomer().getEmailAddress()));
                mimeMessage.setFrom(new InternetAddress("mail@mycompany.com"));
                mimeMessage.setText("Dear " + order.getCustomer().getFirstName() + " " +
                        order.getCustomer().getLastName() + ", thanks for your order. " +
                        "Your order number is " + order.getOrderNumber() + ".");
            }
        };

        try {
            this.mailSender.send(preparator);
        }
        catch (MailException ex) {
            // simply log it and go on...
            System.err.println(ex.getMessage());
        }


// of course you would use DI in any real-world cases
        try {
            JavaMailSenderImpl sender = new JavaMailSenderImpl();
            sender.setHost("smtp.qq.com");
            sender.setUsername("893542907@qq.com");
            sender.setPassword("chhcxwbbevznbfbd");

            Properties props = new Properties();
            props.setProperty("mail.smtp.auth", "true");
            sender.setJavaMailProperties(props);

            MimeMessage message = sender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message);
            helper.setTo("1305039488@qq.com");
            helper.setText("Thank you for ordering!");

            sender.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
*/

}