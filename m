From: Dominic Curran <dcurran@ti.com>
Subject: [PATCH 2/3] [OMAPZOOM] INPUT: Remove LDP gpio key hack from TWL4030 keyboard driver.
Date: Mon, 20 Oct 2008 14:46:14 -0500
Message-ID: <200810201446.14191.dcurran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34788 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752795AbYJTTqU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 15:46:20 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id m9KJkEAK005228
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:19 -0500
Received: from gromit.am.dhcp.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id m9KJkEqU025144
	for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 14:46:14 -0500 (CDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

A keypad hack was initially added when bringing up LDP.
This patch removes that hack from the TWL4030 keypad driver.

Signed-off-by: Dominic Curran <dcurran@ti.com>
---
 drivers/input/keyboard/omap-twl4030keypad.c |  145 ---------------------------
 1 files changed, 0 insertions(+), 145 deletions(-)

diff --git a/drivers/input/keyboard/omap-twl4030keypad.c 
b/drivers/input/keyboard/omap-twl4030keypad.c
index f1903c9..42b26bc 100644
--- a/drivers/input/keyboard/omap-twl4030keypad.c
+++ b/drivers/input/keyboard/omap-twl4030keypad.c
@@ -49,16 +49,6 @@
 #define KEYNUM_MASK		0x00FFFFFF
 #define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
 
-#ifdef CONFIG_MACH_OMAP_LDP
-static unsigned int *omap_gpios;
-static unsigned int cur_gpios[9];
-struct timer_list	gpio_timer;
-
-#define GET_GPIO(val)	(val >> 16) & 0xFFFF
-#define GET_KEY(val)	(val & 0xFFFF)
-
-#endif
-
 /* Global variables */
 
 struct omap_keypad {
@@ -250,133 +240,6 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_MACH_OMAP_LDP
-static void omap_gpio_kp_scan(struct omap_keypad *kp)
-{
-	unsigned int new_gpio;
-	int idx = 0, chg = 0, key, state;
-	bool key_down = 0;
-
-	while (omap_gpios[idx] != 0) {
-		new_gpio = omap_get_gpio_datain(GET_GPIO(omap_gpios[idx]));
-		chg = new_gpio ^ cur_gpios[idx];
-
-		if (chg) {
-			key = GET_KEY(omap_gpios[idx]);
-			state = (new_gpio == 0);
-			input_report_key(kp->omap_twl4030kp, key, state);
-		}
-
-		if (!new_gpio)
-			key_down = 1;
-
-		/* Store the keys current value. */
-		cur_gpios[idx] = new_gpio;
-		idx++;
-	}
-
-	/* Decide whether to kick off timer. */
-	if (key_down) {
-		int delay;
-
-		delay = HZ / 20;
-		/* A key is pressed - use timer to poll the keypad */
-		mod_timer(&gpio_timer, jiffies + delay);
-	}
-
-	return;
-}
-
-
-/*
- * Keypad interrupt handler for OMAP GPIO's.
- */
-static irqreturn_t do_kp_gpio_irq(int irq, void *_kp)
-{
-	struct omap_keypad *kp = _kp;
-
-	/* Scan keypad for any changes in GPIO keys. */
-	omap_gpio_kp_scan(kp);
-
-	return IRQ_HANDLED;
-}
-
-
-static void omap_gpio_kp_timer(unsigned long arg)
-{
-	struct omap_keypad *kp = (struct omap_keypad*)arg;
-	omap_gpio_kp_scan(kp);
-}
-
-static int
-omap_gpio_kp_probe(struct omap_keypad *kp, unsigned int *gpio_keymap)
-{
-	int i, idx = 0, irq_idx = 0;
-
-	/* set the global to the GPIO keymap data*/
-	omap_gpios = gpio_keymap;
-
-	while (omap_gpios[idx] != 0) {
-		/* initial values for current key state array. (1=Up,0=Down) */
-		cur_gpios[idx] = 1;
-
-		if (omap_request_gpio(GET_GPIO(omap_gpios[idx])) < 0) {
-			printk(KERN_ERR "Failed to request GPIO%d for keypad\n",
-				GET_GPIO(omap_gpios[idx]));
-			goto err1;
-		}
-
-		/* GPIO direction is 'Input' */
-		omap_set_gpio_direction(GET_GPIO(omap_gpios[idx]), 1);
-		idx++;
-	}
-
-	/* enable GPIO interrupts */
-	while (omap_gpios[irq_idx] != 0) {
-		if (request_irq(OMAP_GPIO_IRQ(GET_GPIO(omap_gpios[irq_idx])),
-				do_kp_gpio_irq, IRQF_TRIGGER_FALLING,
-				"omap-keypad", kp) < 0)
-			goto err2;
-		irq_idx++;
-	}
-
-	/* Initialize GPIO timer */
-	gpio_timer.function = omap_gpio_kp_timer;
-	gpio_timer.data     = (unsigned long)kp;
-	init_timer(&gpio_timer);
-
-	/* scan current key state */
-	omap_gpio_kp_scan(kp);
-
-	return 0;
-
-err2:
-	for (i = irq_idx - 1; i >= 0; i--)
-		free_irq(GET_GPIO(omap_gpios[i]), 0);
-err1:
-	for (i = idx - 1; i >= 0; i--)
-		omap_free_gpio(GET_GPIO(omap_gpios[i]));
-
-	return -EINVAL;
-}
-
-int omap_gpio_kp_remove(void)
-{
-	int idx = 0;
-
-	del_timer_sync(&gpio_timer);
-
-	while (omap_gpios[idx] != 0) {
-		free_irq(GET_GPIO(omap_gpios[idx]), 0);
-		omap_free_gpio(GET_GPIO(omap_gpios[idx]));
-		idx++;
-	}
-
-	return 0;
-}
-
-#endif /*CONFIG_MACH_OMAP_LDP*/
-
 
 /*
  * Registers keypad device with input sub system
@@ -515,10 +378,6 @@ static int __init omap_kp_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err4;
 
-#ifdef CONFIG_MACH_OMAP_LDP
-	omap_gpio_kp_probe(kp, pdata->row_gpios);
-#endif
-
 	return ret;
 err5:
 	/* mask all events - we don't care about the result */
@@ -539,10 +398,6 @@ static int omap_kp_remove(struct platform_device *pdev)
 
 	free_irq(kp->irq, kp);
 
-#ifdef CONFIG_MACH_OMAP_LDP
-	omap_gpio_kp_remove();
-#endif
-
 	input_unregister_device(kp->omap_twl4030kp);
 	kfree(kp);
 
-- 
1.5.4.1

