From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 2/3] OMAP: move Sharp LS LCD panel device to generic DPI panel driver and new backlight driver
Date: Tue, 30 Nov 2010 20:07:39 +0800
Message-ID: <1291118860-10325-3-git-send-email-bryan.wu@canonical.com>
References: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:50808 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662Ab0K3MHz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 07:07:55 -0500
In-Reply-To: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, rpurdie@rpsys.net

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 arch/arm/mach-omap2/board-3430sdp.c  |   18 +++++++++++++++---
 arch/arm/mach-omap2/board-omap3evm.c |   20 +++++++++++++++++---
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 1ca0156..4c7eaf0 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -261,14 +261,25 @@ static void sdp3430_panel_disable_tv(struct omap_dss_device *dssdev)
 {
 }
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "sharp_ls",
+	.platform_enable	= sdp3430_panel_enable_lcd,
+	.platform_disable	= sdp3430_panel_disable_lcd,
+};
 
 static struct omap_dss_device sdp3430_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "sharp_ls_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines	= 16,
-	.platform_enable	= sdp3430_panel_enable_lcd,
-	.platform_disable	= sdp3430_panel_disable_lcd,
+};
+
+static struct platform_device sdp3430_lcd_backlight_device = {
+	.name		= "sharp-ls-bl",
+	.dev		= {
+		.platform_data = &sdp3430_lcd_device,
+	},
 };
 
 static struct panel_generic_dpi_data dvi_panel = {
@@ -322,6 +333,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supply = {
 
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_dss_device,
+	&sdp3430_lcd_backlight_device,
 };
 
 static struct omap_board_config_kernel sdp3430_config[] __initdata = {
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 369cbdc..4c507de 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -255,15 +255,28 @@ static void omap3_evm_disable_lcd(struct omap_dss_device *dssdev)
 	lcd_enabled = 0;
 }
 
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "sharp_ls",
+	.platform_enable	= omap3_evm_enable_lcd,
+	.platform_disable	= omap3_evm_disable_lcd,
+};
+
 static struct omap_dss_device omap3_evm_lcd_device = {
 	.name			= "lcd",
-	.driver_name		= "sharp_ls_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd_panel,
 	.phy.dpi.data_lines	= 18,
-	.platform_enable	= omap3_evm_enable_lcd,
-	.platform_disable	= omap3_evm_disable_lcd,
 };
 
+static struct platform_device omap3_evm_lcd_backlight_device = {
+	.name		= "sharp-ls-bl",
+	.dev		= {
+		.platform_data = &omap3_evm_lcd_device,
+	},
+};
+
+
 static int omap3_evm_enable_tv(struct omap_dss_device *dssdev)
 {
 	return 0;
@@ -636,6 +649,7 @@ static void __init omap3_evm_init_irq(void)
 
 static struct platform_device *omap3_evm_devices[] __initdata = {
 	&omap3_evm_dss_device,
+	&omap3_evm_lcd_backlight_device,
 };
 
 static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
-- 
1.7.1

