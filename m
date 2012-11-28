From: Andy Green <andy.green@linaro.org>
Subject: [try#1 PATCH 5/7] omap4: panda: add smsc95xx regulator and reset
 dependent on root hub
Date: Wed, 28 Nov 2012 12:59:55 +0000
Message-ID: <20121128125955.29569.25431.stgit@build.warmcat.com>
References: <20121128124744.29569.52739.stgit@build.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from warmcat.com ([87.106.134.80]:59186 "EHLO warmcat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754999Ab2K1M77 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 07:59:59 -0500
In-Reply-To: <20121128124744.29569.52739.stgit@build.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org, rogerq@ti.com, keshava_mgowda@ti.com, balbi@ti.com, stern@rowland.harvard.edu

This adds regulators which are controlled by the OMAP4 PandaBoard (ES)'s
EHCI logical root hub existing.

The regulators are made a device_asset of the EHCI logical root hub by
passing them through the hsusb -> mfd path.  Although the ehci-related
platform_device is created at boot time, it is not instantiated until the
ehci-hcd module is inserted if it is modular.

Since the regulator is an asset of the ehci-omap.0 device, it's turned on
during successful probe and off when the device is removed.

Without power control, the ULPI PHY + SMSC9614 on the Panda eats 700-900mW
all the time, which is around the same as the idle power of the SoC and
rest of the board.

This allows us to start off with it depowered, and only power it if the
ehci-hcd module is inserted.  When the module is removed, it's depowered
again.

Signed-off-by: Andy Green <andy.green@linaro.org>
---
 arch/arm/mach-omap2/board-omap4panda.c |  100 ++++++++++++++++++++++++++------
 arch/arm/mach-omap2/usb-host.c         |    1 
 arch/arm/plat-omap/include/plat/usb.h  |    2 +
 drivers/mfd/omap-usb-host.c            |    9 ++-
 4 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index bfcd397..52add03 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -144,6 +144,15 @@ static struct platform_device *panda_devices[] __initdata = {
 	&btwilink_device,
 };
 
+static struct device_asset assets_ehci_omap0[] = {
+	{
+		.name = "reg-panda-smsc95xx",
+		.pre_probe = regulator_asset_default_preprobe,
+		.post_remove = regulator_asset_default_postremove,
+	},
+	{ }
+};
+
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
@@ -151,12 +160,8 @@ static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 	.phy_reset  = false,
 	.reset_gpio_port[0]  = -EINVAL,
 	.reset_gpio_port[1]  = -EINVAL,
-	.reset_gpio_port[2]  = -EINVAL
-};
-
-static struct gpio panda_ehci_gpios[] __initdata = {
-	{ GPIO_HUB_POWER,	GPIOF_OUT_INIT_LOW,  "hub_power"  },
-	{ GPIO_HUB_NRESET,	GPIOF_OUT_INIT_LOW,  "hub_nreset" },
+	.reset_gpio_port[2]  = -EINVAL,
+	.assets = assets_ehci_omap0,
 };
 
 static void __init omap4_ehci_init(void)
@@ -173,23 +178,76 @@ static void __init omap4_ehci_init(void)
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
+		.name = "reg-panda-smsc95xx",
+		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
+	},
+};
+
+static struct fixed_voltage_config panda_vulpireset = {
+	.supply_name = "reg-panda-smsc95xx",
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
@@ -504,6 +562,8 @@ static void __init omap4_panda_init(void)
 	omap4_panda_i2c_init();
 	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	platform_device_register(&omap_vwlan_device);
+	platform_device_register(&omap_vhub_device);
+	platform_device_register(&omap_vulpireset_device);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
 	omap4_twl6030_hsmmc_init(mmc);
diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index 98f3287..2a0fdf9 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -501,6 +501,7 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 	}
 	ehci_data.phy_reset = pdata->phy_reset;
 	ohci_data.es2_compatibility = pdata->es2_compatibility;
+	ehci_data.assets = pdata->assets;
 	usbhs_data.ehci_data = &ehci_data;
 	usbhs_data.ohci_data = &ohci_data;
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 70acdee..6f6235e 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -36,6 +36,7 @@ struct usbhs_omap_board_data {
 	unsigned			es2_compatibility:1;
 
 	unsigned			phy_reset:1;
+	struct device_asset		*assets;
 };
 
 #ifdef CONFIG_ARCH_OMAP2PLUS
@@ -44,6 +45,7 @@ struct ehci_hcd_omap_platform_data {
 	enum usbhs_omap_port_mode	port_mode[OMAP3_HS_USB_PORTS];
 	int				reset_gpio_port[OMAP3_HS_USB_PORTS];
 	unsigned			phy_reset:1;
+	struct device_asset		*assets;
 };
 
 struct ohci_hcd_omap_platform_data {
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 23cec57..6d57c9d 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -25,6 +25,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
 #include <linux/gpio.h>
+#include <linux/device.h>
 #include <plat/cpu.h>
 #include <plat/usb.h>
 #include <linux/pm_runtime.h>
@@ -136,7 +137,8 @@ static inline u8 usbhs_readb(void __iomem *base, u8 reg)
 
 static struct platform_device *omap_usbhs_alloc_child(const char *name,
 			struct resource	*res, int num_resources, void *pdata,
-			size_t pdata_size, struct device *dev)
+			size_t pdata_size, struct device *dev,
+			struct device_asset *assets)
 {
 	struct platform_device	*child;
 	int			ret;
@@ -160,6 +162,7 @@ static struct platform_device *omap_usbhs_alloc_child(const char *name,
 		goto err_alloc;
 	}
 
+	child->dev.assets = assets;
 	child->dev.dma_mask		= &usbhs_dmamask;
 	dma_set_coherent_mask(&child->dev, DMA_BIT_MASK(32));
 	child->dev.parent		= dev;
@@ -212,7 +215,7 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	resources[1] = *res;
 
 	ehci = omap_usbhs_alloc_child(OMAP_EHCI_DEVICE, resources, 2, ehci_data,
-		sizeof(*ehci_data), dev);
+		sizeof(*ehci_data), dev, ehci_data->assets);
 
 	if (!ehci) {
 		dev_err(dev, "omap_usbhs_alloc_child failed\n");
@@ -237,7 +240,7 @@ static int omap_usbhs_alloc_children(struct platform_device *pdev)
 	resources[1] = *res;
 
 	ohci = omap_usbhs_alloc_child(OMAP_OHCI_DEVICE, resources, 2, ohci_data,
-		sizeof(*ohci_data), dev);
+		sizeof(*ohci_data), dev, NULL);
 	if (!ohci) {
 		dev_err(dev, "omap_usbhs_alloc_child failed\n");
 		ret = -ENOMEM;

