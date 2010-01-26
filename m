From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/14] omap: Fix dmtimer.c for multi-omap boot
Date: Tue, 26 Jan 2010 12:12:48 -0800
Message-ID: <20100126201248.15382.66154.stgit@baageli.muru.com>
References: <20100126200646.15382.52167.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60521 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab0AZUM3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Jan 2010 15:12:29 -0500
In-Reply-To: <20100126200646.15382.52167.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Fix dmtimer.c for multi-omap boot. Also remove legacy
clk_enable/disable wrappers that are no longer needed.

Note that the clock handling should be further improved
to make use of the clock aliases.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dmtimer.c |   90 ++++++++++++++++++------------------------
 1 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 08ccf89..c588cdf 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -163,20 +163,9 @@ struct omap_dm_timer {
 	unsigned posted:1;
 };
 
-#ifdef CONFIG_ARCH_OMAP1
-
-#define omap_dm_clk_enable(x)
-#define omap_dm_clk_disable(x)
-#define omap2_dm_timers			NULL
-#define omap2_dm_source_names		NULL
-#define omap2_dm_source_clocks		NULL
-#define omap3_dm_timers			NULL
-#define omap3_dm_source_names		NULL
-#define omap3_dm_source_clocks		NULL
-#define omap4_dm_timers			NULL
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
+static int dm_timer_count;
 
+#ifdef CONFIG_ARCH_OMAP1
 static struct omap_dm_timer omap1_dm_timers[] = {
 	{ .phys_base = 0xfffb1400, .irq = INT_1610_GPTIMER1 },
 	{ .phys_base = 0xfffb1c00, .irq = INT_1610_GPTIMER2 },
@@ -188,20 +177,14 @@ static struct omap_dm_timer omap1_dm_timers[] = {
 	{ .phys_base = 0xfffbd400, .irq = INT_1610_GPTIMER8 },
 };
 
-static const int dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
-
-#elif defined(CONFIG_ARCH_OMAP2)
+static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
 
-#define omap_dm_clk_enable(x)		clk_enable(x)
-#define omap_dm_clk_disable(x)		clk_disable(x)
+#else
 #define omap1_dm_timers			NULL
-#define omap3_dm_timers			NULL
-#define omap3_dm_source_names		NULL
-#define omap3_dm_source_clocks		NULL
-#define omap4_dm_timers			NULL
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
+#define omap1_dm_timer_count		0
+#endif	/* CONFIG_ARCH_OMAP1 */
 
+#ifdef CONFIG_ARCH_OMAP2
 static struct omap_dm_timer omap2_dm_timers[] = {
 	{ .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
 	{ .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
@@ -225,20 +208,16 @@ static const char *omap2_dm_source_names[] __initdata = {
 };
 
 static struct clk *omap2_dm_source_clocks[3];
-static const int dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
-
-#elif defined(CONFIG_ARCH_OMAP3)
+static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
 
-#define omap_dm_clk_enable(x)		clk_enable(x)
-#define omap_dm_clk_disable(x)		clk_disable(x)
-#define omap1_dm_timers			NULL
+#else
 #define omap2_dm_timers			NULL
+#define omap2_dm_timer_count		0
 #define omap2_dm_source_names		NULL
 #define omap2_dm_source_clocks		NULL
-#define omap4_dm_timers			NULL
-#define omap4_dm_source_names		NULL
-#define omap4_dm_source_clocks		NULL
+#endif	/* CONFIG_ARCH_OMAP2 */
 
+#ifdef CONFIG_ARCH_OMAP3
 static struct omap_dm_timer omap3_dm_timers[] = {
 	{ .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
 	{ .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
@@ -261,20 +240,16 @@ static const char *omap3_dm_source_names[] __initdata = {
 };
 
 static struct clk *omap3_dm_source_clocks[2];
-static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
-
-#elif defined(CONFIG_ARCH_OMAP4)
+static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
-#define omap_dm_clk_enable(x)		clk_enable(x)
-#define omap_dm_clk_disable(x)		clk_disable(x)
-#define omap1_dm_timers			NULL
-#define omap2_dm_timers			NULL
-#define omap2_dm_source_names		NULL
-#define omap2_dm_source_clocks		NULL
+#else
 #define omap3_dm_timers			NULL
+#define omap3_dm_timer_count		0
 #define omap3_dm_source_names		NULL
 #define omap3_dm_source_clocks		NULL
+#endif	/* CONFIG_ARCH_OMAP3 */
 
+#ifdef CONFIG_ARCH_OMAP4
 static struct omap_dm_timer omap4_dm_timers[] = {
 	{ .phys_base = 0x4a318000, .irq = INT_44XX_GPTIMER1 },
 	{ .phys_base = 0x48032000, .irq = INT_44XX_GPTIMER2 },
@@ -295,13 +270,14 @@ static const char *omap4_dm_source_names[] __initdata = {
 	NULL
 };
 static struct clk *omap4_dm_source_clocks[2];
-static const int dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
+static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
 
 #else
-
-#error OMAP architecture not supported!
-
-#endif
+#define omap4_dm_timers			NULL
+#define omap4_dm_timer_count		0
+#define omap4_dm_source_names		NULL
+#define omap4_dm_source_clocks		NULL
+#endif	/* CONFIG_ARCH_OMAP4 */
 
 static struct omap_dm_timer *dm_timers;
 static const char **dm_source_names;
@@ -450,8 +426,12 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
 	if (timer->enabled)
 		return;
 
-	omap_dm_clk_enable(timer->fclk);
-	omap_dm_clk_enable(timer->iclk);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (cpu_class_is_omap2()) {
+		clk_enable(timer->fclk);
+		clk_enable(timer->iclk);
+	}
+#endif
 
 	timer->enabled = 1;
 }
@@ -462,8 +442,12 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
 	if (!timer->enabled)
 		return;
 
-	omap_dm_clk_disable(timer->iclk);
-	omap_dm_clk_disable(timer->fclk);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (cpu_class_is_omap2()) {
+		clk_disable(timer->iclk);
+		clk_disable(timer->fclk);
+	}
+#endif
 
 	timer->enabled = 0;
 }
@@ -764,17 +748,21 @@ int __init omap_dm_timer_init(void)
 
 	if (cpu_class_is_omap1()) {
 		dm_timers = omap1_dm_timers;
+		dm_timer_count = omap1_dm_timer_count;
 		map_size = SZ_2K;
 	} else if (cpu_is_omap24xx()) {
 		dm_timers = omap2_dm_timers;
+		dm_timer_count = omap2_dm_timer_count;
 		dm_source_names = omap2_dm_source_names;
 		dm_source_clocks = omap2_dm_source_clocks;
 	} else if (cpu_is_omap34xx()) {
 		dm_timers = omap3_dm_timers;
+		dm_timer_count = omap3_dm_timer_count;
 		dm_source_names = omap3_dm_source_names;
 		dm_source_clocks = omap3_dm_source_clocks;
 	} else if (cpu_is_omap44xx()) {
 		dm_timers = omap4_dm_timers;
+		dm_timer_count = omap4_dm_timer_count;
 		dm_source_names = omap4_dm_source_names;
 		dm_source_clocks = omap4_dm_source_clocks;
 	}

