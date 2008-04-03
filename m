From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 3/3] I2C: TWL4030: Adapt existing drivers to power IRQ
Date: Thu,  3 Apr 2008 16:44:24 +0300
Message-ID: <1207230264-4629-3-git-send-email-felipe.balbi@nokia.com>
References: <1207230264-4629-1-git-send-email-felipe.balbi@nokia.com>
 <1207230264-4629-2-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64492 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466AbYDCNpp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 09:45:45 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m33DjLrn004358
	for <linux-omap@vger.kernel.org>; Thu, 3 Apr 2008 16:45:42 +0300
In-Reply-To: <1207230264-4629-2-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adapts the existing driver to use the power IRQ handler. This
patch superseeds any previous version.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-usb.c |   18 ++----------------
 drivers/rtc/rtc-twl4030.c       |   17 ++---------------
 include/linux/i2c/twl4030.h     |   10 ++++++++++
 3 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-usb.c b/drivers/i2c/chips/twl4030-usb.c
index 2db1c63..a238904 100644
--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -593,19 +593,6 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 	int ret = IRQ_NONE;
 	u8 val;
 
-	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_ISR1) < 0) {
-		printk(KERN_ERR "twl4030_usb: i2c read failed,"
-				" line %d\n", __LINE__);
-		goto done;
-	}
-
-	/* this interrupt line may be shared */
-	if (!(val & USB_PRES))
-		goto done;
-
-	/* clear the interrupt */
-	twl4030_i2c_write_u8(TWL4030_MODULE_INT, USB_PRES, REG_PWR_ISR1);
-
 	/* action based on cable attach or detach */
 	if (twl4030_i2c_read_u8(TWL4030_MODULE_INT, &val, REG_PWR_EDR1) < 0) {
 		printk(KERN_ERR "twl4030_usb: i2c read failed,"
@@ -708,14 +695,13 @@ static int __init twl4030_usb_init(void)
 
 	the_transceiver = twl;
 
-	twl->irq		= TWL4030_MODIRQ_PWR;
+	twl->irq		= TWL4030_PWRIRQ_USB_PRES;
 	twl->otg.set_host	= twl4030_set_host;
 	twl->otg.set_peripheral	= twl4030_set_peripheral;
 	twl->otg.set_suspend	= twl4030_set_suspend;
 
 	usb_irq_disable();
-	status = request_irq(twl->irq, twl4030_usb_irq,
-		IRQF_DISABLED | IRQF_SHARED, "twl4030_usb", twl);
+	status = request_irq(twl->irq, twl4030_usb_irq, 0, "twl4030_usb", twl);
 	if (status < 0) {
 		printk(KERN_DEBUG "can't get IRQ %d, err %d\n",
 			twl->irq, status);
diff --git a/drivers/rtc/rtc-twl4030.c b/drivers/rtc/rtc-twl4030.c
index 929a788..ca026b1 100644
--- a/drivers/rtc/rtc-twl4030.c
+++ b/drivers/rtc/rtc-twl4030.c
@@ -426,19 +426,6 @@ static irqreturn_t twl4030_rtc_interrupt(int irq, void *rtc)
 	int res;
 	u8 rd_reg;
 	
-	/* clear the RTC interrupt in TWL4030 power module */
-	res = twl4030_i2c_read_u8(TWL4030_MODULE_INT, &rd_reg, REG_PWR_ISR1);
-	if (res)
-		goto out;
-
-	/* Check if interrupt is sourced by RTC */
-	if (!(rd_reg & PWR_RTC_INT_CLR))
-		goto out;
-
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, PWR_RTC_INT_CLR, REG_PWR_ISR1);
-	if (res)
-		goto out;
-
 	res = twl4030_rtc_read_u8(&rd_reg, REG_RTC_STATUS_REG);
 	if (res)
 		goto out;
@@ -528,8 +515,8 @@ static int __devinit twl4030_rtc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out1;
 
-	ret = request_irq(TWL4030_MODIRQ_PWR, twl4030_rtc_interrupt,
-			  IRQF_DISABLED | IRQF_SHARED, rtc->dev.bus_id, rtc);
+	ret = request_irq(TWL4030_PWRIRQ_RTC, twl4030_rtc_interrupt,
+				0, rtc->dev.bus_id, rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
 		goto out1;
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 7f9b90d..fc11fd0 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -62,6 +62,16 @@
 #define TWL4030_MODIRQ_MADC		(IH_TWL4030_BASE + 3)
 #define TWL4030_MODIRQ_USB		(IH_TWL4030_BASE + 4)
 #define TWL4030_MODIRQ_PWR		(IH_TWL4030_BASE + 5)
+
+#define TWL4030_PWRIRQ_PWRBTN		(IH_TWL4030_PWRBASE + 0)
+#define TWL4030_PWRIRQ_CHG_PRES		(IH_TWL4030_PWRBASE + 1)
+#define TWL4030_PWRIRQ_USB_PRES		(IH_TWL4030_PWRBASE + 2)
+#define TWL4030_PWRIRQ_RTC		(IH_TWL4030_PWRBASE + 3)
+#define TWL4030_PWRIRQ_HOT_DIE		(IH_TWL4030_PWRBASE + 4)
+#define TWL4030_PWRIRQ_PWROK_TIMEOUT	(IH_TWL4030_PWRBASE + 5)
+#define TWL4030_PWRIRQ_MBCHG		(IH_TWL4030_PWRBASE + 6)
+#define TWL4030_PWRIRQ_SC_DETECT	(IH_TWL4030_PWRBASE + 7)
+
 /* Rest are unsued currently*/
 
 /* Offsets to Power Registers */
-- 
1.5.5.rc2.25.g5fbd

