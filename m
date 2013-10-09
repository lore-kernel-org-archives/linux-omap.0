From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v3 1/2] ARM: OMAP2+: pdata-quirks: add legacy display init for IGEPv2 board
Date: Wed,  9 Oct 2013 11:19:18 +0200
Message-ID: <1381310359-20668-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:42132 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756658Ab3JIJU0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 05:20:26 -0400
In-Reply-To: <1381310359-20668-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomy Valkeinen <tomi.valkeinen@ti.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, bcousson@baylibre.com, linux-omap@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

IGEPv2 board has both an DVI and TFP410 video interfaces but
DSS support for DeviceTree has not yet landed in mainline so
is necessary to init the displays using legacy platform code.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v2:
 - Don't mix display devices for different; suggested by Tomi Valkeinen
 - Remove the display setup from the board file and use the one in dss-common
   as suggested by Tomi Valkeinen

Changes since v1:
 - Remove duplicate entry in pdata_quirks[] due silly copy & paste error.

 arch/arm/mach-omap2/dss-common.c   | 44 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dss-common.h   |  1 +
 arch/arm/mach-omap2/pdata-quirks.c |  6 ++++++
 3 files changed, 51 insertions(+)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index bf89eff..365bfd3 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -213,3 +213,47 @@ void __init omap_4430sdp_display_init_of(void)
 	platform_device_register(&sdp4430_tpd_device);
 	platform_device_register(&sdp4430_hdmi_connector_device);
 }
+
+
+/* OMAP3 IGEPv2 data */
+
+#define IGEP2_DVI_TFP410_POWER_DOWN_GPIO	170
+
+/* DVI Connector */
+static struct connector_dvi_platform_data omap3_igep2_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = 3,
+};
+
+static struct platform_device omap3_igep2_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_igep2_dvi_connector_pdata,
+};
+
+/* TFP410 DPI-to-DVI chip */
+static struct encoder_tfp410_platform_data omap3_igep2_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = IGEP2_DVI_TFP410_POWER_DOWN_GPIO,
+};
+
+static struct platform_device omap3_igep2_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_igep2_tfp410_pdata,
+};
+
+static struct omap_dss_board_info igep2_dss_data = {
+	.default_display_name = "dvi",
+};
+
+void __init omap3_igep2_display_init_of(void)
+{
+	omap_display_init(&igep2_dss_data);
+
+	platform_device_register(&omap3_igep2_tfp410_device);
+	platform_device_register(&omap3_igep2_dvi_connector_device);
+}
diff --git a/arch/arm/mach-omap2/dss-common.h b/arch/arm/mach-omap2/dss-common.h
index c28fe3c..a9becf0 100644
--- a/arch/arm/mach-omap2/dss-common.h
+++ b/arch/arm/mach-omap2/dss-common.h
@@ -8,5 +8,6 @@
 
 void __init omap4_panda_display_init_of(void);
 void __init omap_4430sdp_display_init_of(void);
+void __init omap3_igep2_display_init_of(void);
 
 #endif
diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 3d472db..9113e70 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -74,6 +74,11 @@ static void __init hsmmc2_internal_input_clk(void)
 	reg |= OMAP2_MMCSDIO2ADPCLKISEL;
 	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
 }
+
+static void __init omap3_igep0020_legacy_init(void)
+{
+	omap3_igep2_display_init_of();
+}
 #endif /* CONFIG_ARCH_OMAP3 */
 
 #ifdef CONFIG_ARCH_OMAP4
@@ -103,6 +108,7 @@ static struct pdata_init pdata_quirks[] __initdata = {
 #ifdef CONFIG_ARCH_OMAP3
 	{ "nokia,omap3-n9", hsmmc2_internal_input_clk, },
 	{ "nokia,omap3-n950", hsmmc2_internal_input_clk, },
+	{ "isee,omap3-igep0020", omap3_igep0020_legacy_init, },
 #endif
 #ifdef CONFIG_ARCH_OMAP4
 	{ "ti,omap4-sdp", omap4_sdp_legacy_init, },
-- 
1.8.4.rc3

