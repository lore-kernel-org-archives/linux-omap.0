From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 14/26] ARM: OMAP2+: timer: Remove hwmod look-up dependency for
 DT-boot
Date: Thu, 24 Apr 2014 16:43:57 -0500
Message-ID: <1398375849-6017-15-git-send-email-joelf@ti.com>
References: <1398375849-6017-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1398375849-6017-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

hwmod look ups should no longer directly happen for dmtimer users of
DT-boot platforms. We separate out the code for platforms that are
still non-DT. Ultimately this code should be deleted if all platforms
are converted to DT-boot.

We use omap_dmtimer_powerup introduced earlier in the series to abstract
out the hwmod dependency for the same. This will help us move the generic
DT specific code out into drivers/clocksource/ later.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 9fdff5b..ea91ef9 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -266,10 +266,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		if (!np)
 			return -ENODEV;
 
-		of_property_read_string_index(np, "ti,hwmods", 0, &oh_name);
-		if (!oh_name)
-			return -ENODEV;
-
 		timer->irq = irq_of_parse_and_map(np, 0);
 		if (!timer->irq)
 			return -ENXIO;
@@ -277,19 +273,24 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 		timer->io_base = of_iomap(np, 0);
 
 		of_node_put(np);
+
+		if (!timer->io_base)
+			return -ENXIO;
+
+		r = omap_dmtimer_powerup(np);
+		if (r)
+			return r;
 	} else {
 		if (omap_dm_timer_reserve_systimer(timer->id))
 			return -ENODEV;
 
 		sprintf(name, "timer%d", timer->id);
 		oh_name = name;
-	}
 
-	oh = omap_hwmod_lookup(oh_name);
-	if (!oh)
-		return -ENODEV;
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh)
+			return -ENODEV;
 
-	if (!of_have_populated_dt()) {
 		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL,
 						   &irq);
 		if (r)
@@ -303,11 +304,14 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 		/* Static mapping, never released */
 		timer->io_base = ioremap(mem.start, mem.end - mem.start);
-	}
 
-	if (!timer->io_base)
-		return -ENXIO;
+		if (!timer->io_base)
+			return -ENXIO;
+
 
+		omap_hwmod_setup_one(oh_name);
+		omap_hwmod_enable(oh);
+	}
 	/* After the dmtimer is using hwmod these clocks won't be needed */
 	timer->fclk = clk_get(NULL, omap_hwmod_get_main_clk(oh));
 	if (IS_ERR(timer->fclk))
@@ -333,10 +337,7 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 
 	clk_put(src);
 
-	omap_hwmod_setup_one(oh_name);
-	omap_hwmod_enable(oh);
 	__omap_dm_timer_init_regs(timer);
-
 	if (posted)
 		__omap_dm_timer_enable_posted(timer);
 
-- 
1.7.9.5
