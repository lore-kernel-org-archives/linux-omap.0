From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc8-omap 7/7] twl4030-gpio implements to_irq()
Date: Fri, 3 Oct 2008 09:04:47 -0700
Message-ID: <200810030904.47529.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32657 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752982AbYJCQbj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Oct 2008 12:31:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make twl4030 GPIO support the new gpio_to_irq() hook

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -653,6 +653,12 @@ static void twl_set(struct gpio_chip *ch
 	twl4030_set_gpio_dataout(offset, value);
 }
 
+static int twl_to_irq(struct gpio_chip *chip, unsigned offset)
+{
+	/* NOTE: assumes IRQs are set up ... */
+	return twl4030_gpio_irq_base + offset;
+}
+
 static struct gpio_chip twl_gpiochip = {
 	.label			= "twl4030",
 	.owner			= THIS_MODULE,
@@ -660,6 +666,7 @@ static struct gpio_chip twl_gpiochip = {
 	.get			= twl_get,
 	.direction_output	= twl_direction_out,
 	.set			= twl_set,
+	.to_irq			= twl_to_irq,
 	.can_sleep		= 1,
 };
 
