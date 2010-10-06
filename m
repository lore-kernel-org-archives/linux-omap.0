From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 12/16] OMAP3: hwmod DSS: DISPC Move init,exit to driver
Date: Wed,  6 Oct 2010 16:44:55 +0530
Message-ID: <1286363699-9614-13-git-send-email-svadivu@ti.com>
References: <1286363699-9614-1-git-send-email-svadivu@ti.com>
 <1286363699-9614-2-git-send-email-svadivu@ti.com>
 <1286363699-9614-3-git-send-email-svadivu@ti.com>
 <1286363699-9614-4-git-send-email-svadivu@ti.com>
 <1286363699-9614-5-git-send-email-svadivu@ti.com>
 <1286363699-9614-6-git-send-email-svadivu@ti.com>
 <1286363699-9614-7-git-send-email-svadivu@ti.com>
 <1286363699-9614-8-git-send-email-svadivu@ti.com>
 <1286363699-9614-9-git-send-email-svadivu@ti.com>
 <1286363699-9614-10-git-send-email-svadivu@ti.com>
 <1286363699-9614-11-git-send-email-svadivu@ti.com>
 <1286363699-9614-12-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32921 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758890Ab0JFLPX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:23 -0400
In-Reply-To: <1286363699-9614-12-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe,remove.
pdev member has to be maintained by its own drivers.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c  |    9 ---------
 drivers/video/omap2/dss/dispc.c |   14 +++++++++++++-
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index cc7a5f1..9652ed7 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -199,12 +199,6 @@ static int omap_dss_probe(struct platform_device *pdev)
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
@@ -262,8 +256,6 @@ err_dsi:
 err_sdi:
 	venc_exit();
 err_venc:
-	dispc_exit();
-err_dispc:
 	dpi_exit();
 err_dpi:
 
@@ -278,7 +270,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 	dss_uninitialize_debugfs();
 
 	venc_exit();
-	dispc_exit();
 	dpi_exit();
 	if (cpu_is_omap34xx()) {
 		dsi_exit();
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index e48c6fa..e35cc87 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -156,6 +156,7 @@ struct dispc_irq_stats {
 };
 
 static struct {
+	struct platform_device *pdev;
 	void __iomem    *base;
 
 	u32	fifo_size[3];
@@ -189,11 +190,22 @@ static inline u32 dispc_read_reg(const struct dispc_reg idx)
 /* DISPC HW IP initialisation */
 static int omap_dispchw_probe(struct platform_device *pdev)
 {
-	return 0;
+	int r;
+	dispc.pdev = pdev;
+
+	r = dispc_init();
+	if (r) {
+		DSSERR("Failed to initialize dispc\n");
+		goto err_dispc;
+	}
+
+err_dispc:
+	return r;
 }
 
 static int omap_dispchw_remove(struct platform_device *pdev)
 {
+	dispc_exit();
 	return 0;
 }
 
-- 
1.6.3.3

