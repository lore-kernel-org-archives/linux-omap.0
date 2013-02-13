From: Archit Taneja <archit@ti.com>
Subject: [PATCH 25/33] arm: omap: dss-common: use picodlp panel's gpio handling
Date: Wed, 13 Feb 2013 19:52:17 +0530
Message-ID: <1360765345-19312-26-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40254 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934079Ab3BMOYa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:24:30 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The dss-common file currently requests gpios required by the picodlp DPI
panel on the 4430sdp/blaze board. It also requests DISPLAY_SEL_GPIO and
DLP_POWER_ON_GPIO gpios which are board specific gpios to switch between lcd2
panel and picodlp, and setting intermediate power supplies for picodlp
respectively. These gpios are toggled through platform_enable/disable functions
called by the picodlp driver.

Remove the gpio requests for the gpios which are already requested by the panel
driver, and remove the platform callback functions and set the platform specific
gpios in such a way that lcd2 panel is selected for the LCD2 overlay manager and
the power supplies for picodlp are disabled.

Note: We need to revisit this so that we can enable and switch to picodlp if
that's the only panel driver available for the LCD2 overlay manager.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/dss-common.c |   53 ++++++++++++--------------------------
 1 file changed, 16 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index 9c49bbe..b073e8b 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -177,45 +177,12 @@ static struct picodlp_panel_data sdp4430_picodlp_pdata = {
 	.pwrgood_gpio		= 45,
 };
 
-static void sdp4430_picodlp_init(void)
-{
-	int r;
-	const struct gpio picodlp_gpios[] = {
-		{DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
-			"DLP POWER ON"},
-		{sdp4430_picodlp_pdata.emu_done_gpio, GPIOF_IN,
-			"DLP EMU DONE"},
-		{sdp4430_picodlp_pdata.pwrgood_gpio, GPIOF_OUT_INIT_LOW,
-			"DLP PWRGOOD"},
-	};
-
-	r = gpio_request_array(picodlp_gpios, ARRAY_SIZE(picodlp_gpios));
-	if (r)
-		pr_err("Cannot request PicoDLP GPIOs, error %d\n", r);
-}
-
-static int sdp4430_panel_enable_picodlp(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(DISPLAY_SEL_GPIO, 0);
-	gpio_set_value(DLP_POWER_ON_GPIO, 1);
-
-	return 0;
-}
-
-static void sdp4430_panel_disable_picodlp(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(DLP_POWER_ON_GPIO, 0);
-	gpio_set_value(DISPLAY_SEL_GPIO, 1);
-}
-
 static struct omap_dss_device sdp4430_picodlp_device = {
 	.name			= "picodlp",
 	.driver_name		= "picodlp_panel",
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.phy.dpi.data_lines	= 24,
 	.channel		= OMAP_DSS_CHANNEL_LCD2,
-	.platform_enable	= sdp4430_panel_enable_picodlp,
-	.platform_disable	= sdp4430_panel_disable_picodlp,
 	.data			= &sdp4430_picodlp_pdata,
 };
 
@@ -232,17 +199,26 @@ static struct omap_dss_board_info sdp4430_dss_data = {
 	.default_device	= &sdp4430_lcd_device,
 };
 
+/*
+ * we select LCD2 by default (instead of Pico DLP) by setting DISPLAY_SEL_GPIO.
+ * Setting DLP_POWER_ON gpio enables the VDLP_2V5 VDLP_1V8 and VDLP_1V0 rails
+ * used by picodlp on the 4430sdp platform. Keep this gpio disabled as LCD2 is
+ * selected by default
+ */
 void __init omap_4430sdp_display_init(void)
 {
 	int r;
 
-	/* Enable LCD2 by default (instead of Pico DLP) */
 	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
 			"display_sel");
 	if (r)
 		pr_err("%s: Could not get display_sel GPIO\n", __func__);
 
-	sdp4430_picodlp_init();
+	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
+		"DLP POWER ON");
+	if (r)
+		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
+
 	omap_display_init(&sdp4430_dss_data);
 	/*
 	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
@@ -262,12 +238,15 @@ void __init omap_4430sdp_display_init_of(void)
 {
 	int r;
 
-	/* Enable LCD2 by default (instead of Pico DLP) */
 	r = gpio_request_one(DISPLAY_SEL_GPIO, GPIOF_OUT_INIT_HIGH,
 			"display_sel");
 	if (r)
 		pr_err("%s: Could not get display_sel GPIO\n", __func__);
 
-	sdp4430_picodlp_init();
+	r = gpio_request_one(DLP_POWER_ON_GPIO, GPIOF_OUT_INIT_LOW,
+		"DLP POWER ON");
+	if (r)
+		pr_err("%s: Could not get DLP POWER ON GPIO\n", __func__);
+
 	omap_display_init(&sdp4430_dss_data);
 }
-- 
1.7.9.5

