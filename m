From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 1/5] OMAPDSS: DSS: init dss ports cleanly
Date: Mon, 26 May 2014 14:58:08 +0530
Message-ID: <1401096492-1405-1-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60000 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751772AbaEZJ3g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 26 May 2014 05:29:36 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id s4Q9TZRI024826
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:35 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
	by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id s4Q9TZ1c014371
	for <linux-omap@vger.kernel.org>; Mon, 26 May 2014 04:29:35 -0500
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

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
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dss.c | 84 ++++++++++++++++++++++++++++++-------
 drivers/video/fbdev/omap2/dss/dss.h | 27 +++++++++++-
 drivers/video/fbdev/omap2/dss/sdi.c |  2 +-
 4 files changed, 97 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 9368972..8593567 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -769,7 +769,7 @@ err_datalines:
 	return r;
 }
 
-void __exit dpi_uninit_port(void)
+void __exit dpi_uninit_port(struct device_node *port)
 {
 	if (!dpi.port_initialized)
 		return;
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 6daeb7e..54a84f4 100644
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
 
@@ -689,6 +691,22 @@ void dss_debug_dump_clocks(struct seq_file *s)
 }
 #endif
 
+
+static enum omap_display_type omap2plus_ports[] = {
+#ifdef CONFIG_OMAP2_DSS_DPI
+	OMAP_DISPLAY_TYPE_DPI,
+#endif
+};
+
+static enum omap_display_type omap34xx_ports[] = {
+#ifdef CONFIG_OMAP2_DSS_DPI
+	OMAP_DISPLAY_TYPE_DPI,
+#endif
+#ifdef CONFIG_OMAP2_DSS_DSI
+	OMAP_DISPLAY_TYPE_SDI,
+#endif
+};
+
 static const struct dss_features omap24xx_dss_feats __initconst = {
 	/*
 	 * fck div max is really 16, but the divider range has gaps. The range
@@ -698,6 +716,8 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"core_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
@@ -705,6 +725,8 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap34xx_ports,
+	.num_ports		=	ARRAY_SIZE(omap34xx_ports),
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
@@ -712,6 +734,8 @@ static const struct dss_features omap3630_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
@@ -719,6 +743,8 @@ static const struct dss_features omap44xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
@@ -726,6 +752,8 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static const struct dss_features am43xx_dss_feats __initconst = {
@@ -733,6 +761,8 @@ static const struct dss_features am43xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	0,
 	.parent_clk_name	=	NULL,
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.ports			=	omap2plus_ports,
+	.num_ports		=	ARRAY_SIZE(omap2plus_ports),
 };
 
 static int __init dss_init_features(struct platform_device *pdev)
@@ -798,6 +828,9 @@ static int __init dss_init_ports(struct platform_device *pdev)
 	if (!port)
 		return 0;
 
+	if (dss.feat->num_ports == 0)
+		return 0;
+
 	do {
 		u32 reg;
 
@@ -805,30 +838,53 @@ static int __init dss_init_ports(struct platform_device *pdev)
 		if (r)
 			reg = 0;
 
-#ifdef CONFIG_OMAP2_DSS_DPI
-		if (reg == 0)
+		if (reg > dss.feat->num_ports - 1)
+			continue;
+
+		if (dss.feat->ports[reg] == OMAP_DISPLAY_TYPE_DPI)
 			dpi_init_port(pdev, port);
-#endif
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-		if (reg == 1)
+		if (dss.feat->ports[reg] == OMAP_DISPLAY_TYPE_SDI)
 			sdi_init_port(pdev, port);
-#endif
 
 	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 
 	return 0;
 }
 
-static void __exit dss_uninit_ports(void)
+static void __exit dss_uninit_ports(struct platform_device *pdev)
 {
-#ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_port();
-#endif
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+	int r;
 
-#ifdef CONFIG_OMAP2_DSS_SDI
-	sdi_uninit_port();
-#endif
+	if (parent == NULL)
+		return;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return;
+
+	if (dss.feat->num_ports == 0)
+		return;
+
+	do {
+		u32 reg;
+
+		r = of_property_read_u32(port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+		if (reg > dss.feat->num_ports - 1)
+			continue;
+
+		if (dss.feat->ports[reg] == OMAP_DISPLAY_TYPE_DPI)
+			dpi_uninit_port(port);
+
+		if (dss.feat->ports[reg] == OMAP_DISPLAY_TYPE_SDI)
+			sdi_uninit_port(port);
+
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 }
 
 /* DSS HW IP initialisation */
@@ -910,7 +966,7 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
-	dss_uninit_ports();
+	dss_uninit_ports(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 8ff22c1..c91f5bd 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -244,8 +244,19 @@ bool dss_div_calc(unsigned long pck, unsigned long fck_min,
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
+	return 0;
+}
+static inline void __exit sdi_uninit_port(struct device_node *port)
+{
+}
+#endif
 
 /* DSI */
 
@@ -358,8 +369,20 @@ static inline bool dsi_pll_calc(struct platform_device *dsidev,
 int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
+#ifdef CONFIG_OMAP2_DSS_DPI
 int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void dpi_uninit_port(void) __exit;
+void dpi_uninit_port(struct device_node *port) __exit;
+#else
+static inline int __init dpi_init_port(struct platform_device *pdev,
+		struct device_node *port)
+{
+	return 0;
+}
+static inline void __exit dpi_uninit_port(struct device_node *port)
+{
+}
+#endif
+
 
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

