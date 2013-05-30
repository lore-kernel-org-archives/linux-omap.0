From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/32] OMAPDSS: SDI: clean up regulator init
Date: Thu, 30 May 2013 12:34:38 +0300
Message-ID: <1369906493-27538-18-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42776 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030342Ab3E3Jfo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 05:35:44 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Clean up the SDI driver's regulator init to remove the (unused)
omap_dss_device parameter, renaming the function to a more sensible
name, and making the code slightly clearer.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 2e3afb8..9801a6e 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -251,30 +251,31 @@ void omapdss_sdi_set_datapairs(struct omap_dss_device *dssdev, int datapairs)
 }
 EXPORT_SYMBOL(omapdss_sdi_set_datapairs);
 
-static int sdi_init_display(struct omap_dss_device *dssdev)
+static int sdi_init_regulator(void)
 {
-	DSSDBG("SDI init\n");
-
-	if (sdi.vdds_sdi_reg == NULL) {
-		struct regulator *vdds_sdi;
-
-		vdds_sdi = dss_get_vdds_sdi();
-
-		if (IS_ERR(vdds_sdi)) {
-			vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
-			if (IS_ERR(vdds_sdi)) {
-				DSSERR("can't get VDDS_SDI regulator\n");
-				return PTR_ERR(vdds_sdi);
-			}
-			sdi.vdds_sdi_from_core = false;
-		} else {
-			sdi.vdds_sdi_from_core = true;
-		}
+	struct regulator *vdds_sdi;
+
+	if (sdi.vdds_sdi_reg != NULL)
+		return 0;
 
+	vdds_sdi = dss_get_vdds_sdi();
+
+	if (!IS_ERR(vdds_sdi)) {
+		sdi.vdds_sdi_from_core = true;
 		sdi.vdds_sdi_reg = vdds_sdi;
+		return 0;
 	}
 
-	return 0;
+	vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
+
+	if (!IS_ERR(vdds_sdi)) {
+		sdi.vdds_sdi_from_core = false;
+		sdi.vdds_sdi_reg = vdds_sdi;
+	}
+
+	DSSERR("can't get VDDS_SDI regulator\n");
+
+	return PTR_ERR(vdds_sdi);
 }
 
 static struct omap_dss_device *sdi_find_dssdev(struct platform_device *pdev)
@@ -322,7 +323,7 @@ static int sdi_probe_pdata(struct platform_device *sdidev)
 
 	dss_copy_device_pdata(dssdev, plat_dssdev);
 
-	r = sdi_init_display(dssdev);
+	r = sdi_init_regulator();
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
 		dss_put_device(dssdev);
-- 
1.8.1.2

