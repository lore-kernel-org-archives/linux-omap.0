From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Remove legacy mux code for display.c
Date: Tue, 19 Nov 2013 08:31:24 -0800
Message-ID: <1384878685-1515-2-git-send-email-tony@atomide.com>
References: <1384878685-1515-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63759 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973Ab3KSQb3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 11:31:29 -0500
In-Reply-To: <1384878685-1515-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

This is all omap4 specific, which is device tree based
nowadays and should use pinctrl-single instead.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/display.c | 78 -------------------------------------------
 1 file changed, 78 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index a4e536b..58347bb 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -32,7 +32,6 @@
 
 #include "soc.h"
 #include "iomap.h"
-#include "mux.h"
 #include "control.h"
 #include "display.h"
 #include "prm.h"
@@ -102,90 +101,13 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initconst = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
-static void __init omap4_tpd12s015_mux_pads(void)
-{
-	omap_mux_init_signal("hdmi_cec",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_ddc_scl",
-			OMAP_PIN_INPUT_PULLUP);
-	omap_mux_init_signal("hdmi_ddc_sda",
-			OMAP_PIN_INPUT_PULLUP);
-}
-
-static void __init omap4_hdmi_mux_pads(enum omap_hdmi_flags flags)
-{
-	u32 reg;
-	u16 control_i2c_1;
-
-	/*
-	 * CONTROL_I2C_1: HDMI_DDC_SDA_PULLUPRESX (bit 28) and
-	 * HDMI_DDC_SCL_PULLUPRESX (bit 24) are set to disable
-	 * internal pull up resistor.
-	 */
-	if (flags & OMAP_HDMI_SDA_SCL_EXTERNAL_PULLUP) {
-		control_i2c_1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_I2C_1;
-		reg = omap4_ctrl_pad_readl(control_i2c_1);
-		reg |= (OMAP4_HDMI_DDC_SDA_PULLUPRESX_MASK |
-			OMAP4_HDMI_DDC_SCL_PULLUPRESX_MASK);
-			omap4_ctrl_pad_writel(reg, control_i2c_1);
-	}
-}
-
-static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
-{
-	u32 enable_mask, enable_shift;
-	u32 pipd_mask, pipd_shift;
-	u32 reg;
-
-	if (dsi_id == 0) {
-		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
-		enable_shift = OMAP4_DSI1_LANEENABLE_SHIFT;
-		pipd_mask = OMAP4_DSI1_PIPD_MASK;
-		pipd_shift = OMAP4_DSI1_PIPD_SHIFT;
-	} else if (dsi_id == 1) {
-		enable_mask = OMAP4_DSI2_LANEENABLE_MASK;
-		enable_shift = OMAP4_DSI2_LANEENABLE_SHIFT;
-		pipd_mask = OMAP4_DSI2_PIPD_MASK;
-		pipd_shift = OMAP4_DSI2_PIPD_SHIFT;
-	} else {
-		return -ENODEV;
-	}
-
-	reg = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
-
-	reg &= ~enable_mask;
-	reg &= ~pipd_mask;
-
-	reg |= (lanes << enable_shift) & enable_mask;
-	reg |= (lanes << pipd_shift) & pipd_mask;
-
-	omap4_ctrl_pad_writel(reg, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
-
-	return 0;
-}
-
-int __init omap_hdmi_init(enum omap_hdmi_flags flags)
-{
-	if (cpu_is_omap44xx()) {
-		omap4_hdmi_mux_pads(flags);
-		omap4_tpd12s015_mux_pads();
-	}
-
-	return 0;
-}
-
 static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
-	if (cpu_is_omap44xx())
-		return omap4_dsi_mux_pads(dsi_id, lane_mask);
-
 	return 0;
 }
 
 static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
-	if (cpu_is_omap44xx())
-		omap4_dsi_mux_pads(dsi_id, 0);
 }
 
 static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long tput)
-- 
1.8.1.1

