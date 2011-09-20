From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v16 12/12] OMAP: dmtimer: get rid of timer_ip_version field
Date: Tue, 20 Sep 2011 17:00:27 +0530
Message-ID: <1316518227-28116-13-git-send-email-tarun.kanti@ti.com>
References: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754960Ab1ITLa4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Sep 2011 07:30:56 -0400
In-Reply-To: <1316518227-28116-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

We do not need this field in dmtimer_platform_data{} anymore.
Instead, read "tidr" register to identify the ip version now.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 --
 arch/arm/mach-omap2/timer.c                        |    8 +++++---
 arch/arm/plat-omap/dmtimer.c                       |    2 ++
 arch/arm/plat-omap/include/plat/dmtimer.h          |    7 -------
 5 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 177dee2..dc6ec15 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -43,7 +43,6 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 struct omap_hwmod_class omap2xxx_timer_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap2xxx_timer_sysc,
-	.rev	= OMAP_TIMER_IP_VERSION_1,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 2e4852d..463ad78 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -545,7 +545,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
 static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
 	.name = "timer",
 	.sysc = &omap3xxx_timer_1ms_sysc,
-	.rev = OMAP_TIMER_IP_VERSION_1,
 };
 
 static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
@@ -561,7 +560,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
 	.name = "timer",
 	.sysc = &omap3xxx_timer_sysc,
-	.rev =  OMAP_TIMER_IP_VERSION_1,
 };
 
 /* secure timers dev attribute */
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 041fed9..c784eda 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -356,9 +356,10 @@ OMAP_SYS_TIMER(4)
 static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 {
 	int ret;
-	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
+	struct omap_dm_timer *timer = platform_get_drvdata(pdev);
 	struct clk *fclk, *parent;
 	char *parent_name = NULL;
+	u32 tidr;
 
 	fclk = clk_get(&pdev->dev, "fck");
 	if (IS_ERR_OR_NULL(fclk)) {
@@ -377,10 +378,12 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 		break;
 
 	case OMAP_TIMER_SRC_EXT_CLK:
-		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
+		tidr = __raw_readl(timer->io_base);
+		if (!(tidr >> 16)) {
 			parent_name = "alt_ck";
 			break;
 		}
+
 		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
 			__func__, __LINE__);
 		clk_put(fclk);
@@ -465,7 +468,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	sscanf(oh->name, "timer%2d", &id);
 
 	pdata->set_timer_src = omap2_dm_timer_set_src;
-	pdata->timer_ip_version = oh->class->rev;
 
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 41755ff..b66f93f 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -700,6 +700,8 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 		pm_runtime_put(&pdev->dev);
 	}
 
+	platform_set_drvdata(pdev, timer);
+
 	/* add the timer element to the list */
 	spin_lock_irqsave(&dm_timer_lock, flags);
 	list_add_tail(&timer->node, &omap_timer_list);
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 639957f..5025c2d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -57,12 +57,6 @@
 #define OMAP_TIMER_TRIGGER_OVERFLOW		0x01
 #define OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
 
-/*
- * IP revision identifier so that Highlander IP
- * in OMAP4 can be distinguished.
- */
-#define OMAP_TIMER_IP_VERSION_1                        0x1
-
 /* timer capabilities used in hwmod database */
 #define OMAP_TIMER_SECURE				0x80000000
 #define OMAP_TIMER_ALWON				0x40000000
@@ -77,7 +71,6 @@ struct clk;
 
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
-	int timer_ip_version;
 	u32 needs_manual_reset:1;
 	bool loses_context;
 
-- 
1.7.0.4

