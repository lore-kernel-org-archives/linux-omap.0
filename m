From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 6/8] ARM: OMAP: Add platform data header for DMTIMERs
Date: Tue, 13 Nov 2012 12:13:21 -0600
Message-ID: <1352830403-1706-7-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57231 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261Ab2KMSNl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 13:13:41 -0500
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Move definition of dmtimer platform data structure in to its own header
under <linux/platform_data>.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap1/timer.c                |    1 +
 arch/arm/mach-omap2/timer.c                |    2 ++
 arch/arm/plat-omap/dmtimer.c               |    2 ++
 arch/arm/plat-omap/include/plat/dmtimer.h  |    8 -------
 include/linux/platform_data/dmtimer-omap.h |   31 ++++++++++++++++++++++++++++
 5 files changed, 36 insertions(+), 8 deletions(-)
 create mode 100644 include/linux/platform_data/dmtimer-omap.h

diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
index cdeb9d3..bde7a35 100644
--- a/arch/arm/mach-omap1/timer.c
+++ b/arch/arm/mach-omap1/timer.c
@@ -25,6 +25,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
+#include <linux/platform_data/dmtimer-omap.h>
 
 #include <mach/irqs.h>
 
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 1a662df..4daa8b4 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -39,6 +39,8 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/dmtimer-omap.h>
 
 #include <asm/mach/time.h>
 #include <asm/smp_twd.h>
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index efe4774..89585c2 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -43,6 +43,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/platform_data/dmtimer-omap.h>
 
 #include <plat/dmtimer.h>
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index b3cd91b..a3fbc48 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -124,14 +124,6 @@ struct omap_dm_timer {
 	struct list_head node;
 };
 
-struct dmtimer_platform_data {
-	/* set_timer_src - Only used for OMAP1 devices */
-	int (*set_timer_src)(struct platform_device *pdev, int source);
-	u32 timer_errata;
-	u32 timer_capability;
-	int (*get_context_loss_count)(struct device *);
-};
-
 int omap_dm_timer_reserve_systimer(int id);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
new file mode 100644
index 0000000..a19b78d
--- /dev/null
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -0,0 +1,31 @@
+/*
+ * DMTIMER platform data for TI OMAP platforms
+ *
+ * Copyright (C) 2012 Texas Instruments
+ * Author: Jon Hunter <jon-hunter@ti.com>
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
+#ifndef __PLATFORM_DATA_DMTIMER_OMAP_H__
+#define __PLATFORM_DATA_DMTIMER_OMAP_H__
+
+struct dmtimer_platform_data {
+	/* set_timer_src - Only used for OMAP1 devices */
+	int (*set_timer_src)(struct platform_device *pdev, int source);
+	u32 timer_capability;
+	u32 timer_errata;
+	int (*get_context_loss_count)(struct device *);
+};
+
+#endif /* __PLATFORM_DATA_DMTIMER_OMAP_H__ */
-- 
1.7.9.5

