From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/14] OMAPDSS: Add functions for external control of PLL
Date: Tue, 27 Jan 2015 12:50:37 +0200
Message-ID: <1422355842-11234-10-git-send-email-tomi.valkeinen@ti.com>
References: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56825 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757812AbbA0KvH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Jan 2015 05:51:07 -0500
In-Reply-To: <1422355842-11234-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add functions which configure the control module register
CTRL_CORE_DSS_PLL_CONTROL found in DRA7xx SoCs. This register configures
whether the PLL registers are accessed internally by DSS, or externally
using OCP2SCP interface. They also configure muxes which route the PLL
output to a particular LCD overlay manager within DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 115 ++++++++++++++++++++++++++++++++++++
 drivers/video/fbdev/omap2/dss/dss.h |   4 ++
 2 files changed, 119 insertions(+)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 8c79839fbe87..d75238f2c537 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -34,6 +34,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/gfp.h>
 #include <linux/sizes.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 #include <linux/of.h>
 
 #include <video/omapdss.h>
@@ -78,6 +80,8 @@ struct dss_features {
 static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
+	struct regmap	*syscon_pll_ctrl;
+	u32		syscon_pll_ctrl_offset;
 
 	struct clk	*parent_clk;
 	struct clk	*dss_clk;
@@ -158,6 +162,99 @@ static void dss_restore_context(void)
 #undef SR
 #undef RR
 
+void dss_ctrl_pll_enable(enum dss_pll_id pll_id, bool enable)
+{
+	unsigned shift;
+	unsigned val;
+
+	if (!dss.syscon_pll_ctrl)
+		return;
+
+	val = !enable;
+
+	switch (pll_id) {
+	case DSS_PLL_VIDEO1:
+		shift = 0;
+		break;
+	case DSS_PLL_VIDEO2:
+		shift = 1;
+		break;
+	case DSS_PLL_HDMI:
+		shift = 2;
+		break;
+	default:
+		DSSERR("illegal DSS PLL ID %d\n", pll_id);
+		return;
+	}
+
+	regmap_update_bits(dss.syscon_pll_ctrl, dss.syscon_pll_ctrl_offset,
+		1 << shift, val << shift);
+}
+
+void dss_ctrl_pll_set_control_mux(enum dss_pll_id pll_id,
+	enum omap_channel channel)
+{
+	unsigned shift, val;
+
+	if (!dss.syscon_pll_ctrl)
+		return;
+
+	switch (channel) {
+	case OMAP_DSS_CHANNEL_LCD:
+		shift = 3;
+
+		switch (pll_id) {
+		case DSS_PLL_VIDEO1:
+			val = 0; break;
+		case DSS_PLL_HDMI:
+			val = 1; break;
+		default:
+			DSSERR("error in PLL mux config for LCD\n");
+			return;
+		}
+
+		break;
+	case OMAP_DSS_CHANNEL_LCD2:
+		shift = 5;
+
+		switch (pll_id) {
+		case DSS_PLL_VIDEO1:
+			val = 0; break;
+		case DSS_PLL_VIDEO2:
+			val = 1; break;
+		case DSS_PLL_HDMI:
+			val = 2; break;
+		default:
+			DSSERR("error in PLL mux config for LCD2\n");
+			return;
+		}
+
+		break;
+	case OMAP_DSS_CHANNEL_LCD3:
+		shift = 7;
+
+		switch (pll_id) {
+		case DSS_PLL_VIDEO1:
+			val = 1; break;
+		case DSS_PLL_VIDEO2:
+			val = 0; break;
+		case DSS_PLL_HDMI:
+			val = 2; break;
+		default:
+			DSSERR("error in PLL mux config for LCD3\n");
+			return;
+		}
+
+		break;
+	default:
+		DSSERR("error in PLL mux config\n");
+		return;
+	}
+
+	regmap_update_bits(dss.syscon_pll_ctrl, dss.syscon_pll_ctrl_offset,
+		0x3 << shift, val << shift);
+}
+
 void dss_sdi_init(int datapairs)
 {
 	u32 l;
@@ -923,6 +1020,7 @@ static void __exit dss_uninit_ports(struct platform_device *pdev)
 static int __init omap_dsshw_probe(struct platform_device *pdev)
 {
 	struct resource *dss_mem;
+	struct device_node *np = pdev->dev.of_node;
 	u32 rev;
 	int r;
 
@@ -979,6 +1077,23 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	dss_init_ports(pdev);
 
+	if (np && of_property_read_bool(np, "syscon-pll-ctrl")) {
+		dss.syscon_pll_ctrl = syscon_regmap_lookup_by_phandle(np,
+			"syscon-pll-ctrl");
+		if (IS_ERR(dss.syscon_pll_ctrl)) {
+			dev_err(&pdev->dev,
+				"failed to get syscon-pll-ctrl regmap\n");
+			return PTR_ERR(dss.syscon_pll_ctrl);
+		}
+
+		if (of_property_read_u32_index(np, "syscon-pll-ctrl", 1,
+				&dss.syscon_pll_ctrl_offset)) {
+			dev_err(&pdev->dev,
+				"failed to get syscon-pll-ctrl offset\n");
+			return -EINVAL;
+		}
+	}
+
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
 			FLD_GET(rev, 7, 4), FLD_GET(rev, 3, 0));
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 4bca36a591ca..76a6eb1da090 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -274,6 +274,10 @@ u32 dss_of_port_get_port_number(struct device_node *port);
 void dss_debug_dump_clocks(struct seq_file *s);
 #endif
 
+void dss_ctrl_pll_enable(enum dss_pll_id pll_id, bool enable);
+void dss_ctrl_pll_set_control_mux(enum dss_pll_id pll_id,
+	enum omap_channel channel);
+
 void dss_sdi_init(int datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
-- 
2.2.2

