From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/20] OMAPDSS: remove dssdev->channel assignments
Date: Fri, 8 Mar 2013 13:51:49 +0200
Message-ID: <1362743515-10152-15-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33516 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933516Ab3CHLwZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:25 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the driver uses ooutput->recommended_channel, we can remove the
uses of the hacky dssdev->channel field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c  |    2 --
 drivers/video/omap2/dss/dsi.c  |    2 --
 drivers/video/omap2/dss/hdmi.c |    2 --
 drivers/video/omap2/dss/rfbi.c |    2 --
 drivers/video/omap2/dss/sdi.c  |    2 --
 drivers/video/omap2/dss/venc.c |    2 --
 6 files changed, 12 deletions(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index eba6b87..775214c 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -432,8 +432,6 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("init_display\n");
 
-	dssdev->channel = dpi_get_channel();
-
 	if (dss_has_feature(FEAT_DPI_USES_VDDS_DSI) &&
 					dpi.vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e0c9e31..f44316a 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -5000,8 +5000,6 @@ static int __init dsi_init_display(struct omap_dss_device *dssdev)
 
 	DSSDBG("DSI init\n");
 
-	dssdev->channel = dsi_get_channel(dsi->module_id);
-
 	if (dsi->vdds_dsi_reg == NULL) {
 		struct regulator *vdds_dsi;
 
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index e4c3be4..a49e73f 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1012,8 +1012,6 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
 	hdmi.hpd_gpio = priv->hpd_gpio;
 
-	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
-
 	r = hdmi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 991ec93..48d51ca 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -945,8 +945,6 @@ EXPORT_SYMBOL(omapdss_rfbi_display_disable);
 
 static int __init rfbi_init_display(struct omap_dss_device *dssdev)
 {
-	dssdev->channel = OMAP_DSS_CHANNEL_LCD;
-
 	rfbi.dssdev[dssdev->phy.rfbi.channel] = dssdev;
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index c797b33..eb4ee17 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -186,8 +186,6 @@ static int __init sdi_init_display(struct omap_dss_device *dssdev)
 {
 	DSSDBG("SDI init\n");
 
-	dssdev->channel = OMAP_DSS_CHANNEL_LCD;
-
 	if (sdi.vdds_sdi_reg == NULL) {
 		struct regulator *vdds_sdi;
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index b85fd3d..6d25a12 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -786,8 +786,6 @@ static void __init venc_probe_pdata(struct platform_device *vencdev)
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
-
 	r = venc_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-- 
1.7.10.4

