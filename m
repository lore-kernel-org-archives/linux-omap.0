From: Archit Taneja <archit@ti.com>
Subject: [RFC 2/6] omapdss: add init port functions for different omap revs
Date: Thu, 8 May 2014 14:45:13 +0530
Message-ID: <1399540517-17883-2-git-send-email-archit@ti.com>
References: <1399540517-17883-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58734 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459AbaEHJQ2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 May 2014 05:16:28 -0400
In-Reply-To: <1399540517-17883-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The init/uninit port functions are used to set up the DPI and SDI outputs under
the dss platform device. A 'reg' property is used to determine whether the node
is DPI or SDI for OMAP34xx DSS revision. For other DSS revisions, only DPI
output exists.

For multiple DPI output instances(introduced in DRA7xx DSS), we would use the
'reg' property to specify the DPI output number.

The current functions work fine if there is only one DPI output instance in
DSS. For multiple DPI instances, it would get complicated to figure out whether
'reg' is used to specify whether the output is SDI, or a later DPI instance.

Create DSS revision specific init/uninit_port functions such that we have a
separate functions for OMAP34xx, this helps us deal with the SDI case
separately.

Also, make the uninit_port functions iterative since we will have multiple DPI
ports in the future.

dpi_uninit_port/sdi_uninit_port functions have to be removed from the exit
section as dss_features(which is initconst data) uses it, this prevents the
section mismatch.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dss.c | 88 ++++++++++++++++++++++++++++++++++---
 drivers/video/fbdev/omap2/dss/dss.h |  4 +-
 drivers/video/fbdev/omap2/dss/sdi.c |  2 +-
 4 files changed, 86 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 157921d..6593c8b 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -765,7 +765,7 @@ err_datalines:
 	return r;
 }
 
-void __exit dpi_uninit_port(void)
+void dpi_uninit_port(struct platform_device *pdev, struct device_node *port)
 {
 	if (!dpi.port_initialized)
 		return;
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 31ef262..c415029 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -65,12 +65,18 @@ struct dss_reg {
 
 static int dss_runtime_get(void);
 static void dss_runtime_put(void);
+static int __init dss_init_ports(struct platform_device *pdev);
+static int __init dss_init_ports_omap34xx(struct platform_device *pdev);
+static void dss_uninit_ports(struct platform_device *pdev);
+static void dss_uninit_ports_omap34xx(struct platform_device *pdev);
 
 struct dss_features {
 	u8 fck_div_max;
 	u8 dss_fck_multiplier;
 	const char *parent_clk_name;
 	int (*dpi_select_source)(enum omap_channel channel);
+	int (*init_ports)(struct platform_device *pdev);
+	void (*uninit_ports)(struct platform_device *pdev);
 };
 
 static struct {
@@ -698,6 +704,8 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"core_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.init_ports		=	&dss_init_ports,
+	.uninit_ports		=	&dss_uninit_ports,
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
@@ -705,6 +713,8 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.init_ports		=	&dss_init_ports_omap34xx,
+	.uninit_ports		=	&dss_uninit_ports_omap34xx,
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
@@ -712,6 +722,8 @@ static const struct dss_features omap3630_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.init_ports		=	&dss_init_ports,
+	.uninit_ports		=	&dss_uninit_ports,
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
@@ -719,6 +731,8 @@ static const struct dss_features omap44xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
+	.init_ports		=	&dss_init_ports,
+	.uninit_ports		=	&dss_uninit_ports,
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
@@ -726,6 +740,8 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll_per_x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
+	.init_ports		=	&dss_init_ports,
+	.uninit_ports		=	&dss_uninit_ports,
 };
 
 static int __init dss_init_features(struct platform_device *pdev)
@@ -774,7 +790,7 @@ static int __init dss_init_features(struct platform_device *pdev)
 	return 0;
 }
 
-static int __init dss_init_ports(struct platform_device *pdev)
+static int __init dss_init_ports_omap34xx(struct platform_device *pdev)
 {
 	struct device_node *parent = pdev->dev.of_node;
 	struct device_node *port;
@@ -809,15 +825,75 @@ static int __init dss_init_ports(struct platform_device *pdev)
 	return 0;
 }
 
-static void dss_uninit_ports(void)
+static int __init dss_init_ports(struct platform_device *pdev)
 {
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+
+	if (parent == NULL)
+		return 0;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return 0;
+
+	do {
 #ifdef CONFIG_OMAP2_DSS_DPI
-	dpi_uninit_port();
+			dpi_init_port(pdev, port);
+#endif
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+
+	return 0;
+}
+
+static void dss_uninit_ports_omap34xx(struct platform_device *pdev)
+{
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+	int r;
+
+	if (parent == NULL)
+		return;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return;
+
+	do {
+		u32 reg;
+
+		r = of_property_read_u32(port, "reg", &reg);
+		if (r)
+			reg = 0;
+
+#ifdef CONFIG_OMAP2_DSS_DPI
+		if (reg == 0)
+			dpi_uninit_port(pdev, port);
 #endif
 
 #ifdef CONFIG_OMAP2_DSS_SDI
-	sdi_uninit_port();
+		if (reg == 1)
+			sdi_uninit_port();
 #endif
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
+}
+
+static void dss_uninit_ports(struct platform_device *pdev)
+{
+	struct device_node *parent = pdev->dev.of_node;
+	struct device_node *port;
+
+	if (parent == NULL)
+		return;
+
+	port = omapdss_of_get_next_port(parent, NULL);
+	if (!port)
+		return;
+	do {
+#ifdef CONFIG_OMAP2_DSS_DPI
+			dpi_uninit_port(pdev, port);
+#endif
+	} while ((port = omapdss_of_get_next_port(parent, port)) != NULL);
 }
 
 /* DSS HW IP initialisation */
@@ -878,7 +954,7 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
 	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
-	dss_init_ports(pdev);
+	dss.feat->init_ports(pdev);
 
 	rev = dss_read_reg(DSS_REVISION);
 	printk(KERN_INFO "OMAP DSS rev %d.%d\n",
@@ -899,7 +975,7 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
-	dss_uninit_ports();
+	dss.feat->uninit_ports(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 560078f..9f4ee49 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -245,7 +245,7 @@ int sdi_init_platform_driver(void) __init;
 void sdi_uninit_platform_driver(void) __exit;
 
 int sdi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void sdi_uninit_port(void) __exit;
+void sdi_uninit_port(void);
 
 /* DSI */
 
@@ -359,7 +359,7 @@ int dpi_init_platform_driver(void) __init;
 void dpi_uninit_platform_driver(void) __exit;
 
 int dpi_init_port(struct platform_device *pdev, struct device_node *port) __init;
-void dpi_uninit_port(void) __exit;
+void dpi_uninit_port(struct platform_device *pdev, struct device_node *port);
 
 /* DISPC */
 int dispc_init_platform_driver(void) __init;
diff --git a/drivers/video/fbdev/omap2/dss/sdi.c b/drivers/video/fbdev/omap2/dss/sdi.c
index 911dcc9..71a3083 100644
--- a/drivers/video/fbdev/omap2/dss/sdi.c
+++ b/drivers/video/fbdev/omap2/dss/sdi.c
@@ -424,7 +424,7 @@ err_datapairs:
 	return r;
 }
 
-void __exit sdi_uninit_port(void)
+void sdi_uninit_port(void)
 {
 	if (!sdi.port_initialized)
 		return;
-- 
1.8.3.2

