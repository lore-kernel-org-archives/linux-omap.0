From: Hema HK <hemahk@ti.com>
Subject: [PATCH 4/7] mfd: TWL6030: OMAP4: Registering the TWL6030-usb device
Date: Tue,  7 Dec 2010 19:11:35 -0500
Message-ID: <1291767095-10182-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44366 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753962Ab0LGNjl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 08:39:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb-owner@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

Registering the twl6030-usb transceiver device as a child to twl6030 core.
Removed the NOP transceiver init call from board file.

Populated twl4030_usb_data platform data structure with the function
pointers for OMAP4430 internal PHY operation to be used twl630-usb driver.


Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    9 +++++-
 arch/arm/mach-omap2/board-omap4panda.c |    7 +++++
 drivers/mfd/twl-core.c                 |   44 +++++++++++++++++++++++++++++----
 include/linux/i2c/twl.h                |    6 ++++
 4 files changed, 59 insertions(+), 7 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -231,6 +231,13 @@ static struct omap_musb_board_data musb_
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
@@ -450,6 +457,7 @@ static struct twl4030_platform_data sdp4
 	.vaux1		= &sdp4430_vaux1,
 	.vaux2		= &sdp4430_vaux2,
 	.vaux3		= &sdp4430_vaux3,
+	.usb		= &omap4_usbphy_data
 };
 
 static struct i2c_board_info __initdata sdp4430_i2c_boardinfo[] = {
@@ -514,8 +522,6 @@ static void __init omap_4430sdp_init(voi
 	platform_add_devices(sdp4430_devices, ARRAY_SIZE(sdp4430_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
-	/* OMAP4 SDP uses internal transceiver so register nop transceiver */
-	usb_nop_xceiv_register();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
Index: linux-2.6/drivers/mfd/twl-core.c
===================================================================
--- linux-2.6.orig/drivers/mfd/twl-core.c
+++ linux-2.6/drivers/mfd/twl-core.c
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
+			/* irq1 = VBUS_PRES, irq0 = USB ID*/
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
Index: linux-2.6/include/linux/i2c/twl.h
===================================================================
--- linux-2.6.orig/include/linux/i2c/twl.h
+++ linux-2.6/include/linux/i2c/twl.h
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
Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
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
