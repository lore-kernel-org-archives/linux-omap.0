From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/14] OMAPDSS: DISPC: program dispc polarities to control module
Date: Tue, 27 Jan 2015 12:50:40 +0200
Message-ID: <1422355842-11234-13-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60769 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757933AbbA0KvL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:11 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

On DRA7xx, DISPC needs to write output signal polarities not only to a
DISPC register, like for all earlier DSS versions, but to control
module's CTRL_CORE_SMA_SW_1 register.

This patch adds support to write the polarities to control module.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dispc.c | 40 +++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dispc.c b/drivers/video/fbdev/omap2/dss/dispc.c
index 48429bab294a..31b743c70272 100644
--- a/drivers/video/fbdev/omap2/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/dss/dispc.c
@@ -36,6 +36,9 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/sizes.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
 
 #include <video/omapdss.h>
 
@@ -117,6 +120,9 @@ static struct {
 	const struct dispc_features *feat;
 
 	bool is_enabled;
+
+	struct regmap *syscon_pol;
+	u32 syscon_pol_offset;
 } dispc;
 
 enum omap_color_component {
@@ -2958,6 +2964,25 @@ static void _dispc_mgr_set_lcd_timings(enum omap_channel channel, int hsw,
 		FLD_VAL(vsync_level, 12, 12);
 
 	dispc_write_reg(DISPC_POL_FREQ(channel), l);
+
+	if (dispc.syscon_pol) {
+		const int shifts[] = {
+			[OMAP_DSS_CHANNEL_LCD] = 0,
+			[OMAP_DSS_CHANNEL_LCD2] = 1,
+			[OMAP_DSS_CHANNEL_LCD3] = 2,
+		};
+
+		u32 mask, val;
+
+		mask = (1 << 0) | (1 << 3) | (1 << 6);
+		val = (rf << 0) | (ipc << 3) | (onoff << 6);
+
+		mask <<= 16 + shifts[channel];
+		val <<= 16 + shifts[channel];
+
+		regmap_update_bits(dispc.syscon_pol, dispc.syscon_pol_offset,
+			mask, val);
+	}
 }
 
 /* change name to mode? */
@@ -3741,6 +3766,7 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 	u32 rev;
 	int r = 0;
 	struct resource *dispc_mem;
+	struct device_node *np = pdev->dev.of_node;
 
 	dispc.pdev = pdev;
 
@@ -3767,6 +3793,20 @@ static int __init omap_dispchw_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (np && of_property_read_bool(np, "syscon-pol")) {
+		dispc.syscon_pol = syscon_regmap_lookup_by_phandle(np, "syscon-pol");
+		if (IS_ERR(dispc.syscon_pol)) {
+			dev_err(&pdev->dev, "failed to get syscon-pol regmap\n");
+			return PTR_ERR(dispc.syscon_pol);
+		}
+
+		if (of_property_read_u32_index(np, "syscon-pol", 1,
+				&dispc.syscon_pol_offset)) {
+			dev_err(&pdev->dev, "failed to get syscon-pol offset\n");
+			return -EINVAL;
+		}
+	}
+
 	pm_runtime_enable(&pdev->dev);
 
 	r = dispc_runtime_get();
-- 
2.2.2

