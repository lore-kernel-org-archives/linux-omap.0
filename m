From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/20] OMAPDSS: Resolve channels for outputs
Date: Fri, 8 Mar 2013 13:51:45 +0200
Message-ID: <1362743515-10152-11-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56461 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756697Ab3CHLwU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:20 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The DISPC channel used for each output is currently passed in panel
platform data from the board files.

To simplify this, and to make the panel drivers less dependent on OMAP,
this patch changes omapdss to resolve the channel independently. The
channel is resolved based on the OMAP version and, in case of DSI, the
DSI module id.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |   37 ++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dsi.c  |   48 ++++++++++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/rfbi.c |    2 ++
 drivers/video/omap2/dss/sdi.c  |    2 ++
 4 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index e282456..3261644 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -396,12 +396,44 @@ static int __init dpi_verify_dsi_pll(struct platform_device *dsidev)
 	return 0;
 }
 
+/*
+ * Return a hardcoded channel for the DPI output. This should work for
+ * current use cases, but this can be later expanded to either resolve
+ * the channel in some more dynamic manner, or get the channel as a user
+ * parameter.
+ */
+static enum omap_channel dpi_get_channel(void)
+{
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP24xx:
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		return OMAP_DSS_CHANNEL_LCD;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		return OMAP_DSS_CHANNEL_LCD2;
+
+	case OMAPDSS_VER_OMAP5:
+		return OMAP_DSS_CHANNEL_LCD2;
+
+	default:
+		DSSWARN("unsupported DSS version\n");
+		return OMAP_DSS_CHANNEL_LCD;
+	}
+}
+
 static int __init dpi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev;
 
 	DSSDBG("init_display\n");
 
+	dssdev->channel = dpi_get_channel();
+
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
 					dpi.vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
@@ -416,11 +448,6 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 		dpi.vdds_dsi_reg = vdds_dsi;
 	}
 
-	/*
-	 * XXX We shouldn't need dssdev->channel for this. The dsi pll clock
-	 * source for DPI is SoC integration detail, not something that should
-	 * be configured in the dssdev
-	 */
 	dsidev = dpi_get_dsidev(dssdev->channel);
 
 	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 1a6ad6f..c39ca86 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4946,6 +4946,52 @@ void omapdss_dsi_set_videomode_timings(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_set_videomode_timings);
 
+/*
+ * Return a hardcoded channel for the DSI output. This should work for
+ * current use cases, but this can be later expanded to either resolve
+ * the channel in some more dynamic manner, or get the channel as a user
+ * parameter.
+ */
+static enum omap_channel dsi_get_channel(int module_id)
+{
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP24xx:
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		return OMAP_DSS_CHANNEL_LCD;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		switch (module_id) {
+		case 0:
+			return OMAP_DSS_CHANNEL_LCD;
+		case 1:
+			return OMAP_DSS_CHANNEL_LCD2;
+		default:
+			DSSWARN("unsupported module id\n");
+			return OMAP_DSS_CHANNEL_LCD;
+		}
+
+	case OMAPDSS_VER_OMAP5:
+		switch (module_id) {
+		case 0:
+			return OMAP_DSS_CHANNEL_LCD;
+		case 1:
+			return OMAP_DSS_CHANNEL_LCD3;
+		default:
+			DSSWARN("unsupported module id\n");
+			return OMAP_DSS_CHANNEL_LCD;
+		}
+
+	default:
+		DSSWARN("unsupported DSS version\n");
+		return OMAP_DSS_CHANNEL_LCD;
+	}
+}
+
 static int __init dsi_init_display(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev =
@@ -4954,6 +5000,8 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("DSI init\n");
 
+	dssdev->channel = dsi_get_channel(dsi->module_id);
+
 	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index a47a9e5..04c4ab6 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -945,6 +945,8 @@ EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
 static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 {
+	dssdev->channel = OMAP_DSS_CHANNEL_LCD;
+
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0802927..d24e971 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -186,6 +186,8 @@ static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
+	dssdev->channel = OMAP_DSS_CHANNEL_LCD;
+
 	if (sdi.vdds_sdi_reg == NULL) {
 		struct regulator *vdds_sdi;
 
-- 
1.7.10.4

