From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 23/26] ARM: OMAP: dmtimer: Eliminate
 __omap_dm_timer_read_counter function
Date: Thu, 24 Apr 2014 16:44:06 -0500
Message-ID: <1398375849-6017-24-git-send-email-joelf@ti.com>
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

__omap_dm_timer_read_counter functionality is folded back into
omap_dm_timer_read_counter and all users converted to use it.

Made possible due to the systimer flags introduced in the series. Also there's
no need to pass posted flags anymore as this data is available in the dmtimer
structure.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/mach-omap2/timer.c               |    6 ++----
 arch/arm/plat-omap/dmtimer.c              |    2 +-
 arch/arm/plat-omap/include/plat/dmtimer.h |    6 ------
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 7c0cd72..39b3e34 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -423,8 +423,7 @@ static bool use_gptimer_clksrc;
  */
 static cycle_t clocksource_read_cycles(struct clocksource *cs)
 {
-	return (cycle_t)__omap_dm_timer_read_counter(&clksrc,
-						     OMAP_TIMER_NONPOSTED);
+	return (cycle_t)omap_dm_timer_read_counter(&clksrc);
 }
 
 static struct clocksource clocksource_gpt = {
@@ -437,8 +436,7 @@ static struct clocksource clocksource_gpt = {
 static u64 notrace dmtimer_read_sched_clock(void)
 {
 	if (clksrc.reserved)
-		return __omap_dm_timer_read_counter(&clksrc,
-						    OMAP_TIMER_NONPOSTED);
+		return omap_dm_timer_read_counter(&clksrc);
 
 	return 0;
 }
diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index af67e30..44cc336 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -808,7 +808,7 @@ unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 	if (!is_timer_available(timer))
 		return 0;
 
-	return __omap_dm_timer_read_counter(timer, timer->posted);
+	return omap_dm_timer_read_reg(timer, OMAP_TIMER_COUNTER_REG);
 }
 EXPORT_SYMBOL_GPL(omap_dm_timer_read_counter);
 
diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
index f542ef2..6ab801b 100644
--- a/arch/arm/plat-omap/include/plat/dmtimer.h
+++ b/arch/arm/plat-omap/include/plat/dmtimer.h
@@ -374,10 +374,4 @@ static inline void __omap_dm_timer_int_enable(struct omap_dm_timer *timer,
 	__omap_dm_timer_write(timer, OMAP_TIMER_WAKEUP_EN_REG, value, 0);
 }
 
-static inline unsigned int
-__omap_dm_timer_read_counter(struct omap_dm_timer *timer, int posted)
-{
-	return __omap_dm_timer_read(timer, OMAP_TIMER_COUNTER_REG, posted);
-}
-
 #endif /* __ASM_ARCH_DMTIMER_H */
-- 
1.7.9.5
