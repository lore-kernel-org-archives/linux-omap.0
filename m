From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Implement dsi_mux_pads for OMAP4
Date: Mon, 22 Aug 2011 11:26:39 +0300
Message-ID: <1314001599-17951-5-git-send-email-tomi.valkeinen@ti.com>
References: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:37597 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755329Ab1HVI1F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Aug 2011 04:27:05 -0400
In-Reply-To: <1314001599-17951-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Implement dsi_mux_pads for OMAP4. On enable the function enables the DSI
pins and disables pull down. On disable the function disables the pins
and enables pull down.

It is unclear from the TRM whether the pull down is active if the pins
are disabled, so this implementation may leave the pins floating when
the DSI device is disabled.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 74f0aff..93db7c1 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -28,6 +28,8 @@
 #include <plat/omap-pm.h>
 #include <plat/common.h>
 
+#include "control.h"
+
 static struct platform_device omap_display_device = {
 	.name          = "omapdss",
 	.id            = -1,
@@ -75,13 +77,51 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initdata = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
+{
+	u32 enable_mask, enable_shift;
+	u32 pipd_mask, pipd_shift;
+	u32 reg;
+
+	if (dsi_id == 0) {
+		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
+		enable_shift = OMAP4_DSI1_LANEENABLE_SHIFT;
+		pipd_mask = OMAP4_DSI1_PIPD_MASK;
+		pipd_shift = OMAP4_DSI1_PIPD_SHIFT;
+	} else if (dsi_id == 1) {
+		enable_mask = OMAP4_DSI2_LANEENABLE_MASK;
+		enable_shift = OMAP4_DSI2_LANEENABLE_SHIFT;
+		pipd_mask = OMAP4_DSI2_PIPD_MASK;
+		pipd_shift = OMAP4_DSI2_PIPD_SHIFT;
+	} else {
+		return -ENODEV;
+	}
+
+	reg = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+
+	reg &= ~enable_mask;
+	reg &= ~pipd_mask;
+
+	reg |= (lanes << enable_shift) & enable_mask;
+	reg |= (lanes << pipd_shift) & pipd_mask;
+
+	omap4_ctrl_pad_writel(reg, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+
+	return 0;
+}
+
 static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
+	if (cpu_is_omap44xx())
+		return omap4_dsi_mux_pads(dsi_id, lane_mask);
+
 	return 0;
 }
 
 static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
+	if (cpu_is_omap44xx())
+		omap4_dsi_mux_pads(dsi_id, 0);
 }
 
 int __init omap_display_init(struct omap_dss_board_info *board_data)
-- 
1.7.4.1

