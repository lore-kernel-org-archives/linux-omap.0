From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 1/5] use gpio_direction_output (OMAP tree only)
Date: Thu, 30 Oct 2008 00:33:53 -0700
Message-ID: <200810300033.53268.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp120.sbc.mail.sp1.yahoo.com ([69.147.64.93]:34848 "HELO
	smtp120.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752972AbYJ3Hih (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Oct 2008 03:38:37 -0400
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
 arch/arm/mach-omap2/board-2430sdp.c     |    3 +--
 arch/arm/mach-omap2/board-n800-camera.c |    3 +--
 arch/arm/mach-omap2/board-n800-mmc.c    |    9 +++------
 arch/arm/mach-omap2/board-n800-usb.c    |    2 +-
 arch/arm/mach-omap2/board-n800.c        |    8 +++-----
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
 15 files changed, 38 insertions(+), 63 deletions(-)

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
@@ -346,19 +346,16 @@ void __init n800_mmc_init(void)
 
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
@@ -36,7 +36,7 @@ static void omap_configure_led_gpio(int 
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
