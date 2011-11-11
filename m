From: <mythripk@ti.com>
Subject: [PATCH v2 1/2] OMAPDSS: HDMI: Move duplicate code from boardfile to
Date: Fri, 11 Nov 2011 18:38:17 +0530
Message-ID: <1321016900-1714-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52828 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757830Ab1KKNQJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 08:16:09 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id pABDG6tg016206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 07:16:08 -0600
Received: from DBDE71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pABDG54U021858
	for <linux-omap@vger.kernel.org>; Fri, 11 Nov 2011 18:46:05 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>

From: Mythri P K <mythripk@ti.com>

Move duplicate HDMI mux_init code from omap4 and panda board file
to display file.

Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   16 +---------------
 arch/arm/mach-omap2/board-omap4panda.c |   17 +----------------
 arch/arm/mach-omap2/display.c          |   23 +++++++++++++++++++++++
 include/video/omapdss.h                |    2 ++
 4 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 73b1e99..4a519a3 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -595,20 +595,6 @@ static void __init omap_sfh7741prox_init(void)
 			__func__, OMAP4_SFH7741_ENABLE_GPIO, error);
 }
 
-static void sdp4430_hdmi_mux_init(void)
-{
-	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
-	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_cec",
-			OMAP_PIN_INPUT_PULLUP);
-	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
-	omap_mux_init_signal("hdmi_ddc_scl",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_ddc_sda",
-			OMAP_PIN_INPUT_PULLUP);
-}
-
 static struct gpio sdp4430_hdmi_gpios[] = {
 	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_hpd"   },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH,	"hdmi_gpio_ls_oe" },
@@ -838,9 +824,9 @@ static void omap_4430sdp_display_init(void)
 		pr_err("%s: Could not get display_sel GPIO\n", __func__);
 
 	sdp4430_lcd_init();
-	sdp4430_hdmi_mux_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
+	omap_hdmi_enable_pads();
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a5b576b..26c6440 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -478,21 +478,6 @@ int __init omap4_panda_dvi_init(void)
 	return r;
 }
 
-
-static void omap4_panda_hdmi_mux_init(void)
-{
-	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
-	omap_mux_init_signal("hdmi_hpd",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_cec",
-			OMAP_PIN_INPUT_PULLUP);
-	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
-	omap_mux_init_signal("hdmi_ddc_scl",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_ddc_sda",
-			OMAP_PIN_INPUT_PULLUP);
-}
-
 static struct gpio panda_hdmi_gpios[] = {
 	{ HDMI_GPIO_HPD,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_hpd"   },
 	{ HDMI_GPIO_LS_OE,	GPIOF_OUT_INIT_HIGH, "hdmi_gpio_ls_oe" },
@@ -555,8 +540,8 @@ void omap4_panda_display_init(void)
 	if (r)
 		pr_err("error initializing panda DVI\n");
 
-	omap4_panda_hdmi_mux_init();
 	omap_display_init(&omap4_panda_dss_data);
+	omap_hdmi_enable_pads();
 }
 
 static void __init omap4_panda_init(void)
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index dce9905..ec7ac1b 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -29,6 +29,7 @@
 #include <plat/omap-pm.h>
 #include <plat/common.h>
 
+#include "mux.h"
 #include "control.h"
 #include "display.h"
 
@@ -96,6 +97,20 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+static void omap4_hdmi_mux_pads(void)
+{
+	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
+	omap_mux_init_signal("hdmi_hpd",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_cec",
+			OMAP_PIN_INPUT_PULLUP);
+	/* PAD0_HDMI_DDC_SCL_PAD1_HDMI_DDC_SDA */
+	omap_mux_init_signal("hdmi_ddc_scl",
+			OMAP_PIN_INPUT_PULLUP);
+	omap_mux_init_signal("hdmi_ddc_sda",
+			OMAP_PIN_INPUT_PULLUP);
+}
+
 static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 {
 	u32 enable_mask, enable_shift;
@@ -129,6 +144,14 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
+int omap_hdmi_enable_pads(void)
+{
+	if (cpu_is_omap44xx())
+		omap4_hdmi_mux_pads();
+
+	return 0;
+}
+
 static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 378c7ed..f4913d6 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -309,6 +309,8 @@ struct omap_dss_board_info {
 
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
+/* HDMI mux init*/
+extern int omap_hdmi_enable_pads(void);
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
-- 
1.7.5.4

