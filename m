From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/32] OMAPDSS: move blocking mgr enable/disable to compat layer
Date: Thu, 15 Nov 2012 17:58:30 +0200
Message-ID: <1352995120-3288-23-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50129 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768251Ab2KOP7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:46 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

dispc_mgr_enable_sync and dispc_mgr_disable_sync are only used with the
compat mode. Non-compat will use the simpler enable and disable
functions.

This patch moves the synchronous enable/disable code to the compat
layer. A new file is created, dispc-compat.c, which contains low level
dispc compat code (versus apply.c, which contains slightly higher level
compat code).

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/Makefile       |    2 +-
 drivers/video/omap2/dss/apply.c        |    1 +
 drivers/video/omap2/dss/dispc-compat.c |  207 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dispc-compat.h |   24 ++++
 drivers/video/omap2/dss/dispc.c        |  175 ---------------------------
 drivers/video/omap2/dss/dss.h          |    2 -
 6 files changed, 233 insertions(+), 178 deletions(-)
 create mode 100644 drivers/video/omap2/dss/dispc-compat.c
 create mode 100644 drivers/video/omap2/dss/dispc-compat.h

diff --git a/drivers/video/omap2/dss/Makefile b/drivers/video/omap2/dss/Makefile
index af866d0..c834f9c 100644
--- a/drivers/video/omap2/dss/Makefile
+++ b/drivers/video/omap2/dss/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_OMAP2_DSS) += omapdss.o
 omapdss-y := core.o dss.o dss_features.o dispc.o dispc_coefs.o display.o \
 	manager.o manager-sysfs.o overlay.o overlay-sysfs.o output.o apply.o \
-	display-sysfs.o
+	display-sysfs.o dispc-compat.o
 omapdss-$(CONFIG_OMAP2_DSS_DPI) += dpi.o
 omapdss-$(CONFIG_OMAP2_DSS_RFBI) += rfbi.o
 omapdss-$(CONFIG_OMAP2_DSS_VENC) += venc.o venc_panel.o
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index f10e0b4..45d837f 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -27,6 +27,7 @@
 
 #include "dss.h"
 #include "dss_features.h"
+#include "dispc-compat.h"
 
 /*
  * We have 4 levels of cache for the dispc settings. First two are in SW and
diff --git a/drivers/video/omap2/dss/dispc-compat.c b/drivers/video/omap2/dss/dispc-compat.c
new file mode 100644
index 0000000..cca3848
--- /dev/null
+++ b/drivers/video/omap2/dss/dispc-compat.c
@@ -0,0 +1,207 @@
+/*
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#define DSS_SUBSYS_NAME "APPLY"
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/jiffies.h>
+#include <linux/delay.h>
+
+#include <video/omapdss.h>
+
+#include "dss.h"
+#include "dss_features.h"
+#include "dispc-compat.h"
+
+static void dispc_mgr_disable_isr(void *data, u32 mask)
+{
+	struct completion *compl = data;
+	complete(compl);
+}
+
+static void dispc_mgr_enable_lcd_out(enum omap_channel channel)
+{
+	dispc_mgr_enable(channel, true);
+}
+
+static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
+{
+	DECLARE_COMPLETION_ONSTACK(framedone_compl);
+	int r;
+	u32 irq;
+
+	if (dispc_mgr_is_enabled(channel) == false)
+		return;
+
+	/*
+	 * When we disable LCD output, we need to wait for FRAMEDONE to know
+	 * that DISPC has finished with the LCD output.
+	 */
+
+	irq = dispc_mgr_get_framedone_irq(channel);
+
+	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
+			irq);
+	if (r)
+		DSSERR("failed to register FRAMEDONE isr\n");
+
+	dispc_mgr_enable(channel, false);
+
+	/* if we couldn't register for framedone, just sleep and exit */
+	if (r) {
+		msleep(100);
+		return;
+	}
+
+	if (!wait_for_completion_timeout(&framedone_compl,
+				msecs_to_jiffies(100)))
+		DSSERR("timeout waiting for FRAME DONE\n");
+
+	r = omap_dispc_unregister_isr(dispc_mgr_disable_isr, &framedone_compl,
+			irq);
+	if (r)
+		DSSERR("failed to unregister FRAMEDONE isr\n");
+}
+
+static void dispc_digit_out_enable_isr(void *data, u32 mask)
+{
+	struct completion *compl = data;
+
+	/* ignore any sync lost interrupts */
+	if (mask & (DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD))
+		complete(compl);
+}
+
+static void dispc_mgr_enable_digit_out(void)
+{
+	DECLARE_COMPLETION_ONSTACK(vsync_compl);
+	int r;
+	u32 irq_mask;
+
+	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == true)
+		return;
+
+	/*
+	 * Digit output produces some sync lost interrupts during the first
+	 * frame when enabling. Those need to be ignored, so we register for the
+	 * sync lost irq to prevent the error handler from triggering.
+	 */
+
+	irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT) |
+		dispc_mgr_get_sync_lost_irq(OMAP_DSS_CHANNEL_DIGIT);
+
+	r = omap_dispc_register_isr(dispc_digit_out_enable_isr, &vsync_compl,
+			irq_mask);
+	if (r) {
+		DSSERR("failed to register %x isr\n", irq_mask);
+		return;
+	}
+
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, true);
+
+	/* wait for the first evsync */
+	if (!wait_for_completion_timeout(&vsync_compl, msecs_to_jiffies(100)))
+		DSSERR("timeout waiting for digit out to start\n");
+
+	r = omap_dispc_unregister_isr(dispc_digit_out_enable_isr, &vsync_compl,
+			irq_mask);
+	if (r)
+		DSSERR("failed to unregister %x isr\n", irq_mask);
+}
+
+static void dispc_mgr_disable_digit_out(void)
+{
+	DECLARE_COMPLETION_ONSTACK(framedone_compl);
+	int r, i;
+	u32 irq_mask;
+	int num_irqs;
+
+	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == false)
+		return;
+
+	/*
+	 * When we disable the digit output, we need to wait for FRAMEDONE to
+	 * know that DISPC has finished with the output.
+	 */
+
+	irq_mask = dispc_mgr_get_framedone_irq(OMAP_DSS_CHANNEL_DIGIT);
+	num_irqs = 1;
+
+	if (!irq_mask) {
+		/*
+		 * omap 2/3 don't have framedone irq for TV, so we need to use
+		 * vsyncs for this.
+		 */
+
+		irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT);
+		/*
+		 * We need to wait for both even and odd vsyncs. Note that this
+		 * is not totally reliable, as we could get a vsync interrupt
+		 * before we disable the output, which leads to timeout in the
+		 * wait_for_completion.
+		 */
+		num_irqs = 2;
+	}
+
+	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
+			irq_mask);
+	if (r)
+		DSSERR("failed to register %x isr\n", irq_mask);
+
+	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, false);
+
+	/* if we couldn't register the irq, just sleep and exit */
+	if (r) {
+		msleep(100);
+		return;
+	}
+
+	for (i = 0; i < num_irqs; ++i) {
+		if (!wait_for_completion_timeout(&framedone_compl,
+					msecs_to_jiffies(100)))
+			DSSERR("timeout waiting for digit out to stop\n");
+	}
+
+	r = omap_dispc_unregister_isr(dispc_mgr_disable_isr, &framedone_compl,
+			irq_mask);
+	if (r)
+		DSSERR("failed to unregister %x isr\n", irq_mask);
+}
+
+void dispc_mgr_enable_sync(enum omap_channel channel)
+{
+	if (dss_mgr_is_lcd(channel))
+		dispc_mgr_enable_lcd_out(channel);
+	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
+		dispc_mgr_enable_digit_out();
+	else
+		WARN_ON(1);
+}
+
+void dispc_mgr_disable_sync(enum omap_channel channel)
+{
+	if (dss_mgr_is_lcd(channel))
+		dispc_mgr_disable_lcd_out(channel);
+	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
+		dispc_mgr_disable_digit_out();
+	else
+		WARN_ON(1);
+}
+
diff --git a/drivers/video/omap2/dss/dispc-compat.h b/drivers/video/omap2/dss/dispc-compat.h
new file mode 100644
index 0000000..2d4f5e7
--- /dev/null
+++ b/drivers/video/omap2/dss/dispc-compat.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef __OMAP2_DSS_DISPC_COMPAT_H
+#define __OMAP2_DSS_DISPC_COMPAT_H
+
+void dispc_mgr_enable_sync(enum omap_channel channel);
+void dispc_mgr_disable_sync(enum omap_channel channel);
+
+#endif
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index f30cdfc..3a1224f 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2593,12 +2593,6 @@ bool dispc_ovl_enabled(enum omap_plane plane)
 	return REG_GET(DISPC_OVL_ATTRIBUTES(plane), 0, 0);
 }
 
-static void dispc_mgr_disable_isr(void *data, u32 mask)
-{
-	struct completion *compl = data;
-	complete(compl);
-}
-
 void dispc_mgr_enable(enum omap_channel channel, bool enable)
 {
 	mgr_fld_write(channel, DISPC_MGR_FLD_ENABLE, enable);
@@ -2611,175 +2605,6 @@ bool dispc_mgr_is_enabled(enum omap_channel channel)
 	return !!mgr_fld_read(channel, DISPC_MGR_FLD_ENABLE);
 }
 
-static void dispc_mgr_enable_lcd_out(enum omap_channel channel)
-{
-	dispc_mgr_enable(channel, true);
-}
-
-static void dispc_mgr_disable_lcd_out(enum omap_channel channel)
-{
-	DECLARE_COMPLETION_ONSTACK(framedone_compl);
-	int r;
-	u32 irq;
-
-	if (dispc_mgr_is_enabled(channel) == false)
-		return;
-
-	/*
-	 * When we disable LCD output, we need to wait for FRAMEDONE to know
-	 * that DISPC has finished with the LCD output.
-	 */
-
-	irq = dispc_mgr_get_framedone_irq(channel);
-
-	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
-			irq);
-	if (r)
-		DSSERR("failed to register FRAMEDONE isr\n");
-
-	dispc_mgr_enable(channel, false);
-
-	/* if we couldn't register for framedone, just sleep and exit */
-	if (r) {
-		msleep(100);
-		return;
-	}
-
-	if (!wait_for_completion_timeout(&framedone_compl,
-				msecs_to_jiffies(100)))
-		DSSERR("timeout waiting for FRAME DONE\n");
-
-	r = omap_dispc_unregister_isr(dispc_mgr_disable_isr, &framedone_compl,
-			irq);
-	if (r)
-		DSSERR("failed to unregister FRAMEDONE isr\n");
-}
-
-static void dispc_digit_out_enable_isr(void *data, u32 mask)
-{
-	struct completion *compl = data;
-
-	/* ignore any sync lost interrupts */
-	if (mask & (DISPC_IRQ_EVSYNC_EVEN | DISPC_IRQ_EVSYNC_ODD))
-		complete(compl);
-}
-
-static void dispc_mgr_enable_digit_out(void)
-{
-	DECLARE_COMPLETION_ONSTACK(vsync_compl);
-	int r;
-	u32 irq_mask;
-
-	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == true)
-		return;
-
-	/*
-	 * Digit output produces some sync lost interrupts during the first
-	 * frame when enabling. Those need to be ignored, so we register for the
-	 * sync lost irq to prevent the error handler from triggering.
-	 */
-
-	irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT) |
-		dispc_mgr_get_sync_lost_irq(OMAP_DSS_CHANNEL_DIGIT);
-
-	r = omap_dispc_register_isr(dispc_digit_out_enable_isr, &vsync_compl,
-			irq_mask);
-	if (r) {
-		DSSERR("failed to register %x isr\n", irq_mask);
-		return;
-	}
-
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, true);
-
-	/* wait for the first evsync */
-	if (!wait_for_completion_timeout(&vsync_compl, msecs_to_jiffies(100)))
-		DSSERR("timeout waiting for digit out to start\n");
-
-	r = omap_dispc_unregister_isr(dispc_digit_out_enable_isr, &vsync_compl,
-			irq_mask);
-	if (r)
-		DSSERR("failed to unregister %x isr\n", irq_mask);
-}
-
-static void dispc_mgr_disable_digit_out(void)
-{
-	DECLARE_COMPLETION_ONSTACK(framedone_compl);
-	int r, i;
-	u32 irq_mask;
-	int num_irqs;
-
-	if (dispc_mgr_is_enabled(OMAP_DSS_CHANNEL_DIGIT) == false)
-		return;
-
-	/*
-	 * When we disable the digit output, we need to wait for FRAMEDONE to
-	 * know that DISPC has finished with the output.
-	 */
-
-	irq_mask = dispc_mgr_get_framedone_irq(OMAP_DSS_CHANNEL_DIGIT);
-	num_irqs = 1;
-
-	if (!irq_mask) {
-		/*
-		 * omap 2/3 don't have framedone irq for TV, so we need to use
-		 * vsyncs for this.
-		 */
-
-		irq_mask = dispc_mgr_get_vsync_irq(OMAP_DSS_CHANNEL_DIGIT);
-		/*
-		 * We need to wait for both even and odd vsyncs. Note that this
-		 * is not totally reliable, as we could get a vsync interrupt
-		 * before we disable the output, which leads to timeout in the
-		 * wait_for_completion.
-		 */
-		num_irqs = 2;
-	}
-
-	r = omap_dispc_register_isr(dispc_mgr_disable_isr, &framedone_compl,
-			irq_mask);
-	if (r)
-		DSSERR("failed to register %x isr\n", irq_mask);
-
-	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, false);
-
-	/* if we couldn't register the irq, just sleep and exit */
-	if (r) {
-		msleep(100);
-		return;
-	}
-
-	for (i = 0; i < num_irqs; ++i) {
-		if (!wait_for_completion_timeout(&framedone_compl,
-					msecs_to_jiffies(100)))
-			DSSERR("timeout waiting for digit out to stop\n");
-	}
-
-	r = omap_dispc_unregister_isr(dispc_mgr_disable_isr, &framedone_compl,
-			irq_mask);
-	if (r)
-		DSSERR("failed to unregister %x isr\n", irq_mask);
-}
-
-void dispc_mgr_enable_sync(enum omap_channel channel)
-{
-	if (dss_mgr_is_lcd(channel))
-		dispc_mgr_enable_lcd_out(channel);
-	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		dispc_mgr_enable_digit_out();
-	else
-		WARN_ON(1);
-}
-
-void dispc_mgr_disable_sync(enum omap_channel channel)
-{
-	if (dss_mgr_is_lcd(channel))
-		dispc_mgr_disable_lcd_out(channel);
-	else if (channel == OMAP_DSS_CHANNEL_DIGIT)
-		dispc_mgr_disable_digit_out();
-	else
-		WARN_ON(1);
-}
-
 void dispc_wb_enable(bool enable)
 {
 	dispc_ovl_enable(OMAP_DSS_WB, enable);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8ec411d..10995d3 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -426,8 +426,6 @@ bool dispc_mgr_go_busy(enum omap_channel channel);
 void dispc_mgr_go(enum omap_channel channel);
 void dispc_mgr_enable(enum omap_channel channel, bool enable);
 bool dispc_mgr_is_enabled(enum omap_channel channel);
-void dispc_mgr_enable_sync(enum omap_channel channel);
-void dispc_mgr_disable_sync(enum omap_channel channel);
 void dispc_mgr_set_lcd_config(enum omap_channel channel,
 		const struct dss_lcd_mgr_config *config);
 void dispc_mgr_set_timings(enum omap_channel channel,
-- 
1.7.10.4

