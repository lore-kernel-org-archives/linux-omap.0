From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP1: Remove unused cycles-to-nsec conversions
Date: Wed, 12 Dec 2007 10:25:56 -0800
Message-ID: <20071212182556.764254188@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap@vger.kernel.org
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

These are no longer used and similar conversions are provided
by the clocksource/clockevent code.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a4f8b20..17674a0 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -56,37 +56,6 @@
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
 
-/* cycles to nsec conversions taken from arch/i386/kernel/timers/timer_tsc.c,
- * converted to use kHz by Kevin Hilman */
-/* convert from cycles(64bits) => nanoseconds (64bits)
- *  basic equation:
- *		ns = cycles / (freq / ns_per_sec)
- *		ns = cycles * (ns_per_sec / freq)
- *		ns = cycles * (10^9 / (cpu_khz * 10^3))
- *		ns = cycles * (10^6 / cpu_khz)
- *
- *	Then we use scaling math (suggested by george at mvista.com) to get:
- *		ns = cycles * (10^6 * SC / cpu_khz / SC
- *		ns = cycles * cyc2ns_scale / SC
- *
- *	And since SC is a constant power of two, we can convert the div
- *  into a shift.
- *			-johnstul at us.ibm.com "math is hard, lets go shopping!"
- */
-static unsigned long cyc2ns_scale;
-#define CYC2NS_SCALE_FACTOR 10 /* 2^10, carefully chosen */
-
-static inline void set_cyc2ns_scale(unsigned long cpu_khz)
-{
-	cyc2ns_scale = (1000000 << CYC2NS_SCALE_FACTOR)/cpu_khz;
-}
-
-static inline unsigned long long cycles_2_ns(unsigned long long cyc)
-{
-	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
-}
-
-
 typedef struct {
 	u32 cntl;			/* CNTL_TIMER, R/W */
 	u32 load_tim;			/* LOAD_TIM,   W */
@@ -194,8 +163,6 @@ static struct irqaction omap_mpu_timer1_irq = {
 
 static __init void omap_init_mpu_timer(unsigned long rate)
 {
-	set_cyc2ns_scale(rate / 1000);
-
 	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
 	omap_mpu_timer_start(0, (rate / HZ) - 1, 1);
 
--
