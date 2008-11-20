From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc5 5/5] twl4030 cleanup symbols and OMAP dependency
Date: Wed, 19 Nov 2008 17:29:59 -0800
Message-ID: <200811191729.59506.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25996 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752658AbYKTBem (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 20:34:42 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Finish removing dependency of TWL driver stack on platform-specific 
IRQ definitions ... and remove the build dependency on OMAP.

This lets the TWL4030 code be included in test builds for most
platforms, and will make it easier for non-OMAP folk to update
most of this code for new APIs etc.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/Kconfig         |    2 +-
 include/linux/i2c/twl4030.h |   32 --------------------------------
 2 files changed, 1 insertion(+), 33 deletions(-)

--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -63,7 +63,7 @@ config UCB1400_CORE
 
 config TWL4030_CORE
 	bool "Texas Instruments TWL4030/TPS659x0 Support"
-	depends on I2C=y && GENERIC_HARDIRQS && (ARCH_OMAP2 || ARCH_OMAP3)
+	depends on I2C=y && GENERIC_HARDIRQS
 	help
 	  Say yes here if you have TWL4030 family chip on your board.
 	  This core driver provides register access and IRQ handling
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -363,33 +363,6 @@ struct twl4030_platform_data {
 
 int twl4030_sih_setup(int module);
 
-/*
- * FIXME completely stop using TWL4030_IRQ_BASE ... instead, pass the
- * IRQ data to subsidiary devices using platform device resources.
- */
-
-/* IRQ information-need base */
-#include <mach/irqs.h>
-/* TWL4030 interrupts */
-
-/* #define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0) */
-/* #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1) */
-/* #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2) */
-/* #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3) */
-/* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
-/* #define TWL4030_MODIRQ_PWR		(TWL4030_IRQ_BASE + 5) */
-
-/* #define TWL4030_PWRIRQ_PWRBTN		(TWL4030_PWR_IRQ_BASE + 0) */
-/* #define TWL4030_PWRIRQ_CHG_PRES		(TWL4030_PWR_IRQ_BASE + 1) */
-/* #define TWL4030_PWRIRQ_USB_PRES		(TWL4030_PWR_IRQ_BASE + 2) */
-/* #define TWL4030_PWRIRQ_RTC		(TWL4030_PWR_IRQ_BASE + 3) */
-/* #define TWL4030_PWRIRQ_HOT_DIE		(TWL4030_PWR_IRQ_BASE + 4) */
-/* #define TWL4030_PWRIRQ_PWROK_TIMEOUT	(TWL4030_PWR_IRQ_BASE + 5) */
-/* #define TWL4030_PWRIRQ_MBCHG		(TWL4030_PWR_IRQ_BASE + 6) */
-/* #define TWL4030_PWRIRQ_SC_DETECT	(TWL4030_PWR_IRQ_BASE + 7) */
-
-/* Rest are unsued currently*/
-
 /* Offsets to Power Registers */
 #define TWL4030_VDAC_DEV_GRP		0x3B
 #define TWL4030_VDAC_DEDICATED		0x3E
@@ -400,11 +373,6 @@ int twl4030_sih_setup(int module);
 #define TWL4030_VAUX3_DEV_GRP		0x1F
 #define TWL4030_VAUX3_DEDICATED		0x22
 
-/* TWL4030 GPIO interrupt definitions */
-
-#define TWL4030_GPIO_IRQ_NO(n)		(TWL4030_GPIO_IRQ_BASE + (n))
-
-
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
 	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
 	extern int twl4030charger_usb_en(int enable);
