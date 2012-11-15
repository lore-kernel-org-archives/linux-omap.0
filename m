From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/32] OMAPDSS: move omap_dispc_wait_for_irq_interruptible_timeout to dispc-compat.c
Date: Thu, 15 Nov 2012 17:58:31 +0200
Message-ID: <1352995120-3288-24-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50131 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768296Ab2KOP7s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:48 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

We have two functions to wait for a dispc interrupt:

int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout);
int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,

Of these, the former is not used at all, and can be removed. The latter
is only used by the compat layer, and can be moved to the compat layer
code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc-compat.c |   30 +++++++++++++++++
 drivers/video/omap2/dss/dispc-compat.h |    3 ++
 drivers/video/omap2/dss/dispc.c        |   57 --------------------------------
 include/video/omapdss.h                |    4 ---
 4 files changed, 33 insertions(+), 61 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc-compat.c b/drivers/video/omap2/dss/dispc-compat.c
index cca3848..24e1d5e 100644
--- a/drivers/video/omap2/dss/dispc-compat.c
+++ b/drivers/video/omap2/dss/dispc-compat.c
@@ -205,3 +205,33 @@ void dispc_mgr_disable_sync(enum omap_channel channel)
 		WARN_ON(1);
 }
 
+int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
+		unsigned long timeout)
+{
+	void dispc_irq_wait_handler(void *data, u32 mask)
+	{
+		complete((struct completion *)data);
+	}
+
+	int r;
+	DECLARE_COMPLETION_ONSTACK(completion);
+
+	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
+			irqmask);
+
+	if (r)
+		return r;
+
+	timeout = wait_for_completion_interruptible_timeout(&completion,
+			timeout);
+
+	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
+
+	if (timeout == 0)
+		return -ETIMEDOUT;
+
+	if (timeout == -ERESTARTSYS)
+		return -ERESTARTSYS;
+
+	return 0;
+}
diff --git a/drivers/video/omap2/dss/dispc-compat.h b/drivers/video/omap2/dss/dispc-compat.h
index 2d4f5e7..8322d43 100644
--- a/drivers/video/omap2/dss/dispc-compat.h
+++ b/drivers/video/omap2/dss/dispc-compat.h
@@ -21,4 +21,7 @@
 void dispc_mgr_enable_sync(enum omap_channel channel);
 void dispc_mgr_disable_sync(enum omap_channel channel);
 
+int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
+		unsigned long timeout);
+
 #endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3a1224f..b976838 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3744,63 +3744,6 @@ static void dispc_error_worker(struct work_struct *work)
 	dispc_runtime_put();
 }
 
-int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout)
-{
-	void dispc_irq_wait_handler(void *data, u32 mask)
-	{
-		complete((struct completion *)data);
-	}
-
-	int r;
-	DECLARE_COMPLETION_ONSTACK(completion);
-
-	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
-			irqmask);
-
-	if (r)
-		return r;
-
-	timeout = wait_for_completion_timeout(&completion, timeout);
-
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
-
-	if (timeout == 0)
-		return -ETIMEDOUT;
-
-	return 0;
-}
-
-int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
-		unsigned long timeout)
-{
-	void dispc_irq_wait_handler(void *data, u32 mask)
-	{
-		complete((struct completion *)data);
-	}
-
-	int r;
-	DECLARE_COMPLETION_ONSTACK(completion);
-
-	r = omap_dispc_register_isr(dispc_irq_wait_handler, &completion,
-			irqmask);
-
-	if (r)
-		return r;
-
-	timeout = wait_for_completion_interruptible_timeout(&completion,
-			timeout);
-
-	omap_dispc_unregister_isr(dispc_irq_wait_handler, &completion, irqmask);
-
-	if (timeout == 0)
-		return -ETIMEDOUT;
-
-	if (timeout == -ERESTARTSYS)
-		return -ERESTARTSYS;
-
-	return 0;
-}
-
 static void _omap_dispc_initialize_irq(void)
 {
 	unsigned long flags;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index a940236..823a07b 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -775,10 +775,6 @@ typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 
-int omap_dispc_wait_for_irq_timeout(u32 irqmask, unsigned long timeout);
-int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
-		unsigned long timeout);
-
 #define to_dss_driver(x) container_of((x), struct omap_dss_driver, driver)
 #define to_dss_device(x) container_of((x), struct omap_dss_device, dev)
 
-- 
1.7.10.4

