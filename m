From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 3/4] ARM: OMAP2+: add legacy display for omap3 DBB056
Date: Mon, 27 Jan 2014 01:33:16 +0100
Message-ID: <1390782797-24105-4-git-send-email-chf.fritz@googlemail.com>
References: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:44038 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753585AbaA0Adq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jan 2014 19:33:46 -0500
In-Reply-To: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tony Lindgren <tony@atomide.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, bcousson@baylibre.com, Daniel Mack <zonque@gmail.com>, "Hans J. Koch" <hjk@hansjkoch.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Full device tree support for omapdss is not yet accomplished. Until
then, init display by legacy platform code.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/mach-omap2/dss-common.c   |   49 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dss-common.h   |    1 +
 arch/arm/mach-omap2/pdata-quirks.c |    8 +++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index dadccc9..b8b4e39 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -257,3 +257,52 @@ void __init omap3_igep2_display_init_of(void)
 	platform_device_register(&omap3_igep2_tfp410_device);
 	platform_device_register(&omap3_igep2_dvi_connector_device);
 }
+
+/* OMAP3 dbb056 data */
+
+#define DBB056_DISPLAY_ENABLE_GPIO 156
+
+static const struct display_timing dbb056_lcd_videomode = {
+	.pixelclock = { 0, 19200000, 0 },
+
+	.hactive = { 0, 640, 0 },
+	.hfront_porch = { 0, 104, 0 },
+	.hback_porch = { 0, 8, 0 },
+	.hsync_len = { 0, 8, 0 },
+
+	.vactive = { 0, 480, 0 },
+	.vfront_porch = { 0, 104, 0 },
+	.vback_porch = { 0, 8, 0 },
+	.vsync_len = { 0, 8, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static struct panel_dpi_platform_data dbb056_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines             = 18,
+
+	.display_timing         = &dbb056_lcd_videomode,
+
+	.enable_gpio            = DBB056_DISPLAY_ENABLE_GPIO,
+	.backlight_gpio         = -1,
+};
+
+static struct platform_device dbb056_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &dbb056_lcd_pdata,
+};
+
+static struct omap_dss_board_info omap_dbb056_dss_data = {
+	.default_display_name = "lcd",
+};
+
+void __init omap3_dbb056_display_init_of(void)
+{
+	platform_device_register(&dbb056_lcd_device);
+	omap_display_init(&omap_dbb056_dss_data);
+}
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
index a9becf0..a125b55 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -9,5 +9,6 @@
 void __init omap4_panda_display_init_of(void);
 void __init omap_4430sdp_display_init_of(void);
 void __init omap3_igep2_display_init_of(void);
+void __init omap3_dbb056_display_init_of(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d5b24d..435a823 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -169,6 +169,11 @@ static void __init am3517_evm_legacy_init(void)
 	omap_ctrl_writel(v, AM35XX_CONTROL_IP_SW_RESET);
 	omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET); /* OCP barrier */
 }
+
+static void __init omap3_dbb056_legacy_init(void)
+{
+	omap3_dbb056_display_init_of();
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -259,10 +264,11 @@ struct of_dev_auxdata omap_auxdata_lookup[] __initdata = {
 static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	{ "compulab,omap3-sbc-t3730", omap3_sbc_t3730_legacy_init, },
+	{ "incostartec,omap3-lilly-dbb056", omap3_dbb056_legacy_init, },
+	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
 	{ "nokia,omap3-n900", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
-	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
 	{ "ti,omap3-evm-37xx", omap3_evm_legacy_init, },
 	{ "ti,omap3-zoom3", omap3_zoom_legacy_init, },
 	{ "ti,am3517-evm", am3517_evm_legacy_init, },
-- 
1.7.10.4

