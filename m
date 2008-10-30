From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 3/5] switch to gpio_direction_output (OMAP and mainline)
Date: Thu, 30 Oct 2008 00:36:04 -0700
Message-ID: <200810300036.04681.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34858 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752972AbYJ3Hij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 03:38:39 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More conversion to the standard GPIO interfaces:  stop using
omap_set_gpio_direction() entirely, and switch over to the
gpio_direction_output() call.

Note that because gpio_direction_output() includes the initial
value, this change isn't quite transparent.

 - For the call sites which defined an initial value either
   before or after setting the direction, that value was used.

   When that value was previously assigned afterwards, this
   could eliminate a brief output glitch ... and possibly
   change behavior.  In a few cases (LCDs) several values
   were assigned together ... those were re-arranged to match
   the explicit sequence provided.

 - Some call sites didn't define such a value; so I chose an
   initial "off/reset" value that seemed to default to "off".

In short, files touched by this patch might notice some small
changes in startup behavior (with trivial fixes).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
 arch/arm/mach-omap1/board-h2.c         |    2 +-
 arch/arm/mach-omap1/board-palmz71.c    |    3 +--
 arch/arm/mach-omap1/board-sx1.c        |   10 +++-------
 arch/arm/mach-omap1/board-voiceblue.c  |    9 +++------
 arch/arm/mach-omap1/leds.c             |    4 ++--
 arch/arm/mach-omap2/board-apollon.c    |    3 +--
 arch/arm/plat-omap/gpio.c              |   14 --------------
 arch/arm/plat-omap/include/mach/gpio.h |    1 -
 8 files changed, 11 insertions(+), 35 deletions(-)

--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -533,7 +533,7 @@ static void __init h2_init(void)
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
 	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
-		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+		gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
 		h2_irda_data.transceiver_mode = h2_transceiver_mode;
 	}
 #endif
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -312,8 +312,7 @@ palmz71_gpio_setup(int early)
 {
 	if (early) {
 		/* Only set GPIO1 so we have a working serial */
-		gpio_set_value(1, 1);
-		omap_set_gpio_direction(1, 0);
+		gpio_direction_output(1, 1);
 	} else {
 		/* Set MMC/SD host WP pin as input */
 		if (omap_request_gpio(PALMZ71_MMC_WP_GPIO)) {
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -427,13 +427,9 @@ static void __init omap_sx1_init(void)
 	omap_request_gpio(1);	/* A_IRDA_OFF */
 	omap_request_gpio(11);	/* A_SWITCH */
 	omap_request_gpio(15);	/* A_USB_ON */
-	omap_set_gpio_direction(1, 0);/* gpio1 -> output */
-	omap_set_gpio_direction(11, 0);/* gpio11 -> output */
-	omap_set_gpio_direction(15, 0);/* gpio15 -> output */
-	/* set GPIO data */
-	gpio_set_value(1, 1);/*A_IRDA_OFF = 1 */
-	gpio_set_value(11, 0);/*A_SWITCH = 0 */
-	gpio_set_value(15, 0);/*A_USB_ON = 0 */
+	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
+	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
+	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
 }
 /*----------------------------------------*/
 static void __init omap_sx1_init_irq(void)
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -163,8 +163,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(0);
 	/* smc91x reset */
 	omap_request_gpio(7);
-	omap_set_gpio_direction(7, 0);
-	gpio_set_value(7, 1);
+	gpio_direction_output(7, 1);
 	udelay(2);	/* wait at least 100ns */
 	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
@@ -172,8 +171,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(8);
 	/* 16C554 reset*/
 	omap_request_gpio(6);
-	omap_set_gpio_direction(6, 0);
-	gpio_set_value(6, 0);
+	gpio_direction_output(6, 0);
 	/* 16C554 interrupt pins */
 	omap_request_gpio(12);
 	omap_request_gpio(13);
@@ -236,8 +234,7 @@ static int wdt_gpio_state;
 
 void voiceblue_wdt_enable(void)
 {
-	omap_set_gpio_direction(0, 0);
-	gpio_set_value(0, 0);
+	gpio_direction_output(0, 0);
 	gpio_set_value(0, 1);
 	gpio_set_value(0, 0);
 	wdt_gpio_state = 0;
--- a/arch/arm/mach-omap1/leds.c
+++ b/arch/arm/mach-omap1/leds.c
@@ -48,13 +48,13 @@ omap_leds_init(void)
 		 */
 		omap_cfg_reg(P18_1610_GPIO3);
 		if (omap_request_gpio(3) == 0)
-			omap_set_gpio_direction(3, 0);
+			gpio_direction_output(3, 1);
 		else
 			printk(KERN_WARNING "LED: can't get GPIO3/red?\n");
 
 		omap_cfg_reg(MPUIO4);
 		if (omap_request_gpio(OMAP_MPUIO(4)) == 0)
-			omap_set_gpio_direction(OMAP_MPUIO(4), 0);
+			gpio_direction_output(OMAP_MPUIO(4), 1);
 		else
 			printk(KERN_WARNING "LED: can't get MPUIO4/green?\n");
 	}
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -392,8 +392,7 @@ static void __init apollon_usb_init(void
 	/* DEVICE_SUSPEND */
 	omap_cfg_reg(P21_242X_GPIO12);
 	omap_request_gpio(12);
-	omap_set_gpio_direction(12, 0);		/* OUT */
-	gpio_set_value(12, 0);
+	gpio_direction_output(12, 0);
 }
 
 static void __init apollon_tsc_init(void)
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -332,19 +332,6 @@ static void _set_gpio_direction(struct g
 	__raw_writel(l, reg);
 }
 
-void omap_set_gpio_direction(int gpio, int is_input)
-{
-	struct gpio_bank *bank;
-	unsigned long flags;
-
-	if (check_gpio(gpio) < 0)
-		return;
-	bank = get_gpio_bank(gpio);
-	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_direction(bank, get_gpio_index(gpio), is_input);
-	spin_unlock_irqrestore(&bank->lock, flags);
-}
-
 static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
 {
 	void __iomem *reg = bank->base;
@@ -1740,7 +1727,6 @@ static int __init omap_gpio_sysinit(void
 
 EXPORT_SYMBOL(omap_request_gpio);
 EXPORT_SYMBOL(omap_free_gpio);
-EXPORT_SYMBOL(omap_set_gpio_direction);
 
 arch_initcall(omap_gpio_sysinit);
 
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -73,7 +73,6 @@
 extern int omap_gpio_init(void);	/* Call from board init only */
 extern int omap_request_gpio(int gpio);
 extern void omap_free_gpio(int gpio);
-extern void omap_set_gpio_direction(int gpio, int is_input);
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
