From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP: switch to gpio_direction_output
Date: Fri, 28 Nov 2008 17:10:29 -0800
Message-ID: <20081129011028.12337.25575.stgit@localhost>
References: <20081129010728.12337.8217.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58097 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753455AbYK2BK2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 20:10:28 -0500
In-Reply-To: <20081129010728.12337.8217.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: David Brownell <dbrownell@users.sourceforge.net>, linux-omap@vger.kernel.org

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-h2.c         |    2 +-
 arch/arm/mach-omap1/board-palmz71.c    |    3 +--
 arch/arm/mach-omap1/board-sx1.c        |   11 +++--------
 arch/arm/mach-omap1/board-voiceblue.c  |    9 +++------
 arch/arm/mach-omap1/leds.c             |    4 ++--
 arch/arm/mach-omap2/board-apollon.c    |    3 +--
 arch/arm/plat-omap/gpio.c              |   14 --------------
 arch/arm/plat-omap/include/mach/gpio.h |    1 -
 8 files changed, 11 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index a2914ac..7329ad5 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -439,7 +439,7 @@ static void __init h2_init(void)
 #if defined(CONFIG_OMAP_IR) || defined(CONFIG_OMAP_IR_MODULE)
 	omap_writel(omap_readl(FUNC_MUX_CTRL_A) | 7, FUNC_MUX_CTRL_A);
 	if (!(omap_request_gpio(H2_IRDA_FIRSEL_GPIO_PIN))) {
-		omap_set_gpio_direction(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+		gpio_direction_output(H2_IRDA_FIRSEL_GPIO_PIN, 0);
 		h2_irda_data.transceiver_mode = h2_transceiver_mode;
 	}
 #endif
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 5a232ad..dec2010 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -323,8 +323,7 @@ palmz71_gpio_setup(int early)
 {
 	if (early) {
 		/* Only set GPIO1 so we have a working serial */
-		gpio_set_value(1, 1);
-		omap_set_gpio_direction(1, 0);
+		gpio_direction_output(1, 1);
 	} else {
 		/* Set MMC/SD host WP pin as input */
 		if (omap_request_gpio(PALMZ71_MMC_WP_GPIO)) {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 2230527..93bd395 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -436,14 +436,9 @@ static void __init omap_sx1_init(void)
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
-
+	gpio_direction_output(1, 1);	/*A_IRDA_OFF = 1 */
+	gpio_direction_output(11, 0);	/*A_SWITCH = 0 */
+	gpio_direction_output(15, 0);	/*A_USB_ON = 0 */
 }
 /*----------------------------------------*/
 static void __init omap_sx1_init_irq(void)
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 86e73b7..43b008f 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -171,8 +171,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(0);
 	/* smc91x reset */
 	omap_request_gpio(7);
-	omap_set_gpio_direction(7, 0);
-	gpio_set_value(7, 1);
+	gpio_direction_output(7, 1);
 	udelay(2);	/* wait at least 100ns */
 	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
@@ -180,8 +179,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(8);
 	/* 16C554 reset*/
 	omap_request_gpio(6);
-	omap_set_gpio_direction(6, 0);
-	gpio_set_value(6, 0);
+	gpio_direction_output(6, 0);
 	/* 16C554 interrupt pins */
 	omap_request_gpio(12);
 	omap_request_gpio(13);
@@ -244,8 +242,7 @@ static int wdt_gpio_state;
 
 void voiceblue_wdt_enable(void)
 {
-	omap_set_gpio_direction(0, 0);
-	gpio_set_value(0, 0);
+	gpio_direction_output(0, 0);
 	gpio_set_value(0, 1);
 	gpio_set_value(0, 0);
 	wdt_gpio_state = 0;
diff --git a/arch/arm/mach-omap1/leds.c b/arch/arm/mach-omap1/leds.c
index 6cdad93..540434e 100644
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
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index abc9167..ab6b8cd 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -360,8 +360,7 @@ static void __init apollon_usb_init(void)
 	/* DEVICE_SUSPEND */
 	omap_cfg_reg(P21_242X_GPIO12);
 	omap_request_gpio(12);
-	omap_set_gpio_direction(12, 0);		/* OUT */
-	gpio_set_value(12, 0);
+	gpio_direction_output(12, 0);
 }
 
 static void __init omap_apollon_init(void)
diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index c0322b5..a6dbef4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -333,19 +333,6 @@ static void _set_gpio_direction(struct gpio_bank *bank, int gpio, int is_input)
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
@@ -1741,7 +1728,6 @@ static int __init omap_gpio_sysinit(void)
 
 EXPORT_SYMBOL(omap_request_gpio);
 EXPORT_SYMBOL(omap_free_gpio);
-EXPORT_SYMBOL(omap_set_gpio_direction);
 
 arch_initcall(omap_gpio_sysinit);
 
diff --git a/arch/arm/plat-omap/include/mach/gpio.h b/arch/arm/plat-omap/include/mach/gpio.h
index d91ba32..552ad0c 100644
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

