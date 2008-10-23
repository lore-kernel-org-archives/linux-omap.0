From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 3/4] remove omap_set_gpio_direction()
Date: Wed, 22 Oct 2008 23:56:20 -0700
Message-ID: <200810222356.21049.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27102 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752186AbYJWHCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

More conversion to the standard GPIO interfaces:  stop using
omap_set_gpio_direction() entirely, and switch over completely
to the gpio_direction_output() call.

Note that because gpio_direction_output() includes the initial
value, this change isn't quite transparent.

 - For the call sites which defined an initial value either
   before or after setting the direction, that value was used.

   When that value was previously assigned afterwards, this
   could eliminate a brief output glitch ... and possibly
   change behavior.  In a few cases (LCDs) several values
   were assigned together ... those were re-arranged to match
   the set-a-value sequence provided.

 - Some call sites didn't define such a value; so I chose an
   initial "off/reset" value that seemed to default to "off".

In short, files touched by this patch might notice some small
changes in startup behavior (with trivial fixes).

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-omap1/board-h2.c          |    2 +-
 arch/arm/mach-omap1/board-palmz71.c     |    3 +--
 arch/arm/mach-omap1/board-sx1.c         |   10 +++-------
 arch/arm/mach-omap1/board-voiceblue.c   |    9 +++------
 arch/arm/mach-omap1/leds.c              |    4 ++--
 arch/arm/mach-omap2/board-2430sdp.c     |    3 +--
 arch/arm/mach-omap2/board-apollon.c     |    3 +--
 arch/arm/mach-omap2/board-n800-camera.c |    3 +--
 arch/arm/mach-omap2/board-n800-mmc.c    |    9 +++------
 arch/arm/mach-omap2/board-n800-usb.c    |    2 +-
 arch/arm/mach-omap2/board-n800.c        |    8 +++-----
 arch/arm/plat-omap/gpio.c               |   14 --------------
 arch/arm/plat-omap/include/mach/gpio.h  |    1 -
 drivers/bluetooth/brf6150.c             |    4 ++--
 drivers/bluetooth/hci_h4p/core.c        |    4 ++--
 drivers/cbus/cbus.c                     |   13 ++++++-------
 drivers/leds/leds-omap.c                |    2 +-
 drivers/spi/tsc2301-core.c              |    3 +--
 drivers/usb/host/ehci-omap.c            |    6 ++----
 drivers/video/omap/lcd_2430sdp.c        |    4 ++--
 drivers/video/omap/lcd_omap2evm.c       |   18 ++++++------------
 drivers/video/omap/lcd_omap3evm.c       |   16 +++++-----------
 drivers/video/omap/lcd_p2.c             |    6 ++----
 sound/arm/omap/omap-alsa-sx1.c          |    2 +-
 24 files changed, 50 insertions(+), 99 deletions(-)

--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -536,7 +536,7 @@ static void __init h2_init(void)
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
@@ -162,8 +162,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(0);
 	/* smc91x reset */
 	omap_request_gpio(7);
-	omap_set_gpio_direction(7, 0);
-	gpio_set_value(7, 1);
+	gpio_direction_output(7, 1);
 	udelay(2);	/* wait at least 100ns */
 	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
@@ -171,8 +170,7 @@ static void __init voiceblue_init(void)
 	omap_request_gpio(8);
 	/* 16C554 reset*/
 	omap_request_gpio(6);
-	omap_set_gpio_direction(6, 0);
-	gpio_set_value(6, 0);
+	gpio_direction_output(6, 0);
 	/* 16C554 interrupt pins */
 	omap_request_gpio(12);
 	omap_request_gpio(13);
@@ -235,8 +233,7 @@ static int wdt_gpio_state;
 
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
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -407,8 +407,7 @@ static void __init omap_2430sdp_init(voi
 	hsmmc_init();
 
 	/* turn off secondary LCD backlight */
-	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
-	gpio_set_value(SECONDARY_LCD_GPIO, 0);
+	gpio_direction_output(SECONDARY_LCD_GPIO, 0);
 }
 
 static void __init omap_2430sdp_map_io(void)
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
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -363,8 +363,7 @@ void __init n800_cam_init(void)
 		return;
 	}
 
-	gpio_set_value(N800_CAM_SENSOR_RESET_GPIO, 0);
-	omap_set_gpio_direction(N800_CAM_SENSOR_RESET_GPIO, 0);
+	gpio_direction_output(N800_CAM_SENSOR_RESET_GPIO, 0);
 
 	sensor_okay = 1;
 }
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -349,19 +349,16 @@ void __init n800_mmc_init(void)
 
 	if (omap_request_gpio(slot_switch_gpio) < 0)
 		BUG();
-	gpio_set_value(slot_switch_gpio, 0);
-	omap_set_gpio_direction(slot_switch_gpio, 0);
+	gpio_direction_output(slot_switch_gpio, 0);
 
 	if (machine_is_nokia_n810()) {
 		if (omap_request_gpio(n810_slot2_pw_vddf) < 0)
 			BUG();
-		gpio_set_value(n810_slot2_pw_vddf, 0);
-		omap_set_gpio_direction(n810_slot2_pw_vddf, 0);
+		gpio_direction_output(n810_slot2_pw_vddf, 0);
 
 		if (omap_request_gpio(n810_slot2_pw_vdd) < 0)
 			BUG();
-		gpio_set_value(n810_slot2_pw_vdd, 0);
-		omap_set_gpio_direction(n810_slot2_pw_vdd, 0);
+		gpio_direction_output(n810_slot2_pw_vdd, 0);
 	}
 
 	mmc_data[0] = &mmc1_data;
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -156,7 +156,7 @@ void __init n800_usb_init(void)
 		       GPIO_TUSB_ENABLE);
 		return;
 	}
-	omap_set_gpio_direction(GPIO_TUSB_ENABLE, 0);
+	gpio_direction_output(GPIO_TUSB_ENABLE, 0);
 
 	tusb_set_power(0);
 
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -133,8 +133,7 @@ void __init nokia_n800_init_irq(void)
 		return;
 	}
 
-	omap_set_gpio_direction(N800_STI_GPIO, 0);
-	gpio_set_value(N800_STI_GPIO, 0);
+	gpio_direction_output(N800_STI_GPIO, 0);
 #endif
 }
 
@@ -258,8 +257,7 @@ static void __init blizzard_dev_init(voi
 	r = omap_request_gpio(N800_BLIZZARD_POWERDOWN_GPIO);
 	if (r < 0)
 		return;
-	omap_set_gpio_direction(N800_BLIZZARD_POWERDOWN_GPIO, 0);
-	gpio_set_value(N800_BLIZZARD_POWERDOWN_GPIO, 1);
+	gpio_direction_output(N800_BLIZZARD_POWERDOWN_GPIO, 1);
 
 	blizzard_get_clocks();
 	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
@@ -339,7 +337,7 @@ static int __init tea5761_dev_init(void)
 			return -ENODEV;
 		}
 
-		omap_set_gpio_direction(enable_gpio, 0);
+		gpio_direction_output(enable_gpio, 0);
 		udelay(50);
 		gpio_set_value(enable_gpio, 1);
 	}
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -334,19 +334,6 @@ static void _set_gpio_direction(struct g
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
@@ -1750,7 +1737,6 @@ static int __init omap_gpio_sysinit(void
 
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
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -943,8 +943,8 @@ static int __init brf6150_init(void)
 		return err;
 	}
 
-	omap_set_gpio_direction(info->btinfo->reset_gpio, 0);
-	omap_set_gpio_direction(info->btinfo->bt_wakeup_gpio, 0);
+	gpio_direction_output(info->btinfo->reset_gpio, 0);
+	gpio_direction_output(info->btinfo->bt_wakeup_gpio, 0);
 	gpio_direction_input(info->btinfo->host_wakeup_gpio);
 	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -852,8 +852,8 @@ static int hci_h4p_probe(struct platform
 		goto cleanup;
 	}
 
-	omap_set_gpio_direction(info->reset_gpio, 0);
-	omap_set_gpio_direction(info->bt_wakeup_gpio, 0);
+	gpio_direction_output(info->reset_gpio, 0);
+	gpio_direction_output(info->bt_wakeup_gpio, 0);
 	gpio_direction_input(info->host_wakeup_gpio);
 
 	switch (bt_config->bt_uart) {
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -99,9 +99,11 @@ static u8 cbus_receive_bit(struct cbus_h
 	return ret;
 }
 
+#define cbus_output(base, gpio, val)	cbus_set_gpio_direction(base, gpio, 0)
+
 #else
 
-#define cbus_set_gpio_direction(base, gpio, is_input) omap_set_gpio_direction(gpio, is_input)
+#define cbus_output(base, gpio, val)	gpio_direction_output(gpio, val)
 #define cbus_set_gpio_dataout(base, gpio, enable) gpio_set_value(gpio, enable)
 #define cbus_get_gpio_datain(base, int, gpio) gpio_get_value(gpio)
 
@@ -156,7 +158,7 @@ static int cbus_transfer(struct cbus_hos
 	cbus_set_gpio_dataout(base, host->sel_gpio, 0);
 
 	/* Set the DAT pin to output */
-	cbus_set_gpio_direction(base, host->dat_gpio, 0);
+	cbus_output(base, host->dat_gpio, 1);
 
 	/* Send the device address */
 	for (i = 3; i > 0; i--)
@@ -260,12 +262,9 @@ int __init cbus_bus_init(void)
 	if ((ret = omap_request_gpio(chost->sel_gpio)) < 0)
 		goto exit3;
 
-	gpio_set_value(chost->clk_gpio, 0);
-	gpio_set_value(chost->sel_gpio, 1);
-
-	omap_set_gpio_direction(chost->clk_gpio, 0);
+	gpio_direction_output(chost->clk_gpio, 0);
 	gpio_direction_input(chost->dat_gpio);
-	omap_set_gpio_direction(chost->sel_gpio, 0);
+	gpio_direction_output(chost->sel_gpio, 1);
 
 	gpio_set_value(chost->clk_gpio, 1);
 	gpio_set_value(chost->clk_gpio, 0);
--- a/drivers/leds/leds-omap.c
+++ b/drivers/leds/leds-omap.c
@@ -40,7 +40,7 @@ static void omap_configure_led_gpio(int 
 		printk(KERN_ERR "Failed to request GPIO%d for LEDs\n", gpio);
 		return;
 	}
-	omap_set_gpio_direction(gpio, 0);	/* OUT */
+	gpio_direction_output(gpio, 0);
 }
 
 static int omap_led_probe(struct platform_device *dev)
--- a/drivers/spi/tsc2301-core.c
+++ b/drivers/spi/tsc2301-core.c
@@ -161,8 +161,7 @@ static int __devinit tsc2301_probe(struc
 		r = omap_request_gpio(tsc->reset_gpio);
 		if (r < 0)
 			goto err1;
-		gpio_set_value(tsc->reset_gpio, 1);
-		omap_set_gpio_direction(tsc->reset_gpio, 0);
+		gpio_direction_output(tsc->reset_gpio, 1);
 		mdelay(1);
 		gpio_set_value(tsc->reset_gpio, 0);
 #endif
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -226,11 +226,9 @@ static int omap_start_ehc(struct platfor
 #ifdef EXTERNAL_PHY_RESET
 	/* Refer: ISSUE1 */
 	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT1);
-	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT1, 0);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT1, 0);
 	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
-	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT2, 0);
-	gpio_set_value(EXT_PHY_RESET_GPIO_PORT1, 0);
-	gpio_set_value(EXT_PHY_RESET_GPIO_PORT2, 0);
+	gpio_direction_output(EXT_PHY_RESET_GPIO_PORT2, 0);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
 #endif
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -67,8 +67,8 @@ static int sdp2430_panel_init(struct lcd
 
 	omap_request_gpio(enable_gpio);			/* LCD panel */
 	omap_request_gpio(backlight_gpio);		/* LCD backlight */
-	omap_set_gpio_direction(enable_gpio, 0);	/* output */
-	omap_set_gpio_direction(backlight_gpio, 0);	/* output */
+	gpio_direction_output(enable_gpio, 0);
+	gpio_direction_output(backlight_gpio, 0);
 
 	return 0;
 }
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -57,18 +57,12 @@ static int omap2evm_panel_init(struct lc
 	omap_request_gpio(LCD_PANEL_QVGA);
 	omap_request_gpio(LCD_PANEL_RESB);
 
-	omap_set_gpio_direction(LCD_PANEL_ENABLE_GPIO, 0);
-	omap_set_gpio_direction(LCD_PANEL_LR, 0);
-	omap_set_gpio_direction(LCD_PANEL_UD, 0);
-	omap_set_gpio_direction(LCD_PANEL_INI, 0);
-	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
-	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
-
-	gpio_set_value(LCD_PANEL_RESB, 1);
-	gpio_set_value(LCD_PANEL_INI, 1);
-	gpio_set_value(LCD_PANEL_QVGA, 0);
-	gpio_set_value(LCD_PANEL_LR, 1);
-	gpio_set_value(LCD_PANEL_UD, 1);
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_direction_output(LCD_PANEL_RESB, 1);
+	gpio_direction_output(LCD_PANEL_INI, 1);
+	gpio_direction_output(LCD_PANEL_QVGA, 0);
+	gpio_direction_output(LCD_PANEL_LR, 1);
+	gpio_direction_output(LCD_PANEL_UD, 1);
 
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -60,23 +60,17 @@ static int omap3evm_panel_init(struct lc
 	omap_request_gpio(LCD_PANEL_RESB);
 	omap_request_gpio(LCD_PANEL_QVGA);
 
-	omap_set_gpio_direction(LCD_PANEL_LR, 0);
-	omap_set_gpio_direction(LCD_PANEL_UD, 0);
-	omap_set_gpio_direction(LCD_PANEL_INI, 0);
-	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
-	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
+	gpio_direction_output(LCD_PANEL_RESB, 1);
+	gpio_direction_output(LCD_PANEL_INI, 1);
+	gpio_direction_output(LCD_PANEL_QVGA, 0);
+	gpio_direction_output(LCD_PANEL_LR, 1);
+	gpio_direction_output(LCD_PANEL_UD, 1);
 
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
 	bklight_level = 100;
 
-	gpio_set_value(LCD_PANEL_RESB, 1);
-	gpio_set_value(LCD_PANEL_INI, 1);
-	gpio_set_value(LCD_PANEL_QVGA, 0);
-	gpio_set_value(LCD_PANEL_LR, 1);
-	gpio_set_value(LCD_PANEL_UD, 1);
-
 	return 0;
 }
 
--- a/drivers/video/omap/lcd_p2.c
+++ b/drivers/video/omap/lcd_p2.c
@@ -165,8 +165,7 @@ static int p2_panel_enable(struct lcd_pa
 	unsigned long value;
 
 		/* thwack the reset line */
-	omap_set_gpio_direction(19, 0);
-	gpio_set_value(19, 0);
+	gpio_direction_output(19, 0);
 	mdelay(2);
 	gpio_set_value(19, 1);
 
@@ -257,8 +256,7 @@ static int p2_panel_enable(struct lcd_pa
 	omap_uwire_data_transfer(LCD_UWIRE_CS, LCD_DISON, 9, 0,NULL,1);
 
 	/* enable backlight */
-	omap_set_gpio_direction(134, 0);
-	gpio_set_value(134, 1);
+	gpio_direction_output(134, 1);
 
 	return 0;
 }
--- a/sound/arm/omap/omap-alsa-sx1.c
+++ b/sound/arm/omap/omap-alsa-sx1.c
@@ -216,7 +216,7 @@ static void egold_configure(void)
 static void egold_clock_setup(void)
 {
 	omap_request_gpio(OSC_EN);
-	omap_set_gpio_direction(OSC_EN, 0); /* output */
+	gpio_direction_output(OSC_EN, 0);
 	snd_printd("\n");
 }
 
