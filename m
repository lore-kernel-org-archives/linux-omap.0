From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 4/7] OMAPDSS: DSS: init dss ports cleanly
Date: Wed, 4 Jun 2014 12:11:00 +0530
Message-ID: <1401864063-19196-5-git-send-email-archit@ti.com>
References: <1401096492-1405-1-git-send-email-archit@ti.com>
 <1401864063-19196-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbaFDGmf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jun 2014 02:42:35 -0400
In-Reply-To: <1401864063-19196-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The init/uninit port functions are used to set up the DPI and SDI outputs under
the dss platform device. A 'reg' property is used to determine whether the node
is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only DPI
output exists.

For multiple DPI output instances(introduced in DRA7xx DSS), we would use the
'reg' property in dts to specify the DPI output instance.

The current functions work fine if there is only one DPI output instance in
DSS. For multiple DPI instances, it would get complicated to figure out whether
'reg' is used to specify whether the output is SDI, or another DPI instance.

We create a list of port types supported for each DSS rev, with the index of the
port in the list matching the reg id. This allows us to have a more generic way
to init/uninit ports within DSS, and support multiple DPI ports.

Also, make the uninit_port functions iterative since we will have multiple DPI
ports to uninit in the future.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss.c | 81 ++++++++++++++++++++++++++++++-------
 drivers/video/fbdev/omap2/dss/dss.h | 26 +++++++++++-
 drivers/video/fbdev/omap2/dss/sdi.c |  2 +-
 3 files changed, 93 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index bebb824..3b41953 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -70,6 +70,8 @@ struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *parent_clk_name;
+	enum omap_display_type *ports;
+	int num_ports;
 	int (*dpi_select_source)(enum omap_channel channel);
 };
 
@@ -689,6 +691,16 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
+
+static enum omap_display_type omap2plus_ports[] = {
+	OMAP_DISPLAY_TYPE_DPI,
+};
+
+static enum omap_display_type omap34xx_ports[] = {
+	OMAP_DISPLAY_TYPE_DPI,
+	OMAP_DISPLAY_TYPE_SDI,
+};
+
 static const struct dss_features omap24xx_dss_feats __initconst = {
 	/*
 	 * fck div max is really 16, but the divider range has gaps. The range
@@ -698,6 +710,8 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"core_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
@@ -705,6 +719,8 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap34xx_ports,
+	.num_ports		=	ARRAY_SIZE(omap34xx_ports),
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
@@ -712,6 +728,8 @@ static const struct dss_features omap3630_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
@@ -719,6 +737,8 @@ static const struct dss_features omap44xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
@@ -726,6 +746,8 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features am43xx_dss_feats __initconst = {
@@ -733,6 +755,8 @@ static const struct dss_features am43xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	0,
 	.parent_clk_name	=	NULL,
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static int __init dss_init_features(struct platform_device *pdev)
@@ -798,23 +822,32 @@ static int __init dss_init_ports(struct platform_device *pdev)
 	if (!port)
 		return 0;
 
+	if (dss.feat->num_ports == 0)
+		return 0;
+
 	do {
+		enum omap_display_type port_type;
 		u32 reg;
 
 		r = of_property_read_u32(port, "reg", &reg);
 		if (r)
 			reg = 0;
 
-#ifdef CONFIG_OMAP2_DSS_DPI
-		if (reg == 0)
-			dpi_init_port(pdev, port);
-#endif
+		if (reg >= dss.feat->num_ports)
+			continue;
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-		if (reg == 1)
-			sdi_init_port(pdev, port);
-#endif
+		port_type = dss.feat->ports[reg];
 
+		switch (port_type) {
+		case OMAP_DISPLAY_TYPE_DPI:
+			dpi_init_port(pdev, port);
+			break;
+		case OMAP_DISPLAY_TYPE_SDI:
+			sdi_init_port(pdev, port);
+			break;
+		default:
+			break;
+		}
 	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 
 	return 0;
@@ -833,13 +866,33 @@ static void __exit dss_uninit_ports(struct platform_device *pdev)
 	if (!port)
 		return;
 
-#ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_port(port);
-#endif
+	if (dss.feat->num_ports == 0)
+		return;
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-	sdi_uninit_port();
-#endif
+	do {
+		enum omap_display_type port_type;
+		u32 reg;
+
+		r = of_property_read_u32(port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+		if (reg >= dss.feat->num_ports)
+			continue;
+
+		port_type = dss.feat->ports[reg];
+
+		switch (port_type) {
+		case OMAP_DISPLAY_TYPE_DPI:
+			dpi_uninit_port(port);
+			break;
+		case OMAP_DISPLAY_TYPE_SDI:
+			sdi_uninit_port(port);
+			break;
+		default:
+			break;
+		}
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 }
 
 /* DSS HW IP initialisation */
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 5b9db95..f0d3e82 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -244,8 +244,20 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
 int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
 
+#ifdef CONFIG_OMAP2_DSS_SDI
 int sdi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void sdi_uninit_port(void) __exit;
+void sdi_uninit_port(struct device_node *port) __exit;
+#else
+static inline int __init sdi_init_port(struct platform_device *pdev,
+		struct device_node *port)
+{
+	WARN("%s: SDI not compiled in\n", __func__);
+	return 0;
+}
+static inline void __exit sdi_uninit_port(struct device_node *port)
+{
+}
+#endif
 
 /* DSI */
 
@@ -358,8 +370,20 @@ static inline bool dsi_pll_calc(struct platform_device *dsidev,
 int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
+#ifdef CONFIG_OMAP2_DSS_DPI
 int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
 void dpi_uninit_port(struct device_node *port) __exit;
+#else
+static inline int __init dpi_init_port(struct platform_device *pdev,
+		struct device_node *port)
+{
+	WARN("%s: DPI not compiled in\n", __func__);
+	return 0;
+}
+static inline void __exit dpi_uninit_port(struct device_node *port)
+{
+}
+#endif
 
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap2/dss/sdi.c
index 911dcc9..72f89db 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -424,7 +424,7 @@ err_datapairs:
 	return r;
 }
 
-void __exit sdi_uninit_port(void)
+void __exit sdi_uninit_port(struct device_node *port)
 {
 	if (!sdi.port_initialized)
 		return;
-- 
1.8.3.2

