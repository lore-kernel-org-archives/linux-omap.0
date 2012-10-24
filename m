From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/20] OMAPDSS: get the dss version from core pdev
Date: Wed, 24 Oct 2012 12:28:53 +0300
Message-ID: <1351070951-18616-3-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48074 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758003Ab2JXJ33 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:29 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The output drivers get the omapdss hw version from the platform data for
their respective output device. This doesn't work with DT, as there's no
platform data for them.

Add a new function, omapdss_get_version(), which returns the dss version
from the core device, which will have platform data on DT also. The
function is exported so that users of omapdss can also use it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c  |    9 ++++++++-
 drivers/video/omap2/dss/dispc.c |    3 +--
 drivers/video/omap2/dss/dss.c   |    3 +--
 drivers/video/omap2/dss/hdmi.c  |    3 +--
 include/video/omapdss.h         |    2 ++
 5 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 00aa026..685d9a9 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -58,6 +58,13 @@ const char *dss_get_default_display_name(void)
 	return core.default_display_name;
 }
 
+enum omapdss_version omapdss_get_version(void)
+{
+	struct omap_dss_board_info *pdata = core.pdev->dev.platform_data;
+	return pdata->version;
+}
+EXPORT_SYMBOL(omapdss_get_version);
+
 /* REGULATORS */
 
 struct regulator *dss_get_vdds_dsi(void)
@@ -232,7 +239,7 @@ static int __init omap_dss_probe(struct platform_device *pdev)
 
 	core.pdev = pdev;
 
-	dss_features_init(pdata->version);
+	dss_features_init(omapdss_get_version());
 
 	dss_apply_init();
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 6dd9eb4..817d671 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -4098,7 +4098,6 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 
 static int __init dispc_init_features(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const struct dispc_features *src;
 	struct dispc_features *dst;
 
@@ -4108,7 +4107,7 @@ static int __init dispc_init_features(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	switch (pdata->version) {
+	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
 		src = &omap24xx_dispc_feats;
 		break;
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 37ee465..d90de37 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -793,7 +793,6 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 
 static int __init dss_init_features(struct platform_device *pdev)
 {
-	struct omap_dss_board_info *pdata = pdev->dev.platform_data;
 	const struct dss_features *src;
 	struct dss_features *dst;
 
@@ -803,7 +802,7 @@ static int __init dss_init_features(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	switch (pdata->version) {
+	switch (omapdss_get_version()) {
 	case OMAPDSS_VER_OMAP24xx:
 		src = &omap24xx_dss_feats;
 		break;
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index adcc906..c1c5488 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -323,7 +323,6 @@ static void hdmi_runtime_put(void)
 
 static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 {
-	struct omap_dss_board_info *pdata = hdmi.pdev->dev.platform_data;
 	int r;
 
 	struct gpio gpios[] = {
@@ -334,7 +333,7 @@ static int __init hdmi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("init_display\n");
 
-	dss_init_hdmi_ip_ops(&hdmi.ip_data, pdata->version);
+	dss_init_hdmi_ip_ops(&hdmi.ip_data, omapdss_get_version());
 
 	if (hdmi.vdda_hdmi_dac_reg == NULL) {
 		struct regulator *reg;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index cdfb22e..eac5f25 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -742,6 +742,8 @@ struct omap_dss_driver {
 
 };
 
+enum omapdss_version omapdss_get_version(void);
+
 int omap_dss_register_driver(struct omap_dss_driver *);
 void omap_dss_unregister_driver(struct omap_dss_driver *);
 
-- 
1.7.9.5

