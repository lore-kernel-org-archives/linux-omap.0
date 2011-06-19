From: Leigh Brown <leigh@solinno.co.uk>
Subject: Re: [PATCH] input: keypad: lm8323: convert to threaded IRQ
Date: Sun, 19 Jun 2011 19:00:13 +0000
Message-ID: <a07cbd61db83c3308dd76f7c0f481477@doppler.thel33t.co.uk>
References: <1307999812-3802-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from doppler.thel33t.co.uk ([193.110.88.198]:38312 "EHLO
	doppler.thel33t.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754651Ab1FSTKW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Jun 2011 15:10:22 -0400
In-Reply-To: <1307999812-3802-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Felipe,

Many thanks for trying to assist me with my problem. To recap,
I'm seeing the keypad lock-up on my N810 using this driver,
when I type quickly.

I tried your patch, and it doesn't fix the issue.  However, I've
read the datasheet for the lm8323 and it looks to me like the
interrupt should be level rather than edge triggered.

The following additional patch makes things work for me.  I
couldn't tell you if it's the correct thing to do but I can no
longer cause the keypad to lock-up by typing too fast.

Regards,

Leigh.

-- 

diff --git a/drivers/input/keyboard/lm8323.c 
b/drivers/input/keyboard/lm8323.c
index 3b21f42..ab0acaf 100644
--- a/drivers/input/keyboard/lm8323.c
+++ b/drivers/input/keyboard/lm8323.c
@@ -734,7 +734,7 @@ static int __devinit lm8323_probe(struct i2c_client 
*client,
  	}

  	err = request_threaded_irq(client->irq, NULL, lm8323_irq,
-			  IRQF_TRIGGER_FALLING, "lm8323", lm);
+			  IRQF_TRIGGER_LOW|IRQF_ONESHOT, "lm8323", lm);
  	if (err) {
  		dev_err(&client->dev, "could not get IRQ %d\n", client->irq);
  		goto fail4;


