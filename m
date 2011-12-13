From: <mythripk@ti.com>
Subject: [PATCH 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Tue, 13 Dec 2011 11:26:58 +0530
Message-ID: <1323755818-17901-2-git-send-email-mythripk@ti.com>
References: <1323755818-17901-1-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751909Ab1LMGEj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Dec 2011 01:04:39 -0500
In-Reply-To: <1323755818-17901-1-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

From: Mythri P K <mythripk@ti.com>

Disables the internal pull resistor for SDA and SCL which are enabled by
default, as there are expernal pull up's in 4460 and 4430 ES2.3
SDP, Blaze and Panda Boards, It is done to avoid the EDID read failure.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |   13 ++++++++++++-
 arch/arm/mach-omap2/board-omap4panda.c |   14 +++++++++++++-
 arch/arm/mach-omap2/display.c          |   17 ++++++++++++++---
 include/video/omapdss.h                |    4 +++-
 4 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c3bd640..1b7c5e5 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -826,7 +826,18 @@ static void omap_4430sdp_display_init(void)
 	sdp4430_lcd_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
-	omap_hdmi_init();
+	/*
+	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
+	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
+	 * internal pull up resistor - This is a change needed in
+	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze Boards as the
+	 * external pull up are present. This is needed to avoid
+	 * EDID read failure.
+	 */
+	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
+		omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
+	else
+		omap_hdmi_init(0);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d95df2e..212e06c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -541,7 +541,19 @@ void omap4_panda_display_init(void)
 		pr_err("error initializing panda DVI\n");
 
 	omap_display_init(&omap4_panda_dss_data);
-	omap_hdmi_init();
+
+	/*
+	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
+	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
+	 * internal pull up resistor - This is a change needed in
+	 * OMAP4460 Panda and OMAP4430 ES2.3 Panda Boards as the
+	 * external pull up are present. This is needed to avoid
+	 * EDID read failure.
+	 */
+	if (cpu_is_omap446x() || (omap_rev() > OMAP4430_REV_ES2_2))
+		omap_hdmi_init(OMAP_HDMI_EXTERNAL_PULLUP);
+	else
+		omap_hdmi_init(0);
 }
 
 static void __init omap4_panda_init(void)
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 8436088..a75e179 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -97,8 +97,11 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void omap4_hdmi_mux_pads()
+static void omap4_hdmi_mux_pads(int flags)
 {
+	u32 reg;
+	u16 control_i2c_1;
+
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
 	omap_mux_init_signal("hdmi_hpd",
 			OMAP_PIN_INPUT_PULLUP);
@@ -109,6 +112,14 @@ static void omap4_hdmi_mux_pads()
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
 			OMAP_PIN_INPUT_PULLUP);
+
+	if (flags & OMAP_HDMI_EXTERNAL_PULLUP) {
+		control_i2c_1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1;
+		reg = omap4_ctrl_pad_readl(control_i2c_1);
+		reg |= (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK |
+		OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);
+		omap4_ctrl_pad_writel(reg, control_i2c_1);
+	}
 }
 
 static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
@@ -144,10 +155,10 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
-int omap_hdmi_init(void)
+int omap_hdmi_init(int flags)
 {
 	if (cpu_is_omap44xx())
-		omap4_hdmi_mux_pads();
+		omap4_hdmi_mux_pads(flags);
 
 	return 0;
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 0cb0469..df585b5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -49,6 +49,8 @@
 #define DISPC_IRQ_FRAMEDONETV		(1 << 24)
 #define DISPC_IRQ_WBBUFFEROVERFLOW	(1 << 25)
 
+#define OMAP_HDMI_EXTERNAL_PULLUP	0x1
+
 struct omap_dss_device;
 struct omap_overlay_manager;
 
@@ -310,7 +312,7 @@ struct omap_dss_board_info {
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
 /* HDMI mux init*/
-extern int  omap_hdmi_init(void);
+extern int  omap_hdmi_init(int flags);
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
-- 
1.7.5.4

