From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-rc6-omap1] twl4030:  improve rtc device setup
Date: Thu, 11 Sep 2008 02:48:39 -0700
Message-ID: <200809110248.39396.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:23428 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751905AbYIKJsl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2008 05:48:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Make the twl4030 RTC initialization follow the driver model better.
The platform device is created (if needed) as part of twl4030 setup
instead of as a board-specific thing, and fits properly into the
driver model tree.

The only minor glitch here is on boards using platform_data to pass
MSECURE initialization hooks to the RTC driver.  The right solution
probably just removes that platform_data, and might even make Linux
follow the principle of "least privilege" (at the hardware level!)
instead of always holding this signal high.

Pending better handling of MSECURE, this patch just does what the
RTC init does, but earlier:  MSECURE is always high, so the RTC time
and calendar registers can be updated (and presumably a bunch of
non-RTC privileged operations will be allowed too).

Yet to be done:  set up the IRQ resource; make the rtc driver use
that IRQ resource; and properly issue wakeup alarms.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
This is an example of what was discussed earlier ... starting
to clean up the twl4030 driver model support.  More can be done
when twl4030 becomes a new-style I2C driver; clean support for
things like the keypad, power control, and gpio will need that to
get proper handling for board-specific data.

Note the net code shrink from "doing it right" and sharing code.

 arch/arm/mach-omap2/board-2430sdp.c     |   34 +++++--------------
 arch/arm/mach-omap2/board-3430sdp.c     |   41 ++++-------------------
 arch/arm/mach-omap2/board-ldp.c         |   36 ++++----------------
 arch/arm/mach-omap2/board-omap3beagle.c |    8 ----
 arch/arm/mach-omap2/board-omap3evm.c    |    8 ----
 drivers/i2c/chips/twl4030-core.c        |   52 ++++++++++++++++++++++++++++++
 6 files changed, 76 insertions(+), 103 deletions(-)

--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -24,7 +24,6 @@
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
-#include <linux/i2c/twl4030-rtc.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -190,13 +189,14 @@ static struct platform_device sdp2430_kp
 	},
 };
 
-static int twl4030_rtc_init(void)
+static int __init msecure_init(void)
 {
 	int ret = 0;
 
-	ret = omap_request_gpio(TWL4030_MSECURE_GPIO);
+#ifdef CONFIG_RTC_DRV_TWL4030
+	ret = gpio_request(TWL4030_MSECURE_GPIO, "msecure");
 	if (ret < 0) {
-		printk(KERN_ERR "twl4030_rtc_init: can't reserve GPIO:%d !\n",
+		printk(KERN_ERR "msecure_init: can't reserve GPIO:%d !\n",
 			TWL4030_MSECURE_GPIO);
 		goto out;
 	}
@@ -205,36 +205,18 @@ static int twl4030_rtc_init(void)
 	 * Make msecure line high in order to change the TWL4030 RTC time
 	 * and calender registers.
 	 */
-	omap_set_gpio_direction(TWL4030_MSECURE_GPIO, 0);	/*dir out */
-	omap_set_gpio_dataout(TWL4030_MSECURE_GPIO, 1);
+	gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
 out:
-	return ret;
-}
+#endif
 
-static void twl4030_rtc_exit(void)
-{
-	omap_free_gpio(TWL4030_MSECURE_GPIO);
+	return ret;
 }
 
-static struct twl4030rtc_platform_data sdp2430_twl4030rtc_data = {
-	.init = &twl4030_rtc_init,
-	.exit = &twl4030_rtc_exit,
-};
-
-static struct platform_device sdp2430_twl4030rtc_device = {
- 	.name		= "twl4030_rtc",
- 	.id		= -1,
-	.dev		= {
-		.platform_data	= &sdp2430_twl4030rtc_data,
-	},
-};
-
 static struct platform_device *sdp2430_devices[] __initdata = {
 	&sdp2430_smc91x_device,
 	&sdp2430_flash_device,
 	&sdp2430_kp_device,
 	&sdp2430_lcd_device,
-	&sdp2430_twl4030rtc_device,	
 };
 
 static void ads7846_dev_init(void)
@@ -398,6 +380,8 @@ static void __init omap_2430sdp_init(voi
 	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
 	omap_serial_init();
 
+	msecure_init();
+
 	sdp2430_flash_init();
 	usb_musb_init();
 
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -20,9 +20,9 @@
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
-#include <linux/i2c/twl4030.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
+#include <linux/i2c/twl4030.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -129,20 +129,20 @@ static struct platform_device sdp3430_kp
 
 static int ts_gpio;
 
-#ifdef CONFIG_RTC_DRV_TWL4030
-static int twl4030_rtc_init(void)
+static int __init msecure_init(void)
 {
 	int ret = 0;
 
+#ifdef CONFIG_RTC_DRV_TWL4030
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
 	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
 		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
 
-		ret = omap_request_gpio(TWL4030_MSECURE_GPIO);
+		ret = gpio_request(TWL4030_MSECURE_GPIO, "msecure");
 		if (ret < 0) {
-			printk(KERN_ERR "twl4030_rtc_init: can't"
+			printk(KERN_ERR "msecure_init: can't"
 				"reserve GPIO:%d !\n", TWL4030_MSECURE_GPIO);
 			goto out;
 		}
@@ -151,41 +151,18 @@ static int twl4030_rtc_init(void)
 		 * is low. Make msecure line high in order to change the
 		 * TWL4030 RTC time and calender registers.
 		 */
-		omap_set_gpio_direction(TWL4030_MSECURE_GPIO, 0);
-
 		tmp = omap_readw(msecure_pad_config_reg);
 		tmp &= 0xF8; /* To enable mux mode 03/04 = GPIO_RTC */
 		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
 		omap_writew(tmp, msecure_pad_config_reg);
 
-		omap_set_gpio_dataout(TWL4030_MSECURE_GPIO, 1);
+		gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
 	}
 out:
+#endif
 	return ret;
 }
 
-static void twl4030_rtc_exit(void)
-{
-	if (is_device_type_gp() &&
-			is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
-		omap_free_gpio(TWL4030_MSECURE_GPIO);
-	}
-}
-
-static struct twl4030rtc_platform_data sdp3430_twl4030rtc_data = {
-	.init = &twl4030_rtc_init,
-	.exit = &twl4030_rtc_exit,
-};
-
-static struct platform_device sdp3430_twl4030rtc_device = {
-	.name = "twl4030_rtc",
-	.id = -1,
-	.dev = {
-	.platform_data = &sdp3430_twl4030rtc_data,
-	},
-};
-#endif
-
 /**
  * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
  *
@@ -276,9 +253,6 @@ static struct platform_device *sdp3430_d
 	&sdp3430_smc91x_device,
 	&sdp3430_kp_device,
 	&sdp3430_lcd_device,
-#ifdef CONFIG_RTC_DRV_TWL4030
-	&sdp3430_twl4030rtc_device,
-#endif
 };
 
 static inline void __init sdp3430_init_smc91x(void)
@@ -367,6 +341,7 @@ static void __init omap_3430sdp_init(voi
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
 	sdp3430_flash_init();
+	msecure_init();
 	twl4030_bci_battery_init();
 	omap_serial_init();
 	usb_musb_init();
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -22,7 +22,6 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
-#include <linux/i2c/twl4030-rtc.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -48,20 +47,20 @@
 
 static int ts_gpio;
 
-#ifdef CONFIG_RTC_DRV_TWL4030
-static int twl4030_rtc_init(void)
+static int __init msecure_init(void)
 {
 	int ret = 0;
 
+#ifdef CONFIG_RTC_DRV_TWL4030
 	/* 3430ES2.0 doesn't have msecure/gpio-22 line connected to T2 */
 	if (is_device_type_gp() && is_sil_rev_less_than(OMAP3430_REV_ES2_0)) {
 		u32 msecure_pad_config_reg = omap_ctrl_base_get() + 0xA3C;
 		int mux_mask = 0x04;
 		u16 tmp;
 
-		ret = omap_request_gpio(TWL4030_MSECURE_GPIO);
+		ret = gpio_request(TWL4030_MSECURE_GPIO, "msecure");
 		if (ret < 0) {
-			printk(KERN_ERR "twl4030_rtc_init: can't"
+			printk(KERN_ERR "msecure_init: can't"
 				"reserve GPIO:%d !\n", TWL4030_MSECURE_GPIO);
 			goto out;
 		}
@@ -70,38 +69,19 @@ static int twl4030_rtc_init(void)
 		 * is low. Make msecure line high in order to change the
 		 * TWL4030 RTC time and calender registers.
 		 */
-		omap_set_gpio_direction(TWL4030_MSECURE_GPIO, 0);
 
 		tmp = omap_readw(msecure_pad_config_reg);
 		tmp &= 0xF8;	/* To enable mux mode 03/04 = GPIO_RTC */
 		tmp |= mux_mask;/* To enable mux mode 03/04 = GPIO_RTC */
 		omap_writew(tmp, msecure_pad_config_reg);
 
-		omap_set_gpio_dataout(TWL4030_MSECURE_GPIO, 1);
+		gpio_direction_output(TWL4030_MSECURE_GPIO, 1);
 	}
 out:
+#endif
 	return ret;
 }
 
-static void twl4030_rtc_exit(void)
-{
-	omap_free_gpio(TWL4030_MSECURE_GPIO);
-}
-
-static struct twl4030rtc_platform_data ldp_twl4030rtc_data = {
-	.init = &twl4030_rtc_init,
-	.exit = &twl4030_rtc_exit,
-};
-
-static struct platform_device ldp_twl4030rtc_device = {
-	.name		= "twl4030_rtc",
-	.id		= -1,
-	.dev		= {
-		.platform_data	= &ldp_twl4030rtc_data,
-	},
-};
-#endif
-
 /**
  * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
  *
@@ -184,9 +164,6 @@ static struct spi_board_info ldp_spi_boa
 };
 
 static struct platform_device *ldp_devices[] __initdata = {
-#ifdef CONFIG_RTC_DRV_TWL4030
-	&ldp_twl4030rtc_device,
-#endif
 };
 
 static void __init omap_ldp_init_irq(void)
@@ -230,6 +207,7 @@ static void __init omap_ldp_init(void)
 	ldp_spi_board_info[0].irq = OMAP_GPIO_IRQ(ts_gpio);
 	spi_register_board_info(ldp_spi_board_info,
 				ARRAY_SIZE(ldp_spi_board_info));
+	msecure_init();
 	ads7846_dev_init();
 	omap_serial_init();
 	usb_musb_init();
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -132,11 +132,6 @@ static struct omap_mmc_config omap3beagl
 	},
 };
 
-static struct platform_device omap3_beagle_twl4030rtc_device = {
-	.name           = "twl4030_rtc",
-	.id             = -1,
-};
-
 static struct platform_device omap3_beagle_lcd_device = {
 	.name		= "omap3beagle_lcd",
 	.id		= -1,
@@ -202,9 +197,6 @@ static struct omap_board_config_kernel o
 
 static struct platform_device *omap3_beagle_devices[] __initdata = {
 	&omap3_beagle_lcd_device,
-#ifdef CONFIG_RTC_DRV_TWL4030
-	&omap3_beagle_twl4030rtc_device,
-#endif
 	&leds_gpio,
 	&keys_gpio,
 };
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -110,11 +110,6 @@ static struct omap_lcd_config omap3_evm_
 	.ctrl_name	= "internal",
 };
 
-static struct platform_device omap3_evm_twl4030rtc_device = {
-	.name		= "twl4030_rtc",
-	.id		= -1,
-};
-
 static void ads7846_dev_init(void)
 {
 	if (omap_request_gpio(OMAP3_EVM_TS_GPIO) < 0)
@@ -205,9 +200,6 @@ static struct omap_board_config_kernel o
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_lcd_device,
 	&omap3evm_kp_device,
-#ifdef CONFIG_RTC_DRV_TWL4030
-	&omap3_evm_twl4030rtc_device,
-#endif
 	&omap3evm_smc911x_device,
 };
 
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -37,6 +37,7 @@
 #include <linux/random.h>
 #include <linux/syscalls.h>
 #include <linux/kthread.h>
+#include <linux/platform_device.h>
 
 #include <linux/i2c.h>
 #include <linux/i2c/twl4030.h>
@@ -742,6 +743,55 @@ static int __init twl4030_detect_client(
 	return err;
 }
 
+static int add_children(void)
+{
+	static bool		children;
+
+	struct platform_device	*pdev = NULL;
+	struct twl4030_client	*twl = NULL;
+	int			status = 0;
+
+	/* FIXME this doesn't yet set up platform_data for anything;
+	 * it can't be available until this becomes a "new style"
+	 * I2C driver.  Similarly, a new style driver will know it
+	 * didn't already initialize its children.
+	 */
+
+	if (children)
+		return 0;
+
+#ifdef CONFIG_RTC_DRV_TWL4030
+	pdev = platform_device_alloc("twl4030_rtc", -1);
+	if (pdev) {
+		twl = &twl4030_modules[TWL4030_SLAVENUM_NUM3];
+		pdev->dev.parent = &twl->client.dev;
+		device_init_wakeup(&pdev->dev, 1);
+
+		/*
+		 * FIXME add the relevant IRQ resource, and make the
+		 * rtc driver use it instead of hard-wiring ...
+		 *
+		 * REVISIT platform_data here currently only supports
+		 * setting up the "msecure" line ... which actually
+		 * violates the "princple of least privilege", since
+		 * it's effectively always in "high trust" mode.
+		 *
+		 * For now, expect equivalent treatment at board init:
+		 * setting msecure high.  Eventually, Linux might
+		 * become more aware of those HW security concerns.
+		 */
+
+		status = platform_device_add(pdev);
+		if (status < 0)
+			platform_device_put(pdev);
+	} else
+		status = -ENOMEM;
+#endif
+
+	children = true;
+	return status;
+}
+
 /* adapter callback */
 static int __init twl4030_attach_adapter(struct i2c_adapter *adapter)
 {
@@ -759,6 +809,8 @@ static int __init twl4030_attach_adapter
 	}
 	twl_i2c_adapter++;
 
+	add_children();
+
 	/*
 	 * Check if the PIH module is initialized, if yes, then init
 	 * the T2 Interrupt subsystem
