From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v1 10/16] OMAP3: hwmod DSS: DSS Move init,exit to driver
Date: Wed,  6 Oct 2010 16:44:53 +0530
Message-ID: <1286363699-9614-11-git-send-email-svadivu@ti.com>
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
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:32917 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758885Ab0JFLPW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Oct 2010 07:15:22 -0400
In-Reply-To: <1286363699-9614-10-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move init exit methods to its driver probe remove.
pdev member has to be maintained by its own drivers.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |   16 ----------------
 drivers/video/omap2/dss/dss.c  |   16 ++++++++++++++++
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index ce5240f..54fe333 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -193,18 +193,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
-#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
-	/* DISPC_CONTROL */
-	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
-		skip_init = 1;
-#endif
-
-	r = dss_init(skip_init);
-	if (r) {
-		DSSERR("Failed to initialize DSS\n");
-		goto err_dss;
-	}
-
 	r = rfbi_init();
 	if (r) {
 		DSSERR("Failed to initialize rfbi\n");
@@ -286,8 +274,6 @@ err_dispc:
 err_dpi:
 	rfbi_exit();
 err_rfbi:
-	dss_exit();
-err_dss:
 
 	return r;
 }
@@ -308,8 +294,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 		sdi_exit();
 	}
 
-	dss_exit();
-
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index fba8bcd..b93b118 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -410,6 +410,7 @@ void dss_debug_dump_clocks(struct seq_file *s)
 static int omap_dsshw_probe(struct platform_device *pdev)
 {
 	int r;
+	int skip_init = 0;
 
 	dss.pdev = pdev;
 
@@ -422,6 +423,19 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	dss.ctx_id = dss_get_ctx_id();
 	DSSDBG("initial ctx id %u\n", dss.ctx_id);
 
+#ifdef CONFIG_FB_OMAP_BOOTLOADER_INIT
+	/* DISPC_CONTROL */
+	if (omap_readl(0x48050440) & 1)	/* LCD enabled? */
+		skip_init = 1;
+#endif
+
+	r = dss_init(skip_init);
+	if (r) {
+		DSSERR("Failed to initialize DSS\n");
+		goto err_dss;
+	}
+
+err_dss:
 	dss_clk_disable_all_no_ctx();
 err_clocks:
 
@@ -432,6 +446,8 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 {
 	int c;
 
+	dss_exit();
+
 	/* these should be removed at some point */
 	c = dss.dss_ick->usecount;
 	if (c > 0) {
-- 
1.6.3.3

