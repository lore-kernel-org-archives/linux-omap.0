From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 04/11] arm: omap2: timer: remove __omap_gptimer_init()
Date: Fri, 16 Oct 2015 11:22:03 -0500
Message-ID: <1445012530-14126-5-git-send-email-balbi@ti.com>
References: <1445012530-14126-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445012530-14126-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

__omap_sync32k_timer_init(), now takes the clock
source as a parameter. This means we no longer need
__omap_gptimer_init().

Note that __omap_sync32k_timer_init() will be
renamed in a follow-up patch as it's not longer 32k
source specific.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index f53ed049d710..976ff9fa3594 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -592,16 +592,6 @@ static inline void __init realtime_counter_init(void)
 {}
 #endif
 
-static void __init __omap_gptimer_init(int clkev_nr, const char *clkev_src,
-		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
-		const char *clksrc_prop)
-{
-	omap_clk_init();
-	omap_dmtimer_init();
-	omap2_gp_clockevent_init(clkev_nr, clkev_src, clkev_prop);
-	omap2_gptimer_clocksource_init(clksrc_nr, clksrc_src, clksrc_prop);
-}
-
 static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src,
 		const char *clkev_prop, int clksrc_nr, const char *clksrc_src,
 		const char *clksrc_prop, bool gptimer)
@@ -643,8 +633,8 @@ void __init omap3_secure_sync32k_timer_init(void)
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
 void __init omap3_gptimer_timer_init(void)
 {
-	__omap_gptimer_init(2, "timer_sys_ck", NULL,
-		       1, "timer_sys_ck", "ti,timer-alwon");
+	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
+			1, "timer_sys_ck", "ti,timer-alwon", true);
 }
 #endif
 
-- 
2.5.3
