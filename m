From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 06/28] OMAP: DSS2: Init dispc first before other components
Date: Thu,  9 Jun 2011 16:56:28 +0300
Message-ID: <1307627810-3768-7-git-send-email-tomi.valkeinen@ti.com>
References: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:49247 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757817Ab1FIN5Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jun 2011 09:57:16 -0400
In-Reply-To: <1307627810-3768-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: b-cousson@ti.com, paul@pwsan.com, khilman@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

The initialization order of the DSS modules is important when pm_runtime
support is implemented. Currently RFBI is initialized before DISPC,
which will cause problems with pm_runtime as RFBI uses DISPC.

Change the init order so that DISPC is before RFBI.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/core.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 3da4267..02187df 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -185,6 +185,11 @@ static int omap_dss_probe(struct platform_device *pdev)
 
 	/* keep clocks enabled to prevent context saves/restores during init */
 	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
+	r = dispc_init_platform_driver();
+	if (r) {
+		DSSERR("Failed to initialize dispc platform driver\n");
+		goto err_dispc;
+	}
 
 	r = rfbi_init_platform_driver();
 	if (r) {
@@ -192,12 +197,6 @@ static int omap_dss_probe(struct platform_device *pdev)
 		goto err_rfbi;
 	}
 
-	r = dispc_init_platform_driver();
-	if (r) {
-		DSSERR("Failed to initialize dispc platform driver\n");
-		goto err_dispc;
-	}
-
 	r = venc_init_platform_driver();
 	if (r) {
 		DSSERR("Failed to initialize venc platform driver\n");
-- 
1.7.4.1

