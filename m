From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/23] ARM: OMAP4: omapdss: remove legacy pad muxing support
Date: Thu, 27 Nov 2014 17:51:47 +0200
Message-ID: <1417103514-17027-17-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37130 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751464AbaK0PwJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:09 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

OMAP4 is DT only now, so the legacy mux support is not needed anymore.
Padconf is used instead from the driver / DT. This removes the need
for having the mux APIs exported from the control module driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   38 --------------------------------------
 1 file changed, 38 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 7a050f9..c5a4592 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -104,51 +104,13 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initconst = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
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
1.7.9.5

