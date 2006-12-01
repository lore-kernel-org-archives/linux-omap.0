From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Add clocksource driver for OMAP1 and OMAP2
Date: Fri, 01 Dec 2006 19:22:56 +0100
Message-ID: <45707300.1090409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030203000302050601060006"
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
--------------030203000302050601060006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Add clocksource driver for OMAP.

This is an update of

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

from Daniel Walker and Kevin Hilman.

Changes from Dirk Behme:

- Apply cleanly to recent git (pt_regs change)
- Move clocksource init to extra function. Can be called
later by clocksource subsystem
- Remove warning
arch/arm/plat-omap/timer32k.c:216: warning:
'omap_32k_timer_handler' defined but not used
if CONFIG_NO_IDLE_HZ isn't set.
- Minor cleanups

Changes from David Brownell:

   - OMAP1 MPU timer:
       * consult clock framework to determine xtal clock
       * use timer1 as a real free-running clock
   - OMAP2 GP timer
       * use timer2 as a real free-running clock
   - Both: minor cleanups
   - Kconfig updates

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>


--------------030203000302050601060006
Content-Type: text/plain;
 name="omap_clocksource_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_clocksource_patch.txt"

Index: linux-osk/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/Kconfig
+++ linux-osk/arch/arm/plat-omap/Kconfig
@@ -125,6 +125,7 @@ choice
 
 config OMAP_MPU_TIMER
 	bool "Use mpu timer"
+	select GENERIC_TIME
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
Index: linux-osk/arch/arm/mach-omap1/time.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/time.c
+++ linux-osk/arch/arm/mach-omap1/time.c
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
Index: linux-osk/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/timer32k.c
+++ linux-osk/arch/arm/plat-omap/timer32k.c
@@ -42,6 +42,7 @@
 #include <linux/spinlock.h>
 #include <linux/err.h>
 #include <linux/clk.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -80,7 +81,8 @@ struct sys_timer omap_timer;
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
 
-#define OMAP_32K_TICKS_PER_HZ		(32768 / HZ)
+#define OMAP_32K_TICKS_PER_SEC		(32768)
+#define OMAP_32K_TICKS_PER_HZ		(OMAP_32K_TICKS_PER_SEC / HZ)
 
 /*
  * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
@@ -171,15 +173,6 @@ omap_32k_ticks_to_nsecs(unsigned long ti
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
@@ -217,6 +210,19 @@ static inline irqreturn_t _omap_32k_time
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
@@ -233,18 +239,6 @@ static irqreturn_t omap_32k_timer_handle
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
@@ -302,7 +296,6 @@ static __init void omap_init_32k_timer(v
 
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
 	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -322,6 +315,40 @@ static __init void omap_init_32k_timer(v
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
+		clocksource_hz2mult(OMAP_32K_TICKS_PER_SEC,
+				    clocksource_32k.shift);
+
+	if (clocksource_register(&clocksource_32k))
+		printk(err, clocksource_32k.name);
+}
+
+
 /*
  * ---------------------------------------------------------------------------
  * Timer initialization
@@ -333,9 +360,9 @@ static void __init omap_timer_init(void)
 	omap_dm_timer_init();
 #endif
 	omap_init_32k_timer();
+	omap_init_clocksource_32k();
 }
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
Index: linux-osk/arch/arm/mach-omap2/timer-gp.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/timer-gp.c
+++ linux-osk/arch/arm/mach-omap2/timer-gp.c
@@ -25,12 +25,15 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/clocksource.h>
 
 #include <asm/mach/time.h>
 #include <asm/arch/dmtimer.h>
 
-static struct omap_dm_timer *gptimer;
 
+static struct omap_dm_timer *gptimer, *clocksource;
+
+/* GP timer 1 generates timer tick irqs */
 static inline void omap2_gp_timer_start(unsigned long load_val)
 {
 	omap_dm_timer_set_load(gptimer, 1, 0xffffffff - load_val);
@@ -51,25 +54,55 @@ static irqreturn_t omap2_gp_timer_interr
 }
 
 static struct irqaction omap2_gp_timer_irq = {
-	.name		= "gp timer",
+	.name		= "gp_timer1",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
 	.handler	= omap2_gp_timer_interrupt,
 };
 
+
+/* GP timer 2 is a free running clock */
+static cycle_t gp_read(void)
+{
+	return omap_dm_timer_read_counter(clocksource);
+}
+
+static struct clocksource clocksource_gp = {
+	.name		= "gp_timer2",
+	.rating		= 300,
+	.read		= gp_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 24,
+	.is_continuous	= 1,
+};
+
+
 static void __init omap2_gp_timer_init(void)
 {
-	u32 tick_period;
+	unsigned long rate;
 
 	omap_dm_timer_init();
+
+	/* GP timer 1 */
 	gptimer = omap_dm_timer_request_specific(1);
 	BUG_ON(gptimer == NULL);
-
 	omap_dm_timer_set_source(gptimer, OMAP_TIMER_SRC_SYS_CLK);
-	tick_period = clk_get_rate(omap_dm_timer_get_fclk(gptimer)) / HZ;
-	tick_period -= 1;
+
+	rate = clk_get_rate(omap_dm_timer_get_fclk(gptimer));
 
 	setup_irq(omap_dm_timer_get_irq(gptimer), &omap2_gp_timer_irq);
-	omap2_gp_timer_start(tick_period);
+	omap2_gp_timer_start((rate / HZ) - 1);
+
+	/* GP timer 2 */
+	clocksource = omap_dm_timer_request_specific(2);
+	BUG_ON(clocksource == NULL);
+	omap_dm_timer_set_source(clocksource, OMAP_TIMER_SRC_SYS_CLK);
+
+	clocksource_gp.mult
+		= clocksource_khz2mult(rate/1000, clocksource_gp.shift);
+	omap_dm_timer_set_load(clocksource, 1, 0);
+	omap_dm_timer_start(clocksource);
+
+	(void) clocksource_register(&clocksource_gp);
 }
 
 struct sys_timer omap_timer = {


--------------030203000302050601060006
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030203000302050601060006--
