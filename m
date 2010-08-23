From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 13/20] Move dsi init to dsi probe
Date: Mon, 23 Aug 2010 21:28:02 +0530
Message-ID: <1282579089-10487-14-git-send-email-svadivu@ti.com>
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
 <1282579089-10487-12-git-send-email-svadivu@ti.com>
 <1282579089-10487-13-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754218Ab0HWP6X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:58:23 -0400
In-Reply-To: <1282579089-10487-13-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSI init and exit moved to dsi probe and remove.
regulator in dsi could be taken care in board file as
"REGULATOR_SUPPLY("vdds_dsi", "dss_dsi1")," but not added as part
of this patch.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |   25 ++++++++++++++-----------
 1 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index df0cfea..ce1f83b 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -197,12 +197,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 			DSSERR("Failed to initialize SDI\n");
 			goto err_sdi;
 		}
-
-		r = dsi_init(pdev);
-		if (r) {
-			DSSERR("Failed to initialize DSI\n");
-			goto err_dsi;
-		}
 	}
 
 	r = dss_initialize_debugfs();
@@ -235,9 +229,6 @@ err_register:
 	dss_uninitialize_debugfs();
 err_debugfs:
 	if (cpu_is_omap34xx())
-		dsi_exit();
-err_dsi:
-	if (cpu_is_omap34xx())
 		sdi_exit();
 err_sdi:
 	dpi_exit();
@@ -257,7 +248,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
-		dsi_exit();
 		sdi_exit();
 	}
 
@@ -315,11 +305,24 @@ static int omap_dispchw_remove(struct platform_device *pdev)
 /* DSI1 HW IP initialisation */
 static int omap_dsi1hw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	if (cpu_is_omap34xx()) {
+		r = dsi_init(pdev);
+		if (r) {
+			DSSERR("Failed to initialize DSI\n");
+			goto err_dsi;
+		}
+	}
+err_dsi:
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	return r;
 }
 
 static int omap_dsi1hw_remove(struct platform_device *pdev)
 {
+	if (cpu_is_omap34xx())
+		dsi_exit();
 	return 0;
 }
 
-- 
1.6.3.3

