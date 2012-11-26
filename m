From: Andy Green <andy.green@linaro.org>
Subject: [RFC PATCH 4/5] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Mon, 26 Nov 2012 12:45:50 +0000
Message-ID: <20121126124550.18106.29133.stgit@build.warmcat.com>
References: <20121126123427.18106.4112.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:41664 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684Ab2KZMpz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 Nov 2012 07:45:55 -0500
In-Reply-To: <20121126123427.18106.4112.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: stern@rowland.harvard.edu
Cc: linux-omap@vger.kernel.org, keshava_mgowda@ti.com, linux-usb@vger.kernel.org, balbi@ti.com, rogerq@ti.com

This adds regulators which are controlled by the OMAP4 PandaBoard (ES)'s
EHCI logical root hub existing.

Without power control, the ULPI PHY + SMSC9614 on the Panda eats 700-900mW
all the time, which is around the same as the idle power of the SoC and
rest of the board.

This allows us to start off with it depowered, and only power it if the
ehci-hcd module is inserted.  When the module is removed, it's depowered
again.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 arch/arm/mach-omap2/Kconfig            |    1 
 arch/arm/mach-omap2/board-omap4panda.c |   90 +++++++++++++++++++++++++-------
 2 files changed, 72 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d669e22..5105109 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -368,6 +368,7 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBL
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select USB_HUB_DEVICE_PATH_REGULATOR
 
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..b032b6b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -154,11 +154,6 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
-static struct gpio panda_ehci_gpios[] __initdata = {
-	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
-	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
-};
-
 static void __init omap4_ehci_init(void)
 {
 	int ret;
@@ -173,23 +168,76 @@ static void __init omap4_ehci_init(void)
 	clk_set_rate(phy_ref_clk, 19200000);
 	clk_prepare_enable(phy_ref_clk);
 
-	/* disable the power to the usb hub prior to init and reset phy+hub */
-	ret = gpio_request_array(panda_ehci_gpios,
-				 ARRAY_SIZE(panda_ehci_gpios));
-	if (ret) {
-		pr_err("Unable to initialize EHCI power/reset\n");
-		return;
-	}
+	usbhs_init(&usbhs_bdata);
+}
 
-	gpio_export(GPIO_HUB_POWER, 0);
-	gpio_export(GPIO_HUB_NRESET, 0);
-	gpio_set_value(GPIO_HUB_NRESET, 1);
+/*
+ * hub_nreset also resets the ULPI PHY and is required after powering SMSC chip
+ *	ULPI PHY is always powered... need to do reset once for both once
+ * hub_power enables a 3.3V regulator for (hub + eth) chip
+ *	however there's no point having ULPI PHY in use alone
+ *	since it's only connected to the (hub + eth) chip
+ */
 
-	usbhs_init(&usbhs_bdata);
+static struct regulator_init_data panda_hub = {
+	.constraints = {
+		.name = "vhub",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
 
-	/* enable power to hub */
-	gpio_set_value(GPIO_HUB_POWER, 1);
-}
+static struct fixed_voltage_config panda_vhub = {
+	.supply_name = "vhub",
+	.microvolts = 3300000,
+	.gpio = GPIO_HUB_POWER,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &panda_hub,
+};
+
+static struct platform_device omap_vhub_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 2,
+	.dev = {
+		.platform_data = &panda_vhub,
+	},
+};
+
+static struct regulator_init_data panda_ulpireset = {
+	/*
+	 * idea is that when operating ulpireset, regulator api will make
+	 * sure that the hub+eth chip is powered, since it's the "parent"
+	 */
+	.supply_regulator = "vhub", /* we are a child of vhub */
+	.constraints = {
+		/*
+		 * this magic string associates us with ehci-omap.0 root hub
+		 * when the root hub logical device is up, we will power
+		 * and reset [ ULPI PHY + [ HUB + ETH ] ]
+		 */
+		.name = "/platform/usbhs_omap/ehci-omap.0/usb*",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config panda_vulpireset = {
+	.supply_name = "/platform/usbhs_omap/ehci-omap.0/usb*",
+	.microvolts = 3300000,
+	.gpio = GPIO_HUB_NRESET,
+	.startup_delay = 70000, /* 70msec */
+	.enable_high = 1,
+	.enabled_at_boot = 0,
+	.init_data = &panda_ulpireset,
+};
+
+static struct platform_device omap_vulpireset_device = {
+	.name		= "reg-fixed-voltage",
+	.id		= 3,
+	.dev = {
+		.platform_data = &panda_vulpireset,
+	},
+};
 
 static struct omap_musb_board_data musb_board_data = {
 	.interface_type		= MUSB_INTERFACE_UTMI,
@@ -503,7 +551,11 @@ static void __init omap4_panda_init(void)
 	omap4_panda_init_rev();
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
+	/* let device_path api know anything matching this reports as this */
+	device_path_register_wildcard_path(panda_ulpireset.constraints.name);
 	platform_device_register(&omap_vwlan_device);
+	platform_device_register(&omap_vhub_device);
+	platform_device_register(&omap_vulpireset_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);

