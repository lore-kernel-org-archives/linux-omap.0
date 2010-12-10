From: Hema HK <hemahk@ti.com>
Subject: [PATCH 5/8 V3] mfd: TWL6030: OMAP4: Registering the TWL6030-usb device
Date: Fri, 10 Dec 2010 18:09:52 +0530
Message-ID: <1291984792-25957-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40583 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755762Ab0LJMkB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 07:40:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Registering the twl6030-usb transceiver device as a child to twl6030 core.
Removed the NOP transceiver init call from board file.

Populated twl4030_usb_data platform data structure with the function
pointers for OMAP4430 internal PHY operation to be used by twl630-usb driver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   11 ++++++--
 arch/arm/mach-omap2/board-omap4panda.c |    8 ++++++
 drivers/mfd/twl-core.c                 |   44 +++++++++++++++++++++++++++++----
 include/linux/i2c/twl.h                |    7 +++++
 4 files changed, 62 insertions(+), 8 deletions(-)

Index: usb/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- usb.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ usb/arch/arm/mach-omap2/board-4430sdp.c
@@ -242,6 +242,13 @@ static struct omap_musb_board_data musb_
 	.power			= 100,
 };
 
+static struct twl4030_usb_data omap4_usbphy_data = {
+	.phy_init	= omap4430_phy_init,
+	.phy_exit	= omap4430_phy_exit,
+	.phy_power	= omap4430_phy_power,
+	.phy_set_clock	= omap4430_phy_set_clk,
+};
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -461,6 +468,7 @@ static struct twl4030_platform_data sdp4
 	.vaux1		= &sdp4430_vaux1,
 	.vaux2		= &sdp4430_vaux2,
 	.vaux3		= &sdp4430_vaux3,
+	.usb		= &omap4_usbphy_data
 };
 
 static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
@@ -533,9 +541,6 @@ static void __init omap_4430sdp_init(voi
 		gpio_direction_output(OMAP4SDP_MDM_PWR_EN_GPIO, 1);
 	}
 	usb_ehci_init(&ehci_pdata);
-
-	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	usb_musb_init(&musb_board_data);
 
 	status = omap_ethernet_init();
Index: usb/drivers/mfd/twl-core.c
===================================================================
--- usb.orig/drivers/mfd/twl-core.c
+++ usb/drivers/mfd/twl-core.c
@@ -95,7 +95,8 @@
 #define twl_has_rtc()	false
 #endif
 
-#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE)
+#if defined(CONFIG_TWL4030_USB) || defined(CONFIG_TWL4030_USB_MODULE) ||\
+	defined(CONFIG_TWL6030_USB) || defined(CONFIG_TWL6030_USB_MODULE)
 #define twl_has_usb()	true
 #else
 #define twl_has_usb()	false
@@ -682,6 +683,43 @@ add_children(struct twl4030_platform_dat
 			usb3v1.dev = child;
 		}
 	}
+	if (twl_has_usb() && pdata->usb && twl_class_is_6030()) {
+
+		static struct regulator_consumer_supply usb3v3 = {
+			.supply =	"vusb",
+		};
+
+		if (twl_has_regulator()) {
+			/* this is a template that gets copied */
+			struct regulator_init_data usb_fixed = {
+				.constraints.valid_modes_mask =
+					REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+				.constraints.valid_ops_mask =
+					REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+			};
+
+			child = add_regulator_linked(TWL6030_REG_VUSB,
+						      &usb_fixed, &usb3v3, 1);
+			if (IS_ERR(child))
+				return PTR_ERR(child);
+		}
+
+		child = add_child(0, "twl6030_usb",
+			pdata->usb, sizeof(*pdata->usb),
+			true,
+			/* irq1 = VBUS_PRES, irq0 = USB ID */
+			pdata->irq_base + USBOTG_INTR_OFFSET,
+			pdata->irq_base + USB_PRES_INTR_OFFSET);
+
+		if (IS_ERR(child))
+			return PTR_ERR(child);
+		/* we need to connect regulators to this transceiver */
+		if (twl_has_regulator() && child)
+			usb3v3.dev = child;
+
+	}
 
 	if (twl_has_watchdog()) {
 		child = add_child(0, "twl4030_wdt", NULL, 0, false, 0, 0);
@@ -815,10 +853,6 @@ add_children(struct twl4030_platform_dat
 		if (IS_ERR(child))
 			return PTR_ERR(child);
 
-		child = add_regulator(TWL6030_REG_VUSB, pdata->vusb);
-		if (IS_ERR(child))
-			return PTR_ERR(child);
-
 		child = add_regulator(TWL6030_REG_VAUX1_6030, pdata->vaux1);
 		if (IS_ERR(child))
 			return PTR_ERR(child);
Index: usb/include/linux/i2c/twl.h
===================================================================
--- usb.orig/include/linux/i2c/twl.h
+++ usb/include/linux/i2c/twl.h
@@ -593,6 +593,13 @@ enum twl4030_usb_mode {
 
 struct twl4030_usb_data {
 	enum twl4030_usb_mode	usb_mode;
+
+	int		(*phy_init)(struct device *dev);
+	int		(*phy_exit)(struct device *dev);
+	/* Power on/off the PHY */
+	int		(*phy_power)(struct device *dev, int iD, int on);
+	/* enable/disable  phy clocks */
+	int		(*phy_set_clock)(struct device *dev, int on);
 };
 
 struct twl4030_ins {
Index: usb/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- usb.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ usb/arch/arm/mach-omap2/board-omap4panda.c
@@ -137,6 +137,13 @@ static struct omap_musb_board_data musb_
 	.power			= 100,
 };
 
+static struct twl4030_usb_data omap4_usbphy_data = {
+	.phy_init	= omap4430_phy_init,
+	.phy_exit	= omap4430_phy_exit,
+	.phy_power	= omap4430_phy_power,
+	.phy_set_clock	= omap4430_phy_set_clk,
+};
+
 static struct omap2_hsmmc_info mmc[] = {
 	{
 		.mmc		= 1,
@@ -345,6 +352,7 @@ static struct twl4030_platform_data omap
 	.vaux1		= &omap4_panda_vaux1,
 	.vaux2		= &omap4_panda_vaux2,
 	.vaux3		= &omap4_panda_vaux3,
+	.usb		= &omap4_usbphy_data,
 };
 
 static struct i2c_board_info __initdata omap4_panda_i2c_boardinfo[] = {
