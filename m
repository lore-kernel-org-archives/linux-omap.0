From: Vishal Mahaveer <vishalm@ti.com>
Subject: [PATCH v2 1/1] omap: blaze: add mmc5/wl1283 device support
Date: Fri, 24 Jun 2011 15:16:29 -0600
Message-ID: <1308950189-7357-2-git-send-email-vishalm@ti.com>
References: <1308950189-7357-1-git-send-email-vishalm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab1FXTsO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 15:48:14 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5OJmD35028991
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5OJmDdK003734
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:13 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5OJmDcr023546
	for <linux-omap@vger.kernel.org>; Fri, 24 Jun 2011 14:48:13 -0500 (CDT)
In-Reply-To: <1308950189-7357-1-git-send-email-vishalm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishal Mahaveer <vishalm@ti.com>

Add MMC5 support on BLAZE, which has the wl1283 device hardwired to.

The wl1283 is a 4-wire, 1.8V, embedded SDIO WLAN device with an external IRQ line,
and power-controlled by a GPIO-based fixed regulator.

Based on the patch for zoom by Ohad Ben-Cohen <ohad@wizery.com>

Signed-off-by: Vishal Mahaveer <vishalm@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |   81 +++++++++++++++++++++++++++++++++++
 1 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 63de2d3..189aa65 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -22,6 +22,7 @@
 #include <linux/i2c/twl.h>
 #include <linux/gpio_keys.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/fixed.h>
 #include <linux/leds.h>
 #include <linux/leds_pwm.h>
 
@@ -37,6 +38,7 @@
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
 #include <video/omapdss.h>
+#include <linux/wl12xx.h>
 
 #include "mux.h"
 #include "hsmmc.h"
@@ -52,6 +54,9 @@
 #define HDMI_GPIO_HPD 60 /* Hot plug pin for HDMI */
 #define HDMI_GPIO_LS_OE 41 /* Level shifter for HDMI */
 
+#define GPIO_WIFI_PMENA		54
+#define GPIO_WIFI_IRQ		53
+
 static const int sdp4430_keymap[] = {
 	KEY(0, 0, KEY_E),
 	KEY(0, 1, KEY_R),
@@ -329,6 +334,14 @@ static struct omap2_hsmmc_info mmc[] = {
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
 
@@ -345,6 +358,37 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
 	},
 };
 
+static struct regulator_consumer_supply omap4_sdp4430_vmmc5_supply = {
+	.supply = "vmmc",
+	.dev_name = "omap_hsmmc.4",
+};
+
+static struct regulator_init_data sdp4430_vmmc5 = {
+	.constraints = {
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies = 1,
+	.consumer_supplies = &omap4_sdp4430_vmmc5_supply,
+};
+
+static struct fixed_voltage_config sdp4430_vwlan = {
+	.supply_name = "vwl1271",
+	.microvolts = 1800000, /* 1.8V */
+	.gpio = GPIO_WIFI_PMENA,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &sdp4430_vmmc5,
+};
+
+static struct platform_device omap_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &sdp4430_vwlan,
+	},
+};
+
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
 {
 	int ret = 0;
@@ -519,6 +563,7 @@ static struct regulator_init_data sdp4430_vusb = {
 static struct regulator_init_data sdp4430_clk32kg = {
 	.constraints = {
 		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+		.always_on		= true,
 	},
 };
 
@@ -723,6 +768,41 @@ static inline void board_serial_init(void)
 }
  #endif
 
+static void omap4_sdp4430_wifi_mux_init(void)
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
+static struct wl12xx_platform_data omap4_sdp4430_wlan_data __initdata = {
+	.irq = OMAP_GPIO_IRQ(GPIO_WIFI_IRQ),
+	.board_ref_clock = WL12XX_REFCLOCK_26,
+	.board_tcxo_clock = WL12XX_TCXOCLOCK_26,
+};
+
+static void omap4_sdp4430_wifi_init(void)
+{
+	omap4_sdp4430_wifi_mux_init();
+	if (wl12xx_set_platform_data(&omap4_sdp4430_wlan_data))
+		pr_err("Error setting wl12xx data\n");
+	platform_device_register(&omap_vwlan_device);
+}
+
 static void __init omap_4430sdp_init(void)
 {
 	int status;
@@ -739,6 +819,7 @@ static void __init omap_4430sdp_init(void)
 	omap_sfh7741prox_init();
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	board_serial_init();
+	omap4_sdp4430_wifi_init();
 	omap4_twl6030_hsmmc_init(mmc);
 
 	usb_musb_init(&musb_board_data);
-- 
1.7.0.4

