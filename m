From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 14/25] minor irq-related cleanups
Date: Tue, 30 Sep 2008 21:42:58 +0300
Message-ID: <1222800189-29737-15-git-send-email-me@felipebalbi.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:60484 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbYI3StD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2008 14:49:03 -0400
In-Reply-To: <1222800189-29737-14-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <dbrownell@users.sourceforge.net>, Felipe Balbi <felipe.balbi@nokia.com>

From: David Brownell <dbrownell@users.sourceforge.net>

Minor IRQ-related cleanups:  comment out the no-longer-used
GPIO irq symbol (more to come, eventually); create RTC IRQ
resource; and use that RTC IRQ resource.

And incidentally, make the RTC code free the correct IRQ;
it was pretty goofed up...

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/gpio/twl4030-gpio.c      |    1 -
 drivers/i2c/chips/twl4030-core.c |   57 +++++++++++++++++++++----------------
 drivers/rtc/rtc-twl4030.c        |   11 +++++--
 include/linux/i2c/twl4030.h      |    2 +-
 4 files changed, 41 insertions(+), 30 deletions(-)

diff --git a/drivers/gpio/twl4030-gpio.c b/drivers/gpio/twl4030-gpio.c
index 2949da1..b65d476 100644
--- a/drivers/gpio/twl4030-gpio.c
+++ b/drivers/gpio/twl4030-gpio.c
@@ -49,7 +49,6 @@
 /* REVISIT when these symbols vanish elsewhere, remove them here too */
 /* #undef TWL4030_GPIO_IRQ_BASE */
 /* #undef TWL4030_GPIO_IRQ_END */
-#undef TWL4030_MODIRQ_GPIO
 
 static struct gpio_chip twl_gpiochip;
 static int twl4030_gpio_irq_base;
diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index 80cf231..e0a6ef4 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -776,37 +776,44 @@ static int add_children(struct twl4030_platform_data *pdata)
 	}
 
 	if (twl_has_rtc()) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+
 		pdev = platform_device_alloc("twl4030_rtc", -1);
-		if (pdev) {
-			twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+		if (!pdev) {
+			pr_debug("%s: can't alloc rtc dev\n", DRIVER_NAME);
+			status = -ENOMEM;
+		} else {
 			pdev->dev.parent = &twl->client->dev;
 			device_init_wakeup(&pdev->dev, 1);
+		}
 
-			/*
-			 * FIXME add the relevant IRQ resource, and make the
-			 * rtc driver use it instead of hard-wiring ...
-			 *
-			 * REVISIT platform_data here currently only supports
-			 * setting up the "msecure" line ... which actually
-			 * violates the "princple of least privilege", since
-			 * it's effectively always in "high trust" mode.
-			 *
-			 * For now, expect equivalent treatment at board init:
-			 * setting msecure high.  Eventually, Linux might
-			 * become more aware of those HW security concerns.
-			 */
+		/*
+		 * REVISIT platform_data here currently might use of
+		 * "msecure" line ... but for now we just expect board
+		 * setup to tell the chip "we are secure" at all times.
+		 * Eventually, Linux might become more aware of such
+		 * HW security concerns, and "least privilege".
+		 */
+
+		/* RTC module IRQ */
+		if (status == 0) {
+			struct resource	r = {
+				/* REVISIT don't hard-wire this stuff */
+				.start = TWL4030_PWRIRQ_RTC,
+				.flags = IORESOURCE_IRQ,
+			};
+
+			status = platform_device_add_resources(pdev, &r, 1);
+		}
 
+		if (status == 0)
 			status = platform_device_add(pdev);
-			if (status < 0) {
-				platform_device_put(pdev);
-				dev_dbg(&twl->client->dev,
-						"can't create rtc dev, %d\n",
-						status);
-				goto err;
-			}
-		} else {
-			pr_debug("%s: can't alloc rtc dev\n", DRIVER_NAME);
-			status = -ENOMEM;
+
+		if (status < 0) {
+			platform_device_put(pdev);
+			dev_dbg(&twl->client->dev,
+					"can't create rtc dev, %d\n",
+					status);
 			goto err;
 		}
 	}
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index 98aea07..b19151a 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -353,8 +353,12 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
 	struct rtc_device *rtc;
 	int ret = 0;
+	int irq = platform_get_irq(pdev, 0);
 	u8 rd_reg;
 
+	if (irq < 0)
+		return irq;
+
 	if (pdata != NULL && pdata->init != NULL) {
 		ret = pdata->init();
 		if (ret < 0)
@@ -389,7 +393,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out1;
 
-	ret = request_irq(TWL4030_PWRIRQ_RTC, twl4030_rtc_interrupt,
+	ret = request_irq(irq, twl4030_rtc_interrupt,
 				0, rtc->dev.bus_id, rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
@@ -438,7 +442,7 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 
 
 out2:
-	free_irq(TWL4030_MODIRQ_PWR, rtc);
+	free_irq(irq, rtc);
 out1:
 	rtc_device_unregister(rtc);
 out0:
@@ -457,11 +461,12 @@ static int __devexit twl4030_rtc_remove(struct platform_device *pdev)
 	/* leave rtc running, but disable irqs */
 	struct twl4030rtc_platform_data *pdata = pdev->dev.platform_data;
 	struct rtc_device *rtc = platform_get_drvdata(pdev);
+	int irq = platform_get_irq(pdev, 0);
 
 	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_ALARM_M);
 	mask_rtc_irq_bit(BIT_RTC_INTERRUPTS_REG_IT_TIMER_M);
 
-	free_irq(TWL4030_MODIRQ_PWR, rtc);
+	free_irq(irq, rtc);
 
 	if (pdata != NULL && pdata->exit != NULL)
 		pdata->exit();
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 404300c..5828485 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -108,7 +108,7 @@ struct twl4030_platform_data {
 #include <mach/irqs.h>
 /* TWL4030 interrupts */
 
-#define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0)
+/* #define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0) */
 #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1)
 #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2)
 #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
-- 
1.6.0.1.196.g01914

