From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v8 18/18] OMAP2,3: DSS2: Get DSS IRQ from platform device
Date: Fri, 21 Jan 2011 20:20:41 +0530
Message-ID: <1295621441-16678-19-git-send-email-sumit.semwal@ti.com>
References: <1295621441-16678-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39236 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389Ab1AUOw2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Jan 2011 09:52:28 -0500
In-Reply-To: <1295621441-16678-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>, Sumit Semwal <sumit.semwal@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS IRQ number can be obtained from platform_get_irq().  This API in turn
picks the right IRQ number belonging to HW IP from the hwmod database.
So hardcoding of IRQ number could be removed.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
---
 drivers/video/omap2/dss/dss.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 4d7a816..22690e9 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -563,7 +563,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 
 static int dss_init(bool skip_init)
 {
-	int r;
+	int r, dss_irq;
 	u32 rev;
 	struct resource *dss_mem;
 
@@ -609,15 +609,18 @@ static int dss_init(bool skip_init)
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
 
-	r = request_irq(INT_24XX_DSS_IRQ,
+	dss_irq = platform_get_irq(dss.pdev, 0);
+	if (dss_irq != -ENXIO) {
+		r = request_irq(dss_irq,
 			cpu_is_omap24xx()
 			? dss_irq_handler_omap2
 			: dss_irq_handler_omap3,
 			0, "OMAP DSS", NULL);
 
-	if (r < 0) {
-		DSSERR("omap2 dss: request_irq failed\n");
-		goto fail1;
+		if (r < 0) {
+			DSSERR("omap2 dss: request_irq failed\n");
+			goto fail1;
+		}
 	}
 
 	if (cpu_is_omap34xx()) {
-- 
1.7.1

