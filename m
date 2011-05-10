From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/8] OMAP: DSS2: RFBI: add rfbi_bus_lock
Date: Tue, 10 May 2011 19:24:11 +0300
Message-ID: <1305044656-31512-4-git-send-email-tomi.valkeinen@ti.com>
References: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:57493 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932972Ab1EJQYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 12:24:34 -0400
In-Reply-To: <1305044656-31512-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Add similar bus lock to RFBI as is in DSI. The panel driver can use the
bus lock to mark that the RFBI bus is currently in use.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    2 ++
 drivers/video/omap2/dss/rfbi.c            |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index bd0f08e..e6629eb 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -214,6 +214,8 @@ int omap_rfbi_enable_te(bool enable, unsigned line);
 int omap_rfbi_setup_te(enum omap_rfbi_te_mode mode,
 			     unsigned hs_pulse_time, unsigned vs_pulse_time,
 			     int hs_pol_inv, int vs_pol_inv, int extif_div);
+void rfbi_bus_lock(void);
+void rfbi_bus_unlock(void);
 
 /* DSI */
 void dsi_bus_lock(void);
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 5ea17f4..b669071 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -32,6 +32,7 @@
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
 #include <linux/seq_file.h>
+#include <linux/semaphore.h>
 
 #include <plat/display.h>
 #include "dss.h"
@@ -119,6 +120,8 @@ static struct {
 	struct completion cmd_done;
 	atomic_t          cmd_fifo_full;
 	atomic_t          cmd_pending;
+
+	struct semaphore bus_lock;
 } rfbi;
 
 struct update_region {
@@ -146,6 +149,18 @@ static void rfbi_enable_clocks(bool enable)
 		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
+void rfbi_bus_lock(void)
+{
+	down(&rfbi.bus_lock);
+}
+EXPORT_SYMBOL(rfbi_bus_lock);
+
+void rfbi_bus_unlock(void)
+{
+	up(&rfbi.bus_lock);
+}
+EXPORT_SYMBOL(rfbi_bus_unlock);
+
 void omap_rfbi_write_command(const void *buf, u32 len)
 {
 	rfbi_enable_clocks(1);
@@ -1022,6 +1037,7 @@ static int omap_rfbihw_probe(struct platform_device *pdev)
 	rfbi.pdev = pdev;
 
 	spin_lock_init(&rfbi.cmd_lock);
+	sema_init(&rfbi.bus_lock, 1);
 
 	init_completion(&rfbi.cmd_done);
 	atomic_set(&rfbi.cmd_fifo_full, 0);
-- 
1.7.4.1

