From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCHv2 4/8] omap3: Enable DSS2 for IGEP v2 board
Date: Wed, 18 Nov 2009 21:20:36 +0100
Message-ID: <1258575640-8169-5-git-send-email-eballetbo@gmail.com>
References: <1258575640-8169-1-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-2-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-3-git-send-email-eballetbo@gmail.com>
 <1258575640-8169-4-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:63735 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417Ab0AMLCw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jan 2010 06:02:52 -0500
Received: by mail-ew0-f209.google.com with SMTP id 1so323499ewy.28
        for <linux-omap@vger.kernel.org>; Wed, 13 Jan 2010 03:02:51 -0800 (PST)
In-Reply-To: <1258575640-8169-4-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>


Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   75 ++++++++++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 6088d65..ea4e29f 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -28,6 +28,7 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
+#include <plat/display.h>
 
 #include "mux.h"
 #include "mmc-twl4030.h"
@@ -38,6 +39,7 @@
 #define IGEP2_GPIO_LED0_RED 	26
 #define IGEP2_GPIO_LED0_GREEN 	27
 #define IGEP2_GPIO_LED1_RED   	28
+#define IGEP2_GPIO_DVI_PUP	170
 
 #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
 
@@ -164,6 +166,76 @@ static struct twl4030_usb_data igep2_usb_data = {
 	.usb_mode	= T2_USB_MODE_ULPI,
 };
 
+static int igep2_enable_dvi(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1);
+
+	return 0;
+}
+
+static void igep2_disable_dvi(struct omap_dss_device *dssdev)
+{
+	gpio_direction_output(IGEP2_GPIO_DVI_PUP, 0);
+}
+
+static struct omap_dss_device igep2_dvi_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "dvi",
+	.driver_name		= "generic_panel",
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= igep2_enable_dvi,
+	.platform_disable	= igep2_disable_dvi,
+};
+
+static struct omap_dss_device *igep2_dss_devices[] = {
+	&igep2_dvi_device
+};
+
+static struct omap_dss_board_info igep2_dss_data = {
+	.num_devices	= ARRAY_SIZE(igep2_dss_devices),
+	.devices	= igep2_dss_devices,
+	.default_device	= &igep2_dvi_device,
+};
+
+static struct platform_device igep2_dss_device = {
+	.name	= "omapdss",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &igep2_dss_data,
+	},
+};
+
+static struct regulator_consumer_supply igep2_vpll2_supply = {
+	.supply	= "vdds_dsi",
+	.dev	= &igep2_dss_device.dev,
+};
+
+static struct regulator_init_data igep2_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.apply_uV		= true,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &igep2_vpll2_supply,
+};
+
+static void __init igep2_display_init(void)
+{
+	if (gpio_request(IGEP2_GPIO_DVI_PUP, "GPIO_DVI_PUP") &&
+	    gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1))
+		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
+}
+
+static struct platform_device *igep2_devices[] __initdata = {
+	&igep2_dss_device,
+};
+
 static void __init igep2_init_irq(void)
 {
 	omap_board_config = igep2_config;
@@ -191,6 +263,7 @@ static struct twl4030_platform_data igep2_twldata = {
 	.codec		= &igep2_codec_data,
 	.gpio		= &igep2_gpio_data,
 	.vmmc1          = &igep2_vmmc1,
+	.vpll2		= &igep2_vpll2,
 
 };
 
@@ -236,10 +309,12 @@ static void __init igep2_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	igep2_i2c_init();
+	platform_add_devices(igep2_devices, ARRAY_SIZE(igep2_devices));
 	omap_serial_init();
 	usb_musb_init();
 	usb_ehci_init(&ehci_pdata);
 
+	igep2_display_init();
 	igep2_init_smsc911x();
 
 	/* GPIO userspace leds */
-- 
1.5.4.3

