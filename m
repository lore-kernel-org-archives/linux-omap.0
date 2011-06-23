From: Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH] OMAP: 4430SDP: add mmc5/wl1283 device support
Date: Thu, 23 Jun 2011 10:55:50 -0600
Message-ID: <1308848150-4015-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52139 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759391Ab1FWP2V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Jun 2011 11:28:21 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5NFSKvB013315
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:28:20 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5NFSKt1028967
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:28:20 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5NFSKkl000833
	for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 10:28:20 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishal Mahaveer <vishalm@ti.com>

Add MMC5 support on 4430SDP/Blaze, which has the wl1283 device hardwired to.

The wl1283 is a 4-wire, 1.8V, embedded SDIO WLAN device with an
external IRQ line, and power-controlled by a GPIO.

Based on the patch for mmc3/wl1271 device support for zoom
by Ohad Ben-Cohen <ohad@wizery.com>

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   76 +++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..555d4f8 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
+#include <linux/wl12xx.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -51,6 +52,8 @@
 #define OMAP4_SFH7741_ENABLE_GPIO		188
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
+#define GPIO_WIFI_PMENA		54
+#define GPIO_WIFI_IRQ		53
 
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -306,6 +309,26 @@ static struct omap_musb_board_data musb_board_data = {
 	.power			= 100,
 };
 
+static int wifi_set_power(struct device *dev, int slot, int power_on, int vdd)
+{
+	static int power_state;
+
+	pr_debug("Powering %s wifi", (power_on ? "on" : "off"));
+
+	if (power_on == power_state)
+		return 0;
+	power_state = power_on;
+
+	if (power_on) {
+		gpio_set_value(GPIO_WIFI_PMENA, 1);
+		mdelay(70);
+	} else {
+		gpio_set_value(GPIO_WIFI_PMENA, 0);
+	}
+
+	return 0;
+}
+
 static struct twl4030_usb_data omap4_usbphy_data = {
 	.phy_init	= omap4430_phy_init,
 	.phy_exit	= omap4430_phy_exit,
@@ -329,6 +352,14 @@ static struct omap2_hsmmc_info mmc[] = {
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
 	},
+	{
+		.mmc		= 5,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_POWER_OFF_CARD,
+		.gpio_cd	= -EINVAL,
+		.gpio_wp	= -EINVAL,
+		.ocr_mask	= MMC_VDD_165_195,
+		.nonremovable	= true,
+	},
 	{}	/* Terminator */
 };
 
@@ -361,6 +392,11 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 						MMCDETECT_INTR_OFFSET;
 		pdata->slots[0].card_detect = twl6030_mmc_card_detect;
 	}
+
+	/* Set the MMC5 (wlan) power function */
+	if (pdev->id == 4)
+		pdata->slots[0].set_power = wifi_set_power;
+
 	return ret;
 }
 
@@ -519,6 +555,7 @@ static struct regulator_init_data sdp4430_vusb = {
 static struct regulator_init_data sdp4430_clk32kg = {
 	.constraints = {
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+		.always_on		= true,
 	},
 };
 
@@ -723,6 +760,43 @@ static inline void board_serial_init(void)
 }
  #endif
 
+
+static void omap4_4430sdp_wifi_mux_init(void)
+{
+	omap_mux_init_gpio(GPIO_WIFI_IRQ, OMAP_PIN_INPUT |
+				OMAP_PIN_OFF_WAKEUPENABLE);
+	omap_mux_init_gpio(GPIO_WIFI_PMENA, OMAP_PIN_OUTPUT);
+
+	omap_mux_init_signal("sdmmc5_cmd.sdmmc5_cmd",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc5_clk.sdmmc5_clk",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc5_dat0.sdmmc5_dat0",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc5_dat1.sdmmc5_dat1",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc5_dat2.sdmmc5_dat2",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("sdmmc5_dat3.sdmmc5_dat3",
+				OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP);
+
+}
+
+static struct wl12xx_platform_data omap4_4430sdp_wlan_data __initdata = {
+	.irq = OMAP_GPIO_IRQ(GPIO_WIFI_IRQ),
+	.board_ref_clock = WL12XX_REFCLOCK_26,
+	.board_tcxo_clock = 1,
+};
+
+static void omap4_4430sdp_wifi_init(void)
+{
+	omap4_4430sdp_wifi_mux_init();
+	if (gpio_request_one(GPIO_WIFI_PMENA, GPIOF_OUT_INIT_LOW, "wl12xx"))
+		pr_err("Error initializing up WLAN_EN\n");
+	if (wl12xx_set_platform_data(&omap4_4430sdp_wlan_data))
+		pr_err("Error setting wl12xx data\n");
+}
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -741,6 +815,8 @@ static void __init omap_4430sdp_init(void)
 	board_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 
+	omap4_4430sdp_wifi_init();
+
 	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
-- 
1.7.0.4

