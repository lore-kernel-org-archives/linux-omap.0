From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 8/17] dmtimer: register mappings moved to hwmod database
Date: Tue, 21 Sep 2010 14:23:46 +0530
Message-ID: <1285059226-26491-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175Ab0ITVwx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:52:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch adds dmtimer register mappings to hwmod database.
This is to avoid maintaining different several mappings within
the omap-plat. The mapping is made available to platform through
dev_attr during device build. The pointer to register map is
preserved in the platform data.

Please note that the cleanup of register map from plat-omap will
be removed in later patch after conversion to platform driver.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   25 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   25 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   25 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   67 ++++++++++++++++++++++++---
 arch/arm/plat-omap/dmtimer.c               |   13 -----
 arch/arm/plat-omap/include/plat/dmtimer.h  |   38 ++++++++++++++++
 6 files changed, 172 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 6003c2e..b3dd8ac 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -131,8 +131,33 @@ static char *timer_clk_src_names[] = {
 	NULL,
 };
 
+/* OMAP2/3 timers register map */
+static u32 omap_timer_reg_map_v1[] = {
+	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | (WP_TOCR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | (WP_TOWR << WPSHIFT)),
+};
+
 static struct omap_timer_dev_attr timer_dev_attr = {
 	.clk_names	= timer_clk_src_names,
+	.reg_map	= omap_timer_reg_map_v1,
 };
 
 static struct omap_hwmod_class_sysconfig omap2420_timer_sysc = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 4b43fb9..787d3ce 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -137,8 +137,33 @@ static char *timer_clk_src_names[] = {
 	NULL
 };
 
+/* OMAP2/3 timers register map */
+static u32 omap_timer_reg_map_v1[] = {
+	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | (WP_TOCR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | (WP_TOWR << WPSHIFT)),
+};
+
 static struct omap_timer_dev_attr timer_dev_attr = {
 	.clk_names	= timer_clk_src_names,
+	.reg_map	= omap_timer_reg_map_v1,
 };
 
 static struct omap_hwmod_class_sysconfig omap2430_timer_sysc = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 70446d7..e477ce8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -109,8 +109,33 @@ static char *timer_clk_src_names[] = {
 	NULL,
 };
 
+/* OMAP2/3 timers register map */
+static u32 omap_timer_reg_map_v1[] = {
+	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | (WP_TOCR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | (WP_TOWR << WPSHIFT)),
+};
+
 static struct omap_timer_dev_attr timer_dev_attr = {
 	.clk_names	= timer_clk_src_names,
+	.reg_map	= omap_timer_reg_map_v1,
 };
 
 /* timer class */
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 7c68228..1f60f8a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -471,12 +471,63 @@ static char *timer_clk_src_names_abe[] = {
 	NULL,
 };
 
-static struct omap_timer_dev_attr timer_dev_attr = {
+/* OMAP2/3 timers register map */
+static u32 omap_timer_reg_map_v1[] = {
+	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]           = (0x18 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]         = (0x1c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x20 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]           = (0x24 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]        = (0x28 | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]           = (0x2c | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]        = (0x30 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]     = (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]          = (0x38 | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]        = (0x3c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]        = (0x40 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]       = (0x44 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_TICK_POS_REG]       = (0x48 | (WP_TPIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_NEG_REG]       = (0x4c | (WP_TNIR << WPSHIFT)),
+	[OMAP_TIMER_TICK_COUNT_REG]     = (0x50 | (WP_TCVR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_SET_REG]      = (0x54 | (WP_TOCR << WPSHIFT)),
+	[OMAP_TIMER_TICK_INT_MASK_COUNT_REG]    = (0x58 | (WP_TOWR << WPSHIFT)),
+};
+
+/* OMAP4 timers register map */
+static u32 omap_timer_reg_map_v2[] = {
+	[OMAP_TIMER_ID_REG]             = (0x00 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_OCP_CFG_REG]        = (0x10 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_SYS_STAT_REG]       = (0x14 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_STAT_REG]           = (0x28 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_EN_REG]         = (0x2c | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_WAKEUP_EN_REG]      = (0x34 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CTRL_REG]           = (0x38 | (WP_TCLR << WPSHIFT)),
+	[OMAP_TIMER_COUNTER_REG]        = (0x3c | (WP_TCRR << WPSHIFT)),
+	[OMAP_TIMER_LOAD_REG]           = (0x40 | (WP_TLDR << WPSHIFT)),
+	[OMAP_TIMER_TRIGGER_REG]        = (0x44 | (WP_TTGR << WPSHIFT)),
+	[OMAP_TIMER_WRITE_PEND_REG]     = (0x48 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_MATCH_REG]          = (0x4c | (WP_TMAR << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE_REG]        = (0x50 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_IF_CTRL_REG]        = (0x54 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_CAPTURE2_REG]       = (0x58 | (WP_NONE << WPSHIFT)),
+	[OMAP_TIMER_INT_CLR_REG]        = (0x30 | (WP_NONE << WPSHIFT)),
+};
+
+static struct omap_timer_dev_attr timer_dev_attr_v1 = {
+	.clk_names      = timer_clk_src_names,
+	.reg_map        = omap_timer_reg_map_v1,
+};
+
+static struct omap_timer_dev_attr timer_dev_attr_v2 = {
 	.clk_names	= timer_clk_src_names,
+	.reg_map	= omap_timer_reg_map_v2,
 };
 
 static struct omap_timer_dev_attr timer_dev_attr_abe = {
 	.clk_names	= timer_clk_src_names_abe,
+	.reg_map	= omap_timer_reg_map_v2,
 };
 
 static struct omap_hwmod_class_sysconfig omap44xx_timer_1ms_sysc = {
@@ -558,7 +609,7 @@ static struct omap_hwmod omap44xx_timer1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_WKUP_TIMER1_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v1,
 	.slaves		= omap44xx_timer1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -604,7 +655,7 @@ static struct omap_hwmod omap44xx_timer2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER2_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v1,
 	.slaves		= omap44xx_timer2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -650,7 +701,7 @@ static struct omap_hwmod omap44xx_timer3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER3_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v2,
 	.slaves		= omap44xx_timer3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -696,7 +747,7 @@ static struct omap_hwmod omap44xx_timer4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER4_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v2,
 	.slaves		= omap44xx_timer4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1002,7 +1053,7 @@ static struct omap_hwmod omap44xx_timer9_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER9_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v2,
 	.slaves		= omap44xx_timer9_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer9_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1048,7 +1099,7 @@ static struct omap_hwmod omap44xx_timer10_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER10_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v1,
 	.slaves		= omap44xx_timer10_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer10_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1094,7 +1145,7 @@ static struct omap_hwmod omap44xx_timer11_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_DMTIMER11_CLKCTRL,
 		},
 	},
-	.dev_attr	= &timer_dev_attr,
+	.dev_attr	= &timer_dev_attr_v2,
 	.slaves		= omap44xx_timer11_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_timer11_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 2d4805d..9a22623 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -72,17 +72,6 @@
 #define _OMAP_TIMER_LOAD_OFFSET		0x2c
 #define _OMAP_TIMER_TRIGGER_OFFSET	0x30
 #define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
-#define		WP_NONE			0	/* no write pending bit */
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
 #define _OMAP_TIMER_MATCH_OFFSET	0x38
 #define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
 #define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
@@ -93,8 +82,6 @@
 #define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
 #define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
 
-/* register offsets with the write pending bit encoded */
-#define	WPSHIFT					16
 
 #define OMAP_TIMER_ID_REG			(_OMAP_TIMER_ID_OFFSET \
 							| (WP_NONE << WPSHIFT))
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 3ec17c5..d983ae3 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -58,6 +58,44 @@
  */
 #define NR_CLK_SOURCES			3
 
+/* register offsets with the write pending bit encoded */
+#define         WPSHIFT                 16
+
+#define         WP_NONE                 0       /* no write pending bit */
+#define         WP_TCLR                 BIT(0)
+#define         WP_TCRR                 BIT(1)
+#define         WP_TLDR                 BIT(2)
+#define         WP_TTGR                 BIT(3)
+#define         WP_TMAR                 BIT(4)
+#define         WP_TPIR                 BIT(5)
+#define         WP_TNIR                 BIT(6)
+#define         WP_TCVR                 BIT(7)
+#define         WP_TOCR                 BIT(8)
+#define         WP_TOWR                 BIT(9)
+
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
 
 /**
  * omap_timer_dev_attr - timer device attribute
-- 
1.6.0.4

