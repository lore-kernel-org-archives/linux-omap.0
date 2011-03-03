From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/4] OMAP: DSS2: Move DPI & SDI init into DSS plat driver
Date: Thu, 3 Mar 2011 10:35:27 +0200
Message-ID: <1299141328-12880-4-git-send-email-tomi.valkeinen@ti.com>
References: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53011 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757769Ab1CCIfj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Mar 2011 03:35:39 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p238ZdD2007846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:39 -0600
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZcDY005520
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:38 -0600 (CST)
Received: from dlee74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p238ZcP7005579
	for <linux-omap@vger.kernel.org>; Thu, 3 Mar 2011 02:35:38 -0600 (CST)
In-Reply-To: <1299141328-12880-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

DPI and SDI are different from the other interfaces as they are not
hwmods and there is not platform driver for them. They could be said to
be a part of DSS or DISPC modules, although it's not a clear definition.

This patch moves DPI and SDI initialization into DSS platform driver,
making the code more consistent: omap_dss_probe() only initializes
platform drivers now.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   19 -------------------
 drivers/video/omap2/dss/dss.c  |   17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index acefe50..8cfedae 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -191,12 +191,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_rfbi;
 	}
 
-	r = dpi_init();
-	if (r) {
-		DSSERR("Failed to initialize dpi\n");
-		goto err_dpi;
-	}
-
 	r = dispc_init_platform_driver();
 	if (r) {
 		DSSERR("Failed to initialize dispc platform driver\n");
@@ -210,12 +204,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 	}
 
 	if (cpu_is_omap34xx()) {
-		r = sdi_init();
-		if (r) {
-			DSSERR("Failed to initialize SDI\n");
-			goto err_sdi;
-		}
-
 		r = dsi_init_platform_driver();
 		if (r) {
 			DSSERR("Failed to initialize DSI platform driver\n");
@@ -255,15 +243,10 @@ err_debugfs:
 	if (cpu_is_omap34xx())
 		dsi_uninit_platform_driver();
 err_dsi:
-	if (cpu_is_omap34xx())
-		sdi_exit();
-err_sdi:
 	venc_uninit_platform_driver();
 err_venc:
 	dispc_uninit_platform_driver();
 err_dispc:
-	dpi_exit();
-err_dpi:
 	rfbi_uninit_platform_driver();
 err_rfbi:
 	dss_uninit_platform_driver();
@@ -281,11 +264,9 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	venc_uninit_platform_driver();
 	dispc_uninit_platform_driver();
-	dpi_exit();
 	rfbi_uninit_platform_driver();
 	if (cpu_is_omap34xx()) {
 		dsi_uninit_platform_driver();
-		sdi_exit();
 	}
 
 	dss_uninit_platform_driver();
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4025a14..e5da050 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -970,9 +970,24 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 		goto err_dss;
 	}
 
+	r = dpi_init();
+	if (r) {
+		DSSERR("Failed to initialize DPI\n");
+		goto err_dpi;
+	}
+
+	r = sdi_init();
+	if (r) {
+		DSSERR("Failed to initialize SDI\n");
+		goto err_sdi;
+	}
+
 	dss_clk_disable_all_no_ctx();
 	return 0;
-
+err_sdi:
+	dpi_exit();
+err_dpi:
+	dss_exit();
 err_dss:
 	dss_clk_disable_all_no_ctx();
 	dss_put_clocks();
-- 
1.7.1

