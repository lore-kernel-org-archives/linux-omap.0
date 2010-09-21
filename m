From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCHv3 16/17] dmtimer: clean redundant code
Date: Tue, 21 Sep 2010 14:26:23 +0530
Message-ID: <1285059383-26693-1-git-send-email-tarun.kanti@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48546 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123Ab0ITVza (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Sep 2010 17:55:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>, Partha Basak <p-basak2@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>

This patch removes the code which are no longer needed
after conversion to platform driver and incorporation
of necessary changes in howmod database.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Signed-off-by: Partha Basak <p-basak2@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |  186 ------------------------------------------
 1 files changed, 0 insertions(+), 186 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 4f735d7..7d57605 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -50,14 +50,6 @@
 #include <mach/irqs.h>
 #include <linux/err.h>
 
-/* register offsets */
-#define _OMAP_TIMER_ID_OFFSET		0x00
-#define _OMAP_TIMER_OCP_CFG_OFFSET	0x10
-#define _OMAP_TIMER_SYS_STAT_OFFSET	0x14
-#define _OMAP_TIMER_STAT_OFFSET		0x18
-#define _OMAP_TIMER_INT_EN_OFFSET	0x1c
-#define _OMAP_TIMER_WAKEUP_EN_OFFSET	0x20
-#define _OMAP_TIMER_CTRL_OFFSET		0x24
 #define		OMAP_TIMER_CTRL_GPOCFG		(1 << 14)
 #define		OMAP_TIMER_CTRL_CAPTMODE	(1 << 13)
 #define		OMAP_TIMER_CTRL_PT		(1 << 12)
@@ -71,28 +63,11 @@
 #define		OMAP_TIMER_CTRL_POSTED		(1 << 2)
 #define		OMAP_TIMER_CTRL_AR		(1 << 1) /* auto-reload enable */
 #define		OMAP_TIMER_CTRL_ST		(1 << 0) /* start timer */
-#define _OMAP_TIMER_COUNTER_OFFSET	0x28
-#define _OMAP_TIMER_LOAD_OFFSET		0x2c
-#define _OMAP_TIMER_TRIGGER_OFFSET	0x30
-#define _OMAP_TIMER_WRITE_PEND_OFFSET	0x34
-#define _OMAP_TIMER_MATCH_OFFSET	0x38
-#define _OMAP_TIMER_CAPTURE_OFFSET	0x3c
-#define _OMAP_TIMER_IF_CTRL_OFFSET	0x40
-#define _OMAP_TIMER_CAPTURE2_OFFSET		0x44	/* TCAR2, 34xx only */
-#define _OMAP_TIMER_TICK_POS_OFFSET		0x48	/* TPIR, 34xx only */
-#define _OMAP_TIMER_TICK_NEG_OFFSET		0x4c	/* TNIR, 34xx only */
-#define _OMAP_TIMER_TICK_COUNT_OFFSET		0x50	/* TCVR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_SET_OFFSET	0x54	/* TOCR, 34xx only */
-#define _OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET	0x58	/* TOWR, 34xx only */
 
 struct omap_dm_timer {
 	int id;
 	unsigned long fclk_rate;
-	unsigned long phys_base;
 	int irq;
-#ifdef CONFIG_ARCH_OMAP2PLUS
-	struct clk *iclk, *fclk;
-#endif
 	void __iomem *io_base;
 	unsigned reserved:1;
 	unsigned enabled:1;
@@ -101,107 +76,6 @@ struct omap_dm_timer {
 	struct list_head node;
 };
 
-static int dm_timer_count;
-
-#ifdef CONFIG_ARCH_OMAP2
-static struct omap_dm_timer omap2_dm_timers[] = {
-	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
-};
-
-static const char *omap2_dm_source_names[] __initdata = {
-	"sys_ck",
-	"func_32k_ck",
-	"alt_ck",
-	NULL
-};
-
-static struct clk *omap2_dm_source_clocks[3];
-static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
-
-#else
-#define omap2_dm_timers			NULL
-#define omap2_dm_timer_count		0
-#define omap2_dm_source_names		NULL
-#define omap2_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP2 */
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct omap_dm_timer omap3_dm_timers[] = {
-	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
-	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
-	{ .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
-	{ .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
-	{ .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
-	{ .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
-	{ .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
-	{ .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
-	{ .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
-	{ .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
-	{ .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
-	{ .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
-};
-
-static const char *omap3_dm_source_names[] __initdata = {
-	"sys_ck",
-	"omap_32k_fck",
-	NULL
-};
-
-static struct clk *omap3_dm_source_clocks[2];
-static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
-
-#else
-#define omap3_dm_timers			NULL
-#define omap3_dm_timer_count		0
-#define omap3_dm_source_names		NULL
-#define omap3_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP3 */
-
-#ifdef CONFIG_ARCH_OMAP4
-static struct omap_dm_timer omap4_dm_timers[] = {
-	{ .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
-	{ .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
-	{ .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
-	{ .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
-	{ .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
-	{ .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
-	{ .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
-	{ .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
-	{ .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
-	{ .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
-	{ .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
-};
-static const char *omap4_dm_source_names[] __initdata = {
-	"sys_clkin_ck",
-	"sys_32k_ck",
-	NULL
-};
-static struct clk *omap4_dm_source_clocks[2];
-static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
-
-#else
-#define omap4_dm_timers			NULL
-#define omap4_dm_timer_count		0
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
-#endif	/* CONFIG_ARCH_OMAP4 */
-
-static struct omap_dm_timer *dm_timers;
-static const char **dm_source_names;
-static struct clk **dm_source_clocks;
-
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
 
@@ -716,66 +590,6 @@ int omap_dm_timers_active(void)
 }
 EXPORT_SYMBOL_GPL(omap_dm_timers_active);
 
-int __init omap_dm_timer_init(void)
-{
-	unsigned long flags;
-	struct omap_dm_timer *timer;
-	int i, map_size = SZ_8K;	/* Module 4KB + L4 4KB except on omap1 */
-
-	if (!cpu_class_is_omap2())
-		return -ENODEV;
-
-
-	if (cpu_is_omap24xx()) {
-		dm_timers = omap2_dm_timers;
-		dm_timer_count = omap2_dm_timer_count;
-		dm_source_names = omap2_dm_source_names;
-		dm_source_clocks = omap2_dm_source_clocks;
-	} else if (cpu_is_omap34xx()) {
-		dm_timers = omap3_dm_timers;
-		dm_timer_count = omap3_dm_timer_count;
-		dm_source_names = omap3_dm_source_names;
-		dm_source_clocks = omap3_dm_source_clocks;
-	} else if (cpu_is_omap44xx()) {
-		dm_timers = omap4_dm_timers;
-		dm_timer_count = omap4_dm_timer_count;
-		dm_source_names = omap4_dm_source_names;
-		dm_source_clocks = omap4_dm_source_clocks;
-	}
-
-	if (cpu_class_is_omap2())
-		for (i = 0; dm_source_names[i] != NULL; i++)
-			dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
-
-	if (cpu_is_omap243x())
-		dm_timers[0].phys_base = 0x49018000;
-
-	for (i = 0; i < dm_timer_count; i++) {
-		timer = &dm_timers[i];
-
-		/* Static mapping, never released */
-		timer->io_base = ioremap(timer->phys_base, map_size);
-		BUG_ON(!timer->io_base);
-
-#ifdef CONFIG_ARCH_OMAP2PLUS
-		if (cpu_class_is_omap2()) {
-			char clk_name[16];
-			sprintf(clk_name, "gpt%d_ick", i + 1);
-			timer->iclk = clk_get(NULL, clk_name);
-			sprintf(clk_name, "gpt%d_fck", i + 1);
-			timer->fclk = clk_get(NULL, clk_name);
-		}
-
-#endif
-		timer->id = i;
-		/* add the timer element to the list */
-		spin_lock_irqsave(&dm_timer_lock, flags);
-		list_add_tail(&timer->node, &omap_timer_list);
-		spin_unlock_irqrestore(&dm_timer_lock, flags);
-	}
-
-	return 0;
-}
 /**
  * omap_dm_timer_probe - probe function called for every registered device
  * @pdev:	pointer to current timer platform device
-- 
1.6.0.4

