From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/6] OMAP: DSS2: DSI: use ISR in send_bta_sync
Date: Wed, 9 Mar 2011 09:21:25 +0200
Message-ID: <1299655288-7121-4-git-send-email-tomi.valkeinen@ti.com>
References: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48212 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab1CIHVp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 02:21:45 -0500
In-Reply-To: <1299655288-7121-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove bta_completion handling from the interrupt handler, and use ISR
support instead.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   32 ++++++++++++++++++--------------
 1 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 9aea9a7..a4d47dd 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -257,7 +257,6 @@ static struct
 
 	unsigned pll_locked;
 
-	struct completion bta_completion;
 	void (*bta_callback)(void);
 
 	spinlock_t irq_lock;
@@ -341,6 +340,11 @@ static bool dsi_bus_is_locked(void)
 	return dsi.bus_lock.count == 0;
 }
 
+static void dsi_completion_handler(void *data, u32 mask)
+{
+	complete((struct completion *)data);
+}
+
 static inline int wait_for_bit_change(const struct dsi_reg idx, int bitnum,
 		int value)
 {
@@ -642,8 +646,6 @@ static irqreturn_t omap_dsi_irq_handler(int irq, void *arg)
 			continue;
 
 		if (vcstatus[i] & DSI_VC_IRQ_BTA) {
-			complete(&dsi.bta_completion);
-
 			if (dsi.bta_callback)
 				dsi.bta_callback();
 		}
@@ -2251,33 +2253,37 @@ static int dsi_vc_send_bta(int channel)
 
 int dsi_vc_send_bta_sync(int channel)
 {
+	DECLARE_COMPLETION_ONSTACK(completion);
 	int r = 0;
 	u32 err;
 
-	INIT_COMPLETION(dsi.bta_completion);
-
-	dsi_vc_enable_bta_irq(channel);
+	r = dsi_register_isr_vc(channel, dsi_completion_handler,
+			&completion, DSI_VC_IRQ_BTA);
+	if (r)
+		goto err0;
 
 	r = dsi_vc_send_bta(channel);
 	if (r)
-		goto err;
+		goto err1;
 
-	if (wait_for_completion_timeout(&dsi.bta_completion,
+	if (wait_for_completion_timeout(&completion,
 				msecs_to_jiffies(500)) == 0) {
 		DSSERR("Failed to receive BTA\n");
 		r = -EIO;
-		goto err;
+		goto err1;
 	}
 
 	err = dsi_get_errors();
 	if (err) {
 		DSSERR("Error while sending BTA: %x\n", err);
 		r = -EIO;
-		goto err;
+		goto err1;
 	}
-err:
-	dsi_vc_disable_bta_irq(channel);
 
+err1:
+	dsi_unregister_isr_vc(channel, dsi_completion_handler,
+			&completion, DSI_VC_IRQ_BTA);
+err0:
 	return r;
 }
 EXPORT_SYMBOL(dsi_vc_send_bta_sync);
@@ -3647,8 +3653,6 @@ static int dsi_init(struct platform_device *pdev)
 	dsi.irq_stats.last_reset = jiffies;
 #endif
 
-	init_completion(&dsi.bta_completion);
-
 	mutex_init(&dsi.lock);
 	sema_init(&dsi.bus_lock, 1);
 
-- 
1.7.1

