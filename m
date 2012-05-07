From: Archit Taneja <archit@ti.com>
Subject: [PATCH 6/6] OMAPDSS: DISPC: Remove Fake VSYNC support
Date: Mon, 7 May 2012 16:51:36 +0530
Message-ID: <1336389696-21636-7-git-send-email-archit@ti.com>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46613 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755567Ab2EGLWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 May 2012 07:22:45 -0400
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Fake VSYNC support is a hack and has some bugs in it. It isn't used by any user
of DSS. Remove Fake VSYNC support. For DSI command mode and RFBI panels, a user
of DSS should wait for the completion of a frame by using the panel driver's
sync op.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/Kconfig |    9 ---------
 drivers/video/omap2/dss/dispc.c |   21 ---------------------
 drivers/video/omap2/dss/dsi.c   |    4 ----
 drivers/video/omap2/dss/dss.h   |    1 -
 4 files changed, 0 insertions(+), 35 deletions(-)

diff --git a/drivers/video/omap2/dss/Kconfig b/drivers/video/omap2/dss/Kconfig
index 7be7c06..9aaf324 100644
--- a/drivers/video/omap2/dss/Kconfig
+++ b/drivers/video/omap2/dss/Kconfig
@@ -90,15 +90,6 @@ config OMAP2_DSS_DSI
 
 	  See http://www.mipi.org/ for DSI spesifications.
 
-config OMAP2_DSS_FAKE_VSYNC
-	bool "Fake VSYNC irq from manual update displays"
-	default n
-	help
-	  If this is selected, DSI will generate a fake DISPC VSYNC interrupt
-	  when DSI has sent a frame. This is only needed with DSI or RFBI
-	  displays using manual mode, and you want VSYNC to, for example,
-	  time animation.
-
 config OMAP2_DSS_MIN_FCK_PER_PCK
 	int "Minimum FCK/PCK ratio (for scaling)"
 	range 0 32
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ef131cd..89d54c5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3443,27 +3443,6 @@ int omap_dispc_wait_for_irq_interruptible_timeout(u32 irqmask,
 	return 0;
 }
 
-#ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
-void dispc_fake_vsync_irq(void)
-{
-	u32 irqstatus = DISPC_IRQ_VSYNC;
-	int i;
-
-	WARN_ON(!in_interrupt());
-
-	for (i = 0; i < DISPC_MAX_NR_ISRS; i++) {
-		struct omap_dispc_isr_data *isr_data;
-		isr_data = &dispc.registered_isr[i];
-
-		if (!isr_data->isr)
-			continue;
-
-		if (isr_data->mask & irqstatus)
-			isr_data->isr(isr_data->arg, irqstatus);
-	}
-}
-#endif
-
 static void _omap_dispc_initialize_irq(void)
 {
 	unsigned long flags;
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index db73598..95bc996 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -4152,10 +4152,6 @@ static void dsi_framedone_irq_callback(void *data, u32 mask)
 	__cancel_delayed_work(&dsi->framedone_timeout_work);
 
 	dsi_handle_framedone(dsidev, 0);
-
-#ifdef CONFIG_OMAP2_DSS_FAKE_VSYNC
-	dispc_fake_vsync_irq();
-#endif
 }
 
 int omap_dsi_update(struct omap_dss_device *dssdev, int channel,
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index f2a51c6..6699197 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -399,7 +399,6 @@ void dispc_dump_clocks(struct seq_file *s);
 void dispc_dump_irqs(struct seq_file *s);
 void dispc_dump_regs(struct seq_file *s);
 void dispc_irq_handler(void);
-void dispc_fake_vsync_irq(void);
 
 int dispc_runtime_get(void);
 void dispc_runtime_put(void);
-- 
1.7.5.4

