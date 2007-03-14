From: Dirk Behme <dirk.behme@googlemail.com>
Subject: OMAP1 realtime patch 2.6.21-rc3-rt0-omap1
Date: Wed, 14 Mar 2007 21:12:15 +0100
Message-ID: <45F8571F.1090505@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040206020907080501060901"
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------040206020907080501060901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Update of our realtime patch to most recent rt patch 
patch-2.6.21-rc3-rt0.

As ususal, use recent OMAP git as starting point, then apply 
patch-2.6.21-rc3-rt0 [1] ignoring conflicts, and on top of 
this patch in attachment.

Note: The raw_spinlock in plat-omap/gpio.c is directly from 
patch-2.6.21-rc3-rt0. Not tested yet if this and the other 
OMAP related raw_spinlock conversions in 
patch-2.6.21-rc3-rt0 are really necessary.

Cheers,

Dirk

[1] http://people.redhat.com/mingo/realtime-preempt/

--------------040206020907080501060901
Content-Type: text/plain;
 name="patch-2.6.21-rc3-rt0-omap1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.21-rc3-rt0-omap1"

Index: linux-osk/arch/arm/mach-omap1/time.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap1/time.c
+++ linux-osk/arch/arm/mach-omap1/time.c
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
@@ -185,7 +244,7 @@ static void __init omap_init_clocksource
 		= clocksource_khz2mult(rate/1000, clocksource_mpu.shift);
 
 	setup_irq(INT_TIMER2, &omap_mpu_timer2_irq);
-	omap_mpu_timer_start(1, ~0);
+	omap_mpu_timer_start(1, ~0, 1);
 
 	if (clocksource_register(&clocksource_mpu))
 		printk(err, clocksource_mpu.name);
Index: linux-osk/arch/arm/plat-omap/timer32k.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/timer32k.c
+++ linux-osk/arch/arm/plat-omap/timer32k.c
@@ -43,6 +43,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/clocksource.h>
+#include <linux/clockchips.h>
 
 #include <asm/system.h>
 #include <asm/hardware.h>
@@ -202,106 +203,16 @@ unsigned long long sched_clock(void)
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
-
-	write_seqlock_irqsave(&xtime_lock, flags);
-	_omap_32k_timer_interrupt(irq, dev_id);
-	write_sequnlock_irqrestore(&xtime_lock, flags);
-
-	return IRQ_HANDLED;
-}
-
-#ifdef CONFIG_NO_IDLE_HZ
-static irqreturn_t omap_32k_timer_handler(int irq, void *dev_id)
-{
-	unsigned long now;
+ 	struct clock_event_device *evt = &clockevent_32k_timer;
+ 	omap_32k_timer_ack_irq();
 
-	now = omap_32k_sync_timer_read();
+ 	evt->event_handler(evt);
 
-	/* Don't bother reprogramming timer if last tick was before next
-	 * jiffie. We will get another interrupt when previously programmed
-	 * timer expires. This cuts down interrupt load quite a bit.
-	 */
-	if (now - omap_32k_last_tick < OMAP_32K_TICKS_PER_HZ)
-		return IRQ_HANDLED;
-
-	return _omap_32k_timer_interrupt(irq, dev_id);
+  	return IRQ_HANDLED;
 }
 
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
@@ -310,10 +221,6 @@ static struct irqaction omap_32k_timer_i
 
 static __init void omap_init_32k_timer(void)
 {
-#ifdef CONFIG_NO_IDLE_HZ
-	omap_timer.dyn_tick = &omap_dyn_tick_timer;
-#endif
-
 	if (cpu_class_is_omap1())
 		setup_irq(INT_OS_TIMER, &omap_32k_timer_irq);
 	omap_32k_last_tick = omap_32k_sync_timer_read();
Index: linux-osk/kernel/irq/manage.c
===================================================================
--- linux-osk.orig/kernel/irq/manage.c
+++ linux-osk/kernel/irq/manage.c
@@ -628,6 +628,7 @@ static void thread_simple_irq(irq_desc_t
 	unsigned int irq = desc - irq_desc;
 	irqreturn_t action_ret;
 
+	restart:
 	if (action && !desc->depth) {
 		spin_unlock(&desc->lock);
 		action_ret = handle_IRQ_event(irq, action);
@@ -636,6 +637,19 @@ static void thread_simple_irq(irq_desc_t
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
 
Index: linux-osk/sound/arm/omap/omap-alsa.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa.c
+++ linux-osk/sound/arm/omap/omap-alsa.c
@@ -168,7 +168,6 @@ static void audio_stop_dma(struct audio_
 	unsigned long flags;
 	ADEBUG();
 
-	spin_lock_irqsave(&s->dma_lock, flags);
 	s->active = 0;
 	s->period = 0;
 	s->periods = 0;
@@ -177,8 +176,6 @@ static void audio_stop_dma(struct audio_
 	omap_stop_alsa_sound_dma(s);
 
 	omap_clear_alsa_sound_dma(s);
-
-	spin_unlock_irqrestore(&s->dma_lock, flags);
 }
 
 /*
Index: linux-osk/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio.c
+++ linux-osk/arch/arm/plat-omap/gpio.c
@@ -136,7 +136,7 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 #endif
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 #define METHOD_MPUIO		0

--------------040206020907080501060901
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040206020907080501060901--
