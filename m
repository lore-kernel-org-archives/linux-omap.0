From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 11/20] Move dispc init to dispc probe
Date: Mon, 23 Aug 2010 21:28:00 +0530
Message-ID: <1282579089-10487-12-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
 <1282579089-10487-10-git-send-email-svadivu@ti.com>
 <1282579089-10487-11-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37914 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab0HWP6W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:58:22 -0400
In-Reply-To: <1282579089-10487-11-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DISPC init and exit moved to dispc probe and remove.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5030a84..a72d2fa 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -205,12 +205,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_dpi;
 	}
 
-	r = dispc_init();
-	if (r) {
-		DSSERR("Failed to initialize dispc\n");
-		goto err_dispc;
-	}
-
 	r = venc_init(pdev);
 	if (r) {
 		DSSERR("Failed to initialize venc\n");
@@ -268,8 +262,6 @@ err_dsi:
 err_sdi:
 	venc_exit();
 err_venc:
-	dispc_exit();
-err_dispc:
 	dpi_exit();
 err_dpi:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
@@ -286,7 +278,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dss_uninitialize_debugfs();
 
 	venc_exit();
-	dispc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
@@ -326,11 +317,21 @@ static int omap_dss_resume(struct platform_device *pdev)
 /* DISPC HW IP initialisation */
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	r = dispc_init();
+	if (r) {
+		DSSERR("Failed to initialize dispc\n");
+		goto err_dispc;
+	}
+err_dispc:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	return r;
 }
 
 static int omap_dispchw_remove(struct platform_device *pdev)
 {
+	dispc_exit();
 	return 0;
 }
 
-- 
1.6.3.3

