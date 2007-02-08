From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: OMAP1 realtime patch
Date: Thu, 08 Feb 2007 19:09:57 +0100
Message-ID: <45CB6775.7020500@googlemail.com>
References: <45C785A4.6080007@googlemail.com>
	<1170882015.11368.25.camel@vence.hilman.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080101080207030701060909"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <1170882015.11368.25.camel@vence.hilman.org>
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
--------------080101080207030701060909
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote:
> Here is a patch which leaves out the raw_spinlock conversions.  It goes
> on the OMAP git tree on top of -rt5 (ignoring conflicts.)  I've left out
> all the raw_spinlock conversions.  This has been tested on an
> OMAP1623/H2 platform.

Update of Kevins update. Tested on OSK.

Changes:

- Remove kernel/printk.c "+    zap_rt_locks();". It's 
already in -rt5.

- Re-add HRTIMER conversion to ads7846.c

With this patch I get Oops below after playing mp3 via NFS. 
Add raw_spinlock_t to sound/arm/omap/omap-alsa-dma.c like in 
my original patch doesn't seem to help.

Dirk


10337 frames decoded (0:04:30.0), +1.3 dB peak amplitude, 
295 clipped samples
kernel BUG at kernel/rtmutex.c:650!
Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
pgd = c0004000
[00000000] *pgd=00000000
Internal error: Oops: 817 [#1]
Modules linked in: ppp_async ppp_generic slhc crc_ccitt 
rfcomm l2cap hci_usb blueti
CPU: 0
PC is at __bug+0x20/0x2c
LR is at 0xc02350f0
pc : [<c0028aa8>]    lr : [<c02350f0>]    Not tainted
sp : c032fe04  ip : 60000093  fp : c032fe10
r10: 00000000  r9 : 00000013  r8 : 00000000
r7 : 00000000  r6 : c1979d14  r5 : c032e000  r4 : a0000013
r3 : 00000000  r2 : 00000001  r1 : c032e000  r0 : 00000027
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 5317F
Table: 11F90000  DAC: 00000017
Process IRQ-19 (pid: 30, stack limit = 0xc032e250)
Stack: (0xc032fe04 to 0xc0330000)
fe00:          c032fe68 c032fe14 c01bcc58 c0028a98 c035d160 
c032fe4c c032fe28
fe20: c00467f0 c0045fac 00000007 c02482a4 c035d160 00000000 
00000001 00000000
fe40: c032fe74 c1979cec 00000000 c1979d14 00000000 00000000 
00000000 c032fe78
fe60: c032fe6c c01bd04c c01bcbc8 c032fe94 c032fe7c bf0b92b0 
c01bd01c bf0b6e6c
fe80: c1e20e00 00000001 c032fea4 c032fe98 bf0a7978 bf0b9250 
c032fec4 c032fea8
fea0: bf0a77c8 bf0a7934 c1c13c00 00b5bffe c1e20e00 c1c13c00 
c032fed4 c032fec8
fec0: bf0a799c bf0a7798 c032fef4 c032fed8 bf0ade9c bf0a7990 
c1979cec c1979d14
fee0: 00000000 00000013 c032ff0c c032fef8 bf0b94ac bf0adcdc 
0000ff7f c024677c
ff00: c032ff20 c032ff10 bf0b9bc0 bf0b9494 00000020 c032ff3c 
c032ff24 c0036b8c
ff20: bf0b9b68 00000000 00000000 c032e000 c032ff54 c032ff40 
c0036bc4 c0036ae4
ff40: c02c2d20 00000000 c032ff80 c032ff58 c006fef8 c0036bb8 
c0224740 c032e000
ff60: c0224740 00000013 c02c2d20 00000000 00000000 c032ffa4 
c032ff84 c0070590
ff80: c006fe9c c0224740 c032e000 c007099c 00000013 60000013 
c032ffcc c032ffa8
ffa0: c0070a90 c0070534 00000032 c0224740 c032e000 c007099c 
c02cbe88 00000000
ffc0: c032fff4 c032ffd0 c0060e24 c00709ac ffffffff ffffffff 
00000000 00000000
ffe0: 00000000 00000000 00000000 c032fff8 c004e1f4 c0060d4c 
00000000 00000000
Backtrace:
[<c0028a88>] (__bug+0x0/0x2c) from [<c01bcc58>] 
(rt_spin_lock_slowlock+0xa0/0x204)
[<c01bcbb8>] (rt_spin_lock_slowlock+0x0/0x204) from 
[<c01bd04c>] (rt_spin_lock+0x4)
[<c01bd00c>] (rt_spin_lock+0x0/0x44) from [<bf0b92b0>] 
(snd_omap_alsa_trigger+0x70)
[<bf0b9240>] (snd_omap_alsa_trigger+0x0/0xac 
[snd_omap_alsa_aic23]) from [<bf0a797)
  r6 = 00000001  r5 = C1E20E00  r4 = BF0B6E6C
[<bf0a7924>] (snd_pcm_do_stop+0x0/0x5c [snd_pcm]) from 
[<bf0a77c8>] (snd_pcm_actio)
[<bf0a7788>] (snd_pcm_action_single+0x0/0x7c [snd_pcm]) from 
[<bf0a799c>] (snd_pcm)
  r7 = C1C13C00  r6 = C1E20E00  r5 = 00B5BFFE  r4 = C1C13C00
[<bf0a7980>] (snd_pcm_drain_done+0x0/0x24 [snd_pcm]) from 
[<bf0ade9c>] (snd_pcm_pe)
[<bf0adccc>] (snd_pcm_period_elapsed+0x0/0x278 [snd_pcm]) 
from [<bf0b94ac>] (callb)
  r7 = 00000013  r6 = 00000000  r5 = C1979D14  r4 = C1979CEC
[<bf0b9484>] (callback_omap_alsa_sound_dma+0x0/0x54 
[snd_omap_alsa_aic23]) from [<)
  r5 = C024677C  r4 = 0000FF7F
[<bf0b9b58>] (sound_dma_irq_handler+0x0/0x80 
[snd_omap_alsa_aic23]) from [<c0036b8)
  r4 = 00000020
[<c0036ad4>] (omap1_dma_handle_ch+0x0/0xd4) from 
[<c0036bc4>] (omap1_dma_irq_handl)
  r6 = C032E000  r5 = 00000000  r4 = 00000000
[<c0036ba8>] (omap1_dma_irq_handler+0x0/0x34) from 
[<c006fef8>] (handle_IRQ_event+)
  r5 = 00000000  r4 = C02C2D20
[<c006fe8c>] (handle_IRQ_event+0x0/0xf8) from [<c0070590>] 
(thread_simple_irq+0x6c)
[<c0070524>] (thread_simple_irq+0x0/0xf4) from [<c0070a90>] 
(do_irqd+0xf4/0x398)
  r8 = 60000013  r7 = 00000013  r6 = C007099C  r5 = C032E000
  r4 = C0224740
[<c007099c>] (do_irqd+0x0/0x398) from [<c0060e24>] 
(kthread+0xe8/0x128)
  r8 = 00000000  r7 = C02CBE88  r6 = C007099C  r5 = C032E000
  r4 = C0224740
[<c0060d3c>] (kthread+0x0/0x128) from [<c004e1f4>] 
(do_exit+0x0/0x860)
  r7 = 00000000  r6 = 00000000  r5 = 00000000  r4 = 00000000
Code: e1a01000 e59f000c eb008bf1 e3a03000 (e5833000)
  <6>note: IRQ-19[30] exited with preempt_count 1

--------------080101080207030701060909
Content-Type: text/plain;
 name="patch-2.6.20-rt5-omap1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.20-rt5-omap1"

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

--------------080101080207030701060909
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080101080207030701060909--
