From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc5 1/5] twl4030 keypad irq & dependencies
Date: Wed, 19 Nov 2008 17:11:01 -0800
Message-ID: <200811191711.01802.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:25968 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752561AbYKTBej (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Nov 2008 20:34:39 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Disable the TWL4030_MODIRQ_KEYPAD symbol and remove all its uses.
It's not needed any more now that platform_get_irq() works for
these keypad devices.

Also remove inappropriate board-specific Kconfig dependencies.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap2/board-2430sdp.c         |    1 -
 arch/arm/mach-omap2/board-3430sdp.c         |    1 -
 arch/arm/mach-omap2/board-ldp.c             |    1 -
 arch/arm/mach-omap2/board-omap2evm.c        |    1 -
 arch/arm/mach-omap2/board-omap3evm.c        |    1 -
 drivers/input/keyboard/Kconfig              |    2 +-
 drivers/input/keyboard/omap-twl4030keypad.c |    2 +-
 include/linux/i2c/twl4030.h                 |    3 +--
 8 files changed, 3 insertions(+), 9 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -182,7 +182,6 @@ static struct twl4030_keypad_data sdp243
 	.keymap		= sdp2430_keymap,
 	.keymapsize	= ARRAY_SIZE(sdp2430_keymap),
 	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static int __init msecure_init(void)
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -118,7 +118,6 @@ static struct twl4030_keypad_data sdp343
 	.keymap		= sdp3430_keymap,
 	.keymapsize	= ARRAY_SIZE(sdp3430_keymap),
 	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static int ts_gpio;
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -101,7 +101,6 @@ static struct twl4030_keypad_data ldp_kp
 	.keymap		= ldp_twl4030_keymap,
 	.keymapsize	= ARRAY_SIZE(ldp_twl4030_keymap),
 	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static struct gpio_keys_button ldp_gpio_keys_buttons[] = {
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -273,7 +273,6 @@ static struct twl4030_keypad_data omap2e
 	.keymap		= omap2evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap2evm_keymap),
 	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static void __init omap2_evm_init_irq(void)
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -125,7 +125,6 @@ static struct twl4030_keypad_data omap3e
 	.keymap		= omap3evm_keymap,
 	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
 	.rep		= 1,
-	.irq		= TWL4030_MODIRQ_KEYPAD,
 };
 
 static struct twl4030_madc_platform_data omap3evm_madc_data = {
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -261,7 +261,7 @@ config KEYBOARD_OMAP
 
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030 keypad support"
-	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP2EVM || MACH_OMAP_3430SDP || MACH_OMAP3EVM || MACH_OMAP_LDP)
+	depends on TWL4030_CORE
 	help
 	  Say Y here if you want to use the OMAP TWL4030 keypad.
 
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -269,7 +269,7 @@ static int __init omap_kp_probe(struct p
 	kp->keymapsize = pdata->keymapsize;
 	kp->n_rows = pdata->rows;
 	kp->n_cols = pdata->cols;
-	kp->irq = pdata->irq;
+	kp->irq = platform_get_irq(pdev, 0);
 
 	/* setup input device */
 	set_bit(EV_KEY, kp->omap_twl4030kp->evbit);
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -259,7 +259,6 @@ struct twl4030_keypad_data {
 	int rows;
 	int cols;
 	int *keymap;
-	int irq;
 	unsigned int keymapsize;
 	unsigned int rep:1;
 };
@@ -374,7 +373,7 @@ int twl4030_sih_setup(int module);
 /* TWL4030 interrupts */
 
 /* #define TWL4030_MODIRQ_GPIO		(TWL4030_IRQ_BASE + 0) */
-#define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1)
+/* #define TWL4030_MODIRQ_KEYPAD		(TWL4030_IRQ_BASE + 1) */
 #define TWL4030_MODIRQ_BCI		(TWL4030_IRQ_BASE + 2)
 #define TWL4030_MODIRQ_MADC		(TWL4030_IRQ_BASE + 3)
 /* #define TWL4030_MODIRQ_USB		(TWL4030_IRQ_BASE + 4) */
