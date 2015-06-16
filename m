From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/7] OMAPDSS: move 'dss_initialized' to dss driver
Date: Tue, 16 Jun 2015 13:16:23 +0300
Message-ID: <1434449789-13812-2-git-send-email-tomi.valkeinen@ti.com>
References: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48349 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756458AbbFPKRH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Jun 2015 06:17:07 -0400
In-Reply-To: <1434449789-13812-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We have a flag, 'dss_initialized', which tells omapfb and omapdrm if
omapdss is available. At the moment it can be set even if the dss
submodules are not all ready, in case something gets deferred.

Move the flag to dss_core driver so that it'll signal the availability
of the dss drivers move accurately.

For now, it'll signal that dss_core is ready, which is not quite correct
but still better than previously.  The following patches will add
component system to omapdss, and after those patches 'dss_initialized'
will signal that all the submodules are ready.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/core.c | 10 ----------
 drivers/video/fbdev/omap2/dss/dss.c  | 12 ++++++++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/core.c b/drivers/video/fbdev/omap2/dss/core.c
index 16751755d433..57b6a5296c87 100644
--- a/drivers/video/fbdev/omap2/dss/core.c
+++ b/drivers/video/fbdev/omap2/dss/core.c
@@ -50,8 +50,6 @@ static char *def_disp_name;
 module_param_named(def_disp, def_disp_name, charp, 0);
 MODULE_PARM_DESC(def_disp, "default display name");
 
-static bool dss_initialized;
-
 const char *omapdss_get_default_display_name(void)
 {
 	return core.default_display_name;
@@ -65,12 +63,6 @@ enum omapdss_version omapdss_get_version(void)
 }
 EXPORT_SYMBOL(omapdss_get_version);
 
-bool omapdss_is_initialized(void)
-{
-	return dss_initialized;
-}
-EXPORT_SYMBOL(omapdss_is_initialized);
-
 struct platform_device *dss_get_core_pdev(void)
 {
 	return core.pdev;
@@ -333,8 +325,6 @@ static int __init omap_dss_init(void)
 			dss_output_drv_loaded[i] = true;
 	}
 
-	dss_initialized = true;
-
 	return 0;
 
 err_dispc:
diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
index 7f978b6a34e8..35601ab232e3 100644
--- a/drivers/video/fbdev/omap2/dss/dss.c
+++ b/drivers/video/fbdev/omap2/dss/dss.c
@@ -111,6 +111,14 @@ static const char * const dss_generic_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "DSI_PLL2_HSDIV_DSI",
 };
 
+static bool dss_initialized;
+
+bool omapdss_is_initialized(void)
+{
+	return dss_initialized;
+}
+EXPORT_SYMBOL(omapdss_is_initialized);
+
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -1141,6 +1149,8 @@ static int __init omap_dsshw_probe(struct platform_device *pdev)
 
 	pm_set_vt_switch(0);
 
+	dss_initialized = true;
+
 	return 0;
 
 err_pll_init:
@@ -1158,6 +1168,8 @@ err_setup_clocks:
 
 static int __exit omap_dsshw_remove(struct platform_device *pdev)
 {
+	dss_initialized = false;
+
 	if (dss.video1_pll)
 		dss_video_pll_uninit(dss.video1_pll);
 
-- 
2.1.4

