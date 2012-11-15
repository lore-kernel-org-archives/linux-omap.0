From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 16/16] ARM: OMAP: omap4panda: Power down the USB PHY and ETH when not in use
Date: Thu, 15 Nov 2012 16:34:14 +0200
Message-ID: <1352990054-14680-17-git-send-email-rogerq@ti.com>
References: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54712 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768033Ab2KOOek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 09:34:40 -0500
In-Reply-To: <1352990054-14680-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com, Andy Green <andy.green@linaro.org>

From: Andy Green <andy.green@linaro.org>

This patch changes the management of the two GPIO for
"hub reset" (actually controls enable of ULPI PHY and hub reset) and
"hub power" (controls power to hub + eth).

Because the only connection from the ULPI PHY output is to the hub+eth
chip, there is no meaning in having the ULPI PHY running but not the
hub+eth chip.

The patch adds two regulators, the hub power one being the parent of the
reset one, and binds the reset one to the hsusb driver by using the magic
name "hsusb.0".

The end result is the usb and eth driver may now be built modular, and
when ehci-hcd is not inserted, the ULPI PHY, hub and ethernet are all
depowered or held in reset.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   80 +++++++++++++++++++++++--------
 1 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index b942abe..90fb2c4 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -156,32 +156,68 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.clkrate[0] = 19200000,
 };
 
-static struct gpio panda_ehci_gpios[] __initdata = {
-	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
-	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
+/*
+ * hub_nreset also enables the ULPI PHY
+ * ULPI PHY is always powered
+ * hub_power enables a 3.3V regulator for (hub + eth) chip
+ * however there's no point having ULPI PHY in use alone
+ * since it's only connected to the (hub + eth) chip
+ */
+
+static struct regulator_init_data panda_hub = {
+	.constraints = {
+		.name = "vhub",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
 };
 
-static void __init omap4_ehci_init(void)
-{
-	int ret;
+static struct fixed_voltage_config panda_vhub = {
+	.supply_name = "vhub",
+	.microvolts = 3300000,
+	.gpio = GPIO_HUB_POWER,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &panda_hub,
+};
 
-	/* disable the power to the usb hub prior to init and reset phy+hub */
-	ret = gpio_request_array(panda_ehci_gpios,
-				 ARRAY_SIZE(panda_ehci_gpios));
-	if (ret) {
-		pr_err("Unable to initialize EHCI power/reset\n");
-		return;
-	}
+static struct platform_device omap_vhub_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 2,
+	.dev = {
+		.platform_data = &panda_vhub,
+	},
+};
 
-	gpio_export(GPIO_HUB_POWER, 0);
-	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 1);
+static struct regulator_init_data panda_ulpireset = {
+	/*
+	 * idea is that when operating ulpireset, regulator api will make
+	 * sure that the hub+eth chip is powered, since it's the "parent"
+	 */
+	.supply_regulator = "vhub", /* we are a child of vhub */
+	.constraints = {
+		.name = "hsusb0",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
 
-	usbhs_init(&usbhs_bdata);
+static struct fixed_voltage_config panda_vulpireset = {
+	.supply_name = "hsusb0",  /* this name is magic for hsusb driver */
+	.microvolts = 3300000,
+	.gpio = GPIO_HUB_NRESET,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &panda_ulpireset,
+};
 
-	/* enable power to hub */
-	gpio_set_value(GPIO_HUB_POWER, 1);
-}
+static struct platform_device omap_vulpireset_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 3,
+	.dev = {
+		.platform_data = &panda_vulpireset,
+	},
+};
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
@@ -496,10 +532,12 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
+	platform_device_register(&omap_vhub_device);
+	platform_device_register(&omap_vulpireset_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
-	omap4_ehci_init();
+	usbhs_init(&usbhs_bdata);
 	usb_musb_init(&musb_board_data);
 	omap4_panda_display_init();
 }
-- 
1.7.4.1

