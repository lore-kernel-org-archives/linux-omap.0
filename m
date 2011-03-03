From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 4/4] OMAP: DSS2: Remove unneeded cpu_is_xxx checks
Date: Thu, 3 Mar 2011 10:35:28 +0200
Message-ID: <1299141328-12880-5-git-send-email-tomi.valkeinen@ti.com>
References: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53012 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769Ab1CCIfk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 03:35:40 -0500
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p238ZeqM007851
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:40 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id p238Zewt000469
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:40 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZehC005587
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:40 -0600 (CST)
In-Reply-To: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

cpu_is_omapxxx() was used previously to select the supported interfaces.
Now that the interfaces are platform devices, we no longer need to do
the check when registering the driver. Thus we can just remove the
checks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 8cfedae..c2f930b 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -203,12 +203,10 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_venc;
 	}
 
-	if (cpu_is_omap34xx()) {
-		r = dsi_init_platform_driver();
-		if (r) {
-			DSSERR("Failed to initialize DSI platform driver\n");
-			goto err_dsi;
-		}
+	r = dsi_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize DSI platform driver\n");
+		goto err_dsi;
 	}
 
 	r = dss_initialize_debugfs();
@@ -240,8 +238,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
-	if (cpu_is_omap34xx())
-		dsi_uninit_platform_driver();
+	dsi_uninit_platform_driver();
 err_dsi:
 	venc_uninit_platform_driver();
 err_venc:
@@ -265,10 +262,7 @@ static int omap_dss_remove(struct platform_device *pdev)
 	venc_uninit_platform_driver();
 	dispc_uninit_platform_driver();
 	rfbi_uninit_platform_driver();
-	if (cpu_is_omap34xx()) {
-		dsi_uninit_platform_driver();
-	}
-
+	dsi_uninit_platform_driver();
 	dss_uninit_platform_driver();
 
 	dss_uninit_overlays(pdev);
-- 
1.7.1

