From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 06/26] OMAPDSS: SDI: fix regulators
Date: Tue, 26 Mar 2013 15:33:36 +0200
Message-ID: <1364304836-18134-7-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36230 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934319Ab3CZNek (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:34:40 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

SDI requires a regulator to operate. This regulator is, for some reason,
currently attached to the virtual omapdss device, instead of the SDI
device. This does not work for DT, as the regulator mappings need to be
described in the DT data, and the virtual omapdss device is not present
there.

Fix the issue by acquiring the regulator in the SDI device. To retain
compatibility with the current board files, the old method of getting
the regulator is kept. The old method can be removed when the board
files have been changed to pass the regulator to SDI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/sdi.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 0155c7e..607244a 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -31,8 +31,11 @@
 #include "dss.h"
 
 static struct {
+	struct platform_device *pdev;
+
 	bool update_enabled;
 	struct regulator *vdds_sdi_reg;
+	bool vdds_sdi_from_core;
 
 	struct dss_lcd_mgr_config mgr_config;
 	struct omap_video_timings timings;
@@ -258,8 +261,14 @@ static int __init sdi_init_display(struct omap_dss_device *dssdev)
 		vdds_sdi = dss_get_vdds_sdi();
 
 		if (IS_ERR(vdds_sdi)) {
-			DSSERR("can't get VDDS_SDI regulator\n");
-			return PTR_ERR(vdds_sdi);
+			vdds_sdi = regulator_get(&sdi.pdev->dev, "vdds_sdi");
+			if (IS_ERR(vdds_sdi)) {
+				DSSERR("can't get VDDS_SDI regulator\n");
+				return PTR_ERR(vdds_sdi);
+			}
+			sdi.vdds_sdi_from_core = false;
+		} else {
+			sdi.vdds_sdi_from_core = true;
 		}
 
 		sdi.vdds_sdi_reg = vdds_sdi;
@@ -359,6 +368,8 @@ static void __exit sdi_uninit_output(struct platform_device *pdev)
 
 static int __init omap_sdi_probe(struct platform_device *pdev)
 {
+	sdi.pdev = pdev;
+
 	sdi_init_output(pdev);
 
 	if (pdev->dev.platform_data)
@@ -373,6 +384,11 @@ static int __exit omap_sdi_remove(struct platform_device *pdev)
 
 	sdi_uninit_output(pdev);
 
+	if (sdi.vdds_sdi_reg != NULL && sdi.vdds_sdi_from_core == false) {
+		regulator_put(sdi.vdds_sdi_reg);
+		sdi.vdds_sdi_reg = NULL;
+	}
+
 	return 0;
 }
 
-- 
1.7.10.4

