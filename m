From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc3-omap git 2/2] twl4030-gpio debounce cleanup
Date: Fri, 7 Nov 2008 11:59:49 -0800
Message-ID: <200811071159.49679.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:33076 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751279AbYKGT7w (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Nov 2008 14:59:52 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Provide a static debounce configuration mechanism for twl4030 GPIOs,
replacing the previous dynamic one.  The single user of that mechanism
was for MMC card detect debouncing.

Boards can provide a bitmask saying which GPIOs to debounce (30 msec).
It's always enabled for pins with the MMC card-detect/VMMCx link active,
so most boards won't need to set the debounce mask.

This is a net code shrink, including runtime footprint.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
I'll submit this to mainline as soon as I get appropriate
acks/signoffs here.

 drivers/gpio/twl4030-gpio.c |   54 +++++++++++++++++-------------------------
 include/linux/i2c/twl4030.h |    9 ++-----
 2 files changed, 26 insertions(+), 37 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -202,37 +202,6 @@ static int twl4030_get_gpio_datain(int g
 	return ret;
 }
 
-/*
- * Configure debounce timing value for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_debounce(int gpio, int enable)
-{
-	u8 d_bnk = gpio >> 3;
-	u8 d_msk = BIT(gpio & 0x7);
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & BIT(gpio))))
-		return -EPERM;
-
-	base = REG_GPIO_DEBEN1 + d_bnk;
-	mutex_lock(&gpio_lock);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		if (enable)
-			reg = ret | d_msk;
-		else
-			reg = ret & ~d_msk;
-
-		ret = gpio_twl4030_write(base, reg);
-	}
-	mutex_unlock(&gpio_lock);
-	return ret;
-}
-EXPORT_SYMBOL(twl4030_set_gpio_debounce);
-
 /*----------------------------------------------------------------------*/
 
 static int twl_request(struct gpio_chip *chip, unsigned offset)
@@ -405,6 +374,23 @@ static int __devinit gpio_twl4030_pulls(
 				REG_GPIOPUPDCTR1, 5);
 }
 
+static int __devinit gpio_twl4030_debounce(u32 debounce, u8 mmc_cd)
+{
+	u8		message[4];
+
+	/* 30 msec of debouncing is always used for MMC card detect,
+	 * and is optional for everything else.
+	 */
+	message[1] = (debounce & 0xff) | (mmc_cd & 0x03);
+	debounce >>= 8;
+	message[2] = (debounce & 0xff);
+	debounce >>= 8;
+	message[3] = (debounce & 0x03);
+
+	return twl4030_i2c_write(TWL4030_MODULE_GPIO, message,
+				REG_GPIO_DEBEN1, 3);
+}
+
 static int gpio_twl4030_remove(struct platform_device *pdev);
 
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
@@ -439,6 +425,12 @@ no_irqs:
 				pdata->pullups, pdata->pulldowns,
 				ret);
 
+	ret = gpio_twl4030_debounce(pdata->debounce, pdata->mmc_cd);
+	if (ret)
+		dev_dbg(&pdev->dev, "debounce %.03x %.01x --> %d\n",
+				pdata->debounce, pdata->mmc_cd,
+				ret);
+
 	twl_gpiochip.base = pdata->gpio_base;
 	twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
 	twl_gpiochip.dev = &pdev->dev;
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -234,6 +234,9 @@ struct twl4030_gpio_platform_data {
 	/* gpio-n should control VMMC(n+1) if BIT(n) in mmc_cd is set */
 	u8		mmc_cd;
 
+	/* if BIT(N) is set, or VMMC(n+1) is linked, debounce GPIO-N */
+	u32		debounce;
+
 	/* For gpio-N, bit (1 << N) in "pullups" is set if that pullup
 	 * should be enabled.  Else, if that bit is set in "pulldowns",
 	 * that pulldown is enabled.  Don't waste power by letting any
@@ -390,12 +393,6 @@ int twl4030_sih_setup(int module);
 
 #define TWL4030_GPIO_IRQ_NO(n)		(TWL4030_GPIO_IRQ_BASE + (n))
 
-/*
- * Exported TWL4030 GPIO APIs
- *
- * WARNING -- use standard GPIO and IRQ calls instead; these will vanish.
- */
-int twl4030_set_gpio_debounce(int gpio, int enable);
 
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
 	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
