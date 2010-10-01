From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] omap: pandora: add fixed regulator for wlan
Date: Fri, 01 Oct 2010 16:34:13 -0700
Message-ID: <20101001233413.31894.99754.stgit@baageli.muru.com>
References: <20101001233315.31894.49599.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56199 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753873Ab0JAXeO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 19:34:14 -0400
In-Reply-To: <20101001233315.31894.49599.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Grazvydas Ignotas <notasas@gmail.com>

From: Grazvydas Ignotas <notasas@gmail.com>

Instead of enabling the wifi module explicitly using GPIO, add a fixed
regulator and hook it to MMC host card power control. This way it will
only be enabled when SDIO subsystem wants to talk to it, saving power
(as done by Zoom boards).

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   43 ++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 2d2e6fc..7c222ba 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -34,6 +34,7 @@
 #include <linux/gpio_keys.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/regulator/fixed.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -345,6 +346,9 @@ static struct regulator_consumer_supply pandora_vmmc1_supply =
 static struct regulator_consumer_supply pandora_vmmc2_supply =
 	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.1");
 
+static struct regulator_consumer_supply pandora_vmmc3_supply =
+	REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.2");
+
 static struct regulator_consumer_supply pandora_vdda_dac_supply =
 	REGULATOR_SUPPLY("vdda_dac", "omapdss");
 
@@ -489,6 +493,33 @@ static struct regulator_init_data pandora_vsim = {
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
@@ -645,19 +676,8 @@ static void pandora_wl1251_init(void)
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
@@ -669,6 +689,7 @@ static struct platform_device *omap3pandora_devices[] __initdata = {
 	&pandora_keys_gpio,
 	&pandora_dss_device,
 	&pandora_wl1251_data,
+	&pandora_vwlan_device,
 };
 
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {

