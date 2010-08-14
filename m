From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 7/13] dmtimer: OMAP: multi-platform register map definitions
Date: Sat, 14 Aug 2010 21:06:34 +0530
Message-ID: <1281800194-15110-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52829 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932562Ab0HNEhU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Aug 2010 00:37:20 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Thara Gopinath <thara@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch introduces new structures and mappings of registers
so that it is expandable to support multiple omap platforms.
The present modification is intended to support OMAP4 and previous
platforms without minimal changes to the accessing code by
suitably mapping of specific register maps.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |  185 ++++++++++++++++++++----------------------
 1 files changed, 87 insertions(+), 98 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 0915a37..14a20e0 100755
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -51,114 +51,103 @@
 #include <mach/irqs.h>
 #include <linux/interrupt.h>
 
-/* register offsets */
-#define _OMAP_TIMER_ID_OFFSET		0x00
-#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
-#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
-#define _OMAP_TIMER_STAT_OFFSET		0x18
-#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
-#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
-#define _OMAP_TIMER_CTRL_OFFSET		0x24
-#define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
-#define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
-#define		OMAP_TIMER_CTRL_PT		(1 << 12)
-#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	(0x1 << 8)
-#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	(0x2 << 8)
+#define		OMAP_TIMER_CTRL_GPOCFG		BIT(14)
+#define		OMAP_TIMER_CTRL_CAPTMODE	BIT(13)
+#define		OMAP_TIMER_CTRL_PT		BIT(12)
+#define		OMAP_TIMER_CTRL_TCM_LOWTOHIGH	BIT(8)
+#define		OMAP_TIMER_CTRL_TCM_HIGHTOLOW	BIT(9)
 #define		OMAP_TIMER_CTRL_TCM_BOTHEDGES	(0x3 << 8)
-#define		OMAP_TIMER_CTRL_SCPWM		(1 << 7)
-#define		OMAP_TIMER_CTRL_CE		(1 << 6) /* compare enable */
-#define		OMAP_TIMER_CTRL_PRE		(1 << 5) /* prescaler enable */
+#define		OMAP_TIMER_CTRL_SCPWM		BIT(7)
+#define		OMAP_TIMER_CTRL_CE		BIT(6) /* compare enable */
+#define		OMAP_TIMER_CTRL_PRE		BIT(5) /* prescaler enable */
 #define		OMAP_TIMER_CTRL_PTV_SHIFT	2 /* prescaler value shift */
-#define		OMAP_TIMER_CTRL_POSTED		(1 << 2)
-#define		OMAP_TIMER_CTRL_AR		(1 << 1) /* auto-reload enable */
-#define		OMAP_TIMER_CTRL_ST		(1 << 0) /* start timer */
-#define _OMAP_TIMER_COUNTER_OFFSET	0x28
-#define _OMAP_TIMER_LOAD_OFFSET		0x2c
-#define _OMAP_TIMER_TRIGGER_OFFSET	0x30
-#define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
+#define		OMAP_TIMER_CTRL_POSTED		BIT(2)
+#define		OMAP_TIMER_CTRL_AR		BIT(1) /* auto-reload enable */
+#define		OMAP_TIMER_CTRL_ST		BIT(0) /* start timer */
+
 #define		WP_NONE			0	/* no write pending bit */
-#define		WP_TCLR			(1 << 0)
-#define		WP_TCRR			(1 << 1)
-#define		WP_TLDR			(1 << 2)
-#define		WP_TTGR			(1 << 3)
-#define		WP_TMAR			(1 << 4)
-#define		WP_TPIR			(1 << 5)
-#define		WP_TNIR			(1 << 6)
-#define		WP_TCVR			(1 << 7)
-#define		WP_TOCR			(1 << 8)
-#define		WP_TOWR			(1 << 9)
-#define _OMAP_TIMER_MATCH_OFFSET	0x38
-#define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
-#define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
-#define _OMAP_TIMER_CAPTURE2_OFFSET		0x44	/* TCAR2, 34xx only */
-#define _OMAP_TIMER_TICK_POS_OFFSET		0x48	/* TPIR, 34xx only */
-#define _OMAP_TIMER_TICK_NEG_OFFSET		0x4c	/* TNIR, 34xx only */
-#define _OMAP_TIMER_TICK_COUNT_OFFSET		0x50	/* TCVR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
+#define		WP_TCLR			BIT(0)
+#define		WP_TCRR			BIT(1)
+#define		WP_TLDR			BIT(2)
+#define		WP_TTGR			BIT(3)
+#define		WP_TMAR			BIT(4)
+#define		WP_TPIR			BIT(5)
+#define		WP_TNIR			BIT(6)
+#define		WP_TCVR			BIT(7)
+#define		WP_TOCR			BIT(8)
+#define		WP_TOWR			BIT(9)
 
 /* register offsets with the write pending bit encoded */
 #define	WPSHIFT					16
 
-#define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_OCP_CFG_REG			(_OMAP_TIMER_OCP_CFG_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_SYS_STAT_REG			(_OMAP_TIMER_SYS_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_STAT_REG			(_OMAP_TIMER_STAT_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_INT_EN_REG			(_OMAP_TIMER_INT_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_WAKEUP_EN_REG		(_OMAP_TIMER_WAKEUP_EN_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CTRL_REG			(_OMAP_TIMER_CTRL_OFFSET \
-							| (WP_TCLR << WPSHIFT))
-
-#define OMAP_TIMER_COUNTER_REG			(_OMAP_TIMER_COUNTER_OFFSET \
-							| (WP_TCRR << WPSHIFT))
-
-#define OMAP_TIMER_LOAD_REG			(_OMAP_TIMER_LOAD_OFFSET \
-							| (WP_TLDR << WPSHIFT))
-
-#define OMAP_TIMER_TRIGGER_REG			(_OMAP_TIMER_TRIGGER_OFFSET \
-							| (WP_TTGR << WPSHIFT))
-
-#define OMAP_TIMER_WRITE_PEND_REG		(_OMAP_TIMER_WRITE_PEND_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_MATCH_REG			(_OMAP_TIMER_MATCH_OFFSET \
-							| (WP_TMAR << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE_REG			(_OMAP_TIMER_CAPTURE_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_IF_CTRL_REG			(_OMAP_TIMER_IF_CTRL_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_CAPTURE2_REG			(_OMAP_TIMER_CAPTURE2_OFFSET \
-							| (WP_NONE << WPSHIFT))
-
-#define OMAP_TIMER_TICK_POS_REG			(_OMAP_TIMER_TICK_POS_OFFSET \
-							| (WP_TPIR << WPSHIFT))
-
-#define OMAP_TIMER_TICK_NEG_REG			(_OMAP_TIMER_TICK_NEG_OFFSET \
-							| (WP_TNIR << WPSHIFT))
+enum {
+	OMAP_TIMER_ID_REG = 0,
+	OMAP_TIMER_OCP_CFG_REG,
+	OMAP_TIMER_SYS_STAT_REG,
+	OMAP_TIMER_STAT_REG,
+	OMAP_TIMER_INT_EN_REG,
+	OMAP_TIMER_WAKEUP_EN_REG,
+	OMAP_TIMER_CTRL_REG,
+	OMAP_TIMER_COUNTER_REG,
+	OMAP_TIMER_LOAD_REG,
+	OMAP_TIMER_TRIGGER_REG,
+	OMAP_TIMER_WRITE_PEND_REG,
+	OMAP_TIMER_MATCH_REG,
+	OMAP_TIMER_CAPTURE_REG,
+	OMAP_TIMER_IF_CTRL_REG,
+	OMAP_TIMER_CAPTURE2_REG,
+	OMAP_TIMER_TICK_POS_REG,
+	OMAP_TIMER_TICK_NEG_REG,
+	OMAP_TIMER_TICK_COUNT_REG,
+	OMAP_TIMER_TICK_INT_MASK_SET_REG,
+	OMAP_TIMER_TICK_INT_MASK_COUNT_REG,
+	OMAP_TIMER_INT_CLR_REG,
+};
 
-#define OMAP_TIMER_TICK_COUNT_REG		(_OMAP_TIMER_TICK_COUNT_OFFSET \
-							| (WP_TCVR << WPSHIFT))
+/* omap2xxx and omap3xxx timers register map */
+static const u32 reg_map[] = {
+	[OMAP_TIMER_ID_REG]		= (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]	= (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]	= (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]		= (0x18 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]		= (0x1c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]	= (0x20 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]		= (0x24 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]	= (0x28 | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]		= (0x2c | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]	= (0x30 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]	= (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]		= (0x38 | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]	= (0x3c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]	= (0x40 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]	= (0x44 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_TICK_POS_REG]	= (0x48 | (WP_TPIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_NEG_REG]	= (0x4c | (WP_TNIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_COUNT_REG]	= (0x50 | (WP_TCVR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_SET_REG]	= (0x54 | (WP_TOCR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]	= (0x58 | (WP_TOWR << WPSHIFT)),
+};
 
-#define OMAP_TIMER_TICK_INT_MASK_SET_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_SET_OFFSET | (WP_TOCR << WPSHIFT))
+/* omap4 timers register map */
+static const u32 omap4_reg_map[] = {
+	[OMAP_TIMER_ID_REG]		= (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]	= (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]	= (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]		= (0x28 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]		= (0x2c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]	= (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]		= (0x38 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]	= (0x3c | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]		= (0x40 | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]	= (0x44 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]	= (0x48 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]		= (0x4c | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]	= (0x50 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]	= (0x54 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]	= (0x58 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_CLR_REG]	= (0x30 | (WP_NONE << WPSHIFT)),
+};
 
-#define OMAP_TIMER_TICK_INT_MASK_COUNT_REG				\
-		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
 struct omap_dm_timer {
 	int id;
-- 
1.6.0.4

