From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 6/6] remove some gllobal twl4030 IRQ defines
Date: Fri, 10 Oct 2008 14:23:01 -0700
Message-ID: <200810101423.01759.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp126.sbc.mail.sp1.yahoo.com ([69.147.65.185]:44669 "HELO
	smtp126.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760871AbYJJV3x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Oct 2008 17:29:53 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Disable more unnecessary TWL4030_*IRQ_* symbols.

We're not yet ready to remove them all from <linux/i2c/twl4030.h>
since various drivers still use those symbols (maybe indirectly)
not platform resources: twl4030_bci_battery.c, twl4030-madc.c,
twl4030-pwrbutton.c, and omap-twl4030keypad.c all need updates.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-core.c  |   13 +++++++++----
 include/linux/i2c/twl4030.h |   16 ++++++++--------
 2 files changed, 17 insertions(+), 12 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -352,6 +352,12 @@ EXPORT_SYMBOL(twl4030_i2c_read_u8);
 
 /*----------------------------------------------------------------------*/
 
+/*
+ * NOTE:  We know the first 8 IRQs after pdata->base_irq are
+ * for the PIH, and the next are for the PWR_INT SIH, since
+ * that's how twl_init_irq() sets things up.
+ */
+
 static int add_children(struct twl4030_platform_data *pdata)
 {
 	struct platform_device	*pdev = NULL;
@@ -382,7 +388,7 @@ static int add_children(struct twl4030_p
 
 		if (status == 0) {
 			struct resource r = {
-				.start = TWL4030_PWRIRQ_CHG_PRES,
+				.start = pdata->irq_base + 8 + 1,
 				.flags = IORESOURCE_IRQ,
 			};
 
@@ -531,8 +537,7 @@ static int add_children(struct twl4030_p
 		/* RTC module IRQ */
 		if (status == 0) {
 			struct resource	r = {
-				/* REVISIT don't hard-wire this stuff */
-				.start = TWL4030_PWRIRQ_RTC,
+				.start = pdata->irq_base + 8 + 3,
 				.flags = IORESOURCE_IRQ,
 			};
 
@@ -577,7 +582,7 @@ static int add_children(struct twl4030_p
 
 		if (status == 0) {
 			struct resource r = {
-				.start = TWL4030_PWRIRQ_USB_PRES,
+				.start = pdata->irq_base + 8 + 2,
 				.flags = IORESOURCE_IRQ,
 			};
 
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -293,16 +293,16 @@ int twl4030_sih_setup(int module);
 #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2)
 #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
 /* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
-#define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5)
+/* #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5) */
 
 #define TWL4030_PWRIRQ_PWRBTN		(TWL4030_PWR_IRQ_BASE + 0)
-#define TWL4030_PWRIRQ_CHG_PRES		(TWL4030_PWR_IRQ_BASE + 1)
-#define TWL4030_PWRIRQ_USB_PRES		(TWL4030_PWR_IRQ_BASE + 2)
-#define TWL4030_PWRIRQ_RTC		(TWL4030_PWR_IRQ_BASE + 3)
-#define TWL4030_PWRIRQ_HOT_DIE		(TWL4030_PWR_IRQ_BASE + 4)
-#define TWL4030_PWRIRQ_PWROK_TIMEOUT	(TWL4030_PWR_IRQ_BASE + 5)
-#define TWL4030_PWRIRQ_MBCHG		(TWL4030_PWR_IRQ_BASE + 6)
-#define TWL4030_PWRIRQ_SC_DETECT	(TWL4030_PWR_IRQ_BASE + 7)
+/* #define TWL4030_PWRIRQ_CHG_PRES		(TWL4030_PWR_IRQ_BASE + 1) */
+/* #define TWL4030_PWRIRQ_USB_PRES		(TWL4030_PWR_IRQ_BASE + 2) */
+/* #define TWL4030_PWRIRQ_RTC		(TWL4030_PWR_IRQ_BASE + 3) */
+/* #define TWL4030_PWRIRQ_HOT_DIE		(TWL4030_PWR_IRQ_BASE + 4) */
+/* #define TWL4030_PWRIRQ_PWROK_TIMEOUT	(TWL4030_PWR_IRQ_BASE + 5) */
+/* #define TWL4030_PWRIRQ_MBCHG		(TWL4030_PWR_IRQ_BASE + 6) */
+/* #define TWL4030_PWRIRQ_SC_DETECT	(TWL4030_PWR_IRQ_BASE + 7) */
 
 /* Rest are unsued currently*/
 
