From: <mythripk@ti.com>
Subject: [PATCH v4 2/2] OMAPDSS: HDMI: Disable DDC internal pull up
Date: Mon, 2 Jan 2012 14:02:38 +0530
Message-ID: <1325493158-25740-3-git-send-email-mythripk@ti.com>
References: <1325493158-25740-1-git-send-email-mythripk@ti.com>
 <1325493158-25740-2-git-send-email-mythripk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab2ABIkM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jan 2012 03:40:12 -0500
In-Reply-To: <1325493158-25740-2-git-send-email-mythripk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Mythri P K <mythripk@ti.com>, Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>

From: Mythri P K <mythripk@ti.com>

Disables the internal pull resistor for SDA and SCL which are enabled by
default, as there are external pull up's in 4460 and 4430 ES2.3
SDP, Blaze and Panda Boards, It is done to avoid the EDID read failure.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@linaro.org>
Signed-off-by: Mythri P K <mythripk@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c    |    9 ++++++++-
 arch/arm/mach-omap2/board-omap4panda.c |   10 +++++++++-
 arch/arm/mach-omap2/display.c          |   22 +++++++++++++++++++---
 include/video/omapdss.h                |    6 +++++-
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c3bd640..4af874a 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -826,7 +826,14 @@ static void omap_4430sdp_display_init(void)
 	sdp4430_lcd_init();
 	sdp4430_picodlp_init();
 	omap_display_init(&sdp4430_dss_data);
-	omap_hdmi_init();
+	/*
+	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
+	 * later have external pull up on the HDMI I2C lines
+	 */
+	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
+		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
+	else
+		omap_hdmi_init(0);
 }
 
 #ifdef CONFIG_OMAP_MUX
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index d95df2e..00103e3 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -541,7 +541,15 @@ void omap4_panda_display_init(void)
 		pr_err("error initializing panda DVI\n");
 
 	omap_display_init(&omap4_panda_dss_data);
-	omap_hdmi_init();
+
+	/*
+	 * OMAP4460SDP/Blaze and OMAP4430 ES2.3 SDP/Blaze boards and
+	 * later have external pull up on the HDMI I2C lines
+	 */
+	if (cpu_is_omap446x() || omap_rev() > OMAP4430_REV_ES2_2)
+		omap_hdmi_init(OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP);
+	else
+		omap_hdmi_init(0);
 }
 
 static void __init omap4_panda_init(void)
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 8436088..ffd9bd9 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -97,8 +97,11 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void omap4_hdmi_mux_pads()
+static void omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
 {
+	u32 reg;
+	u16 control_i2c_1;
+
 	/* PAD0_HDMI_HPD_PAD1_HDMI_CEC */
 	omap_mux_init_signal("hdmi_hpd",
 			OMAP_PIN_INPUT_PULLUP);
@@ -109,6 +112,19 @@ static void omap4_hdmi_mux_pads()
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
 			OMAP_PIN_INPUT_PULLUP);
+
+	/*
+	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
+	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
+	 * internal pull up resistor.
+	 */
+	if (flags & OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP) {
+		control_i2c_1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1;
+		reg = omap4_ctrl_pad_readl(control_i2c_1);
+		reg |= (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK |
+			OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);
+			omap4_ctrl_pad_writel(reg, control_i2c_1);
+	}
 }
 
 static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
@@ -144,10 +160,10 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
-int omap_hdmi_init(void)
+int omap_hdmi_init(enum omap_hdmi_flags flags)
 {
 	if (cpu_is_omap44xx())
-		omap4_hdmi_mux_pads();
+		omap4_hdmi_mux_pads(flags);
 
 	return 0;
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 1e11683..05da097 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -200,6 +200,10 @@ enum omap_dss_clk_source {
 	OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI,	/* OMAP4: PLL2_CLK2 */
 };
 
+enum omap_hdmi_flags {
+	OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP = 1 << 0,
+};
+
 /* RFBI */
 
 struct rfbi_timings {
@@ -310,7 +314,7 @@ struct omap_dss_board_info {
 /* Init with the board info */
 extern int omap_display_init(struct omap_dss_board_info *board_data);
 /* HDMI mux init*/
-extern int omap_hdmi_init(void);
+extern int omap_hdmi_init(enum omap_hdmi_flags flags);
 
 struct omap_display_platform_data {
 	struct omap_dss_board_info *board_data;
-- 
1.7.5.4

