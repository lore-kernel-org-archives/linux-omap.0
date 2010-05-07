From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v2 2/2] OMAP: DSS2: Fix omap_dss_probe() error path
Date: Fri,  7 May 2010 12:58:42 +0300
Message-ID: <82a31f3af6c59bd242fdbcf18f7387940d8d822f.1273222740.git.ext-jani.1.nikula@nokia.com>
References: <1273219659.1978.144.camel@tubuntu.research.nokia.com>
 <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
 <a17cc11c19f780bd656ce29b64e60d878e1c6fea.1273222740.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61768 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755373Ab0EGJ7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 05:59:19 -0400
In-Reply-To: <a17cc11c19f780bd656ce29b64e60d878e1c6fea.1273222740.git.ext-jani.1.nikula@nokia.com>
In-Reply-To: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
References: <cover.1273222740.git.ext-jani.1.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, khilman@deeprootsystems.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org, ext-jani.1.nikula@nokia.com

From: Jani Nikula <ext-jani.1.nikula@nokia.com>

Perform graceful cleanup on errors instead of just bailing out.

Signed-off-by: Jani Nikula <ext-jani.1.nikula@nokia.com>
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
1.6.5.2

