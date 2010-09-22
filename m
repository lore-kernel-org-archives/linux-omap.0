From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH] omap: pandora: add fixed regulator for wlan
Date: Thu, 23 Sep 2010 00:20:27 +0300
Message-ID: <1285190427-15834-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44845 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab0IVVUk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Sep 2010 17:20:40 -0400
Received: by ewy23 with SMTP id 23so296980ewy.19
        for <linux-omap@vger.kernel.org>; Wed, 22 Sep 2010 14:20:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Grazvydas Ignotas <notasas@gmail.com>

Instead of enabling the wifi module explicitly using GPIO, add a fixed
regulator and hook it to MMC host card power control. This way it will
only be enabled when SDIO subsystem wants to talk to it, saving power
(as done by Zoom boards).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   43 ++++++++++++++++++++++-------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 7ea1eb4..3214cd7 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -33,6 +33,7 @@
 #include <linux/input/matrix_keypad.h>
 #include <linux/gpio_keys.h>
 #include <linux/mmc/card.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -344,6 +345,9 @@ static struct regulator_consumer_supply pandora_vmmc1_supply =
 static struct regulator_consumer_supply pandora_vmmc2_supply =
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
 
+static struct regulator_consumer_supply pandora_vmmc3_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.2");
+
 static struct regulator_consumer_supply pandora_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
@@ -488,6 +492,33 @@ static struct regulator_init_data pandora_vsim = {
 	.consumer_supplies	= &pandora_adac_supply,
 };
 
+/* Fixed regulator internal to Wifi module */
+static struct regulator_init_data pandora_vmmc3 = {
+	.constraints = {
+		.valid_ops_mask		= REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &pandora_vmmc3_supply,
+};
+
+static struct fixed_voltage_config pandora_vwlan = {
+	.supply_name		= "vwlan",
+	.microvolts		= 1800000, /* 1.8V */
+	.gpio			= PANDORA_WIFI_NRESET_GPIO,
+	.startup_delay		= 50000, /* 50ms */
+	.enable_high		= 1,
+	.enabled_at_boot	= 0,
+	.init_data		= &pandora_vmmc3,
+};
+
+static struct platform_device pandora_vwlan_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 1,
+	.dev = {
+		.platform_data = &pandora_vwlan,
+	},
+};
+
 static struct twl4030_usb_data omap3pandora_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
@@ -644,19 +675,8 @@ static void pandora_wl1251_init(void)
 	if (pandora_wl1251_pdata.irq < 0)
 		goto fail_irq;
 
-	ret = gpio_request(PANDORA_WIFI_NRESET_GPIO, "wl1251 nreset");
-	if (ret < 0)
-		goto fail_irq;
-
-	/* start powered so that it probes with MMC subsystem */
-	ret = gpio_direction_output(PANDORA_WIFI_NRESET_GPIO, 1);
-	if (ret < 0)
-		goto fail_nreset;
-
 	return;
 
-fail_nreset:
-	gpio_free(PANDORA_WIFI_NRESET_GPIO);
 fail_irq:
 	gpio_free(PANDORA_WIFI_IRQ_GPIO);
 fail:
@@ -668,6 +688,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 	&pandora_dss_device,
 	&pandora_wl1251_data,
+	&pandora_vwlan_device,
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
-- 
1.6.3.3

