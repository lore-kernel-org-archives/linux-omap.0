From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH 09/20] Move dss_init to dsshw_probe
Date: Mon, 23 Aug 2010 21:27:58 +0530
Message-ID: <1282579089-10487-10-git-send-email-svadivu@ti.com>
References: <1282579089-10487-1-git-send-email-svadivu@ti.com>
 <1282579089-10487-2-git-send-email-svadivu@ti.com>
 <1282579089-10487-3-git-send-email-svadivu@ti.com>
 <1282579089-10487-4-git-send-email-svadivu@ti.com>
 <1282579089-10487-5-git-send-email-svadivu@ti.com>
 <1282579089-10487-6-git-send-email-svadivu@ti.com>
 <1282579089-10487-7-git-send-email-svadivu@ti.com>
 <1282579089-10487-8-git-send-email-svadivu@ti.com>
 <1282579089-10487-9-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37923 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228Ab0HWP6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Aug 2010 11:58:24 -0400
In-Reply-To: <1282579089-10487-9-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

Move dss_init and dss_exit from core driver to dss driver

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/core.c |   15 ---------------
 drivers/video/omap2/dss/dss.c  |   17 ++++++++++++++++-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 24b93d5..90a8f77 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -199,18 +199,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 
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
@@ -292,8 +280,6 @@ err_dispc:
 err_dpi:
 	rfbi_exit();
 err_rfbi:
-	dss_exit();
-err_dss:
 	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
 
 	return r;
@@ -316,7 +302,6 @@ static int omap_dss_remove(struct platform_device *pdev)
 		sdi_exit();
 	}
 
-	dss_exit();
 
 	dss_uninit_overlays(pdev);
 	dss_uninit_overlay_managers(pdev);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 098ff96..cbad9ff 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -456,6 +456,7 @@ void dss_debug_dump_clocks(struct seq_file *s)
 static int omap_dsshw_probe(struct platform_device *pdev)
 {
 	int r;
+	int skip_init = 0;
 
 	dss.pdev = pdev;
 	dss.pdata = dss.pdev->dev.platform_data;
@@ -469,8 +470,20 @@ static int omap_dsshw_probe(struct platform_device *pdev)
 	dss.ctx_id = dss_get_ctx_id();
 	DSSDBG("initial ctx id %u\n", dss.ctx_id);
 
-err_clocks:
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
 
+err_clocks:
+err_dss:
 	return r;
 }
 
@@ -478,6 +491,8 @@ static int omap_dsshw_remove(struct platform_device *pdev)
 {
 	int c;
 
+	dss_exit();
+
 	/* these should be removed at some point */
 	c = dss.dss_ick->usecount;
 	if (c > 0) {
-- 
1.6.3.3

