From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 23/23] OMAP: DSS2: Fix omap_dss_probe() error path
Date: Tue, 18 May 2010 15:35:14 +0300
Message-ID: <1274186114-26951-24-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62574 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757587Ab0ERMgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:37 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Jani Nikula <ext-jani.1.nikula@nokia.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Perform graceful cleanup on errors instead of just bailing out.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
Tested-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/dss/core.c |   54 ++++++++++++++++++++++++++++++---------
 1 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 92ee067..b3a498f 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -507,7 +507,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	r = dss_get_clocks();
 	if (r)
-		goto fail0;
+		goto err_clocks;
 
 	dss_clk_enable_all_no_ctx();
 
@@ -523,57 +523,64 @@ static int omap_dss_probe(struct platform_device *pdev)
 	r = dss_init(skip_init);
 	if (r) {
 		DSSERR("Failed to initialize DSS\n");
-		goto fail0;
+		goto err_dss;
 	}
 
 	r = rfbi_init();
 	if (r) {
 		DSSERR("Failed to initialize rfbi\n");
-		goto fail0;
+		goto err_rfbi;
 	}
 
 	r = dpi_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize dpi\n");
-		goto fail0;
+		goto err_dpi;
 	}
 
 	r = dispc_init();
 	if (r) {
 		DSSERR("Failed to initialize dispc\n");
-		goto fail0;
+		goto err_dispc;
 	}
 
 	r = venc_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize venc\n");
-		goto fail0;
+		goto err_venc;
 	}
 
 	if (cpu_is_omap34xx()) {
 		r = sdi_init(skip_init);
 		if (r) {
 			DSSERR("Failed to initialize SDI\n");
-			goto fail0;
+			goto err_sdi;
 		}
 
 		r = dsi_init(pdev);
 		if (r) {
 			DSSERR("Failed to initialize DSI\n");
-			goto fail0;
+			goto err_dsi;
 		}
 	}
 
 	r = dss_initialize_debugfs();
 	if (r)
-		goto fail0;
+		goto err_debugfs;
 
 	for (i = 0; i < pdata->num_devices; ++i) {
 		struct omap_dss_device *dssdev = pdata->devices[i];
 
 		r = omap_dss_register_device(dssdev);
-		if (r)
-			DSSERR("device reg failed %d\n", i);
+		if (r) {
+			DSSERR("device %d %s register failed %d\n", i,
+				dssdev->name ?: "unnamed", r);
+
+			while (--i >= 0)
+				omap_dss_unregister_device(pdata->devices[i]);
+
+			goto err_register;
+		}
 
 		if (def_disp_name && strcmp(def_disp_name, dssdev->name) == 0)
 			pdata->default_device = dssdev;
@@ -583,8 +590,29 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	return 0;
 
-	/* XXX fail correctly */
-fail0:
+err_register:
+	dss_uninitialize_debugfs();
+err_debugfs:
+	if (cpu_is_omap34xx())
+		dsi_exit();
+err_dsi:
+	if (cpu_is_omap34xx())
+		sdi_exit();
+err_sdi:
+	venc_exit();
+err_venc:
+	dispc_exit();
+err_dispc:
+	dpi_exit();
+err_dpi:
+	rfbi_exit();
+err_rfbi:
+	dss_exit();
+err_dss:
+	dss_clk_disable_all_no_ctx();
+	dss_put_clocks();
+err_clocks:
+
 	return r;
 }
 
-- 
1.7.0.4

