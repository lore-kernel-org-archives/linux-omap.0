From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 12/26] ARM: OMAP2+: timer: Simplify clock event/source name
 setting
Date: Thu, 24 Apr 2014 16:43:55 -0500
Message-ID: <1398375849-6017-13-git-send-email-joelf@ti.com>
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

For the OMAPs, we're setting up only one clockevent and clocksource. Further,
for DT boot there's no easy way to get the timer name and currently this is
done in an ugly way by reading a hwmod entry. So let's just set it to a simpler
name like timer_clkev and timer_clksrc.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index ec427e6..f192a41 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -251,7 +251,6 @@ static u32 __init omap_dm_timer_get_errata(void)
 static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 					 const char *fck_source,
 					 const char *property,
-					 const char **timer_name,
 					 int posted)
 {
 	char name[10]; /* 10 = sizeof("gptXX_Xck0") */
@@ -290,8 +289,6 @@ static int __init omap_dm_timer_init_one(struct omap_dm_timer *timer,
 	if (!oh)
 		return -ENODEV;
 
-	*timer_name = oh->name;
-
 	if (!of_have_populated_dt()) {
 		r = omap_hwmod_get_resource_byname(oh, IORESOURCE_IRQ, NULL,
 						   &irq);
@@ -365,8 +362,10 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
 	 */
 	__omap_dm_timer_override_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
 
+	clockevent_gpt.name = "timer_clkev";
+
 	res = omap_dm_timer_init_one(&clkev, fck_source, property,
-				     &clockevent_gpt.name, OMAP_TIMER_POSTED);
+				     OMAP_TIMER_POSTED);
 	BUG_ON(res);
 
 	omap2_gp_timer_irq.dev_id = &clkev;
@@ -489,10 +488,11 @@ static void __init omap2_gptimer_clocksource_init(int gptimer_id,
 	clksrc.errata = omap_dm_timer_get_errata();
 
 	res = omap_dm_timer_init_one(&clksrc, fck_source, property,
-				     &clocksource_gpt.name,
 				     OMAP_TIMER_NONPOSTED);
 	BUG_ON(res);
 
+	clocksource_gpt.name = "timer_clksrc";
+
 	__omap_dm_timer_load_start(&clksrc,
 				   OMAP_TIMER_CTRL_AR, 0,
 				   OMAP_TIMER_NONPOSTED);
-- 
1.7.9.5
