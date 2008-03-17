From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/14] ARM: OMAP: Use gpiolib with tps65010 for OSK 5912
Date: Mon, 17 Mar 2008 11:42:28 +0200
Message-ID: <1205746958-11242-5-git-send-email-tony@atomide.com>
References: omap-upstream-2008-03-17-114234
 <1205746958-11242-1-git-send-email-tony@atomide.com>
 <1205746958-11242-2-git-send-email-tony@atomide.com>
 <1205746958-11242-3-git-send-email-tony@atomide.com>
 <1205746958-11242-4-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:64289 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbYCQJn1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Mar 2008 05:43:27 -0400
In-Reply-To: <1205746958-11242-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, David Brownell <david-b@pacbell.net>, David Brownell <dbrownell@users.sourceforge.net>, Tony Lindgren <tony@atomide.com>

From: David Brownell <david-b@pacbell.net>

Convert OSK board to use new tps65010 gpiolib support.  This
includes moving its LED support from leds-osk to gpio-leds,
giving more trigger options and a net platform code shrink.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/board-osk.c       |  108 +++++++++++++++++++++------------
 arch/arm/mach-omap1/leds-osk.c        |   80 +------------------------
 include/asm-arm/arch-omap/board-osk.h |   11 +++
 3 files changed, 82 insertions(+), 117 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index dd9ece8..4f9baba 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -32,6 +32,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/i2c.h>
+#include <linux/leds.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
@@ -183,11 +184,80 @@ static struct platform_device *osk5912_devices[] __initdata = {
 	&osk5912_mcbsp1_device,
 };
 
+static struct gpio_led tps_leds[] = {
+	/* NOTE:  D9 and D2 have hardware blink support.
+	 * Also, D9 requires non-battery power.
+	 */
+	{ .gpio = OSK_TPS_GPIO_LED_D9, .name = "d9", },
+	{ .gpio = OSK_TPS_GPIO_LED_D2, .name = "d2", },
+	{ .gpio = OSK_TPS_GPIO_LED_D3, .name = "d3", .active_low = 1,
+			.default_trigger = "heartbeat", },
+};
+
+static struct gpio_led_platform_data tps_leds_data = {
+	.num_leds	= 3,
+	.leds		= tps_leds,
+};
+
+static struct platform_device osk5912_tps_leds = {
+	.name			= "leds-gpio",
+	.id			= 0,
+	.dev.platform_data	= &tps_leds_data,
+};
+
+static int osk_tps_setup(struct i2c_client *client, void *context)
+{
+	/* Set GPIO 1 HIGH to disable VBUS power supply;
+	 * OHCI driver powers it up/down as needed.
+	 */
+	gpio_request(OSK_TPS_GPIO_USB_PWR_EN, "n_vbus_en");
+	gpio_direction_output(OSK_TPS_GPIO_USB_PWR_EN, 1);
+
+	/* Set GPIO 2 high so LED D3 is off by default */
+	tps65010_set_gpio_out_value(GPIO2, HIGH);
+
+	/* Set GPIO 3 low to take ethernet out of reset */
+	gpio_request(OSK_TPS_GPIO_LAN_RESET, "smc_reset");
+	gpio_direction_output(OSK_TPS_GPIO_LAN_RESET, 0);
+
+	/* GPIO4 is VDD_DSP */
+	gpio_request(OSK_TPS_GPIO_DSP_PWR_EN, "dsp_power");
+	gpio_direction_output(OSK_TPS_GPIO_DSP_PWR_EN, 1);
+	/* REVISIT if DSP support isn't configured, power it off ... */
+
+	/* Let LED1 (D9) blink; leds-gpio may override it */
+	tps65010_set_led(LED1, BLINK);
+
+	/* Set LED2 off by default */
+	tps65010_set_led(LED2, OFF);
+
+	/* Enable LOW_PWR handshake */
+	tps65010_set_low_pwr(ON);
+
+	/* Switch VLDO2 to 3.0V for AIC23 */
+	tps65010_config_vregs1(TPS_LDO2_ENABLE | TPS_VLDO2_3_0V
+			| TPS_LDO1_ENABLE);
+
+	/* register these three LEDs */
+	osk5912_tps_leds.dev.parent = &client->dev;
+	platform_device_register(&osk5912_tps_leds);
+
+	return 0;
+}
+
+static struct tps65010_board tps_board = {
+	.base		= OSK_TPS_GPIO_BASE,
+	.outmask	= 0x0f,
+	.setup		= osk_tps_setup,
+};
+
 static struct i2c_board_info __initdata osk_i2c_board_info[] = {
 	{
 		I2C_BOARD_INFO("tps65010", 0x48),
 		.type		= "tps65010",
 		.irq		= OMAP_GPIO_IRQ(OMAP_MPUIO(1)),
+		.platform_data	= &tps_board,
+
 	},
 	/* TODO when driver support is ready:
 	 *  - aic23 audio chip at 0x1a
@@ -488,44 +558,6 @@ static void __init osk_map_io(void)
 	omap1_map_common_io();
 }
 
-#ifdef CONFIG_TPS65010
-static int __init osk_tps_init(void)
-{
-	if (!machine_is_omap_osk())
-		return 0;
-
-	/* Let LED1 (D9) blink */
-	tps65010_set_led(LED1, BLINK);
-
-	/* Disable LED 2 (D2) */
-	tps65010_set_led(LED2, OFF);
-
-	/* Set GPIO 1 HIGH to disable VBUS power supply;
-	 * OHCI driver powers it up/down as needed.
-	 */
-	tps65010_set_gpio_out_value(GPIO1, HIGH);
-
-	/* Set GPIO 2 low to turn on LED D3 */
-	tps65010_set_gpio_out_value(GPIO2, HIGH);
-
-	/* Set GPIO 3 low to take ethernet out of reset */
-	tps65010_set_gpio_out_value(GPIO3, LOW);
-
-	/* gpio4 for VDD_DSP */
-	/* FIXME send power to DSP iff it's configured */
-
-	/* Enable LOW_PWR */
-	tps65010_set_low_pwr(ON);
-
-	/* Switch VLDO2 to 3.0V for AIC23 */
-	tps65010_config_vregs1(TPS_LDO2_ENABLE | TPS_VLDO2_3_0V
-			| TPS_LDO1_ENABLE);
-
-	return 0;
-}
-fs_initcall(osk_tps_init);
-#endif
-
 MACHINE_START(OMAP_OSK, "TI-OSK")
 	/* Maintainer: Dirk Behme <dirk.behme@de.bosch.com> */
 	.phys_io	= 0xfff00000,
diff --git a/arch/arm/mach-omap1/leds-osk.c b/arch/arm/mach-omap1/leds-osk.c
index 026685e..754383d 100644
--- a/arch/arm/mach-omap1/leds-osk.c
+++ b/arch/arm/mach-omap1/leds-osk.c
@@ -1,11 +1,9 @@
 /*
  * linux/arch/arm/mach-omap1/leds-osk.c
  *
- * LED driver for OSK, and optionally Mistral QVGA, boards
+ * LED driver for OSK with optional Mistral QVGA board
  */
 #include <linux/init.h>
-#include <linux/workqueue.h>
-#include <linux/i2c/tps65010.h>
 
 #include <asm/hardware.h>
 #include <asm/leds.h>
@@ -20,49 +18,11 @@
 #define LED_STATE_CLAIMED	(1 << 1)
 static u8 led_state;
 
-#define	GREEN_LED		(1 << 0)	/* TPS65010 LED1 */
-#define	AMBER_LED		(1 << 1)	/* TPS65010 LED2 */
-#define	RED_LED			(1 << 2)	/* TPS65010 GPIO2 */
 #define	TIMER_LED		(1 << 3)	/* Mistral board */
 #define	IDLE_LED		(1 << 4)	/* Mistral board */
 static u8 hw_led_state;
 
 
-/* TPS65010 leds are changed using i2c -- from a task context.
- * Using one of these for the "idle" LED would be impractical...
- */
-#define	TPS_LEDS	(GREEN_LED | RED_LED | AMBER_LED)
-
-static u8 tps_leds_change;
-
-static void tps_work(struct work_struct *unused)
-{
-	for (;;) {
-		u8	leds;
-
-		local_irq_disable();
-		leds = tps_leds_change;
-		tps_leds_change = 0;
-		local_irq_enable();
-
-		if (!leds)
-			break;
-
-		/* careful:  the set_led() value is on/off/blink */
-		if (leds & GREEN_LED)
-			tps65010_set_led(LED1, !!(hw_led_state & GREEN_LED));
-		if (leds & AMBER_LED)
-			tps65010_set_led(LED2, !!(hw_led_state & AMBER_LED));
-
-		/* the gpio led doesn't have that issue */
-		if (leds & RED_LED)
-			tps65010_set_gpio_out_value(GPIO2,
-					!(hw_led_state & RED_LED));
-	}
-}
-
-static DECLARE_WORK(work, tps_work);
-
 #ifdef	CONFIG_OMAP_OSK_MISTRAL
 
 /* For now, all system indicators require the Mistral board, since that
@@ -112,7 +72,6 @@ void osk_leds_event(led_event_t evt)
 	case led_stop:
 		led_state &= ~LED_STATE_ENABLED;
 		hw_led_state = 0;
-		/* NOTE:  work may still be pending!! */
 		break;
 
 	case led_claim:
@@ -145,48 +104,11 @@ void osk_leds_event(led_event_t evt)
 
 #endif	/* CONFIG_OMAP_OSK_MISTRAL */
 
-	/* "green" == tps LED1 (leftmost, normally power-good)
-	 * works only with DC adapter, not on battery power!
-	 */
-	case led_green_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= GREEN_LED;
-		break;
-	case led_green_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~GREEN_LED;
-		break;
-
-	/* "amber" == tps LED2 (middle) */
-	case led_amber_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= AMBER_LED;
-		break;
-	case led_amber_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~AMBER_LED;
-		break;
-
-	/* "red" == LED on tps gpio3 (rightmost) */
-	case led_red_on:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state |= RED_LED;
-		break;
-	case led_red_off:
-		if (led_state & LED_STATE_CLAIMED)
-			hw_led_state &= ~RED_LED;
-		break;
-
 	default:
 		break;
 	}
 
 	leds ^= hw_led_state;
-	leds &= TPS_LEDS;
-	if (leds && (led_state & LED_STATE_CLAIMED)) {
-		tps_leds_change |= leds;
-		schedule_work(&work);
-	}
 
 done:
 	local_irq_restore(flags);
diff --git a/include/asm-arm/arch-omap/board-osk.h b/include/asm-arm/arch-omap/board-osk.h
index 2b1a8a4..9492609 100644
--- a/include/asm-arm/arch-omap/board-osk.h
+++ b/include/asm-arm/arch-omap/board-osk.h
@@ -32,5 +32,16 @@
 /* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
 #define OMAP_OSK_ETHR_START		0x04800300
 
+/* TPS65010 has four GPIOs.  nPG and LED2 can be treated like GPIOs with
+ * alternate pin configurations for hardware-controlled blinking.
+ */
+#define OSK_TPS_GPIO_BASE		(OMAP_MAX_GPIO_LINES + 16 /* MPUIO */)
+#	define OSK_TPS_GPIO_USB_PWR_EN	(OSK_TPS_GPIO_BASE + 0)
+#	define OSK_TPS_GPIO_LED_D3	(OSK_TPS_GPIO_BASE + 1)
+#	define OSK_TPS_GPIO_LAN_RESET	(OSK_TPS_GPIO_BASE + 2)
+#	define OSK_TPS_GPIO_DSP_PWR_EN	(OSK_TPS_GPIO_BASE + 3)
+#	define OSK_TPS_GPIO_LED_D9	(OSK_TPS_GPIO_BASE + 4)
+#	define OSK_TPS_GPIO_LED_D2	(OSK_TPS_GPIO_BASE + 5)
+
 #endif /*  __ASM_ARCH_OMAP_OSK_H */
 
-- 
1.5.3.6

