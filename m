From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/20] OMAPDSS: split hdmi muxing function
Date: Wed, 24 Oct 2012 12:29:11 +0300
Message-ID: <1351070951-18616-21-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47975 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934544Ab2JXJ35 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 05:29:57 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ricardo Neri <ricardo.neri@ti.com>

Split the omap4_hdmi_mux_pads() function into two parts, one handles the
tpd12s015 gpio muxing, the other handles the hdmi pins.

This is clearer, as hdmi and tpd12s015 are separate devices, and it also
allows us to mux those separately with DT.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ricardo Neri <ricardo.neri@ti.com>
---
 arch/arm/mach-omap2/display.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 28f5087..282c814e 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -100,17 +100,20 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initconst = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void __init omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
+static void __init omap4_tpd12s015_mux_pads(void)
 {
-	u32 reg;
-	u16 control_i2c_1;
-
 	omap_mux_init_signal("hdmi_cec",
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_scl",
 			OMAP_PIN_INPUT_PULLUP);
 	omap_mux_init_signal("hdmi_ddc_sda",
 			OMAP_PIN_INPUT_PULLUP);
+}
+
+static void __init omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
+{
+	u32 reg;
+	u16 control_i2c_1;
 
 	/*
 	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
@@ -161,8 +164,10 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 
 int __init omap_hdmi_init(enum omap_hdmi_flags flags)
 {
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		omap4_hdmi_mux_pads(flags);
+		omap4_tpd12s015_mux_pads();
+	}
 
 	return 0;
 }
-- 
1.7.9.5

