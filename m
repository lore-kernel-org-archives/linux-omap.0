From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc2-omap 1/4] use standard gpio get/set calls (OMAP tree only)
Date: Wed, 29 Oct 2008 20:39:22 -0700
Message-ID: <200810292039.22956.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:32985 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752308AbYJ3Do0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Oct 2008 23:44:26 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

This patch replaces some legacy OMAP GPIO calls with the "new" (not
really, any more!) calls that work on most platforms.

The calls addressed by this patch are the simple ones to get and set
values ... for code that has NOT merged to mainline.

Except for the Documentation file, all of these changes were performed
by a simple SED script.  A few "if() set() else set()" branches were
merged by hand.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 Documentation/arm/OMAP/gpio             |   15 +++++++++++++++
 arch/arm/mach-omap2/board-2430sdp.c     |    4 ++--
 arch/arm/mach-omap2/board-3430sdp.c     |    2 +-
 arch/arm/mach-omap2/board-ldp.c         |    2 +-
 arch/arm/mach-omap2/board-n800-camera.c |    6 +++---
 arch/arm/mach-omap2/board-n800-mmc.c    |   19 ++++++++-----------
 arch/arm/mach-omap2/board-n800-usb.c    |    6 +++---
 arch/arm/mach-omap2/board-n800.c        |   12 ++++++------
 arch/arm/mach-omap2/board-omap2evm.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c    |    2 +-
 arch/arm/plat-omap/gpio-switch.c        |   10 +++++-----
 drivers/bluetooth/brf6150.c             |   18 +++++++++---------
 drivers/bluetooth/hci_h4p/core.c        |   24 ++++++++++++------------
 drivers/cbus/cbus.c                     |   24 ++++++++++++------------
 drivers/leds/leds-omap.c                |    6 +-----
 drivers/spi/tsc2301-core.c              |    4 ++--
 drivers/usb/host/ehci-omap.c            |    8 ++++----
 drivers/video/omap/lcd_2430sdp.c        |    8 ++++----
 drivers/video/omap/lcd_omap2evm.c       |   14 +++++++-------
 drivers/video/omap/lcd_omap3beagle.c    |    4 ++--
 drivers/video/omap/lcd_omap3evm.c       |   14 +++++++-------
 drivers/video/omap/lcd_p2.c             |    6 +++---
 22 files changed, 109 insertions(+), 101 deletions(-)

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
@@ -178,7 +178,7 @@ static void ads7846_dev_init(void)
 
 static int ads7846_get_pendown_state(void)
 {
-	return !omap_get_gpio_datain(ts_gpio);
+	return !gpio_get_value(ts_gpio);
 }
 
 /*
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -107,7 +107,7 @@ static void ads7846_dev_init(void)
 
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
@@ -42,10 +42,7 @@ static int n800_mmc_switch_slot(struct d
 #ifdef CONFIG_MMC_DEBUG
 	dev_dbg(dev, "Choose slot %d\n", slot + 1);
 #endif
-	if (slot == 0)
-		omap_set_gpio_dataout(slot_switch_gpio, 0);
-	else
-		omap_set_gpio_dataout(slot_switch_gpio, 1);
+	gpio_set_value(slot_switch_gpio, slot);
 	return 0;
 }
 
@@ -125,14 +122,14 @@ static void nokia_mmc_set_power_internal
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
@@ -349,18 +346,18 @@ void __init n800_mmc_init(void)
 
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
@@ -27,11 +27,7 @@ static void omap_set_led_gpio(struct led
 	struct omap_led_config *led_dev;
 
 	led_dev = container_of(led_cdev, struct omap_led_config, cdev);
-
-	if (value)
-		omap_set_gpio_dataout(led_dev->gpio, 1);
-	else
-		omap_set_gpio_dataout(led_dev->gpio, 0);
+	gpio_set_value(led_dev->gpio, value);
 }
 
 static void omap_configure_led_gpio(int gpio)
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
