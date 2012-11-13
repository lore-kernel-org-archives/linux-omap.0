From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 3/8] ARM: OMAP: Don't store timers physical address
Date: Tue, 13 Nov 2012 12:13:18 -0600
Message-ID: <1352830403-1706-4-git-send-email-jon-hunter@ti.com>
References: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57226 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755261Ab2KMSNh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Nov 2012 13:13:37 -0500
In-Reply-To: <1352830403-1706-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The OMAP2+ system timer code stores the physical address of the timer
but never uses it. Remove this and clean-up the code by removing the
local variable "size" and changing the names of the local variables
mem_rsrc and irq_rsrc to mem and irq, respectively.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |   13 +++++--------
 arch/arm/plat-omap/include/plat/dmtimer.h |    1 -
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 099e406..e9fcc5f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -245,8 +245,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	const char *oh_name;
 	struct device_node *np;
 	struct omap_hwmod *oh;
-	struct resource irq_rsrc, mem_rsrc;
-	size_t size;
+	struct resource irq, mem;
 	int res = 0;
 	int r;
 
@@ -280,20 +279,18 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	if (!of_have_populated_dt()) {
 		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL,
-						   &irq_rsrc);
+						   &irq);
 		if (r)
 			return -ENXIO;
-		timer->irq = irq_rsrc.start;
+		timer->irq = irq.start;
 
 		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM, NULL,
-						   &mem_rsrc);
+						   &mem);
 		if (r)
 			return -ENXIO;
-		timer->phys_base = mem_rsrc.start;
-		size = mem_rsrc.end - mem_rsrc.start;
 
 		/* Static mapping, never released */
-		timer->io_base = ioremap(timer->phys_base, size);
+		timer->io_base = ioremap(mem.start, mem.end - mem.start);
 	}
 
 	if (!timer->io_base)
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 40383b6..b60e2b6 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -261,7 +261,6 @@ int omap_dm_timers_active(void);
 		(_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
 
 struct omap_dm_timer {
-	unsigned long phys_base;
 	int id;
 	int irq;
 	struct clk *fclk;
-- 
1.7.9.5

