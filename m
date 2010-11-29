From: Guruswamy Senthilvadivu <svadivu@ti.com>
Subject: [PATCH v2 17/17] OMAP2,3: DSS: Get DSS IRQ from platform device
Date: Mon, 29 Nov 2010 17:21:43 +0530
Message-ID: <1291031503-21036-18-git-send-email-svadivu@ti.com>
References: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48976 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0K2Lv7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 06:51:59 -0500
In-Reply-To: <1291031503-21036-1-git-send-email-svadivu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, tomi.valkeinen@nokia.com, paul@pwsan.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Senthilvadivu Guruswamy <svadivu@ti.com>

From: Senthilvadivu Guruswamy <svadivu@ti.com>

DSS IRQ got from platform device.

Signed-off-by: Senthilvadivu Guruswamy <svadivu@ti.com>
---
 drivers/video/omap2/dss/dss.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index f544160..8fafae9 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -565,7 +565,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 
 int dss_init(bool skip_init)
 {
-	int r;
+	int r, dss_irq;
 	u32 rev;
 	struct resource *dss_mem;
 
@@ -611,15 +611,18 @@ int dss_init(bool skip_init)
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
1.6.3.3

