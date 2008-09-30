From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 24/25] twl4030-gpio: pullup/pulldown init
Date: Tue, 30 Sep 2008 21:43:08 +0300
Message-ID: <1222800189-29737-25-git-send-email-me@felipebalbi.com>
References: <1222800189-29737-1-git-send-email-me@felipebalbi.com>
 <1222800189-29737-2-git-send-email-me@felipebalbi.com>
 <1222800189-29737-3-git-send-email-me@felipebalbi.com>
 <1222800189-29737-4-git-send-email-me@felipebalbi.com>
 <1222800189-29737-5-git-send-email-me@felipebalbi.com>
 <1222800189-29737-6-git-send-email-me@felipebalbi.com>
 <1222800189-29737-7-git-send-email-me@felipebalbi.com>
 <1222800189-29737-8-git-send-email-me@felipebalbi.com>
 <1222800189-29737-9-git-send-email-me@felipebalbi.com>
 <1222800189-29737-10-git-send-email-me@felipebalbi.com>
 <1222800189-29737-11-git-send-email-me@felipebalbi.com>
 <1222800189-29737-12-git-send-email-me@felipebalbi.com>
 <1222800189-29737-13-git-send-email-me@felipebalbi.com>
 <1222800189-29737-14-git-send-email-me@felipebalbi.com>
 <1222800189-29737-15-git-send-email-me@felipebalbi.com>
 <1222800189-29737-16-git-send-email-me@felipebalbi.com>
 <1222800189-29737-17-git-send-email-me@felipebalbi.com>
 <1222800189-29737-18-git-send-email-me@felipebalbi.com>
 <1222800189-29737-19-git-send-email-me@felipebalbi.com>
 <1222800189-29737-20-git-send-email-me@felipebalbi.com>
 <1222800189-29737-21-git-send-email-me@felipebalbi.com>
 <1222800189-29737-22-git-send-email-me@felipebalbi.com>
 <1222800189-29737-23-git-send-email-me@felipebalbi.com>
 <1222800189-29737-24-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60539 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753241AbYI3StO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:49:14 -0400
In-Reply-To: <1222800189-29737-24-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>

From: David Brownell <dbrownell@users.sourceforge.net>

Finish moving initialization of pullups and pulldowns for twl4030
GPIOs into board specific init.  Remove partial/incorrect init code
for that from the hsmmc glue.

Doing this right requires some attention from board init logic,
based on how the TWL chip is wired.  Letting digital inputs float
will waste power.  Everyone with board schematics should update
their board init code so it matches their boards; meanwhile,
this returns to "current" behavior (all pullups disabled) but
finally offers a way to do it "right".

Note that the ULPI pins won't need this attention (muxed against
gpio{3-5,9-12,14} pins), and neither will ones with external
pullups or pulldowns (conventional for MMC/SD card detect).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/hsmmc.c |    6 ---
 drivers/gpio/twl4030-gpio.c |   78 ++++++++++++++++++++++---------------------
 include/linux/i2c/twl4030.h |    7 +++-
 3 files changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index cc67a1d..c6ff490 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -27,7 +27,6 @@
 #define VMMC1_DEDICATED		0x2A
 #define VSEL_3V			0x02
 #define VSEL_18V		0x00
-#define TWL_GPIO_PUPDCTR1	0x13
 #define TWL_GPIO_IMR1A		0x1C
 #define TWL_GPIO_ISR1A		0x19
 #define LDO_CLR			0x00
@@ -65,11 +64,6 @@ static int hsmmc_late_init(struct device *dev)
 	if (ret)
 		goto err;
 
-	ret = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0x02,
-						TWL_GPIO_PUPDCTR1);
-	if (ret)
-		goto err;
-
 	ret = twl4030_set_gpio_debounce(MMC1_CD_IRQ, TWL4030_GPIO_IS_ENABLE);
 	if (ret)
 		goto err;
diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index 40abcbd..47dc6e2 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -476,44 +476,6 @@ int twl4030_get_gpio_datain(int gpio)
 }
 EXPORT_SYMBOL(twl4030_get_gpio_datain);
 
-#if 0
-/*
- * Configure PULL type for a GPIO pin on TWL4030
- */
-int twl4030_set_gpio_pull(int gpio, int pull_dircn)
-{
-	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
-	u8 c_off = GET_GPIO_CTL_OFF(gpio);
-	u8 c_msk = 0;
-	u8 reg = 0;
-	u8 base = 0;
-	int ret = 0;
-
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)	||
-		!(gpio_usage_count & (0x1 << gpio))))
-		return -EPERM;
-
-	base = REG_GPIOPUPDCTR1 + c_bnk;
-	if (pull_dircn == TWL4030_GPIO_PULL_DOWN)
-		c_msk = MASK_GPIOPUPDCTR1_GPIOxPD(c_off);
-	else if (pull_dircn == TWL4030_GPIO_PULL_UP)
-		c_msk = MASK_GPIOPUPDCTR1_GPIOxPU(c_off);
-
-	mutex_lock(&gpio_lock);
-	ret = gpio_twl4030_read(base);
-	if (ret >= 0) {
-		/* clear the previous up/down values */
-		reg = (u8) (ret);
-		reg &= ~(MASK_GPIOPUPDCTR1_GPIOxPU(c_off) |
-			MASK_GPIOPUPDCTR1_GPIOxPD(c_off));
-		reg |= c_msk;
-		ret = gpio_twl4030_write(base, reg);
-	}
-	mutex_unlock(&gpio_lock);
-	return ret;
-}
-#endif
-
 static int twl4030_set_gpio_edge_ctrl(int gpio, int edge)
 {
 	u8 c_bnk = GET_GPIO_CTL_BANK(gpio);
@@ -578,6 +540,9 @@ EXPORT_SYMBOL(twl4030_set_gpio_debounce);
 #if 0
 /*
  * Configure Card detect for GPIO pin on TWL4030
+ *
+ * This means:  VMMC1 or VMMC2 is enabled or disabled based
+ * on the status of GPIO-0 or GPIO-1 pins (respectively).
  */
 int twl4030_set_gpio_card_detect(int gpio, int enable)
 {
@@ -800,6 +765,31 @@ static struct gpio_chip twl_gpiochip = {
 
 /*----------------------------------------------------------------------*/
 
+static int __devinit gpio_twl4030_pulls(u32 ups, u32 downs)
+{
+	u8		message[6];
+	unsigned	i, gpio_bit;
+
+	/* For most pins, a pulldown was enabled by default.
+	 * We should have data that's specific to this board.
+	 */
+	for (gpio_bit = 1, i = 1; i < 6; i++) {
+		u8		bit_mask;
+		unsigned	j;
+
+		for (bit_mask = 0, j = 0; j < 8; j += 2, gpio_bit <<= 1) {
+			if (ups & gpio_bit)
+				bit_mask |= 1 << (j + 1);
+			else if (downs & gpio_bit)
+				bit_mask |= 1 << (j + 0);
+		}
+		message[i] = bit_mask;
+	}
+
+	return twl4030_i2c_write(TWL4030_MODULE_GPIO, message,
+				REG_GPIOPUPDCTR1, 5);
+}
+
 static int gpio_twl4030_remove(struct platform_device *pdev);
 
 static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
@@ -875,6 +865,18 @@ static int __devinit gpio_twl4030_probe(struct platform_device *pdev)
 
 no_irqs:
 	if (!ret) {
+		/*
+		 * NOTE:  boards may waste power if they don't set pullups
+		 * and pulldowns correctly ... default for non-ULPI pins is
+		 * pulldown, and some other pins may have external pullups
+		 * or pulldowns.  Careful!
+		 */
+		ret = gpio_twl4030_pulls(pdata->pullups, pdata->pulldowns);
+		if (ret)
+			dev_dbg(&pdev->dev, "pullups %.05x %.05x --> %d\n",
+					pdata->pullups, pdata->pulldowns,
+					ret);
+
 		twl_gpiochip.base = pdata->gpio_base;
 		twl_gpiochip.ngpio = TWL4030_GPIO_MAX;
 		twl_gpiochip.dev = &pdev->dev;
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 1746733..f5a1bfa 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -62,8 +62,13 @@ struct twl4030_gpio_platform_data {
 	int		gpio_base;
 	unsigned	irq_base, irq_end;
 
-	/* for gpio-N, bit (1 << N) is set if pullup should be used */
+	/* For gpio-N, bit (1 << N) in "pullups" is set if that pullup
+	 * should be enabled.  Else, if that bit is set in "pulldowns",
+	 * that pulldown is enabled.  Don't waste power by letting any
+	 * digital inputs float...
+	 */
 	u32		pullups;
+	u32		pulldowns;
 
 	int		(*setup)(struct device *dev,
 				unsigned gpio, unsigned ngpio);
-- 
1.6.0.1.196.g01914

