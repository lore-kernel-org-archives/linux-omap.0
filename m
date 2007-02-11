From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP1 realtime patch
Date: Sun, 11 Feb 2007 18:01:05 +0100
Message-ID: <45CF4BD1.6010109@googlemail.com>
References: <45C785A4.6080007@googlemail.com>
	<1170882015.11368.25.camel@vence.hilman.org>
	<45CB6775.7020500@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050203050002070502050909"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <45CB6775.7020500@googlemail.com>
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
--------------050203050002070502050909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Dirk Behme wrote:
> Kevin Hilman wrote:
> 
>> Here is a patch which leaves out the raw_spinlock conversions.  It goes
>> on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
>> all the raw_spinlock conversions.  This has been tested on an
>> OMAP1623/H2 platform.
> 
> Update of Kevins update. Tested on OSK.
> 
> Changes:
> 
> - Remove kernel/printk.c "+    zap_rt_locks();". It's already in -rt5.
> 
> - Re-add HRTIMER conversion to ads7846.c
> 
> With this patch I get Oops below after playing mp3 via NFS. Add 
> raw_spinlock_t to sound/arm/omap/omap-alsa-dma.c like in my original 
> patch doesn't seem to help.

Re-adding raw_spinlock_t to omap-alsa.h helps against this Oops.

Updated patch-2.6.20-rt5-omap2 in attachment.

Dirk

P.S.: As with Tony patches, omap2 stands here for "second 
-rt5 omap patch" and not for OMAP2 chips.


--------------050203050002070502050909
Content-Type: text/plain;
 name="patch-2.6.20-rt5-omap2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.20-rt5-omap2"

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
Index: linux-osk/arch/arm/plat-omap/common.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/common.c
+++ linux-osk/arch/arm/plat-omap/common.c
@@ -212,7 +212,7 @@ static struct clocksource clocksource_32
 	.read		= omap_32k_read,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.shift		= 10,
-	.is_continuous	= 1,
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static int __init omap_init_clocksource_32k(void)
Index: linux-osk/kernel/irq/manage.c
===================================================================
--- linux-osk.orig/kernel/irq/manage.c
+++ linux-osk/kernel/irq/manage.c
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
 
Index: linux-osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/ads7846.c
+++ linux-osk/drivers/input/touchscreen/ads7846.c
@@ -454,7 +454,7 @@ static void ads7846_rx(void *ads)
 			ts->spi->dev.bus_id, ts->tc.ignore, Rt);
 #endif
 		hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
-			      HRTIMER_REL);
+			      HRTIMER_MODE_REL);
 		return;
 	}
 
@@ -473,7 +473,8 @@ static void ads7846_rx(void *ads)
 		ads7846_sync_events(ts);
 	}
 
-	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
+	hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
+		      HRTIMER_MODE_REL);
 }
 
 static int ads7846_debounce(void *ads, int data_idx, int *val)
@@ -558,7 +559,7 @@ static void ads7846_rx_val(void *ads)
 				status);
 }
 
-static int ads7846_timer(struct hrtimer *handle)
+static enum hrtimer_restart ads7846_timer(struct hrtimer *handle)
 {
 	struct ads7846	*ts = container_of(handle, struct ads7846, timer);
 	int		status = 0;
@@ -609,7 +610,7 @@ static irqreturn_t ads7846_irq(int irq, 
 			disable_irq(ts->spi->irq);
 			ts->pending = 1;
 			hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
-					HRTIMER_REL);
+					HRTIMER_MODE_REL);
 		}
 	}
 	spin_unlock_irqrestore(&ts->lock, flags);
@@ -747,7 +748,7 @@ static int __devinit ads7846_probe(struc
 	ts->input = input_dev;
 	ts->hwmon = hwmon;
 
-	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_REL);
+	hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ts->timer.function = ads7846_timer;
 
 	spin_lock_init(&ts->lock);
Index: linux-osk/include/asm-arm/arch-omap/omap-alsa.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/omap-alsa.h
+++ linux-osk/include/asm-arm/arch-omap/omap-alsa.h
@@ -83,7 +83,7 @@ struct audio_stream {
 	int active:1;		/* we are using this stream for transfer now */
 	int period;		/* current transfer period */
 	int periods;		/* current count of periods registerd in the DMA engine */
-	spinlock_t dma_lock;	/* for locking in DMA operations */
+	raw_spinlock_t dma_lock;	/* for locking in DMA operations */
 	snd_pcm_substream_t *stream;	/* the pcm stream */
 	unsigned linked:1;	/* dma channels linked */
 	int offset;		/* store start position of the last period in the alsa buffer */

--------------050203050002070502050909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------050203050002070502050909--
