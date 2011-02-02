From: Archit Taneja <archit@ti.com>
Subject: [PATCH] OMAP: DSS2: Common IRQ handler for all OMAPs
Date: Wed,  2 Feb 2011 14:26:30 +0530
Message-ID: <1296636990-24775-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45657 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab1BBI5g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Feb 2011 03:57:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomba@iki.fi
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

OMAP2 has an irq line dedicated for DISPC interrupts, there is no DSI
on omap2.
OMAP3 has a common irq line for DISPC and DSI interrupts.
OMAP4 has seperate irq lines for DISPC and DSI Interrupts.

Use dss_features to have a common DSS irq handler for all OMAP revisions.

Also, use a member of the global dss structure to store the irq number
as it is used in 2 functions.
 
Signed-off-by: Archit Taneja <archit@ti.com>
---
Note: Applies over a) v10 of OMAP2,3 DSS2 HWMOD b)v3 of DSS2: Generalize clock names
and c) v3 of DSS2: OMAP4 DSS HWMOD :

https://patchwork.kernel.org/patch/500191/
https://patchwork.kernel.org/patch/520191/
https://patchwork.kernel.org/patch/511211/

 drivers/video/omap2/dss/dss.c          |   46 +++++++++++++------------------
 drivers/video/omap2/dss/dss_features.c |    5 ++-
 drivers/video/omap2/dss/dss_features.h |   17 ++++++-----
 3 files changed, 31 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c7cdbea..24d6f98 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -33,6 +33,7 @@
 #include <plat/display.h>
 #include <plat/clock.h>
 #include "dss.h"
+#include "dss_features.h"
 
 #define DSS_SZ_REGS			SZ_512
 
@@ -61,6 +62,7 @@ static struct {
 	struct platform_device *pdev;
 	void __iomem    *base;
 	int             ctx_id;
+	int		irq;
 
 	struct clk	*dpll4_m4_ck;
 	struct clk	*dss_ick;
@@ -494,28 +496,22 @@ found:
 	return 0;
 }
 
-
-
-static irqreturn_t dss_irq_handler_omap2(int irq, void *arg)
-{
-	dispc_irq_handler();
-
-	return IRQ_HANDLED;
-}
-
-static irqreturn_t dss_irq_handler_omap3(int irq, void *arg)
+static irqreturn_t dss_irq_handler(int irq, void *arg)
 {
-	u32 irqstatus;
+	if (dss_has_feature(FEAT_COMMON_IRQ_DISPC_DSI)) {
+		u32 irqstatus;
 
-	irqstatus = dss_read_reg(DSS_IRQSTATUS);
+		irqstatus = dss_read_reg(DSS_IRQSTATUS);
 
-	if (irqstatus & (1<<0))	/* DISPC_IRQ */
-		dispc_irq_handler();
+		if (irqstatus & (1<<0))	/* DISPC_IRQ */
+			dispc_irq_handler();
 #ifdef CONFIG_OMAP2_DSS_DSI
-	if (irqstatus & (1<<1))	/* DSI_IRQ */
-		dsi_irq_handler();
+		if (irqstatus & (1<<1))	/* DSI_IRQ */
+			dsi_irq_handler();
 #endif
-
+	} else {
+		dispc_irq_handler();
+	}
 	return IRQ_HANDLED;
 }
 
@@ -563,7 +559,7 @@ void dss_set_dac_pwrdn_bgz(bool enable)
 
 static int dss_init(bool skip_init)
 {
-	int r, dss_irq;
+	int r;
 	u32 rev;
 	struct resource *dss_mem;
 
@@ -609,18 +605,14 @@ static int dss_init(bool skip_init)
 	REG_FLD_MOD(DSS_CONTROL, 0, 2, 2);	/* venc clock mode = normal */
 #endif
 
-	dss_irq = platform_get_irq(dss.pdev, 0);
-	if (dss_irq < 0) {
+	dss.irq = platform_get_irq(dss.pdev, 0);
+	if (dss.irq < 0) {
 		DSSERR("omap2 dss: platform_get_irq failed\n");
 		r = -ENODEV;
 		goto fail1;
 	}
 
-	r = request_irq(dss_irq,
-		cpu_is_omap24xx()
-		? dss_irq_handler_omap2
-		: dss_irq_handler_omap3,
-		0, "OMAP DSS", NULL);
+	r = request_irq(dss.irq, dss_irq_handler, 0, "OMAP DSS", NULL);
 
 	if (r < 0) {
 		DSSERR("omap2 dss: request_irq failed\n");
@@ -648,7 +640,7 @@ static int dss_init(bool skip_init)
 	return 0;
 
 fail2:
-	free_irq(dss_irq, NULL);
+	free_irq(dss.irq, NULL);
 fail1:
 	iounmap(dss.base);
 fail0:
@@ -660,7 +652,7 @@ static void dss_exit(void)
 	if (cpu_is_omap34xx())
 		clk_put(dss.dpll4_m4_ck);
 
-	free_irq(INT_24XX_DSS_IRQ, NULL);
+	free_irq(dss.irq, NULL);
 
 	iounmap(dss.base);
 }
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index cf3ef69..f3ef929 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -157,7 +157,7 @@ static struct omap_dss_features omap3430_dss_features = {
 	.has_feature	=
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED,
+		FEAT_FUNCGATED | FEAT_COMMON_IRQ_DISPC_DSI,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -172,7 +172,8 @@ static struct omap_dss_features omap3630_dss_features = {
 	.has_feature    =
 		FEAT_GLOBAL_ALPHA | FEAT_LCDENABLEPOL |
 		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED,
+		FEAT_PRE_MULT_ALPHA | FEAT_FUNCGATED |
+		FEAT_COMMON_IRQ_DISPC_DSI,
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b9c70be..1c93a49 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -25,14 +25,15 @@
 
 /* DSS has feature id */
 enum dss_feat_id {
-	FEAT_GLOBAL_ALPHA	= 1 << 0,
-	FEAT_GLOBAL_ALPHA_VID1	= 1 << 1,
-	FEAT_PRE_MULT_ALPHA	= 1 << 2,
-	FEAT_LCDENABLEPOL	= 1 << 3,
-	FEAT_LCDENABLESIGNAL	= 1 << 4,
-	FEAT_PCKFREEENABLE	= 1 << 5,
-	FEAT_FUNCGATED		= 1 << 6,
-	FEAT_MGR_LCD2		= 1 << 7,
+	FEAT_GLOBAL_ALPHA		= 1 << 0,
+	FEAT_GLOBAL_ALPHA_VID1		= 1 << 1,
+	FEAT_PRE_MULT_ALPHA		= 1 << 2,
+	FEAT_LCDENABLEPOL		= 1 << 3,
+	FEAT_LCDENABLESIGNAL		= 1 << 4,
+	FEAT_PCKFREEENABLE		= 1 << 5,
+	FEAT_FUNCGATED			= 1 << 6,
+	FEAT_MGR_LCD2			= 1 << 7,
+	FEAT_COMMON_IRQ_DISPC_DSI	= 1 << 8,
 };
 
 /* DSS register field id */
-- 
1.7.1

