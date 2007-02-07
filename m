From: Kevin Hilman <khilman@mvista.com>
Subject: Re: OMAP1 realtime patch
Date: Wed, 07 Feb 2007 13:00:15 -0800
Message-ID: <1170882015.11368.25.camel@vence.hilman.org>
References: <45C785A4.6080007@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-MLAQBamiEkgCc7ZF6cXN"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45C785A4.6080007@googlemail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


--=-MLAQBamiEkgCc7ZF6cXN
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2007-02-05 at 20:29 +0100, Dirk Behme wrote:
> For everybody interested please find in attachment my OMAP1
> realtime patch.

Dirk,

Was there a reason for the raw_spinlock conversions?  Did you run into
specific issues for converting those?  At first glance, I don't think
any of those are needed.  

Here is a patch which leaves out the raw_spinlock conversions.  It goes
on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
all the raw_spinlock conversions.  This has been tested on an
OMAP1623/H2 platform.

Kevin


--=-MLAQBamiEkgCc7ZF6cXN
Content-Disposition: attachment; filename=patch-2.6.20-rt5-omap1-fixups
Content-Type: text/x-patch; name=patch-2.6.20-rt5-omap1-fixups; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: dev/arch/arm/mach-omap1/time.c
===================================================================
--- dev.orig/arch/arm/mach-omap1/time.c
+++ dev/arch/arm/mach-omap1/time.c
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
 {
 	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
 
+	timer->cntl = timer->cntl | MPU_TIMER_AR;
+}
+
+static inline void omap_mpu_remove_autoreset(int nr)
+{
+	volatile omap_mpu_timer_regs_t* timer = omap_mpu_timer_base(nr);
+
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
@@ -118,12 +137,42 @@ static inline void omap_mpu_timer_start(
  * MPU timer 1 ... count down to zero, interrupt, reload
  * ---------------------------------------------------------------------------
  */
+static int omap_mpu_set_next_event(unsigned long cycles,
+				    struct clock_event_device *evt)
+{
+	omap_mpu_timer_start(0, cycles, 0);
+	return 0;
+}
+
+static void omap_mpu_set_mode(enum clock_event_mode mode,
+			      struct clock_event_device *evt)
+{
+	switch (mode) {
+	case CLOCK_EVT_MODE_PERIODIC:
+		omap_mpu_set_autoreset(0);
+		break;
+	case CLOCK_EVT_MODE_ONESHOT:
+		omap_mpu_remove_autoreset(0);
+		break;
+	case CLOCK_EVT_MODE_UNUSED:
+	case CLOCK_EVT_MODE_SHUTDOWN:
+		break;
+	}
+}
+
+static struct clock_event_device clockevent_mpu_timer1 = {
+	.name		= "mpu_timer1",
+	.features	= CLOCK_EVT_FEAT_PERIODIC, CLOCK_EVT_FEAT_ONESHOT,
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
+	struct clock_event_device *evt = &clockevent_mpu_timer1;
+
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -139,7 +188,17 @@ static __init void omap_init_mpu_timer(u
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
+	clockevent_mpu_timer1.cpumask = cpumask_of_cpu(0);
+	clockevents_register_device(&clockevent_mpu_timer1);
 }
 
 /*
@@ -173,7 +232,7 @@ static struct clocksource clocksource_mp
 	.read		= mpu_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 24,
-	.is_continuous	= 1,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static void __init omap_init_clocksource(unsigned long rate)
@@ -185,7 +244,7 @@ static void __init omap_init_clocksource
 		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
 
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
-	omap_mpu_timer_start(1, ~0);
+	omap_mpu_timer_start(1, ~0, 1);
 
 	if (clocksource_register(&clocksource_mpu))
 		printk(err, clocksource_mpu.name);
Index: dev/arch/arm/plat-omap/timer32k.c
===================================================================
--- dev.orig/arch/arm/plat-omap/timer32k.c
+++ dev/arch/arm/plat-omap/timer32k.c
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -210,23 +211,10 @@ unsigned long long sched_clock(void)
  */
 static inline irqreturn_t _omap_32k_timer_interrupt(int irq, void *dev_id)
 {
-	unsigned long now;
-
+	struct clock_event_device *evt = &clockevent_32k_timer;
 	omap_32k_timer_ack_irq();
-	now = omap_32k_sync_timer_read();
 
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
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
Index: dev/kernel/printk.c
===================================================================
--- dev.orig/kernel/printk.c
+++ dev/kernel/printk.c
@@ -464,6 +464,7 @@ static void zap_locks(void)
 	spin_lock_init(&logbuf_lock);
 	/* And make sure that we print immediately */
 	init_MUTEX(&console_sem);
+	zap_rt_locks();
 }
 
 static int printk_time = 0;
Index: dev/arch/arm/plat-omap/common.c
===================================================================
--- dev.orig/arch/arm/plat-omap/common.c
+++ dev/arch/arm/plat-omap/common.c
@@ -212,7 +212,7 @@ static struct clocksource clocksource_32
 	.read		= omap_32k_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 10,
-	.is_continuous	= 1,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static int __init omap_init_clocksource_32k(void)
Index: dev/kernel/irq/manage.c
===================================================================
--- dev.orig/kernel/irq/manage.c
+++ dev/kernel/irq/manage.c
@@ -593,6 +593,7 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;
 
+	restart:
 	if (action && !desc->depth) {
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, action);
@@ -601,6 +602,19 @@ static void thread_simple_irq(irq_desc_t
 		if (!noirqdebug)
 			note_interrupt(irq, desc, action_ret);
 	}
+
+	/*
+	 * Some boards will disable an interrupt when it
+	 * sets IRQ_PENDING . So we have to remove the flag
+	 * and re-enable to handle it.
+	 */
+	if (desc->status & IRQ_PENDING) {
+		desc->status &= ~IRQ_PENDING;
+		if (desc->chip)
+			desc->chip->enable(irq);
+		goto restart;
+	}
+
 	desc->status &= ~IRQ_INPROGRESS;
 }
 

--=-MLAQBamiEkgCc7ZF6cXN
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-MLAQBamiEkgCc7ZF6cXN--
