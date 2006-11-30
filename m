From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] [PATCH] ARM: OMAP1: Add clocksource driver for OMAP1
Date: Thu, 30 Nov 2006 11:14:08 -0800
Message-ID: <200611301114.09352.david-b@pacbell.net>
References: <4550A70B.7020609@gmail.com> <4550CA9E.6090500@mvista.com>
	<456F1B1E.1050305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <456F1B1E.1050305@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Thursday 30 November 2006 9:55 am, Dirk Behme wrote:

> I checked links below and can't find anything of your 
> patches integrated there. Do I miss anything?
> 
> I wonder because 2.6.19 is out now and mainline patch window 
> opens for 2.6.20.

BTW, please examine the appended patch to consider updating the
merge candidate.  I verified that the MPU timer patch works,
it updates two things:

 - consults the actual xtal clock, instead of compile-time constants;
 - uses another mpu timer for a free-running clock

The use of only _one_ MPU timer in the original patch seems wrong
to me ... it's just resetting itself after each tick, so it can't
be used to detect missed ticks.

In my testing, this updated MPU timer worked ok.  But the 32k timer
did NOT, although AFAICT there are no substantive changes to what
was posted.  (Had to copy it by hand, somehow in the midst of the
many patch versions posted, I didn't have the "right" one saved.)
The original MPU time patch I had in my mailbox didn't work either.
(That's on OMAP 5912 fwiw.)

- Dave



Modified version of clocksource patches:

 - MPU timer based:
     * consult clock framework to determine xtal clock
     * use timer1 as a real free-running clock
 - Both: minor cleanups
 - Kconfig updates:

Largely copied by hand from list archives; I didn't have one patch
that was current (though Dirk did post a similar one).


Index: osk2/arch/arm/plat-omap/Kconfig
===================================================================
--- osk2.orig/arch/arm/plat-omap/Kconfig	2006-11-15 21:11:10.000000000 -0800
+++ osk2/arch/arm/plat-omap/Kconfig	2006-11-28 11:41:24.000000000 -0800
@@ -125,6 +125,7 @@ choice
 
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
+	select GENERIC_TIME if ARCH_OMAP1
 	help
 	  Select this option if you want to use the OMAP mpu timer. This
 	  timer provides more intra-tick resolution than the 32KHz timer,
@@ -133,6 +134,7 @@ config OMAP_MPU_TIMER
 config OMAP_32K_TIMER
 	bool "Use 32KHz timer"
 	depends on ARCH_OMAP16XX || ARCH_OMAP24XX
+	select GENERIC_TIME
 	help
 	  Select this option if you want to enable the OMAP 32KHz timer.
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
Index: osk2/arch/arm/mach-omap1/time.c
===================================================================
--- osk2.orig/arch/arm/mach-omap1/time.c	2006-10-25 14:06:18.000000000 -0700
+++ osk2/arch/arm/mach-omap1/time.c	2006-11-28 11:39:18.000000000 -0800
@@ -39,6 +39,9 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -52,58 +55,12 @@ struct sys_timer omap_timer;
 
 /*
  * ---------------------------------------------------------------------------
- * MPU timer
+ * MPU timer 0 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
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
-/*
- * MPU_TICKS_PER_SEC must be an even number, otherwise machinecycles_to_usecs
- * will break. On P2, the timer count rate is 6.5 MHz after programming PTV
- * with 0. This divides the 13MHz input by 2, and is undocumented.
- */
-#if defined(CONFIG_MACH_OMAP_PERSEUS2) || defined(CONFIG_MACH_OMAP_FSAMPLE)
-/* REVISIT: This ifdef construct should be replaced by a query to clock
- * framework to see if timer base frequency is 12.0, 13.0 or 19.2 MHz.
- */
-#define MPU_TICKS_PER_SEC		(13000000 / 2)
-#else
-#define MPU_TICKS_PER_SEC		(12000000 / 2)
-#endif
-
-#define MPU_TIMER_TICK_PERIOD		((MPU_TICKS_PER_SEC / HZ) - 1)
-
 typedef struct {
 	u32 cntl;			/* CNTL_TIMER, R/W */
 	u32 load_tim;			/* LOAD_TIM,   W */
@@ -131,43 +88,9 @@ static inline void omap_mpu_timer_start(
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
 
@@ -175,47 +98,47 @@ static irqreturn_t omap_mpu_timer_interr
 }
 
 static struct irqaction omap_mpu_timer_irq = {
-	.name		= "mpu timer",
+	.name		= "mpu_timer0",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= omap_mpu_timer_interrupt,
 };
 
-static unsigned long omap_mpu_timer1_overflows;
-static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
+static __init void omap_init_mpu_timer(unsigned long rate)
 {
-	omap_mpu_timer1_overflows++;
-	return IRQ_HANDLED;
+	setup_irq(INT_TIMER1, &omap_mpu_timer_irq);
+	omap_mpu_timer_start(0, (rate / HZ) - 1);
 }
 
-static struct irqaction omap_mpu_timer1_irq = {
-	.name		= "mpu timer1 overflow",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer1_interrupt,
-};
-
-static __init void omap_init_mpu_timer(void)
+/*
+ * ---------------------------------------------------------------------------
+ * MPU timer 1 ... free running 32-bit clock source
+ * ---------------------------------------------------------------------------
+ */
+static cycle_t mpu_read(void)
 {
-	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
-	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
-	omap_mpu_timer_start(0, 0xffffffff);
-	omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
+	return ~omap_mpu_timer_read(1);
 }
 
-/*
- * Scheduler clock - returns current time in nanosec units.
- */
-unsigned long long sched_clock(void)
+static struct clocksource clocksource_mpu = {
+	.name		= "mpu_timer1",
+	.rating		= 300,
+	.read		= mpu_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 24,
+	.is_continuous	= 1,
+};
+
+static void __init omap_init_clocksource(unsigned long rate)
 {
-	unsigned long ticks = 0 - omap_mpu_timer_read(0);
-	unsigned long long ticks64;
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
 
-	ticks64 = omap_mpu_timer1_overflows;
-	ticks64 <<= 32;
-	ticks64 |= ticks;
+	clocksource_mpu.mult
+		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
 
-	return cycles_2_ns(ticks64);
+	omap_mpu_timer_start(1, clocksource_mpu.mask);
+	if (clocksource_register(&clocksource_mpu))
+		printk(err, clocksource_mpu.name);
 }
 
 /*
@@ -225,10 +148,21 @@ unsigned long long sched_clock(void)
  */
 static void __init omap_timer_init(void)
 {
-	omap_init_mpu_timer();
+	struct clk	*ck_ref = clk_get(NULL, "ck_ref");
+	unsigned long	rate;
+
+	BUG_ON(IS_ERR(ck_ref));
+
+	rate = clk_get_rate(ck_ref);
+	clk_put(ck_ref);
+
+	/* PTV = 0 */
+	rate /= 2;
+
+	omap_init_mpu_timer(rate);
+	omap_init_clocksource(rate);
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
Index: osk2/arch/arm/plat-omap/timer32k.c
===================================================================
--- osk2.orig/arch/arm/plat-omap/timer32k.c	2006-10-25 14:06:19.000000000 -0700
+++ osk2/arch/arm/plat-omap/timer32k.c	2006-11-28 12:02:50.000000000 -0800
@@ -42,6 +42,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -171,15 +172,6 @@ omap_32k_ticks_to_nsecs(unsigned long ti
 static unsigned long omap_32k_last_tick = 0;
 
 /*
- * Returns elapsed usecs since last 32k timer interrupt
- */
-static unsigned long omap_32k_timer_gettimeoffset(void)
-{
-	unsigned long now = omap_32k_sync_timer_read();
-	return omap_32k_ticks_to_usecs(now - omap_32k_last_tick);
-}
-
-/*
  * Returns current time from boot in nsecs. It's OK for this to wrap
  * around for now, as it's just a relative time stamp.
  */
@@ -217,6 +209,19 @@ static inline irqreturn_t _omap_32k_time
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
+{
+	unsigned long flags;
+
+	write_seqlock_irqsave(&xtime_lock, flags);
+	_omap_32k_timer_interrupt(irq, dev_id);
+	write_sequnlock_irqrestore(&xtime_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+#ifdef CONFIG_NO_IDLE_HZ
+
 static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
 {
 	unsigned long now;
@@ -233,18 +238,6 @@ static irqreturn_t omap_32k_timer_handle
 	return _omap_32k_timer_interrupt(irq, dev_id);
 }
 
-static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long flags;
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
 /*
  * Programs the next timer interrupt needed. Called when dynamic tick is
  * enabled, and to reprogram the ticks to skip from pm_idle. Note that
@@ -302,7 +295,6 @@ static __init void omap_init_32k_timer(v
 
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
 	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -322,6 +314,39 @@ static __init void omap_init_32k_timer(v
 	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
 }
 
+
+/*
+ * ---------------------------------------------------------------------------
+ * 32KHz clocksource
+ * ---------------------------------------------------------------------------
+ */
+static cycle_t omap_32k_read(void)
+{
+	return omap_32k_sync_timer_read();
+}
+
+static struct clocksource clocksource_32k = {
+	.name		= "32k_timer",
+	.rating		= 250,
+	.read		= omap_32k_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 10,
+	.is_continuous	= 1,
+};
+
+static void __init omap_init_clocksource_32k(void)
+{
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	clocksource_32k.mult =
+		clocksource_khz2mult(32768, clocksource_32k.shift);
+
+	if (clocksource_register(&clocksource_32k))
+		printk(err, clocksource_32k.name);
+}
+
+
 /*
  * ---------------------------------------------------------------------------
  * Timer initialization
@@ -333,9 +358,9 @@ static void __init omap_timer_init(void)
 	omap_dm_timer_init();
 #endif
 	omap_init_32k_timer();
+	omap_init_clocksource_32k();
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
