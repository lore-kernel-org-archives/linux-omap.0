From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Thu, 24 Apr 2014 13:17:02 +0300
Message-ID: <1398334639-14172-7-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59015 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754153AbaDXKTD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 06:19:03 -0400
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tony Lindgren <tony@atomide.com>

Add support to set OMAP5 DSI pin muxing.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/display.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 16d33d831287..974461441fc3 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -137,11 +137,42 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	return 0;
 }
 
+#define CONTROL_PAD_BASE	0x4A002800
+#define CONTROL_DSIPHY		0x614
+
+static int omap5_dsi_mux_pads(int dsi_id, unsigned lanes)
+{
+	u32 enable_mask, enable_shift, reg;
+	void __iomem *ctrl_pad_base = NULL;
+
+	ctrl_pad_base = ioremap(CONTROL_PAD_BASE, SZ_4K);
+	if (!ctrl_pad_base)
+		return -ENXIO;
+
+	if (dsi_id == 0) {
+		enable_mask = OMAP4_DSI1_LANEENABLE_MASK;
+		enable_shift = OMAP4_DSI1_LANEENABLE_SHIFT;
+	} else if (dsi_id == 1) {
+		enable_mask = OMAP4_DSI2_LANEENABLE_MASK;
+		enable_shift = OMAP4_DSI2_LANEENABLE_SHIFT;
+	} else {
+		return -ENODEV;
+	}
+
+	reg = __raw_readl(ctrl_pad_base + CONTROL_DSIPHY);
+	reg &= ~enable_mask;
+	reg |= (lanes << enable_shift) & enable_mask;
+	__raw_writel(reg, ctrl_pad_base + CONTROL_DSIPHY);
+
+	return 0;
+}
+
 static int omap_dsi_enable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		return omap4_dsi_mux_pads(dsi_id, lane_mask);
-
+	else if (soc_is_omap54xx())
+		return omap5_dsi_mux_pads(dsi_id, lane_mask);
 	return 0;
 }
 
@@ -149,6 +180,8 @@ static void omap_dsi_disable_pads(int dsi_id, unsigned lane_mask)
 {
 	if (cpu_is_omap44xx())
 		omap4_dsi_mux_pads(dsi_id, 0);
+	else if (soc_is_omap54xx())
+		omap5_dsi_mux_pads(dsi_id, 0);
 }
 
 static int omap_dss_set_min_bus_tput(struct device *dev, unsigned long tput)
-- 
1.9.1

