From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.27-omap-git 1/4] remove omap_set_gpio_dataout() and omap_get_gpio_datain()
Date: Wed, 22 Oct 2008 23:53:56 -0700
Message-ID: <200810222353.56683.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:27097 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750930AbYJWHCO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:14 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

This patch replaces some legacy OMAP GPIO calls with the "new" (not
really, any more!) calls that work on most platforms.

The calls addressed by this patch are the simple ones to get and set
values.  Except for the declarations and definitions of those calls,
and the Documentation file, all of these changes were performed by a
simple SED script.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 Documentation/arm/OMAP/gpio             |   15 +++++++++++++++
 arch/arm/mach-omap1/board-fsample.c     |    2 +-
 arch/arm/mach-omap1/board-h2.c          |    6 +++---
 arch/arm/mach-omap1/board-h3.c          |    2 +-
 arch/arm/mach-omap1/board-nokia770.c    |   10 +++++-----
 arch/arm/mach-omap1/board-palmte.c      |    6 +++---
 arch/arm/mach-omap1/board-palmtt.c      |    2 +-
 arch/arm/mach-omap1/board-palmz71.c     |    6 +++---
 arch/arm/mach-omap1/board-perseus2.c    |    2 +-
 arch/arm/mach-omap1/board-sx1.c         |    6 +++---
 arch/arm/mach-omap1/board-voiceblue.c   |   20 ++++++++++----------
 arch/arm/mach-omap1/leds-h2p2-debug.c   |   10 +++++-----
 arch/arm/mach-omap1/leds-osk.c          |    4 ++--
 arch/arm/mach-omap2/board-2430sdp.c     |    4 ++--
 arch/arm/mach-omap2/board-3430sdp.c     |    2 +-
 arch/arm/mach-omap2/board-apollon.c     |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-n800-camera.c |    6 +++---
 arch/arm/mach-omap2/board-n800-mmc.c    |   18 +++++++++---------
 arch/arm/mach-omap2/board-n800-usb.c    |    6 +++---
 arch/arm/mach-omap2/board-n800.c        |   12 ++++++------
 arch/arm/mach-omap2/board-omap2evm.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/plat-omap/debug-leds.c         |   10 +++++-----
 arch/arm/plat-omap/gpio-switch.c        |   10 +++++-----
 arch/arm/plat-omap/gpio.c               |   21 +++------------------
 arch/arm/plat-omap/include/mach/gpio.h  |    2 --
 drivers/bluetooth/brf6150.c             |   18 +++++++++---------
 drivers/bluetooth/hci_h4p/core.c        |   24 ++++++++++++------------
 drivers/cbus/cbus.c                     |   24 ++++++++++++------------
 drivers/leds/leds-omap.c                |    4 ++--
 drivers/mtd/onenand/omap2.c             |    2 +-
 drivers/spi/tsc2301-core.c              |    4 ++--
 drivers/usb/host/ehci-omap.c            |    8 ++++----
 drivers/video/omap/lcd_2430sdp.c        |    8 ++++----
 drivers/video/omap/lcd_omap2evm.c       |   14 +++++++-------
 drivers/video/omap/lcd_omap3beagle.c    |    4 ++--
 drivers/video/omap/lcd_omap3evm.c       |   14 +++++++-------
 drivers/video/omap/lcd_p2.c             |    6 +++---
 sound/arm/omap/omap-alsa-sx1.c          |    4 ++--
 40 files changed, 161 insertions(+), 163 deletions(-)

--- a/Documentation/arm/OMAP/gpio
+++ b/Documentation/arm/OMAP/gpio
@@ -9,6 +9,21 @@ or less GPIOs) to other OMAP processors 
 If anything is missing, is wrong, needs extension or update, please send
 update to Linux-omap-open-source@linux.omap.com.
 
+	*************************************************************
+
+	NOTICE:  these OMAP-specific interfaces are deprecated/obsolete.
+
+	See Documentation/gpio.txt for information on the standard
+	cross-platform GPIO interface.  All new code should use those
+	calls instead of the ones described here.
+
+	The only exception to that policy is the omap_cfg_reg() call,
+	which isn't a GPIO-specific interface; it configures how chip
+	functions are multiplexed to pins, with GPIO being only one
+	of those functions.
+
+	*************************************************************
+
 I. GPIO Modules/Banks
 ---------------------
 
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -205,7 +205,7 @@ static struct platform_device *devices[]
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
 static struct omap_uart_config fsample_uart_config __initdata = {
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -257,9 +257,9 @@ static struct platform_device h2_kp_devi
 static int h2_transceiver_mode(struct device *dev, int state)
 {
 	if (state & IR_SIRMODE)
-		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 0);
+		gpio_set_value(H2_IRDA_FIRSEL_GPIO_PIN, 0);
 	else    /* MIR/FIR */
-		omap_set_gpio_dataout(H2_IRDA_FIRSEL_GPIO_PIN, 1);
+		gpio_set_value(H2_IRDA_FIRSEL_GPIO_PIN, 1);
 
 	return 0;
 }
@@ -503,7 +503,7 @@ static struct omap_board_config_kernel h
 
 static int h2_nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(H2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(H2_NAND_RB_GPIO_PIN);
 }
 
 static void __init h2_init(void)
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -479,7 +479,7 @@ static struct omap_board_config_kernel h
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(H3_NAND_RB_GPIO_PIN);
+	return gpio_get_value(H3_NAND_RB_GPIO_PIN);
 }
 
 #if defined(CONFIG_VIDEO_OV9640) || defined(CONFIG_VIDEO_OV9640_MODULE)
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -104,7 +104,7 @@ static void mipid_shutdown(struct mipid_
 {
 	if (pdata->nreset_gpio != -1) {
 		printk(KERN_INFO "shutdown LCD\n");
-		omap_set_gpio_dataout(pdata->nreset_gpio, 0);
+		gpio_set_value(pdata->nreset_gpio, 0);
 		msleep(120);
 	}
 }
@@ -132,7 +132,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(ADS7846_PENDOWN_GPIO);
+	return !gpio_get_value(ADS7846_PENDOWN_GPIO);
 }
 
 static struct ads7846_platform_data nokia770_ads7846_platform_data __initdata = {
@@ -313,9 +313,9 @@ static void nokia770_audio_pwr_up(void)
 	/* Turn on codec */
 	aic23_power_up();
 
-	if (omap_get_gpio_datain(HEADPHONE_GPIO))
+	if (gpio_get_value(HEADPHONE_GPIO))
 		/* HP not connected, turn on amplifier */
-		omap_set_gpio_dataout(AMPLIFIER_CTRL_GPIO, 1);
+		gpio_set_value(AMPLIFIER_CTRL_GPIO, 1);
 	else
 		/* HP connected, do not turn on amplifier */
 		printk("HP connected\n");
@@ -335,7 +335,7 @@ static DECLARE_DELAYED_WORK(codec_power_
 static void nokia770_audio_pwr_down(void)
 {
 	/* Turn off amplifier */
-	omap_set_gpio_dataout(AMPLIFIER_CTRL_GPIO, 0);
+	gpio_set_value(AMPLIFIER_CTRL_GPIO, 0);
 
 	/* Turn off codec: schedule delayed work */
 	schedule_delayed_work(&codec_power_down_work, HZ / 20);	/* 50ms */
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -247,7 +247,7 @@ static void palmte_get_power_status(stru
 {
 	int charging, batt, hi, lo, mid;
 
-	charging = !omap_get_gpio_datain(PALMTE_DC_GPIO);
+	charging = !gpio_get_value(PALMTE_DC_GPIO);
 	batt = battery[0];
 	if (charging)
 		batt -= 60;
@@ -326,11 +326,11 @@ static void palmte_headphones_detect(voi
 {
 	if (state) {
 		/* Headphones connected, disable speaker */
-		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 0);
+		gpio_set_value(PALMTE_SPEAKER_GPIO, 0);
 		printk(KERN_INFO "PM: speaker off\n");
 	} else {
 		/* Headphones unplugged, re-enable speaker */
-		omap_set_gpio_dataout(PALMTE_SPEAKER_GPIO, 1);
+		gpio_set_value(PALMTE_SPEAKER_GPIO, 1);
 		printk(KERN_INFO "PM: speaker on\n");
 	}
 }
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -268,7 +268,7 @@ static struct platform_device *palmtt_de
 
 static int palmtt_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(6);
+	return !gpio_get_value(6);
 }
 
 static const struct ads7846_platform_data palmtt_ts_info = {
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -239,7 +239,7 @@ static struct platform_device *devices[]
 static int
 palmz71_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(PALMZ71_PENIRQ_GPIO);
+	return !gpio_get_value(PALMZ71_PENIRQ_GPIO);
 }
 
 static const struct ads7846_platform_data palmz71_ts_info = {
@@ -284,7 +284,7 @@ static struct omap_board_config_kernel p
 static irqreturn_t
 palmz71_powercable(int irq, void *dev_id)
 {
-	if (omap_get_gpio_datain(PALMZ71_USBDETECT_GPIO)) {
+	if (gpio_get_value(PALMZ71_USBDETECT_GPIO)) {
 		printk(KERN_INFO "PM: Power cable connected\n");
 		set_irq_type(OMAP_GPIO_IRQ(PALMZ71_USBDETECT_GPIO),
 				IRQ_TYPE_EDGE_FALLING);
@@ -312,7 +312,7 @@ palmz71_gpio_setup(int early)
 {
 	if (early) {
 		/* Only set GPIO1 so we have a working serial */
-		omap_set_gpio_dataout(1, 1);
+		gpio_set_value(1, 1);
 		omap_set_gpio_direction(1, 0);
 	} else {
 		/* Set MMC/SD host WP pin as input */
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -205,7 +205,7 @@ static struct platform_device *devices[]
 
 static int nand_dev_ready(struct omap_nand_platform_data *data)
 {
-	return omap_get_gpio_datain(P2_NAND_RB_GPIO_PIN);
+	return gpio_get_value(P2_NAND_RB_GPIO_PIN);
 }
 
 static struct omap_uart_config perseus2_uart_config __initdata = {
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -431,9 +431,9 @@ static void __init omap_sx1_init(void)
 	omap_set_gpio_direction(11, 0);/* gpio11 -> output */
 	omap_set_gpio_direction(15, 0);/* gpio15 -> output */
 	/* set GPIO data */
-	omap_set_gpio_dataout(1, 1);/*A_IRDA_OFF = 1 */
-	omap_set_gpio_dataout(11, 0);/*A_SWITCH = 0 */
-	omap_set_gpio_dataout(15, 0);/*A_USB_ON = 0 */
+	gpio_set_value(1, 1);/*A_IRDA_OFF = 1 */
+	gpio_set_value(11, 0);/*A_SWITCH = 0 */
+	gpio_set_value(15, 0);/*A_USB_ON = 0 */
 }
 /*----------------------------------------*/
 static void __init omap_sx1_init_irq(void)
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -163,16 +163,16 @@ static void __init voiceblue_init(void)
 	/* smc91x reset */
 	omap_request_gpio(7);
 	omap_set_gpio_direction(7, 0);
-	omap_set_gpio_dataout(7, 1);
+	gpio_set_value(7, 1);
 	udelay(2);	/* wait at least 100ns */
-	omap_set_gpio_dataout(7, 0);
+	gpio_set_value(7, 0);
 	mdelay(50);	/* 50ms until PHY ready */
 	/* smc91x interrupt pin */
 	omap_request_gpio(8);
 	/* 16C554 reset*/
 	omap_request_gpio(6);
 	omap_set_gpio_direction(6, 0);
-	omap_set_gpio_dataout(6, 0);
+	gpio_set_value(6, 0);
 	/* 16C554 interrupt pins */
 	omap_request_gpio(12);
 	omap_request_gpio(13);
@@ -236,17 +236,17 @@ static int wdt_gpio_state;
 void voiceblue_wdt_enable(void)
 {
 	omap_set_gpio_direction(0, 0);
-	omap_set_gpio_dataout(0, 0);
-	omap_set_gpio_dataout(0, 1);
-	omap_set_gpio_dataout(0, 0);
+	gpio_set_value(0, 0);
+	gpio_set_value(0, 1);
+	gpio_set_value(0, 0);
 	wdt_gpio_state = 0;
 }
 
 void voiceblue_wdt_disable(void)
 {
-	omap_set_gpio_dataout(0, 0);
-	omap_set_gpio_dataout(0, 1);
-	omap_set_gpio_dataout(0, 0);
+	gpio_set_value(0, 0);
+	gpio_set_value(0, 1);
+	gpio_set_value(0, 0);
 	omap_set_gpio_direction(0, 1);
 }
 
@@ -256,7 +256,7 @@ void voiceblue_wdt_ping(void)
 		return;
 
 	wdt_gpio_state = !wdt_gpio_state;
-	omap_set_gpio_dataout(0, wdt_gpio_state);
+	gpio_set_value(0, wdt_gpio_state);
 }
 
 void voiceblue_reset(void)
--- a/arch/arm/mach-omap1/leds-h2p2-debug.c
+++ b/arch/arm/mach-omap1/leds-h2p2-debug.c
@@ -65,8 +65,8 @@ void h2p2_dbg_leds_event(led_event_t evt
 		/* all leds off during suspend or shutdown */
 
 		if (! machine_is_omap_perseus2()) {
-			omap_set_gpio_dataout(GPIO_TIMER, 0);
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_TIMER, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 		}
 
 		__raw_writew(~0, &fpga->leds);
@@ -94,7 +94,7 @@ void h2p2_dbg_leds_event(led_event_t evt
 		if (machine_is_omap_perseus2())
 			hw_led_state ^= H2P2_DBG_FPGA_P2_LED_TIMER;
 		else {
-			omap_set_gpio_dataout(GPIO_TIMER, led_state & LED_TIMER_ON);
+			gpio_set_value(GPIO_TIMER, led_state & LED_TIMER_ON);
 			goto done;
 		}
 
@@ -106,7 +106,7 @@ void h2p2_dbg_leds_event(led_event_t evt
 		if (machine_is_omap_perseus2())
 			hw_led_state |= H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 1);
+			gpio_set_value(GPIO_IDLE, 1);
 			goto done;
 		}
 
@@ -116,7 +116,7 @@ void h2p2_dbg_leds_event(led_event_t evt
 		if (machine_is_omap_perseus2())
 			hw_led_state &= ~H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 			goto done;
 		}
 
--- a/arch/arm/mach-omap1/leds-osk.c
+++ b/arch/arm/mach-omap1/leds-osk.c
@@ -44,8 +44,8 @@ static void mistral_setled(void)
 		green = 1;
 	/* else both sides are disabled */
 
-	omap_set_gpio_dataout(GPIO_LED_GREEN, green);
-	omap_set_gpio_dataout(GPIO_LED_RED, red);
+	gpio_set_value(GPIO_LED_GREEN, green);
+	gpio_set_value(GPIO_LED_RED, red);
 }
 
 #endif
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -224,7 +224,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(TS_GPIO);
+	return !gpio_get_value(TS_GPIO);
 }
 
 static struct ads7846_platform_data tsc2046_config __initdata = {
@@ -408,7 +408,7 @@ static void __init omap_2430sdp_init(voi
 
 	/* turn off secondary LCD backlight */
 	omap_set_gpio_direction(SECONDARY_LCD_GPIO, 0);
-	omap_set_gpio_dataout(SECONDARY_LCD_GPIO, 0);
+	gpio_set_value(SECONDARY_LCD_GPIO, 0);
 }
 
 static void __init omap_2430sdp_map_io(void)
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -176,7 +176,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(ts_gpio);
+	return !gpio_get_value(ts_gpio);
 }
 
 /*
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -393,7 +393,7 @@ static void __init apollon_usb_init(void
 	omap_cfg_reg(P21_242X_GPIO12);
 	omap_request_gpio(12);
 	omap_set_gpio_direction(12, 0);		/* OUT */
-	omap_set_gpio_dataout(12, 0);
+	gpio_set_value(12, 0);
 }
 
 static void __init apollon_tsc_init(void)
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -105,7 +105,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(ts_gpio);
+	return !gpio_get_value(ts_gpio);
 }
 
 /*
--- a/arch/arm/mach-omap2/board-n800-camera.c
+++ b/arch/arm/mach-omap2/board-n800-camera.c
@@ -172,7 +172,7 @@ static int tcm825x_power_on(void)
 	retu_write_reg(RETU_REG_CTRL_SET, 0x0080);
 	msleep(1);
 
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 1);
+	gpio_set_value(N800_CAM_SENSOR_RESET_GPIO, 1);
 	msleep(1);
 
 	saturated_count = 0;
@@ -185,7 +185,7 @@ static int tcm825x_power_off(void)
 {
 	int ret;
 
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	gpio_set_value(N800_CAM_SENSOR_RESET_GPIO, 0);
 	msleep(1);
 
 	/* Set VSim1 off */
@@ -363,7 +363,7 @@ void __init n800_cam_init(void)
 		return;
 	}
 
-	omap_set_gpio_dataout(N800_CAM_SENSOR_RESET_GPIO, 0);
+	gpio_set_value(N800_CAM_SENSOR_RESET_GPIO, 0);
 	omap_set_gpio_direction(N800_CAM_SENSOR_RESET_GPIO, 0);
 
 	sensor_okay = 1;
--- a/arch/arm/mach-omap2/board-n800-mmc.c
+++ b/arch/arm/mach-omap2/board-n800-mmc.c
@@ -43,9 +43,9 @@ static int n800_mmc_switch_slot(struct d
 	dev_dbg(dev, "Choose slot %d\n", slot + 1);
 #endif
 	if (slot == 0)
-		omap_set_gpio_dataout(slot_switch_gpio, 0);
+		gpio_set_value(slot_switch_gpio, 0);
 	else
-		omap_set_gpio_dataout(slot_switch_gpio, 1);
+		gpio_set_value(slot_switch_gpio, 1);
 	return 0;
 }
 
@@ -125,14 +125,14 @@ static void nokia_mmc_set_power_internal
 		power_on ? "on" : "off");
 
 	if (power_on) {
-		omap_set_gpio_dataout(n810_slot2_pw_vddf, 1);
+		gpio_set_value(n810_slot2_pw_vddf, 1);
 		udelay(30);
-		omap_set_gpio_dataout(n810_slot2_pw_vdd, 1);
+		gpio_set_value(n810_slot2_pw_vdd, 1);
 		udelay(100);
 	} else {
-		omap_set_gpio_dataout(n810_slot2_pw_vdd, 0);
+		gpio_set_value(n810_slot2_pw_vdd, 0);
 		msleep(50);
-		omap_set_gpio_dataout(n810_slot2_pw_vddf, 0);
+		gpio_set_value(n810_slot2_pw_vddf, 0);
 		msleep(50);
 	}
 }
@@ -349,18 +349,18 @@ void __init n800_mmc_init(void)
 
 	if (omap_request_gpio(slot_switch_gpio) < 0)
 		BUG();
-	omap_set_gpio_dataout(slot_switch_gpio, 0);
+	gpio_set_value(slot_switch_gpio, 0);
 	omap_set_gpio_direction(slot_switch_gpio, 0);
 
 	if (machine_is_nokia_n810()) {
 		if (omap_request_gpio(n810_slot2_pw_vddf) < 0)
 			BUG();
-		omap_set_gpio_dataout(n810_slot2_pw_vddf, 0);
+		gpio_set_value(n810_slot2_pw_vddf, 0);
 		omap_set_gpio_direction(n810_slot2_pw_vddf, 0);
 
 		if (omap_request_gpio(n810_slot2_pw_vdd) < 0)
 			BUG();
-		omap_set_gpio_dataout(n810_slot2_pw_vdd, 0);
+		gpio_set_value(n810_slot2_pw_vdd, 0);
 		omap_set_gpio_direction(n810_slot2_pw_vdd, 0);
 	}
 
--- a/arch/arm/mach-omap2/board-n800-usb.c
+++ b/arch/arm/mach-omap2/board-n800-usb.c
@@ -99,12 +99,12 @@ static int tusb_set_power(int state)
 	int i, retval = 0;
 
 	if (state) {
-		omap_set_gpio_dataout(GPIO_TUSB_ENABLE, 1);
+		gpio_set_value(GPIO_TUSB_ENABLE, 1);
 		msleep(1);
 
 		/* Wait until TUSB6010 pulls INT pin down */
 		i = 100;
-		while (i && omap_get_gpio_datain(GPIO_TUSB_INT)) {
+		while (i && gpio_get_value(GPIO_TUSB_INT)) {
 			msleep(1);
 			i--;
 		}
@@ -114,7 +114,7 @@ static int tusb_set_power(int state)
 			retval = -ENODEV;
 		}
 	} else {
-		omap_set_gpio_dataout(GPIO_TUSB_ENABLE, 0);
+		gpio_set_value(GPIO_TUSB_ENABLE, 0);
 		msleep(10);
 	}
 
--- a/arch/arm/mach-omap2/board-n800.c
+++ b/arch/arm/mach-omap2/board-n800.c
@@ -134,7 +134,7 @@ void __init nokia_n800_init_irq(void)
 	}
 
 	omap_set_gpio_direction(N800_STI_GPIO, 0);
-	omap_set_gpio_dataout(N800_STI_GPIO, 0);
+	gpio_set_value(N800_STI_GPIO, 0);
 #endif
 }
 
@@ -178,7 +178,7 @@ static void mipid_shutdown(struct mipid_
 {
 	if (pdata->nreset_gpio != -1) {
 		pr_info("shutdown LCD\n");
-		omap_set_gpio_dataout(pdata->nreset_gpio, 0);
+		gpio_set_value(pdata->nreset_gpio, 0);
 		msleep(120);
 	}
 }
@@ -232,12 +232,12 @@ static void blizzard_power_up(struct dev
 	msleep(10);
 
 	blizzard_enable_clocks(1);
-	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 1);
+	gpio_set_value(N800_BLIZZARD_POWERDOWN_GPIO, 1);
 }
 
 static void blizzard_power_down(struct device *dev)
 {
-	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 0);
+	gpio_set_value(N800_BLIZZARD_POWERDOWN_GPIO, 0);
 	blizzard_enable_clocks(0);
 
 	/* Vcore to 1.005V */
@@ -259,7 +259,7 @@ static void __init blizzard_dev_init(voi
 	if (r < 0)
 		return;
 	omap_set_gpio_direction(N800_BLIZZARD_POWERDOWN_GPIO, 0);
-	omap_set_gpio_dataout(N800_BLIZZARD_POWERDOWN_GPIO, 1);
+	gpio_set_value(N800_BLIZZARD_POWERDOWN_GPIO, 1);
 
 	blizzard_get_clocks();
 	omapfb_set_ctrl_platform_data(&n800_blizzard_data);
@@ -341,7 +341,7 @@ static int __init tea5761_dev_init(void)
 
 		omap_set_gpio_direction(enable_gpio, 0);
 		udelay(50);
-		omap_set_gpio_dataout(enable_gpio, 1);
+		gpio_set_value(enable_gpio, 1);
 	}
 
 	return 0;
--- a/arch/arm/mach-omap2/board-omap2evm.c
+++ b/arch/arm/mach-omap2/board-omap2evm.c
@@ -211,7 +211,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(OMAP2_EVM_TS_GPIO);
+	return !gpio_get_value(OMAP2_EVM_TS_GPIO);
 }
 
 struct ads7846_platform_data ads7846_config = {
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -182,7 +182,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(OMAP3_EVM_TS_GPIO);
+	return !gpio_get_value(OMAP3_EVM_TS_GPIO);
 }
 
 struct ads7846_platform_data ads7846_config = {
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -83,8 +83,8 @@ static void h2p2_dbg_leds_event(led_even
 		/* all leds off during suspend or shutdown */
 
 		if (!(machine_is_omap_perseus2() || machine_is_omap_h4())) {
-			omap_set_gpio_dataout(GPIO_TIMER, 0);
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_TIMER, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 		}
 
 		__raw_writew(~0, &fpga->leds);
@@ -107,7 +107,7 @@ static void h2p2_dbg_leds_event(led_even
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state ^= H2P2_DBG_FPGA_P2_LED_TIMER;
 		else {
-			omap_set_gpio_dataout(GPIO_TIMER,
+			gpio_set_value(GPIO_TIMER,
 					led_state & LED_TIMER_ON);
 			goto done;
 		}
@@ -121,7 +121,7 @@ static void h2p2_dbg_leds_event(led_even
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state &= ~H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 1);
+			gpio_set_value(GPIO_IDLE, 1);
 			goto done;
 		}
 
@@ -131,7 +131,7 @@ static void h2p2_dbg_leds_event(led_even
 		if (machine_is_omap_perseus2() || machine_is_omap_h4())
 			hw_led_state |= H2P2_DBG_FPGA_P2_LED_IDLE;
 		else {
-			omap_set_gpio_dataout(GPIO_IDLE, 0);
+			gpio_set_value(GPIO_IDLE, 0);
 			goto done;
 		}
 
--- a/arch/arm/plat-omap/gpio-switch.c
+++ b/arch/arm/plat-omap/gpio-switch.c
@@ -106,7 +106,7 @@ static int gpio_sw_get_state(struct gpio
 {
 	int state;
 
-	state = omap_get_gpio_datain(sw->gpio);
+	state = gpio_get_value(sw->gpio);
 	if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
 		state = !state;
 
@@ -139,7 +139,7 @@ static ssize_t gpio_sw_state_store(struc
 
 	if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
 		enable = !enable;
-	omap_set_gpio_dataout(sw->gpio, enable);
+	gpio_set_value(sw->gpio, enable);
 
 	return count;
 }
@@ -190,7 +190,7 @@ static irqreturn_t gpio_sw_irq_handler(i
 	int state;
 
 	if (!sw->both_edges) {
-		if (omap_get_gpio_datain(sw->gpio))
+		if (gpio_get_value(sw->gpio))
 			set_irq_type(OMAP_GPIO_IRQ(sw->gpio), IRQ_TYPE_EDGE_FALLING);
 		else
 			set_irq_type(OMAP_GPIO_IRQ(sw->gpio), IRQ_TYPE_EDGE_RISING);
@@ -305,7 +305,7 @@ static int __init new_switch(struct gpio
 		trigger = IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING;
 		sw->both_edges = 1;
 	} else {
-		if (omap_get_gpio_datain(sw->gpio))
+		if (gpio_get_value(sw->gpio))
 			trigger = IRQF_TRIGGER_FALLING;
 		else
 			trigger = IRQF_TRIGGER_RISING;
@@ -465,7 +465,7 @@ static void __init report_initial_state(
 	list_for_each_entry(sw, &gpio_switches, node) {
 		int state;
 
-		state = omap_get_gpio_datain(sw->gpio);
+		state = gpio_get_value(sw->gpio);
 		if (sw->flags & OMAP_GPIO_SWITCH_FLAG_INVERTED)
 			state = !state;
 		if (sw->notify != NULL)
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -408,20 +408,7 @@ static void _set_gpio_dataout(struct gpi
 	__raw_writel(l, reg);
 }
 
-void omap_set_gpio_dataout(int gpio, int enable)
-{
-	struct gpio_bank *bank;
-	unsigned long flags;
-
-	if (check_gpio(gpio) < 0)
-		return;
-	bank = get_gpio_bank(gpio);
-	spin_lock_irqsave(&bank->lock, flags);
-	_set_gpio_dataout(bank, get_gpio_index(gpio), enable);
-	spin_unlock_irqrestore(&bank->lock, flags);
-}
-
-int omap_get_gpio_datain(int gpio)
+static int __omap_get_gpio_datain(int gpio)
 {
 	struct gpio_bank *bank;
 	void __iomem *reg;
@@ -1267,7 +1254,7 @@ static int gpio_input(struct gpio_chip *
 
 static int gpio_get(struct gpio_chip *chip, unsigned offset)
 {
-	return omap_get_gpio_datain(chip->base + offset);
+	return __omap_get_gpio_datain(chip->base + offset);
 }
 
 static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
@@ -1764,8 +1751,6 @@ static int __init omap_gpio_sysinit(void
 EXPORT_SYMBOL(omap_request_gpio);
 EXPORT_SYMBOL(omap_free_gpio);
 EXPORT_SYMBOL(omap_set_gpio_direction);
-EXPORT_SYMBOL(omap_set_gpio_dataout);
-EXPORT_SYMBOL(omap_get_gpio_datain);
 
 arch_initcall(omap_gpio_sysinit);
 
@@ -1823,7 +1808,7 @@ static int dbg_gpio_show(struct seq_file
 				continue;
 
 			irq = bank->virtual_irq_start + j;
-			value = omap_get_gpio_datain(gpio);
+			value = gpio_get_value(gpio);
 			is_in = gpio_is_input(bank, mask);
 
 			if (bank_is_mpuio(bank))
--- a/arch/arm/plat-omap/include/mach/gpio.h
+++ b/arch/arm/plat-omap/include/mach/gpio.h
@@ -74,8 +74,6 @@ extern int omap_gpio_init(void);	/* Call
 extern int omap_request_gpio(int gpio);
 extern void omap_free_gpio(int gpio);
 extern void omap_set_gpio_direction(int gpio, int is_input);
-extern void omap_set_gpio_dataout(int gpio, int enable);
-extern int omap_get_gpio_datain(int gpio);
 extern void omap2_gpio_prepare_for_retention(void);
 extern void omap2_gpio_resume_after_retention(void);
 extern void omap_set_gpio_debounce(int gpio, int enable);
--- a/drivers/bluetooth/brf6150.c
+++ b/drivers/bluetooth/brf6150.c
@@ -181,9 +181,9 @@ static void brf6150_disable_pm_tx(struct
 {
 	if (info->pm_enabled) {
 		info->tx_pm_enabled = 0;
-		omap_set_gpio_dataout(info->btinfo->bt_wakeup_gpio, 1);
+		gpio_set_value(info->btinfo->bt_wakeup_gpio, 1);
 	}
-	if (omap_get_gpio_datain(info->btinfo->host_wakeup_gpio))
+	if (gpio_get_value(info->btinfo->host_wakeup_gpio))
 		tasklet_schedule(&info->tx_task);
 }
 
@@ -193,7 +193,7 @@ static void brf6150_pm_timer(unsigned lo
 
 	info = (struct brf6150_info *)data;
 	if (info->tx_pm_enabled && info->rx_pm_enabled && !test_bit(HCI_INQUIRY, &info->hdev->flags))
-		omap_set_gpio_dataout(info->btinfo->bt_wakeup_gpio, 0);
+		gpio_set_value(info->btinfo->bt_wakeup_gpio, 0);
 	else
 		mod_timer(&info->pm_timer, jiffies + msecs_to_jiffies(PM_TIMEOUT));
 }
@@ -624,7 +624,7 @@ static irqreturn_t brf6150_wakeup_interr
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock, flags);
-	should_wakeup = omap_get_gpio_datain(info->btinfo->host_wakeup_gpio);
+	should_wakeup = gpio_get_value(info->btinfo->host_wakeup_gpio);
 	NBT_DBG_POWER("gpio interrupt %d\n", should_wakeup);
 	if (should_wakeup) {
 		clk_enable(info->uart_ck);
@@ -671,14 +671,14 @@ static int brf6150_init_uart(struct brf6
 
 static int brf6150_reset(struct brf6150_info *info)
 {
-	omap_set_gpio_dataout(info->btinfo->bt_wakeup_gpio, 0);
-	omap_set_gpio_dataout(info->btinfo->reset_gpio, 0);
+	gpio_set_value(info->btinfo->bt_wakeup_gpio, 0);
+	gpio_set_value(info->btinfo->reset_gpio, 0);
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(msecs_to_jiffies(10));
-	omap_set_gpio_dataout(info->btinfo->bt_wakeup_gpio, 1);
+	gpio_set_value(info->btinfo->bt_wakeup_gpio, 1);
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(msecs_to_jiffies(100));
-	omap_set_gpio_dataout(info->btinfo->reset_gpio, 1);
+	gpio_set_value(info->btinfo->reset_gpio, 1);
 	current->state = TASK_UNINTERRUPTIBLE;
 	schedule_timeout(msecs_to_jiffies(100));
 
@@ -786,7 +786,7 @@ static int brf6150_hci_close(struct hci_
 	brf6150_hci_flush(hdev);
 	clk_disable(info->uart_ck);
 	del_timer_sync(&info->pm_timer);
-	omap_set_gpio_dataout(info->btinfo->bt_wakeup_gpio, 0);
+	gpio_set_value(info->btinfo->bt_wakeup_gpio, 0);
 	set_irq_type(OMAP_GPIO_IRQ(info->btinfo->host_wakeup_gpio), IRQ_TYPE_NONE);
 
 	return 0;
--- a/drivers/bluetooth/hci_h4p/core.c
+++ b/drivers/bluetooth/hci_h4p/core.c
@@ -102,7 +102,7 @@ static void hci_h4p_enable_tx(struct hci
 	if (info->tx_pm_enabled) {
 		info->tx_pm_enabled = 0;
 		hci_h4p_set_clk(info, &info->tx_clocks_en, 1);
-		omap_set_gpio_dataout(info->bt_wakeup_gpio, 1);
+		gpio_set_value(info->bt_wakeup_gpio, 1);
 	}
 }
 
@@ -115,7 +115,7 @@ static void hci_h4p_tx_pm_timer(unsigned
 	info = (struct hci_h4p_info *)data;
 
 	if (hci_h4p_inb(info, UART_LSR) & UART_LSR_TEMT) {
-		omap_set_gpio_dataout(info->bt_wakeup_gpio, 0);
+		gpio_set_value(info->bt_wakeup_gpio, 0);
 		hci_h4p_set_clk(info, &info->tx_clocks_en, 0);
 		info->tx_pm_enabled = 1;
 	}
@@ -527,7 +527,7 @@ static irqreturn_t hci_h4p_wakeup_interr
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return IRQ_HANDLED;
 
-	should_wakeup = omap_get_gpio_datain(info->host_wakeup_gpio);
+	should_wakeup = gpio_get_value(info->host_wakeup_gpio);
 	NBT_DBG_POWER("gpio interrupt %d\n", should_wakeup);
 	if (should_wakeup) {
 		hci_h4p_enable_rx(info);
@@ -545,10 +545,10 @@ static int hci_h4p_reset(struct hci_h4p_
 	hci_h4p_init_uart(info);
 	hci_h4p_set_rts(info, 0);
 
-	omap_set_gpio_dataout(info->reset_gpio, 0);
+	gpio_set_value(info->reset_gpio, 0);
 	msleep(100);
-	omap_set_gpio_dataout(info->bt_wakeup_gpio, 1);
-	omap_set_gpio_dataout(info->reset_gpio, 1);
+	gpio_set_value(info->bt_wakeup_gpio, 1);
+	gpio_set_value(info->reset_gpio, 1);
 	msleep(100);
 
 	err = hci_h4p_wait_for_cts(info, 1, 10);
@@ -646,8 +646,8 @@ err_clean:
 	hci_h4p_reset_uart(info);
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 0);
 	hci_h4p_set_clk(info, &info->rx_clocks_en, 0);
-	omap_set_gpio_dataout(info->reset_gpio, 0);
-	omap_set_gpio_dataout(info->bt_wakeup_gpio, 0);
+	gpio_set_value(info->reset_gpio, 0);
+	gpio_set_value(info->bt_wakeup_gpio, 0);
 	skb_queue_purge(&fw_queue);
 	kfree_skb(neg_cmd_skb);
 	neg_cmd_skb = NULL;
@@ -675,8 +675,8 @@ static int hci_h4p_hci_close(struct hci_
 	hci_h4p_reset_uart(info);
 	hci_h4p_set_clk(info, &info->tx_clocks_en, 0);
 	hci_h4p_set_clk(info, &info->rx_clocks_en, 0);
-	omap_set_gpio_dataout(info->reset_gpio, 0);
-	omap_set_gpio_dataout(info->bt_wakeup_gpio, 0);
+	gpio_set_value(info->reset_gpio, 0);
+	gpio_set_value(info->bt_wakeup_gpio, 0);
 	kfree_skb(info->rx_skb);
 
 	return 0;
@@ -944,7 +944,7 @@ static int hci_h4p_probe(struct platform
 		dev_err(info->dev, "failed to register hci_h4p hci device\n");
 		goto cleanup_irq;
 	}
-	omap_set_gpio_dataout(info->reset_gpio, 0);
+	gpio_set_value(info->reset_gpio, 0);
 
 	return 0;
 
@@ -952,7 +952,7 @@ cleanup_irq:
 	free_irq(irq, (void *)info);
 	free_irq(OMAP_GPIO_IRQ(info->host_wakeup_gpio), (void *)info);
 cleanup:
-	omap_set_gpio_dataout(info->reset_gpio, 0);
+	gpio_set_value(info->reset_gpio, 0);
 	omap_free_gpio(info->reset_gpio);
 	omap_free_gpio(info->bt_wakeup_gpio);
 	omap_free_gpio(info->host_wakeup_gpio);
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c
@@ -102,28 +102,28 @@ static u8 cbus_receive_bit(struct cbus_h
 #else
 
 #define cbus_set_gpio_direction(base, gpio, is_input) omap_set_gpio_direction(gpio, is_input)
-#define cbus_set_gpio_dataout(base, gpio, enable) omap_set_gpio_dataout(gpio, enable)
-#define cbus_get_gpio_datain(base, int, gpio) omap_get_gpio_datain(gpio)
+#define cbus_set_gpio_dataout(base, gpio, enable) gpio_set_value(gpio, enable)
+#define cbus_get_gpio_datain(base, int, gpio) gpio_get_value(gpio)
 
 static void _cbus_send_bit(struct cbus_host *host, int bit, int set_to_input)
 {
-	omap_set_gpio_dataout(host->dat_gpio, bit ? 1 : 0);
-	omap_set_gpio_dataout(host->clk_gpio, 1);
+	gpio_set_value(host->dat_gpio, bit ? 1 : 0);
+	gpio_set_value(host->clk_gpio, 1);
 
 	/* The data bit is read on the rising edge of CLK */
 	if (set_to_input)
 		omap_set_gpio_direction(host->dat_gpio, 1);
 
-	omap_set_gpio_dataout(host->clk_gpio, 0);
+	gpio_set_value(host->clk_gpio, 0);
 }
 
 static u8 _cbus_receive_bit(struct cbus_host *host)
 {
 	u8 ret;
 
-	omap_set_gpio_dataout(host->clk_gpio, 1);
-	ret = omap_get_gpio_datain(host->dat_gpio);
-	omap_set_gpio_dataout(host->clk_gpio, 0);
+	gpio_set_value(host->clk_gpio, 1);
+	ret = gpio_get_value(host->dat_gpio);
+	gpio_set_value(host->clk_gpio, 0);
 
 	return ret;
 }
@@ -260,15 +260,15 @@ int __init cbus_bus_init(void)
 	if ((ret = omap_request_gpio(chost->sel_gpio)) < 0)
 		goto exit3;
 
-	omap_set_gpio_dataout(chost->clk_gpio, 0);
-	omap_set_gpio_dataout(chost->sel_gpio, 1);
+	gpio_set_value(chost->clk_gpio, 0);
+	gpio_set_value(chost->sel_gpio, 1);
 
 	omap_set_gpio_direction(chost->clk_gpio, 0);
 	omap_set_gpio_direction(chost->dat_gpio, 1);
 	omap_set_gpio_direction(chost->sel_gpio, 0);
 
-	omap_set_gpio_dataout(chost->clk_gpio, 1);
-	omap_set_gpio_dataout(chost->clk_gpio, 0);
+	gpio_set_value(chost->clk_gpio, 1);
+	gpio_set_value(chost->clk_gpio, 0);
 
 	cbus_host = chost;
 
--- a/drivers/leds/leds-omap.c
+++ b/drivers/leds/leds-omap.c
@@ -29,9 +29,9 @@ static void omap_set_led_gpio(struct led
 	led_dev = container_of(led_cdev, struct omap_led_config, cdev);
 
 	if (value)
-		omap_set_gpio_dataout(led_dev->gpio, 1);
+		gpio_set_value(led_dev->gpio, 1);
 	else
-		omap_set_gpio_dataout(led_dev->gpio, 0);
+		gpio_set_value(led_dev->gpio, 0);
 }
 
 static void omap_configure_led_gpio(int gpio)
--- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -150,7 +150,7 @@ static int omap2_onenand_wait(struct mtd
 
 		INIT_COMPLETION(c->irq_done);
 		if (c->gpio_irq) {
-			result = omap_get_gpio_datain(c->gpio_irq);
+			result = gpio_get_value(c->gpio_irq);
 			if (result == -1) {
 				ctrl = read_reg(c, ONENAND_REG_CTRL_STATUS);
 				intr = read_reg(c, ONENAND_REG_INTERRUPT);
--- a/drivers/spi/tsc2301-core.c
+++ b/drivers/spi/tsc2301-core.c
@@ -161,10 +161,10 @@ static int __devinit tsc2301_probe(struc
 		r = omap_request_gpio(tsc->reset_gpio);
 		if (r < 0)
 			goto err1;
-		omap_set_gpio_dataout(tsc->reset_gpio, 1);
+		gpio_set_value(tsc->reset_gpio, 1);
 		omap_set_gpio_direction(tsc->reset_gpio, 0);
 		mdelay(1);
-		omap_set_gpio_dataout(tsc->reset_gpio, 0);
+		gpio_set_value(tsc->reset_gpio, 0);
 #endif
 	} else
 		tsc->reset_gpio = -1;
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -229,8 +229,8 @@ static int omap_start_ehc(struct platfor
 	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT1, 0);
 	omap_request_gpio(EXT_PHY_RESET_GPIO_PORT2);
 	omap_set_gpio_direction(EXT_PHY_RESET_GPIO_PORT2, 0);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 0);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 0);
+	gpio_set_value(EXT_PHY_RESET_GPIO_PORT1, 0);
+	gpio_set_value(EXT_PHY_RESET_GPIO_PORT2, 0);
 	/* Hold the PHY in RESET for enough time till DIR is high */
 	udelay(EXT_PHY_RESET_DELAY);
 #endif
@@ -309,8 +309,8 @@ static int omap_start_ehc(struct platfor
 	 * Hold the PHY in RESET for enough time till PHY is settled and ready
 	 */
 	udelay(EXT_PHY_RESET_DELAY);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT1, 1);
-	omap_set_gpio_dataout(EXT_PHY_RESET_GPIO_PORT2, 1);
+	gpio_set_value(EXT_PHY_RESET_GPIO_PORT1, 1);
+	gpio_set_value(EXT_PHY_RESET_GPIO_PORT2, 1);
 #endif
 
 #ifdef VBUS_INTERNAL_CHARGEPUMP_HACK
--- a/drivers/video/omap/lcd_2430sdp.c
+++ b/drivers/video/omap/lcd_2430sdp.c
@@ -101,8 +101,8 @@ static int sdp2430_panel_enable(struct l
 		grp_val = ENABLE_VAUX2_DEV_GRP;
 	}
 		
-	omap_set_gpio_dataout(enable_gpio, 1);
-	omap_set_gpio_dataout(backlight_gpio, 1);
+	gpio_set_value(enable_gpio, 1);
+	gpio_set_value(backlight_gpio, 1);
 
 	if (0 != t2_out(PM_RECEIVER, ded_val, ded_reg))
 		return -EIO;
@@ -114,8 +114,8 @@ static int sdp2430_panel_enable(struct l
 
 static void sdp2430_panel_disable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(enable_gpio, 0);
-	omap_set_gpio_dataout(backlight_gpio, 0);
+	gpio_set_value(enable_gpio, 0);
+	gpio_set_value(backlight_gpio, 0);
 	if (system_rev > OMAP3430_REV_ES1_0) {
 		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEDICATED);
 		t2_out(PM_RECEIVER, 0x0, TWL4030_VPLL2_DEV_GRP);
--- a/drivers/video/omap/lcd_omap2evm.c
+++ b/drivers/video/omap/lcd_omap2evm.c
@@ -64,11 +64,11 @@ static int omap2evm_panel_init(struct lc
 	omap_set_gpio_direction(LCD_PANEL_QVGA, 0);
 	omap_set_gpio_direction(LCD_PANEL_RESB, 0);
 
-	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
-	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
-	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
-	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
-	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+	gpio_set_value(LCD_PANEL_RESB, 1);
+	gpio_set_value(LCD_PANEL_INI, 1);
+	gpio_set_value(LCD_PANEL_QVGA, 0);
+	gpio_set_value(LCD_PANEL_LR, 1);
+	gpio_set_value(LCD_PANEL_UD, 1);
 
 	twl4030_i2c_write_u8(TWL4030_MODULE_LED, 0x11, TWL_LED_LEDEN);
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x01, TWL_PWMA_PWMAON);
@@ -84,13 +84,13 @@ static void omap2evm_panel_cleanup(struc
 
 static int omap2evm_panel_enable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
 	return 0;
 }
 
 static void omap2evm_panel_disable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
 }
 
 static unsigned long omap2evm_panel_get_caps(struct lcd_panel *panel)
--- a/drivers/video/omap/lcd_omap3beagle.c
+++ b/drivers/video/omap/lcd_omap3beagle.c
@@ -48,13 +48,13 @@ static void omap3beagle_panel_cleanup(st
 
 static int omap3beagle_panel_enable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
 	return 0;
 }
 
 static void omap3beagle_panel_disable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
 }
 
 static unsigned long omap3beagle_panel_get_caps(struct lcd_panel *panel)
--- a/drivers/video/omap/lcd_omap3evm.c
+++ b/drivers/video/omap/lcd_omap3evm.c
@@ -71,11 +71,11 @@ static int omap3evm_panel_init(struct lc
 	twl4030_i2c_write_u8(TWL4030_MODULE_PWMA, 0x02, TWL_PWMA_PWMAOFF);
 	bklight_level = 100;
 
-	omap_set_gpio_dataout(LCD_PANEL_RESB, 1);
-	omap_set_gpio_dataout(LCD_PANEL_INI, 1);
-	omap_set_gpio_dataout(LCD_PANEL_QVGA, 0);
-	omap_set_gpio_dataout(LCD_PANEL_LR, 1);
-	omap_set_gpio_dataout(LCD_PANEL_UD, 1);
+	gpio_set_value(LCD_PANEL_RESB, 1);
+	gpio_set_value(LCD_PANEL_INI, 1);
+	gpio_set_value(LCD_PANEL_QVGA, 0);
+	gpio_set_value(LCD_PANEL_LR, 1);
+	gpio_set_value(LCD_PANEL_UD, 1);
 
 	return 0;
 }
@@ -86,13 +86,13 @@ static void omap3evm_panel_cleanup(struc
 
 static int omap3evm_panel_enable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
 	return 0;
 }
 
 static void omap3evm_panel_disable(struct lcd_panel *panel)
 {
-	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
 }
 
 static unsigned long omap3evm_panel_get_caps(struct lcd_panel *panel)
--- a/drivers/video/omap/lcd_p2.c
+++ b/drivers/video/omap/lcd_p2.c
@@ -166,9 +166,9 @@ static int p2_panel_enable(struct lcd_pa
 
 		/* thwack the reset line */
 	omap_set_gpio_direction(19, 0);
-	omap_set_gpio_dataout(19, 0);
+	gpio_set_value(19, 0);
 	mdelay(2);
-	omap_set_gpio_dataout(19, 1);
+	gpio_set_value(19, 1);
 
 		/* bits 31:28 -> 0  LCD_PXL_15 .. 12 */
 	value = omap_readl(OMAP730_IO_CONF_3) & 0x0FFFFFFF;
@@ -258,7 +258,7 @@ static int p2_panel_enable(struct lcd_pa
 
 	/* enable backlight */
 	omap_set_gpio_direction(134, 0);
-	omap_set_gpio_dataout(134, 1);
+	gpio_set_value(134, 1);
 
 	return 0;
 }
--- a/sound/arm/omap/omap-alsa-sx1.c
+++ b/sound/arm/omap/omap-alsa-sx1.c
@@ -225,7 +225,7 @@ static void egold_clock_setup(void)
  */
 static int egold_clock_on(void)
 {
-	omap_set_gpio_dataout(OSC_EN, 1);
+	gpio_set_value(OSC_EN, 1);
 	egold_set_samplerate(44100); /* TODO */
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_SPEAKER, 0);
 	cn_sx1snd_send(DAC_OPEN_DEFAULT, current_rate , 4);
@@ -240,7 +240,7 @@ static int egold_clock_off(void)
 {
 	cn_sx1snd_send(DAC_CLOSE, 0 , 0);
 	cn_sx1snd_send(DAC_SETAUDIODEVICE, SX1_DEVICE_PHONE, 0);
-	omap_set_gpio_dataout(OSC_EN, 0);
+	gpio_set_value(OSC_EN, 0);
 	snd_printd("\n");
 	return 0;
 }
