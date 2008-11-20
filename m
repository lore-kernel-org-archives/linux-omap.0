From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc5 3/5] twl4030 MADC irq
Date: Wed, 19 Nov 2008 17:28:16 -0800
Message-ID: <200811191728.17100.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25978 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752561AbYKTBek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 20:34:40 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Disable the TWL4030_MODIRQ_MADC symbol and remove all its uses.
It's not needed any more now that platform_get_irq() works for
these MADC devices.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/i2c/chips/twl4030-madc.c |    4 ++--
 include/linux/i2c/twl4030.h      |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/i2c/chips/twl4030-madc.c
+++ b/drivers/i2c/chips/twl4030-madc.c
@@ -458,7 +458,7 @@ static int __init twl4030_madc_probe(str
 	ret = twl4030_i2c_write_u8(TWL4030_MODULE_MAIN_CHARGE,
 				   regval, TWL4030_BCI_BCICTL1);
 
-	ret = request_irq(TWL4030_MODIRQ_MADC, twl4030_madc_irq_handler,
+	ret = request_irq(platform_get_irq(pdev, 0), twl4030_madc_irq_handler,
 			  0, "twl4030_madc", madc);
 	if (ret) {
 		dev_dbg(&pdev->dev, "could not request irq\n");
@@ -489,7 +489,7 @@ static int __exit twl4030_madc_remove(st
 
 	twl4030_madc_set_power(madc, 0);
 	twl4030_madc_set_current_generator(madc, 0, 0);
-	free_irq(TWL4030_MODIRQ_MADC, madc);
+	free_irq(platform_get_irq(pdev, 0), madc);
 	cancel_work_sync(&madc->ws);
 	misc_deregister(&twl4030_madc_device);
 
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -375,7 +375,7 @@ int twl4030_sih_setup(int module);
 /* #define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0) */
 /* #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1) */
 /* #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2) */
-#define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
+/* #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3) */
 /* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
 /* #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5) */
 
