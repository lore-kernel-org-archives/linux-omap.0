From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 2/5] twl4030-gpio use new gpiolib hooks
Date: Mon, 13 Oct 2008 13:02:18 -0700
Message-ID: <200810131302.18302.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:36240 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752860AbYJMUSh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Oct 2008 16:18:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Use the new gpiolib internal mechanism for tracking gpio usage,
making them power the GPIO module on/off, so that the standard
gpio_request()/gpio_free() calls can completely replace the
twl4030-specific versions.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c |   77 ++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -102,32 +102,10 @@ static inline int gpio_twl4030_read(u8 a
  */
 int twl4030_request_gpio(int gpio)
 {
-	int ret = 0;
-
 	if (unlikely(gpio >= TWL4030_GPIO_MAX))
 		return -EPERM;
 
-	ret = gpio_request(twl_gpiochip.base + gpio, NULL);
-	if (ret < 0)
-		return ret;
-
-	mutex_lock(&gpio_lock);
-	if (gpio_usage_count & BIT(gpio)) {
-		ret = -EBUSY;
-	} else {
-		/* First time usage? - switch on GPIO module */
-		if (!gpio_usage_count) {
-			ret = gpio_twl4030_write(REG_GPIO_CTRL,
-					MASK_GPIO_CTRL_GPIO_ON);
-
-		}
-		if (!ret)
-			gpio_usage_count |= BIT(gpio);
-		else
-			gpio_free(twl_gpiochip.base + gpio);
-	}
-	mutex_unlock(&gpio_lock);
-	return ret;
+	return gpio_request(twl_gpiochip.base + gpio, NULL);
 }
 EXPORT_SYMBOL(twl4030_request_gpio);
 
@@ -136,26 +114,11 @@ EXPORT_SYMBOL(twl4030_request_gpio);
  */
 int twl4030_free_gpio(int gpio)
 {
-	int ret = 0;
-
 	if (unlikely(gpio >= TWL4030_GPIO_MAX))
 		return -EPERM;
 
-	mutex_lock(&gpio_lock);
-
-	if ((gpio_usage_count & BIT(gpio)) == 0) {
-		ret = -EPERM;
-	} else {
-		gpio_usage_count &= ~BIT(gpio);
-		gpio_free(twl_gpiochip.base + gpio);
-	}
-
-	/* Last time usage? - switch off GPIO module */
-	if (ret == 0 && !gpio_usage_count)
-		ret = gpio_twl4030_write(REG_GPIO_CTRL, 0x0);
-
-	mutex_unlock(&gpio_lock);
-	return ret;
+	gpio_free(twl_gpiochip.base + gpio);
+	return 0;
 }
 EXPORT_SYMBOL(twl4030_free_gpio);
 
@@ -283,6 +246,38 @@ int twl4030_set_gpio_card_detect(int gpi
 
 /*----------------------------------------------------------------------*/
 
+static int twl_request(struct gpio_chip *chip, unsigned offset)
+{
+	int status = 0;
+
+	mutex_lock(&gpio_lock);
+
+	/* on first use, turn GPIO module "on" */
+	if (!gpio_usage_count)
+		status = gpio_twl4030_write(REG_GPIO_CTRL,
+				MASK_GPIO_CTRL_GPIO_ON);
+
+	if (!status)
+		gpio_usage_count |= (0x1 << offset);
+
+done:
+	mutex_unlock(&gpio_lock);
+	return status;
+}
+
+static void twl_free(struct gpio_chip *chip, unsigned offset)
+{
+	mutex_lock(&gpio_lock);
+
+	gpio_usage_count &= ~BIT(offset);
+
+	/* on last use, switch off GPIO module */
+	if (!gpio_usage_count)
+		gpio_twl4030_write(REG_GPIO_CTRL, 0x0);
+
+	mutex_unlock(&gpio_lock);
+}
+
 static int twl_direction_in(struct gpio_chip *chip, unsigned offset)
 {
 	return twl4030_set_gpio_direction(offset, 1);
@@ -316,6 +311,8 @@ static int twl_to_irq(struct gpio_chip *
 static struct gpio_chip twl_gpiochip = {
 	.label			= "twl4030",
 	.owner			= THIS_MODULE,
+	.request		= twl_request,
+	.free			= twl_free,
 	.direction_input	= twl_direction_in,
 	.get			= twl_get,
 	.direction_output	= twl_direction_out,
