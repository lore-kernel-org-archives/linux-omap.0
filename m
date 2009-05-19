From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/4] ARM: OMAP: Remove unwanted type casts and fix the compiler warning.
Date: Tue, 19 May 2009 18:58:32 +0530
Message-ID: <1242739712-12198-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43009 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753248AbZESN2w (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 May 2009 09:28:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the compiler warning "assignment from incompatible
pointer type"  in dmtimer.c and removes the tye casts. These warnings
were suppressed by type catsing.

The proposed fix was suggested by Russell King <rmk+kernel@arm.linux.org.uk>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 55bb996..ee20612 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -214,7 +214,7 @@ static const char *omap2_dm_source_names[] __initdata = {
 	NULL
 };
 
-static struct clk **omap2_dm_source_clocks[3];
+static struct clk *omap2_dm_source_clocks[3];
 static const int dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
 
 #elif defined(CONFIG_ARCH_OMAP3)
@@ -247,7 +247,7 @@ static const char *omap3_dm_source_names[] __initdata = {
 	NULL
 };
 
-static struct clk **omap3_dm_source_clocks[2];
+static struct clk *omap3_dm_source_clocks[2];
 static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 
 #else
@@ -257,7 +257,7 @@ static const int dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
 #endif
 
 static struct omap_dm_timer *dm_timers;
-static char **dm_source_names;
+static const char **dm_source_names;
 static struct clk **dm_source_clocks;
 
 static spinlock_t dm_timer_lock;
@@ -705,12 +705,12 @@ int __init omap_dm_timer_init(void)
 		dm_timers = omap1_dm_timers;
 	else if (cpu_is_omap24xx()) {
 		dm_timers = omap2_dm_timers;
-		dm_source_names = (char **)omap2_dm_source_names;
-		dm_source_clocks = (struct clk **)omap2_dm_source_clocks;
+		dm_source_names = omap2_dm_source_names;
+		dm_source_clocks = omap2_dm_source_clocks;
 	} else if (cpu_is_omap34xx()) {
 		dm_timers = omap3_dm_timers;
-		dm_source_names = (char **)omap3_dm_source_names;
-		dm_source_clocks = (struct clk **)omap3_dm_source_clocks;
+		dm_source_names = omap3_dm_source_names;
+		dm_source_clocks = omap3_dm_source_clocks;
 	}
 
 	if (cpu_class_is_omap2())
-- 
1.5.4.7

