From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 07/11] ARM: OMAP2+: Fix external clock support for dmtimers
Date: Mon, 4 Jun 2012 12:22:31 -0500
Message-ID: <1338830555-20469-8-git-send-email-jon-hunter@ti.com>
References: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:32798 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754955Ab2FDRX3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 13:23:29 -0400
In-Reply-To: <1338830555-20469-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

Currently, the dmtimer determines whether an timer can support an external
clock source (sys_altclk) for driving the timer by the IP version. Only
OMAP24xx devices can support an external clock source, but the IP version
between OMAP24xx and OMAP3xxx is common and so this incorrectly indicates
that OMAP3 devices can use an external clock source.

Rather than use the IP version, just let the clock framework handle this.
If the "alt_ck" does not exist for a timer then the clock framework will fail
to find the clock and hence will return an error. By doing this we can eliminate
the "timer_ip_version" variable passed as part of the platform data and simplify
the code.

We can also remove the timer IP version from the HWMOD data because the dmtimer
driver uses the TIDR register to determine the IP version.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 --
 arch/arm/mach-omap2/timer.c                        |   11 ++---------
 arch/arm/plat-omap/include/plat/dmtimer.h          |    7 -------
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
index 7814e83..afad69c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c
@@ -68,7 +68,6 @@ static struct omap_hwmod_class_sysconfig omap2xxx_timer_sysc = {
 struct omap_hwmod_class omap2xxx_timer_hwmod_class = {
 	.name	= "timer",
 	.sysc	= &omap2xxx_timer_sysc,
-	.rev	= OMAP_TIMER_IP_VERSION_1,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 7b33094..0ea53bc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -129,7 +129,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
 static struct omap_hwmod_class omap3xxx_timer_1ms_hwmod_class = {
 	.name = "timer",
 	.sysc = &omap3xxx_timer_1ms_sysc,
-	.rev = OMAP_TIMER_IP_VERSION_1,
 };
 
 static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
@@ -145,7 +144,6 @@ static struct omap_hwmod_class_sysconfig omap3xxx_timer_sysc = {
 static struct omap_hwmod_class omap3xxx_timer_hwmod_class = {
 	.name = "timer",
 	.sysc = &omap3xxx_timer_sysc,
-	.rev =  OMAP_TIMER_IP_VERSION_1,
 };
 
 /* secure timers dev attribute */
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index d8a5dc3..a89f5f4 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -418,14 +418,8 @@ static int omap2_dm_timer_set_src(struct platform_device *pdev, int source)
 		break;
 
 	case OMAP_TIMER_SRC_EXT_CLK:
-		if (pdata->timer_ip_version == OMAP_TIMER_IP_VERSION_1) {
-			parent_name = "alt_ck";
-			break;
-		}
-		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
-			__func__, __LINE__);
-		clk_put(fclk);
-		return -EINVAL;
+		parent_name = "alt_ck";
+		break;
 	}
 
 	parent = clk_get(&pdev->dev, parent_name);
@@ -498,7 +492,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	sscanf(oh->name, "timer%2d", &id);
 
 	pdata->set_timer_src = omap2_dm_timer_set_src;
-	pdata->timer_ip_version = oh->class->rev;
 
 	if (timer_dev_attr)
 		pdata->timer_capability = timer_dev_attr->timer_capability;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 48e54ca..362cf97 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -55,12 +55,6 @@
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
@@ -96,7 +90,6 @@ struct timer_regs {
 
 struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
-	int timer_ip_version;
 	u32 needs_manual_reset:1;
 	bool loses_context;
 
-- 
1.7.9.5

