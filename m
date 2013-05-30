From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/32] OMAPDSS: VENC: clean up regulator init
Date: Thu, 30 May 2013 12:34:39 +0300
Message-ID: <1369906493-27538-19-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37448 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030321Ab3E3Jfp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:45 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Clean up the VENC driver's regulator init to remove the (unused)
omap_dss_device parameter, renaming the function to a more sensible
name, and making the code slightly clearer.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 7b2e3ae..f484b9f 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -633,23 +633,22 @@ void omapdss_venc_invert_vid_out_polarity(struct omap_dss_device *dssdev,
 	mutex_unlock(&venc.venc_lock);
 }
 
-static int venc_init_display(struct omap_dss_device *dssdev)
+static int venc_init_regulator(void)
 {
-	DSSDBG("init_display\n");
+	struct regulator *vdda_dac;
 
-	if (venc.vdda_dac_reg == NULL) {
-		struct regulator *vdda_dac;
-
-		vdda_dac = regulator_get(&venc.pdev->dev, "vdda_dac");
+	if (venc.vdda_dac_reg != NULL)
+		return 0;
 
-		if (IS_ERR(vdda_dac)) {
-			DSSERR("can't get VDDA_DAC regulator\n");
-			return PTR_ERR(vdda_dac);
-		}
+	vdda_dac = regulator_get(&venc.pdev->dev, "vdda_dac");
 
-		venc.vdda_dac_reg = vdda_dac;
+	if (IS_ERR(vdda_dac)) {
+		DSSERR("can't get VDDA_DAC regulator\n");
+		return PTR_ERR(vdda_dac);
 	}
 
+	venc.vdda_dac_reg = vdda_dac;
+
 	return 0;
 }
 
@@ -765,19 +764,16 @@ static int venc_probe_pdata(struct platform_device *vencdev)
 	if (!plat_dssdev)
 		return 0;
 
+	r = venc_init_regulator();
+	if (r)
+		return r;
+
 	dssdev = dss_alloc_and_init_device(&vencdev->dev);
 	if (!dssdev)
 		return -ENOMEM;
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	r = venc_init_display(dssdev);
-	if (r) {
-		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-		dss_put_device(dssdev);
-		return r;
-	}
-
 	r = omapdss_output_set_device(&venc.output, dssdev);
 	if (r) {
 		DSSERR("failed to connect output to new device: %s\n",
-- 
1.8.1.2

