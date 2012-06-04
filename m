From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V3 03/12] ARM: OMAP2+: Add dmtimer platform function to reserve systimers
Date: Mon, 4 Jun 2012 14:41:40 -0500
Message-ID: <1338838909-25356-4-git-send-email-jon-hunter@ti.com>
References: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59971 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751412Ab2FDTl6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 15:41:58 -0400
In-Reply-To: <1338838909-25356-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Jon Hunter <jon-hunter@ti.com>

During early boot, one or two dmtimers are reserved by the kernel as system
timers (for clocksource and clockevents). These timers are marked as reserved
and the dmtimer driver is notified which timers have been reserved via the
platform data information.

For OMAP2+ devices the timers reserved may vary depending on device and compile
flags. Therefore, it is not easy to assume which timers we be reserved for the
system timers. In order to migrate the dmtimer driver to support device-tree we
need a way to pass the timers reserved for system timers to the dmtimer driver.
Using the platform data structure will not work in the same way as it is
currently used because the platform data structure will be stored statically in
the dmtimer itself and the platform data will be selected via the device-tree
match device function (of_match_device).

There are a couple ways to workaround this. One option is to store the system
timers reserved for the kernel in the device-tree and query them on boot.
The downside of this approach is that it adds some delay to parse the DT blob
to search for the system timers. Secondly, for OMAP3 devices we have a
dependency on compile time flags and the device-tree would not be aware of that
kernel compile flags and so we would need to address that.

The second option is to add a function to the dmtimer code to reserved the
system timers during boot and so the dmtimer knows exactly which timers are
being used for system timers. This also allows us to remove the "reserved"
member from the timer platform data. This seemed like the simpler approach and
so was implemented here.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    9 ++-------
 arch/arm/plat-omap/dmtimer.c              |   18 +++++++++++++++++-
 arch/arm/plat-omap/include/plat/dmtimer.h |    3 +--
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index c030dfe..b0b2080 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -69,8 +69,6 @@
 #define OMAP3_SECURE_TIMER	1
 #endif
 
-static u32 sys_timer_reserved;
-
 /* Clockevent code */
 
 static struct omap_dm_timer clkev;
@@ -177,7 +175,8 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	omap_hwmod_enable(oh);
 
-	sys_timer_reserved |= (1 << (gptimer_id - 1));
+	if (omap_dm_timer_reserve_systimer(gptimer_id))
+		return -ENODEV;
 
 	if (gptimer_id != 12) {
 		struct clk *src;
@@ -501,10 +500,6 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *unused)
 	pdata->set_timer_src = omap2_dm_timer_set_src;
 	pdata->timer_ip_version = oh->class->rev;
 
-	/* Mark clocksource and clockevent timers as reserved */
-	if ((sys_timer_reserved >> (id - 1)) & 0x1)
-		pdata->reserved = 1;
-
 	pwrdm = omap_hwmod_get_pwrdm(oh);
 	pdata->loses_context = pwrdm_can_ever_lose_context(pwrdm);
 #ifdef CONFIG_PM
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 3b0cfeb..f5b5c89 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -45,6 +45,7 @@
 
 #include <mach/hardware.h>
 
+static u32 omap_reserved_systimers;
 static LIST_HEAD(omap_timer_list);
 static DEFINE_SPINLOCK(dm_timer_lock);
 
@@ -152,6 +153,21 @@ int omap_dm_timer_prepare(struct omap_dm_timer *timer)
 	return ret;
 }
 
+static inline u32 omap_dm_timer_reserved_systimer(int id)
+{
+	return (omap_reserved_systimers & (1 << (id - 1))) ? 1 : 0;
+}
+
+int omap_dm_timer_reserve_systimer(int id)
+{
+	if (omap_dm_timer_reserved_systimer(id))
+		return -ENODEV;
+
+	omap_reserved_systimers |= (1 << (id - 1));
+
+	return 0;
+}
+
 struct omap_dm_timer *omap_dm_timer_request(void)
 {
 	struct omap_dm_timer *timer = NULL, *t;
@@ -674,7 +690,7 @@ static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
 
 	timer->id = pdev->id;
 	timer->irq = irq->start;
-	timer->reserved = pdata->reserved;
+	timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
 	timer->pdev = pdev;
 	timer->loses_context = pdata->loses_context;
 	timer->get_context_loss_count = pdata->get_context_loss_count;
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 5fdfaa4..1e5ce5d 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -98,13 +98,12 @@ struct dmtimer_platform_data {
 	int (*set_timer_src)(struct platform_device *pdev, int source);
 	int timer_ip_version;
 	u32 needs_manual_reset:1;
-	bool reserved;
-
 	bool loses_context;
 
 	int (*get_context_loss_count)(struct device *dev);
 };
 
+int omap_dm_timer_reserve_systimer(int id);
 struct omap_dm_timer *omap_dm_timer_request(void);
 struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
 int omap_dm_timer_free(struct omap_dm_timer *timer);
-- 
1.7.9.5

