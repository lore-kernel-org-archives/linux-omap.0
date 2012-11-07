From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH V2 14/14] ARM: OMAP: Remove __omap_dm_timer_set_source function
Date: Wed, 7 Nov 2012 13:01:30 -0600
Message-ID: <1352314890-22224-15-git-send-email-jon-hunter@ti.com>
References: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36399 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754333Ab2KGTBy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 7 Nov 2012 14:01:54 -0500
In-Reply-To: <1352314890-22224-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

The __omap_dm_timer_set_source() function is only used by the system timer
(clock-events and clock-source) code for OMAP2+ devices. Therefore, we can
remove this code from the dmtimer driver and move it to the system timer
code for OMAP2+ devices.

The current __omap_dm_timer_set_source() function calls clk_disable() before
calling clk_set_parent() and clk_enable() afterwards. We can avoid these calls
to clk_disable/enable by moving the calls to omap_hwmod_setup_one() and
omap_hwmod_enable() to after the call to clk_set_parent() in
omap_dm_timer_init_one().

The function omap_hwmod_setup_one() will enable the timers functional clock
and therefore increment the use-count of the functional clock to 1.
clk_set_parent() will fail if the use-count is not 0 when called. Hence, if
omap_hwmod_setup_one() is called before clk_set_parent(), we will need to call
clk_disable() before calling clk_set_parent() to decrement the use-count.
Hence, avoid these extra calls to disable and enable the functional clock by
moving the calls to omap_hwmod_setup_one() and omap_hwmod_enable() to after
clk_set_parent().

We can also remove the delay from the __omap_dm_timer_set_source() function
because enabling the clock will now be handled via the HWMOD framework by
calling omap_hwmod_setup_one(). Therefore, by moving the calls to
omap_hwmod_setup_one() and omap_hwmod_enable() to after the call to
clk_set_parent(), we can simply replace __omap_dm_timer_set_source() with
clk_set_parent().

It should be safe to move these hwmod calls to later in the
omap_dm_timer_init_one() because other calls to the hwmod layer that occur
before are just requesting resource information.

Testing includes boot testing on OMAP2420 H4, OMAP3430 SDP and OMAP4430 Blaze
with the following configurations:
1. CONFIG_OMAP_32K_TIMER=y
2. CONFIG_OMAP_32K_TIMER=y and boot parameter "clocksource=gp_timer"
3. CONFIG_OMAP_32K_TIMER not set
4. CONFIG_OMAP_32K_TIMER not set and boot parameter "clocksource=gp_timer"

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    9 ++++-----
 arch/arm/plat-omap/include/plat/dmtimer.h |   19 -------------------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b9b6f21..066a48d 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -277,9 +277,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		oh_name = name;
 	}
 
-	omap_hwmod_setup_one(oh_name);
 	oh = omap_hwmod_lookup(oh_name);
-
 	if (!oh)
 		return -ENODEV;
 
@@ -309,8 +307,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (IS_ERR(timer->fclk))
 		return -ENODEV;
 
-	omap_hwmod_enable(oh);
-
 	/* FIXME: Need to remove hard-coded test on timer ID */
 	if (gptimer_id != 12) {
 		struct clk *src;
@@ -319,13 +315,16 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (IS_ERR(src)) {
 			res = -EINVAL;
 		} else {
-			res = __omap_dm_timer_set_source(timer->fclk, src);
+			res = clk_set_parent(timer->fclk, src);
 			if (IS_ERR_VALUE(res))
 				pr_warn("%s: %s cannot set source\n",
 					__func__, oh->name);
 			clk_put(src);
 		}
 	}
+
+	omap_hwmod_setup_one(oh_name);
+	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
 
 	if (posted)
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index 14190e8..24a1c74 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -32,7 +32,6 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
@@ -358,24 +357,6 @@ static inline void __omap_dm_timer_reset(struct omap_dm_timer *timer,
 	__raw_writel(l, timer->io_base + OMAP_TIMER_OCP_CFG_OFFSET);
 }
 
-static inline int __omap_dm_timer_set_source(struct clk *timer_fck,
-						struct clk *parent)
-{
-	int ret;
-
-	clk_disable(timer_fck);
-	ret = clk_set_parent(timer_fck, parent);
-	clk_enable(timer_fck);
-
-	/*
-	 * When the functional clock disappears, too quick writes seem
-	 * to cause an abort. XXX Is this still necessary?
-	 */
-	__delay(300000);
-
-	return ret;
-}
-
 static inline void __omap_dm_timer_stop(struct omap_dm_timer *timer,
 					int posted, unsigned long rate)
 {
-- 
1.7.9.5

