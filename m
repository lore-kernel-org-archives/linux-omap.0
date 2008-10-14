From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git+ 6/5] twl4030 MMC card detction
Date: Tue, 14 Oct 2008 12:01:43 -0700
Message-ID: <200810141201.43612.david-b@pacbell.net>
References: <200810131259.50460.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:25363 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751390AbYJNTBq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2008 15:01:46 -0400
In-Reply-To: <200810131259.50460.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Replace stubbed-out card-detect support for twl4030 GPIOs with
a simpler platform_data mechanism.  As before, no current users.
Sanity tested by enabling this on Beagle; it booted OK with
root on MMC.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/gpio/twl4030-gpio.c |   52 +++++++++---------------------------------
 include/linux/i2c/twl4030.h |    3 ++
 2 files changed, 15 insertions(+), 40 deletions(-)

--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -46,8 +46,6 @@
  * intended to support multiple hosts.
  *
  * There are also two LED pins used sometimes as output-only GPIOs.
- *
- * FIXME code currently only handles the first IRQ line.
  */
 
 
@@ -235,41 +233,6 @@ int twl4030_set_gpio_debounce(int gpio, 
 }
 EXPORT_SYMBOL(twl4030_set_gpio_debounce);
 
-#if 0
-/*
- * Configure Card detect for GPIO pin on TWL4030
- *
- * This means:  VMMC1 or VMMC2 is enabled or disabled based
- * on the status of GPIO-0 or GPIO-1 pins (respectively).
- */
-int twl4030_set_gpio_card_detect(int gpio, int enable)
-{
-	u8 reg = 0;
-	u8 msk = (1 << gpio);
-	int ret = 0;
-
-	/* Only GPIO 0 or 1 can be used for CD feature.. */
-	if (unlikely((gpio >= TWL4030_GPIO_MAX)
-		|| !(gpio_usage_count & BIT(gpio))
-		|| (gpio >= TWL4030_GPIO_MAX_CD))) {
-		return -EPERM;
-	}
-
-	mutex_lock(&gpio_lock);
-	ret = gpio_twl4030_read(REG_GPIO_CTRL);
-	if (ret >= 0) {
-		if (enable)
-			reg = (u8) (ret | msk);
-		else
-			reg = (u8) (ret & ~msk);
-
-		ret = gpio_twl4030_write(REG_GPIO_CTRL, reg);
-	}
-	mutex_unlock(&gpio_lock);
-	return ret;
-}
-#endif
-
 /*----------------------------------------------------------------------*/
 
 static int twl_request(struct gpio_chip *chip, unsigned offset)
@@ -317,9 +280,18 @@ static int twl_request(struct gpio_chip 
 	}
 
 	/* on first use, turn GPIO module "on" */
-	if (!gpio_usage_count)
-		status = gpio_twl4030_write(REG_GPIO_CTRL,
-				MASK_GPIO_CTRL_GPIO_ON);
+	if (!gpio_usage_count) {
+		struct twl4030_gpio_platform_data *pdata;
+		u8 value = MASK_GPIO_CTRL_GPIO_ON;
+
+		/* optionally have the first two GPIOs switch vMMC1
+		 * and vMMC2 power supplies based on card presence.
+		 */
+		pdata = chip->dev->platform_data;
+		value |= pdata->mmc_cd & 0x03;
+
+		status = gpio_twl4030_write(REG_GPIO_CTRL, value);
+	}
 
 	if (!status)
 		gpio_usage_count |= (0x1 << offset);
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -231,6 +231,9 @@ struct twl4030_gpio_platform_data {
 	/* package the two LED signals as output-only GPIOs? */
 	bool		use_leds;
 
+	/* gpio-n should control VMMC(n+1) if BIT(n) in mmc_cd is set */
+	u8		mmc_cd;
+
 	/* For gpio-N, bit (1 << N) in "pullups" is set if that pullup
 	 * should be enabled.  Else, if that bit is set in "pulldowns",
 	 * that pulldown is enabled.  Don't waste power by letting any
