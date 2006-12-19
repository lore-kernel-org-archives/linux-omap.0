From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [RFC] Send OMAP clocksource and clockevent to rt mailing list
Date: Tue, 19 Dec 2006 20:12:02 +0100
Message-ID: <45883982.8080207@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000404090705030305050706"
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
To: OMAP-Linux <linux-omap-open-source@linux.omap.com>, Kevin Hilman <khilman@mvista.com>, Daniel Walker <dwalker@mvista.com>, David Brownell <david-b@pacbell.net>
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------000404090705030305050706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

recently, there were some ARM related clocksource and
clockevent patches sent to the rt mailing list [1]. Looks
like they didn't get too many objections :) So, I'd like to
send our clocksource and clockevent patches to that list as
well.

I took (in this order)

linux-2.6.19.tar.bz2 (clean Linus one, not our OMAP tree)
patch-2.6.19-rt15 [2]
patch-2.6.19-rt15-fixes.diff [3]

and then our patches

arm-hrt-kconfig-patch.txt
arm-no-hz-patch.txt
arm_omap_clocksource_patch.txt
arm_omap_clockevents_patch.txt

(from Daniel, Kevin, David and me) and updated them to apply
cleanly to Linus kernel + rt patch. Kernel built with these
patches applied boots at least on OSK. For reference, see 
patches in
attachment.

Any objections to send these patches in attachment to rt
mailing list?

Dirk

[1]
http://permalink.gmane.org/gmane.linux.rt.user/72
http://permalink.gmane.org/gmane.linux.rt.user/78

Umph, the archive looks broken. Best archive I get with

http://rss.gmane.org/gmane.linux.rt.user

Sender names and dates seem to be wrong there anyway.

[2] http://people.redhat.com/mingo/realtime-preempt/

[3] http://permalink.gmane.org/gmane.linux.rt.user/69


--------------000404090705030305050706
Content-Type: text/plain;
 name="arm-hrt-kconfig-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm-hrt-kconfig-patch.txt"

Subject: ARM: Kconfig support for GENERIC_CLOCKEVENTS

Index: linux-2.6.19/arch/arm/Kconfig
===================================================================
--- linux-2.6.19.orig/arch/arm/Kconfig
+++ linux-2.6.19/arch/arm/Kconfig
@@ -21,6 +21,10 @@ config GENERIC_TIME
 	bool
 	default n
 
+config GENERIC_CLOCKEVENTS
+	bool
+	default n
+
 config MMU
 	bool
 	default y
@@ -443,6 +447,8 @@ endmenu
 
 menu "Kernel Features"
 
+source "kernel/time/Kconfig"
+
 config SMP
 	bool "Symmetric Multi-Processing (EXPERIMENTAL)"
 	depends on EXPERIMENTAL && REALVIEW_MPCORE







--------------000404090705030305050706
Content-Type: text/plain;
 name="arm-no-hz-patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm-no-hz-patch.txt"

Subject: ARM: NO_HZ support

Index: linux-2.6.19/arch/arm/Kconfig
===================================================================
--- linux-2.6.19.orig/arch/arm/Kconfig
+++ linux-2.6.19/arch/arm/Kconfig
@@ -497,6 +497,7 @@ source kernel/Kconfig.preempt
 
 config NO_IDLE_HZ
 	bool "Dynamic tick timer"
+	depends on !GENERIC_CLOCKEVENTS
 	help
 	  Select this option if you want to disable continuous timer ticks
 	  and have them programmed to occur as required. This option saves







--------------000404090705030305050706
Content-Type: text/plain;
 name="arm_omap_clocksource_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_omap_clocksource_patch.txt"

Add clocksource driver for OMAP.

This is an update of

http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3876/1

from Daniel Walker and Kevin Hilman.

Changes from Dirk Behme:

   - Apply cleanly to recent git (pt_regs change)
   - Move clocksource init to extra function. Can be called
     later by clocksource subsystem
   - Remove warning: 'omap_32k_timer_handler' defined but not used
     when CONFIG_NO_IDLE_HZ isn't set.
   - Minor cleanups

Changes from David Brownell:

   - OMAP1, OMAP2: 32k clocksource is always available on 16xx and 24xx
   - OMAP1 MPU timer:
       * consult clock framework to determine xtal clock
       * bugfix sched_clock() low order bits
       * cleanup
   - Kconfig updates

Note that "MPU timer" still doesn't have lost tick support.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>



Index: linux-2.6.19/arch/arm/Kconfig
===================================================================
--- linux-2.6.19.orig/arch/arm/Kconfig
+++ linux-2.6.19/arch/arm/Kconfig
@@ -318,6 +318,7 @@ config ARCH_LH7A40X
 
 config ARCH_OMAP
 	bool "TI OMAP"
+	select GENERIC_TIME
 	help
 	  Support for TI's OMAP platform (OMAP1 and OMAP2).
 
Index: linux-2.6.19/arch/arm/plat-omap/common.c
===================================================================
--- linux-2.6.19.orig/arch/arm/plat-omap/common.c
+++ linux-2.6.19/arch/arm/plat-omap/common.c
@@ -156,3 +156,53 @@ static int __init omap_add_serial_consol
 	return add_preferred_console("ttyS", line, opt);
 }
 console_initcall(omap_add_serial_console);
+
+
+/*
+ * 32KHz clocksource ... always available, on pretty most chips except
+ * OMAP 730 and 1510.  Other timers could be used as clocksources, with
+ * higher resolution in free-running counter modes (e.g. 12 MHz xtal),
+ * but systems won't necessarily want to spend resources that way.
+ */
+
+#if defined(CONFIG_ARCH_OMAP16XX)
+#define TIMER_32K_SYNCHRONIZED		0xfffbc410
+#elif defined(CONFIG_ARCH_OMAP24XX)
+#define TIMER_32K_SYNCHRONIZED		0x48004010
+#endif
+
+#ifdef	TIMER_32K_SYNCHRONIZED
+
+#include <linux/clocksource.h>
+
+static cycle_t omap_32k_read(void)
+{
+	return omap_readl(TIMER_32K_SYNCHRONIZED);
+}
+
+static struct clocksource clocksource_32k = {
+	.name		= "32k_counter",
+	.rating		= 250,
+	.read		= omap_32k_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 10,
+	.is_continuous	= 1,
+};
+
+static int __init omap_init_clocksource_32k(void)
+{
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	if (cpu_is_omap16xx() || cpu_is_omap24xx()) {
+		clocksource_32k.mult = clocksource_hz2mult(32768,
+					    clocksource_32k.shift);
+
+		if (clocksource_register(&clocksource_32k))
+			printk(err, clocksource_32k.name);
+	}
+	return 0;
+}
+arch_initcall(omap_init_clocksource_32k);
+
+#endif	/* TIMER_32K_SYNCHRONIZED */
Index: linux-2.6.19/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.19.orig/arch/arm/plat-omap/timer32k.c
+++ linux-2.6.19/arch/arm/plat-omap/timer32k.c
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
@@ -217,11 +209,6 @@ static inline irqreturn_t _omap_32k_time
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
-{
-	return _omap_32k_timer_interrupt(irq, dev_id);
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
 	unsigned long flags;
@@ -234,6 +221,7 @@ static irqreturn_t omap_32k_timer_interr
 }
 
 #ifdef CONFIG_NO_IDLE_HZ
+
 /*
  * Programs the next timer interrupt needed. Called when dynamic tick is
  * enabled, and to reprogram the ticks to skip from pm_idle. Note that
@@ -269,6 +257,22 @@ static int omap_32k_timer_disable_dyn_ti
 	return 0;
 }
 
+static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
+{
+	unsigned long now;
+
+	now = omap_32k_sync_timer_read();
+
+	/* Don't bother reprogramming timer if last tick was before next
+	 * jiffie. We will get another interrupt when previously programmed
+	 * timer expires. This cuts down interrupt load quite a bit.
+	 */
+	if (now - omap_32k_last_tick < OMAP_32K_TICKS_PER_HZ)
+		return IRQ_HANDLED;
+
+	return _omap_32k_timer_interrupt(irq, dev_id);
+}
+
 static struct dyn_tick_timer omap_dyn_tick_timer = {
 	.enable		= omap_32k_timer_enable_dyn_tick,
 	.disable	= omap_32k_timer_disable_dyn_tick,
@@ -291,7 +295,6 @@ static __init void omap_init_32k_timer(v
 
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
-	omap_timer.offset  = omap_32k_timer_gettimeoffset;
 	omap_32k_last_tick = omap_32k_sync_timer_read();
 
 #ifdef CONFIG_ARCH_OMAP2
@@ -326,5 +329,4 @@ static void __init omap_timer_init(void)
 
 struct sys_timer omap_timer = {
 	.init		= omap_timer_init,
-	.offset		= NULL,		/* Initialized later */
 };
Index: linux-2.6.19/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.19.orig/arch/arm/mach-omap1/time.c
+++ linux-2.6.19/arch/arm/mach-omap1/time.c
@@ -39,6 +39,9 @@
 #include <linux/interrupt.h>
 #include <linux/sched.h>
 #include <linux/spinlock.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/clocksource.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -48,13 +51,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-struct sys_timer omap_timer;
 
-/*
- * ---------------------------------------------------------------------------
- * MPU timer
- * ---------------------------------------------------------------------------
- */
 #define OMAP_MPU_TIMER_BASE		OMAP_MPU_TIMER1_BASE
 #define OMAP_MPU_TIMER_OFFSET		0x100
 
@@ -88,21 +85,6 @@ static inline unsigned long long cycles_
 	return (cyc * cyc2ns_scale) >> CYC2NS_SCALE_FACTOR;
 }
 
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
 
 typedef struct {
 	u32 cntl;			/* CNTL_TIMER, R/W */
@@ -131,87 +113,94 @@ static inline void omap_mpu_timer_start(
 	timer->cntl = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_AR | MPU_TIMER_ST);
 }
 
-unsigned long omap_mpu_timer_ticks_to_usecs(unsigned long nr_ticks)
+/*
+ * ---------------------------------------------------------------------------
+ * MPU timer 1 ... count down to zero, interrupt, reload
+ * ---------------------------------------------------------------------------
+ */
+static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
-	unsigned long long nsec;
+	write_seqlock(&xtime_lock);
+	/* NOTE:  no lost-tick detection/handling! */
+	timer_tick();
+	write_sequnlock(&xtime_lock);
 
-	nsec = cycles_2_ns((unsigned long long)nr_ticks);
-	return (unsigned long)nsec / 1000;
+	return IRQ_HANDLED;
 }
 
-/*
- * Last processed system timer interrupt
- */
-static unsigned long omap_mpu_timer_last = 0;
+static struct irqaction omap_mpu_timer1_irq = {
+	.name		= "mpu_timer1",
+	.flags		= IRQF_DISABLED | IRQF_TIMER,
+	.handler	= omap_mpu_timer1_interrupt,
+};
 
-/*
- * Returns elapsed usecs since last system timer interrupt
- */
-static unsigned long omap_mpu_timer_gettimeoffset(void)
+static __init void omap_init_mpu_timer(unsigned long rate)
 {
-	unsigned long now = 0 - omap_mpu_timer_read(0);
-	unsigned long elapsed = now - omap_mpu_timer_last;
+	set_cyc2ns_scale(rate / 1000);
 
-	return omap_mpu_timer_ticks_to_usecs(elapsed);
+	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
+	omap_mpu_timer_start(0, (rate / HZ) - 1);
 }
 
 /*
- * Elapsed time between interrupts is calculated using timer0.
- * Latency during the interrupt is calculated using timer1.
- * Both timer0 and timer1 are counting at 6MHz (P2 6.5MHz).
+ * ---------------------------------------------------------------------------
+ * MPU timer 2 ... free running 32-bit clock source and scheduler clock
+ * ---------------------------------------------------------------------------
  */
-static irqreturn_t omap_mpu_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long now, latency;
 
-	write_seqlock(&xtime_lock);
-	now = 0 - omap_mpu_timer_read(0);
-	latency = MPU_TICKS_PER_SEC / HZ - omap_mpu_timer_read(1);
-	omap_mpu_timer_last = now - latency;
-	timer_tick();
-	write_sequnlock(&xtime_lock);
+static unsigned long omap_mpu_timer2_overflows;
 
+static irqreturn_t omap_mpu_timer2_interrupt(int irq, void *dev_id)
+{
+	omap_mpu_timer2_overflows++;
 	return IRQ_HANDLED;
 }
 
-static struct irqaction omap_mpu_timer_irq = {
-	.name		= "mpu timer",
-	.flags		= IRQF_DISABLED | IRQF_TIMER,
-	.handler	= omap_mpu_timer_interrupt,
+static struct irqaction omap_mpu_timer2_irq = {
+	.name		= "mpu_timer2",
+	.flags		= IRQF_DISABLED,
+	.handler	= omap_mpu_timer2_interrupt,
 };
 
-static unsigned long omap_mpu_timer1_overflows;
-static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
+static cycle_t mpu_read(void)
 {
-	omap_mpu_timer1_overflows++;
-	return IRQ_HANDLED;
+	return ~omap_mpu_timer_read(1);
 }
 
-static struct irqaction omap_mpu_timer1_irq = {
-	.name		= "mpu timer1 overflow",
-	.flags		= IRQF_DISABLED,
-	.handler	= omap_mpu_timer1_interrupt,
+static struct clocksource clocksource_mpu = {
+	.name		= "mpu_timer2",
+	.rating		= 300,
+	.read		= mpu_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.shift		= 24,
+	.is_continuous	= 1,
 };
 
-static __init void omap_init_mpu_timer(void)
+static void __init omap_init_clocksource(unsigned long rate)
 {
-	set_cyc2ns_scale(MPU_TICKS_PER_SEC / 1000);
-	omap_timer.offset = omap_mpu_timer_gettimeoffset;
-	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	setup_irq(INT_TIMER2, &omap_mpu_timer_irq);
-	omap_mpu_timer_start(0, 0xffffffff);
-	omap_mpu_timer_start(1, MPU_TIMER_TICK_PERIOD);
+	static char err[] __initdata = KERN_ERR
+			"%s: can't register clocksource!\n";
+
+	clocksource_mpu.mult
+		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
+
+	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
+	omap_mpu_timer_start(1, ~0);
+
+	if (clocksource_register(&clocksource_mpu))
+		printk(err, clocksource_mpu.name);
 }
 
+
 /*
  * Scheduler clock - returns current time in nanosec units.
  */
 unsigned long long sched_clock(void)
 {
-	unsigned long ticks = 0 - omap_mpu_timer_read(0);
+	unsigned long ticks = 0 - omap_mpu_timer_read(1);
 	unsigned long long ticks64;
 
-	ticks64 = omap_mpu_timer1_overflows;
+	ticks64 = omap_mpu_timer2_overflows;
 	ticks64 <<= 32;
 	ticks64 |= ticks;
 
@@ -225,10 +214,21 @@ unsigned long long sched_clock(void)
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




--------------000404090705030305050706
Content-Type: text/plain;
 name="arm_omap_clockevents_patch.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arm_omap_clockevents_patch.txt"

Index: linux-2.6.19/arch/arm/mach-omap1/time.c
===================================================================
--- linux-2.6.19.orig/arch/arm/mach-omap1/time.c
+++ linux-2.6.19/arch/arm/mach-omap1/time.c
@@ -42,6 +42,7 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -102,15 +103,33 @@ static inline unsigned long omap_mpu_tim
 	return timer->read_tim;
 }
 
-static inline void omap_mpu_timer_start(int nr, unsigned long load_val)
+static inline void omap_mpu_set_autoreset(int nr)
+{
+ 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+
+	timer->cntl = timer->cntl | MPU_TIMER_AR;
+}
+
+static inline void omap_mpu_remove_autoreset(int nr)
 {
 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
 
+	timer->cntl = timer->cntl & ~MPU_TIMER_AR;
+}
+
+static inline void omap_mpu_timer_start(int nr, unsigned long load_val,
+					int autoreset)
+{
+	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+	unsigned int timerflags = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_ST);
+
+	if (autoreset) timerflags |= MPU_TIMER_AR;
+
 	timer->cntl = MPU_TIMER_CLOCK_ENABLE;
 	udelay(1);
 	timer->load_tim = load_val;
         udelay(1);
-	timer->cntl = (MPU_TIMER_CLOCK_ENABLE | MPU_TIMER_AR | MPU_TIMER_ST);
+	timer->cntl = timerflags;
 }
 
 /*
@@ -118,12 +137,39 @@ static inline void omap_mpu_timer_start(
  * MPU timer 1 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
+static void omap_mpu_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	omap_mpu_timer_start(0, cycles, 0);
+}
+
+static void omap_mpu_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_PERIODIC:
+		omap_mpu_set_autoreset(0);
+		break;
+	case CLOCK_EVT_ONESHOT:
+		omap_mpu_remove_autoreset(0);
+		break;
+	case CLOCK_EVT_SHUTDOWN:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_mpu_timer1 = {
+	.name		= "mpu_timer1",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE,
+	.shift		= 32,
+	.set_next_event	= omap_mpu_set_next_event,
+	.set_mode	= omap_mpu_set_mode,
+};
+
 static irqreturn_t omap_mpu_timer1_interrupt(int irq, void *dev_id)
 {
-	write_seqlock(&xtime_lock);
-	/* NOTE:  no lost-tick detection/handling! */
-	timer_tick();
-	write_sequnlock(&xtime_lock);
+	clockevent_mpu_timer1.event_handler();
 
 	return IRQ_HANDLED;
 }
@@ -139,9 +185,19 @@ static __init void omap_init_mpu_timer(u
 	set_cyc2ns_scale(rate / 1000);
 
 	setup_irq(INT_TIMER1, &omap_mpu_timer1_irq);
-	omap_mpu_timer_start(0, (rate / HZ) - 1);
+	omap_mpu_timer_start(0, (rate / HZ) - 1, 1);
+
+	clockevent_mpu_timer1.mult = div_sc(rate, NSEC_PER_SEC,
+					    clockevent_mpu_timer1.shift);
+	clockevent_mpu_timer1.max_delta_ns =
+		clockevent_delta2ns(-1, &clockevent_mpu_timer1);
+	clockevent_mpu_timer1.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_mpu_timer1);
+
+        register_global_clockevent(&clockevent_mpu_timer1);
 }
 
+
 /*
  * ---------------------------------------------------------------------------
  * MPU timer 2 ... free running 32-bit clock source and scheduler clock
@@ -185,7 +241,7 @@ static void __init omap_init_clocksource
 		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
 
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
-	omap_mpu_timer_start(1, ~0);
+	omap_mpu_timer_start(1, ~0, 1);
 
 	if (clocksource_register(&clocksource_mpu))
 		printk(err, clocksource_mpu.name);
Index: linux-2.6.19/arch/arm/plat-omap/Kconfig
===================================================================
--- linux-2.6.19.orig/arch/arm/plat-omap/Kconfig
+++ linux-2.6.19/arch/arm/plat-omap/Kconfig
@@ -11,6 +11,8 @@ choice
 
 config ARCH_OMAP1
 	bool "TI OMAP1"
+ 	select GENERIC_TIME
+	select GENERIC_CLOCKEVENTS
 
 config ARCH_OMAP2
 	bool "TI OMAP2"
Index: linux-2.6.19/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-2.6.19.orig/arch/arm/plat-omap/timer32k.c
+++ linux-2.6.19/arch/arm/plat-omap/timer32k.c
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -81,13 +82,13 @@ struct sys_timer omap_timer;
 #define OMAP1_32K_TIMER_TVR		0x00
 #define OMAP1_32K_TIMER_TCR		0x04
 
-#define OMAP_32K_TICKS_PER_HZ		(32768 / HZ)
+#define OMAP_32K_TICKS_PER_SEC		(32768)
 
 /*
  * TRM says 1 / HZ = ( TVR + 1) / 32768, so TRV = (32768 / HZ) - 1
  * so with HZ = 128, TVR = 255.
  */
-#define OMAP_32K_TIMER_TICK_PERIOD	((32768 / HZ) - 1)
+#define OMAP_32K_TIMER_TICK_PERIOD	((OMAP_32K_TICKS_PER_SEC / HZ) - 1)
 
 #define JIFFIES_TO_HW_TICKS(nr_jiffies, clock_rate)			\
 				(((nr_jiffies) * (clock_rate)) / HZ)
@@ -143,6 +144,49 @@ static inline void omap_32k_timer_ack_ir
 
 #endif
 
+static void omap_32k_timer_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	omap_32k_timer_stop();
+	omap_32k_timer_start(cycles);
+	local_irq_restore(flags);
+}
+
+static void omap_32k_timer_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	static int periodic_requests = 0;
+
+	switch (mode) {
+	case CLOCK_EVT_ONESHOT:
+		/* 32k timer does not have one-shot support in hardware.
+		 * instead, wet just to a stop in the next_event hook,
+		 * and dont support PERIODIC */
+		break;
+	case CLOCK_EVT_PERIODIC:
+		if (periodic_requests)
+			printk(KERN_ERR "32k-timer: CLOCK_EVT_PERIODIC "
+			       "is not supported.\n");
+		periodic_requests++;
+		break;
+	case CLOCK_EVT_SHUTDOWN:
+		omap_32k_timer_stop();
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_32k_timer = {
+	.name		= "32k-timer",
+	.capabilities	= CLOCK_CAP_NEXTEVT | CLOCK_CAP_TICK |
+			  CLOCK_CAP_UPDATE,
+	.shift		= 32,
+	.set_next_event	= omap_32k_timer_set_next_event,
+	.set_mode	= omap_32k_timer_set_mode,
+};
+
 /*
  * The 32KHz synchronized timer is an additional timer on 16xx.
  * It is always running.
@@ -180,107 +224,15 @@ unsigned long long sched_clock(void)
 	return omap_32k_ticks_to_nsecs(omap_32k_sync_timer_read());
 }
 
-/*
- * Timer interrupt for 32KHz timer. When dynamic tick is enabled, this
- * function is also called from other interrupts to remove latency
- * issues with dynamic tick. In the dynamic tick case, we need to lock
- * with irqsave.
- */
-static inline irqreturn_t _omap_32k_timer_interrupt(int irq, void *dev_id)
-{
-	unsigned long now;
-
-	omap_32k_timer_ack_irq();
-	now = omap_32k_sync_timer_read();
-
-	while ((signed long)(now - omap_32k_last_tick)
-						>= OMAP_32K_TICKS_PER_HZ) {
-		omap_32k_last_tick += OMAP_32K_TICKS_PER_HZ;
-		timer_tick();
-	}
-
-	/* Restart timer so we don't drift off due to modulo or dynamic tick.
-	 * By default we program the next timer to be continuous to avoid
-	 * latencies during high system load. During dynamic tick operation the
-	 * continuous timer can be overridden from pm_idle to be longer.
-	 */
-	omap_32k_timer_start(omap_32k_last_tick + OMAP_32K_TICKS_PER_HZ - now);
-
-	return IRQ_HANDLED;
-}
-
 static irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long flags;
+	omap_32k_timer_ack_irq();
 
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
+	clockevent_32k_timer.event_handler();
 
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_NO_IDLE_HZ
-
-/*
- * Programs the next timer interrupt needed. Called when dynamic tick is
- * enabled, and to reprogram the ticks to skip from pm_idle. Note that
- * we can keep the timer continuous, and don't need to set it to run in
- * one-shot mode. This is because the timer will get reprogrammed again
- * after next interrupt.
- */
-void omap_32k_timer_reprogram(unsigned long next_tick)
-{
-	unsigned long ticks = JIFFIES_TO_HW_TICKS(next_tick, 32768) + 1;
-	unsigned long now = omap_32k_sync_timer_read();
-	unsigned long idled = now - omap_32k_last_tick;
-
-	if (idled + 1 < ticks)
-		ticks -= idled;
-	else
-		ticks = 1;
-	omap_32k_timer_start(ticks);
-}
-
-static struct irqaction omap_32k_timer_irq;
-extern struct timer_update_handler timer_update;
-
-static int omap_32k_timer_enable_dyn_tick(void)
-{
-	/* No need to reprogram timer, just use the next interrupt */
-	return 0;
-}
-
-static int omap_32k_timer_disable_dyn_tick(void)
-{
-	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
-	return 0;
-}
-
-static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
-{
-	unsigned long now;
-
-	now = omap_32k_sync_timer_read();
-
-	/* Don't bother reprogramming timer if last tick was before next
-	 * jiffie. We will get another interrupt when previously programmed
-	 * timer expires. This cuts down interrupt load quite a bit.
-	 */
-	if (now - omap_32k_last_tick < OMAP_32K_TICKS_PER_HZ)
-		return IRQ_HANDLED;
-
-	return _omap_32k_timer_interrupt(irq, dev_id);
-}
-
-static struct dyn_tick_timer omap_dyn_tick_timer = {
-	.enable		= omap_32k_timer_enable_dyn_tick,
-	.disable	= omap_32k_timer_disable_dyn_tick,
-	.reprogram	= omap_32k_timer_reprogram,
-	.handler	= omap_32k_timer_handler,
-};
-#endif	/* CONFIG_NO_IDLE_HZ */
-
 static struct irqaction omap_32k_timer_irq = {
 	.name		= "32KHz timer",
 	.flags		= IRQF_DISABLED | IRQF_TIMER,
@@ -289,10 +241,6 @@ static struct irqaction omap_32k_timer_i
 
 static __init void omap_init_32k_timer(void)
 {
-#ifdef CONFIG_NO_IDLE_HZ
-	omap_timer.dyn_tick = &omap_dyn_tick_timer;
-#endif
-
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
 	omap_32k_last_tick = omap_32k_sync_timer_read();
@@ -312,6 +260,16 @@ static __init void omap_init_32k_timer(v
 #endif
 
 	omap_32k_timer_start(OMAP_32K_TIMER_TICK_PERIOD);
+
+	clockevent_32k_timer.mult = div_sc(OMAP_32K_TICKS_PER_SEC, 
+					   NSEC_PER_SEC,
+					   clockevent_32k_timer.shift);
+	clockevent_32k_timer.max_delta_ns =
+		clockevent_delta2ns(0xfffffffe, &clockevent_32k_timer);
+	clockevent_32k_timer.min_delta_ns =
+		clockevent_delta2ns(1, &clockevent_32k_timer);
+
+	register_global_clockevent(&clockevent_32k_timer);
 }
 
 /*



--------------000404090705030305050706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------000404090705030305050706--
