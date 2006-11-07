From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Tue, 07 Nov 2006 16:32:27 +0100
Message-ID: <4550A70B.7020609@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070801060503090206020206"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------070801060503090206020206
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Add clocksource driver for OMAP1.

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

What do you think about this? OSK still boots and I can't
see any runtime issues. But maybe others?

For reference see

- The two new files highres.txt and hrtimers.txt in
http://tglx.de/projects/hrtimers/2.6.18/patch-2.6.18-hrt-dyntick2.patch
- 
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036695.html 

(and the other "clocksource" patches there)
- 
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036713.html

Next steps would be:

* Move omap_clocksource_init() to something like

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036700.html

* Add clockevent system, e.g.

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036705.html

(and the other "clockevent" patches there)

* Enable generic time and generic clock events:

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036696.html
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036711.html

But seems that we have to wait some integration cylces
of mainline for this.

Cheers

Dirk

Btw: With clocksource added, we should be able to use
rt-preempt patch:

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2006-October/036496.html
rt.wiki.kernel.org
http://www.linuxdevices.com/news/NS9566944929.html

if it will be available for 2.6.19 (with some small OMAP
specific adaptions) .







--------------070801060503090206020206
Content-Type: text/plain;
 name="omap1_clocksource_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap1_clocksource_patch.txt"

Index: linux-osk/arch/arm/mach-omap1/time.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/time.c
+++ linux-osk/arch/arm/mach-omap1/time.c
@@ -39,6 +39,7 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -58,36 +59,6 @@ struct sys_timer omap_timer;
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
 /*
  * MPU_TICKS_PER_SEC must be an even number, otherwise machinecycles_to_usecs
  * will break. On P2, the timer count rate is 6.5 MHz after programming PTV
@@ -131,43 +102,9 @@ static inline void omap_mpu_timer_start(
 	timer->cntl = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_AR | MPU_TIMER_ST);
 }
 
-unsigned long omap_mpu_timer_ticks_to_usecs(unsigned long nr_ticks)
-{
-	unsigned long long nsec;
-
-	nsec = cycles_2_ns((unsigned long long)nr_ticks);
-	return (unsigned long)nsec / 1000;
-}
-
-/*
- * Last processed system timer interrupt
- */
-static unsigned long omap_mpu_timer_last = 0;
-
-/*
- * Returns elapsed usecs since last system timer interrupt
- */
-static unsigned long omap_mpu_timer_gettimeoffset(void)
-{
-	unsigned long now = 0 - omap_mpu_timer_read(0);
-	unsigned long elapsed = now - omap_mpu_timer_last;
-
-	return omap_mpu_timer_ticks_to_usecs(elapsed);
-}
-
-/*
- * Elapsed time between interrupts is calculated using timer0.
- * Latency during the interrupt is calculated using timer1.
- * Both timer0 and timer1 are counting at 6MHz (P2 6.5MHz).
- */
 static irqreturn_t omap_mpu_timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long now, latency;
-
 	write_seqlock(&xtime_lock);
-	now = 0 - omap_mpu_timer_read(0);
-	latency = MPU_TICKS_PER_SEC / HZ - omap_mpu_timer_read(1);
-	omap_mpu_timer_last = now - latency;
 	timer_tick();
 	write_sequnlock(&xtime_lock);
 
@@ -180,42 +117,33 @@ static struct irqaction omap_mpu_timer_i
 	.handler	= omap_mpu_timer_interrupt,
 };
 
-static unsigned long omap_mpu_timer1_overflows;
-static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
+static __init void omap_init_mpu_timer(void)
 {
-	omap_mpu_timer1_overflows++;
-	return IRQ_HANDLED;
+	setup_irq(INT_TIMER1, &omap_mpu_timer_irq);
+	omap_mpu_timer_start(0, MPU_TIMER_TICK_PERIOD);
 }
 
-static struct irqaction omap_mpu_timer1_irq = {
-	.name		= "mpu timer1 overflow",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer1_interrupt,
-};
-
-static __init void omap_init_mpu_timer(void)
+cycle_t omap_get_cycles(void)
 {
-	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
-	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
-	omap_mpu_timer_start(0, 0xffffffff);
-	omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
+	return omap_mpu_timer_read(0);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
-{
-	unsigned long ticks = 0 - omap_mpu_timer_read(0);
-	unsigned long long ticks64;
+static struct clocksource clocksource_omap = {
+	.name 		= "timer0",
+	.rating		= 200,
+	.read		= omap_get_cycles,
+	.mask		= 0xFFFFFFFF,
+	.shift 		= 20,
+	.is_continuous 	= 1,
+};
 
-	ticks64 = omap_mpu_timer1_overflows;
-	ticks64 <<= 32;
-	ticks64 |= ticks;
+static int __init omap_init_clocksource(void)
+{
+	clocksource_omap.mult = clocksource_khz2mult(MPU_TICKS_PER_SEC/1000,
+                                                     clocksource_omap.shift);
+	clocksource_register(&clocksource_omap);
 
-	return cycles_2_ns(ticks64);
+	return 0;
 }
 
 /*
@@ -226,9 +154,9 @@ unsigned long long sched_clock(void)
 static void __init omap_timer_init(void)
 {
 	omap_init_mpu_timer();
+	omap_init_clocksource();
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };








--------------070801060503090206020206
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------070801060503090206020206--
