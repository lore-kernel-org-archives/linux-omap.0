From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 31/35] ARM: OMAP4: display: convert display to use syscon for dsi muxing
Date: Fri, 20 Mar 2015 20:44:42 +0200
Message-ID: <1426877086-17131-32-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56930 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbCTSqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:46:36 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

The legacy control module APIs will be gone, thus convert the display
driver to use syscon. This change should eventually be moved to
display driver from the board directory.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 7a050f9..f492ae1 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -26,6 +26,8 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/slab.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
 #include <video/omapdss.h>
 #include "omap_hwmod.h"
@@ -104,6 +106,10 @@ static const struct omap_dss_hwmod_data omap4_dss_hwmod_data[] __initconst = {
 	{ "dss_hdmi", "omapdss_hdmi", -1 },
 };
 
+#define OMAP4_DSIPHY_SYSCON_OFFSET		0x78
+
+static struct regmap *omap4_dsi_mux_syscon;
+
 static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 {
 	u32 enable_mask, enable_shift;
@@ -124,7 +130,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 		return -ENODEV;
 	}
 
-	reg = omap4_ctrl_pad_readl(OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+	regmap_read(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, &reg);
 
 	reg &= ~enable_mask;
 	reg &= ~pipd_mask;
@@ -132,7 +138,7 @@ static int omap4_dsi_mux_pads(int dsi_id, unsigned lanes)
 	reg |= (lanes << enable_shift) & enable_mask;
 	reg |= (lanes << pipd_shift) & pipd_mask;
 
-	omap4_ctrl_pad_writel(reg, OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_DSIPHY);
+	regmap_write(omap4_dsi_mux_syscon, OMAP4_DSIPHY_SYSCON_OFFSET, reg);
 
 	return 0;
 }
@@ -665,5 +671,10 @@ int __init omapdss_init_of(void)
 		return r;
 	}
 
+	/* add DSI info for omap4 */
+	node = of_find_node_by_name(NULL, "omap4_padconf_global");
+	if (node)
+		omap4_dsi_mux_syscon = syscon_node_to_regmap(node);
+
 	return 0;
 }
-- 
1.7.9.5

