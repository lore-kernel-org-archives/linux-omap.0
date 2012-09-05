From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 02/10] ARM: OMAP: Fix timer posted mode support
Date: Wed, 5 Sep 2012 14:04:24 -0500
Message-ID: <1346871872-24413-3-git-send-email-jon-hunter@ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43399 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754365Ab2IETEp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:04:45 -0400
In-Reply-To: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

Currently the dmtimer posted mode is being enabled when the function
__omap_dm_timer_reset() is called. This function is only being called for
OMAP1 timers and OMAP2+ timers that are being used as system timers. Hence,
for OMAP2+ timers that are NOT being used as a system timer, posted mode is
not enabled but the "timer->posted" variable is still set (incorrectly) in
the omap_dm_timer_prepare() function.

This is a regression introduced by commit 3392cdd3 (ARM: OMAP: dmtimer:
switch-over to platform device driver) which changed the code to only call
omap_dm_timer_reset() for OMAP1 devices. Although this is a regression from
the original code it only impacts performance and so is not needed for stable.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    3 +--
 arch/arm/plat-omap/dmtimer.c              |   14 +++++---------
 arch/arm/plat-omap/include/plat/dmtimer.h |    9 ++++++++-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 5471706..e24ee0f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -194,10 +194,9 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	}
 	__omap_dm_timer_init_regs(timer);
 	__omap_dm_timer_reset(timer, 1, 1);
-	timer->posted = 1;
+	__omap_dm_timer_enable_posted(timer);
 
 	timer->rate = clk_get_rate(timer->fclk);
-
 	timer->reserved = 1;
 
 	return res;
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index c34f55b..22790ea 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -122,21 +122,15 @@ static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
 
 static void omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
-	omap_dm_timer_enable(timer);
 	if (timer->pdev->id != 1) {
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
 		omap_dm_timer_wait_for_reset(timer);
 	}
-
 	__omap_dm_timer_reset(timer, 0, 0);
-	omap_dm_timer_disable(timer);
-	timer->posted = 1;
 }
 
 int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 {
-	int ret;
-
 	/*
 	 * FIXME: OMAP1 devices do not use the clock framework for dmtimers so
 	 * do not call clk_get() for these devices.
@@ -150,13 +144,15 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 		}
 	}
 
+	omap_dm_timer_enable(timer);
+
 	if (timer->capability & OMAP_TIMER_NEEDS_RESET)
 		omap_dm_timer_reset(timer);
 
-	ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
+	__omap_dm_timer_enable_posted(timer);
+	omap_dm_timer_disable(timer);
 
-	timer->posted = 1;
-	return ret;
+	return omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
 }
 
 static inline u32 omap_dm_timer_reserved_systimer(int id)
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5ce2f00..fa9d04b 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -348,13 +348,20 @@ static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
 		l |= 1 << 2;
 
 	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
+}
+
+static inline void __omap_dm_timer_enable_posted(struct omap_dm_timer *timer)
+{
+	if (timer->posted)
+		return;
 
 	if (timer->errata & OMAP_TIMER_ERRATA_I103_I767)
 		return;
 
-	/* Match hardware reset default of posted mode */
 	__omap_dm_timer_write(timer, OMAP_TIMER_IF_CTRL_REG,
 					OMAP_TIMER_CTRL_POSTED, 0);
+	timer->context.tsicr = OMAP_TIMER_CTRL_POSTED;
+	timer->posted = 1;
 }
 
 /**
-- 
1.7.9.5

