From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v11 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
Date: Wed, 16 Feb 2011 10:44:00 +0530
Message-ID: <1297833240-6103-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58068 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750726Ab1BPFOI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 00:14:08 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G5E8cl030267
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 23:14:08 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS IRQ number can be obtained from platform_get_irq().  This API in turn
picks the right IRQ number belonging to HW IP from the hwmod database.
So hardcoding of IRQ number could be removed.

This IRQ is stored in dss_irq as part of dss structure, and freed it in
dss_exit().

Reviewed-by: Paul Walmsley <paul@pwsan.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/video/omap2/dss/dss.c |   22 +++++++++++++++-------
 1 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4d7a816..f4d90f2 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -79,6 +79,7 @@ static struct {
 	enum dss_clk_source dispc_clk_source;
 
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
+	int		dss_irq;
 } dss;
 
 static void dss_clk_enable_all_no_ctx(void);
@@ -609,11 +610,18 @@ static int dss_init(bool skip_init)
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
 
-	r = request_irq(INT_24XX_DSS_IRQ,
-			cpu_is_omap24xx()
-			? dss_irq_handler_omap2
-			: dss_irq_handler_omap3,
-			0, "OMAP DSS", NULL);
+	dss.dss_irq = platform_get_irq(dss.pdev, 0);
+	if (dss.dss_irq < 0) {
+		DSSERR("omap2 dss: platform_get_irq failed\n");
+		r = -ENODEV;
+		goto fail1;
+	}
+
+	r = request_irq(dss.dss_irq,
+		cpu_is_omap24xx()
+		? dss_irq_handler_omap2
+		: dss_irq_handler_omap3,
+		0, "OMAP DSS", NULL);
 
 	if (r < 0) {
 		DSSERR("omap2 dss: request_irq failed\n");
@@ -641,7 +649,7 @@ static int dss_init(bool skip_init)
 	return 0;
 
 fail2:
-	free_irq(INT_24XX_DSS_IRQ, NULL);
+	free_irq(dss.dss_irq, NULL);
 fail1:
 	iounmap(dss.base);
 fail0:
@@ -653,7 +661,7 @@ static void dss_exit(void)
 	if (cpu_is_omap34xx())
 		clk_put(dss.dpll4_m4_ck);
 
-	free_irq(INT_24XX_DSS_IRQ, NULL);
+	free_irq(dss.dss_irq, NULL);
 
 	iounmap(dss.base);
 }
-- 
1.7.1

