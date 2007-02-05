From: Dirk Behme <dirk.behme@googlemail.com>
Subject: OMAP1 realtime patch
Date: Mon, 05 Feb 2007 20:29:40 +0100
Message-ID: <45C785A4.6080007@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010204060502070901010708"
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
--------------010204060502070901010708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


For everybody interested please find in attachment my OMAP1
realtime patch.

It's tested on OSK and boots with both, MPU and 32KHz timer
and plays mp3 via NFS. It's against recent OMAP 2.6.20 git
tree and should be applied on top of patch-2.6.20-rt2 [1].
Note that with our OMAP git, patch-2.6.20-rt2 will not apply
cleanly due to differences between mainline and our git.
Ignore the resulting patch-2.6.20-rt2 rejects, using e.g.
quilt you have to use push -f to force apply.

Order to use:

1) OMAP 2.6.20 git [2]

2) patch-2.6.20-rt2 [1]

(The -rtX patches are frequently updated. > -rt2 patches
should work as well unless major changes)

3) patch-2.6.20-rt2-omap1 in attachment

For more info see [3].

Enjoy,

Dirk

[1] http://people.redhat.com/mingo/realtime-preempt/

[2]
http://source.mvista.com/git/gitweb.cgi?p=linux-omap-2.6.git;a=log

[3] http://rt.wiki.kernel.org/


--------------010204060502070901010708
Content-Type: text/plain;
 name="patch-2.6.20-rt2-omap1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.6.20-rt2-omap1"

Index: linux-osk/arch/arm/mach-omap2/gpmc.c
===================================================================
--- linux-osk.orig/arch/arm/mach-omap2/gpmc.c
+++ linux-osk/arch/arm/mach-omap2/gpmc.c
@@ -61,7 +61,7 @@
 
 static struct resource	gpmc_mem_root;
 static struct resource	gpmc_cs_mem[GPMC_CS_NUM];
-static spinlock_t	gpmc_mem_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t	gpmc_mem_lock = SPIN_LOCK_UNLOCKED;
 static unsigned		gpmc_cs_map;
 
 static void __iomem *gpmc_base =
Index: linux-osk/arch/arm/plat-omap/debug-leds.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/debug-leds.c
+++ linux-osk/arch/arm/plat-omap/debug-leds.c
@@ -34,7 +34,7 @@
  * one, or both.
  */
 
-static spinlock_t			lock;
+static raw_spinlock_t			lock;
 static struct h2p2_dbg_fpga __iomem	*fpga;
 static u16				led_state, hw_led_state;
 
Index: linux-osk/arch/arm/plat-omap/dma.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dma.c
+++ linux-osk/arch/arm/plat-omap/dma.c
@@ -62,7 +62,7 @@ struct omap_dma_lch {
 
 static int dma_chan_count;
 
-static spinlock_t dma_chan_lock;
+static raw_spinlock_t dma_chan_lock;
 static struct omap_dma_lch dma_chan[OMAP_LOGICAL_DMA_CH_COUNT];
 
 static const u8 omap1_dma_irq[OMAP_LOGICAL_DMA_CH_COUNT] = {
Index: linux-osk/arch/arm/plat-omap/dmtimer.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dmtimer.c
+++ linux-osk/arch/arm/plat-omap/dmtimer.c
@@ -129,7 +129,7 @@ static struct clk *dm_source_clocks[3];
 #endif
 
 static const int dm_timer_count = ARRAY_SIZE(dm_timers);
-static spinlock_t dm_timer_lock;
+static raw_spinlock_t dm_timer_lock;
 
 static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
 {
Index: linux-osk/arch/arm/plat-omap/dsp/fifo.h
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/fifo.h
+++ linux-osk/arch/arm/plat-omap/dsp/fifo.h
@@ -22,7 +22,7 @@
  */
 
 struct fifo_struct {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	char *buf;
 	size_t sz;
 	size_t cnt;
Index: linux-osk/arch/arm/plat-omap/dsp/ipbuf.h
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/ipbuf.h
+++ linux-osk/arch/arm/plat-omap/dsp/ipbuf.h
@@ -79,15 +79,15 @@ extern struct ipbuf_sys *ipbuf_sys_da, *
 #define dsp_mem_disable_ipbuf()	dsp_mem_disable(ipbcfg.base)
 
 struct ipblink {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	u16 top;
 	u16 tail;
 };
 
-#define IPBLINK_INIT {				\
-		.lock = SPIN_LOCK_UNLOCKED,	\
-		.top  = BID_NULL,		\
-		.tail = BID_NULL,		\
+#define IPBLINK_INIT {				               \
+		.lock = RAW_SPIN_LOCK_UNLOCKED(ipb_free.lock), \
+		.top  = BID_NULL,		               \
+		.tail = BID_NULL,		               \
 	}
 
 #define INIT_IPBLINK(link)			\
Index: linux-osk/arch/arm/plat-omap/dsp/mblog.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/mblog.c
+++ linux-osk/arch/arm/plat-omap/dsp/mblog.c
@@ -117,12 +117,12 @@ struct mblogent {
 };
 
 static struct {
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	int wp;
 	unsigned long cnt, cnt_ad, cnt_da;
 	struct mblogent ent[MBLOG_DEPTH];
 } mblog = {
-	.lock = SPIN_LOCK_UNLOCKED,
+	.lock = RAW_SPIN_LOCK_UNLOCKED(mblog.lock),
 };
 
 #ifdef CONFIG_OMAP_DSP_MBCMD_VERBOSE
Index: linux-osk/arch/arm/plat-omap/dsp/proclist.h
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/proclist.h
+++ linux-osk/arch/arm/plat-omap/dsp/proclist.h
@@ -27,8 +27,10 @@ struct proc_list {
 	struct file *file;
 };
 
-static __inline__ void proc_list_add(spinlock_t *lock, struct list_head *list,
-				     struct task_struct *tsk, struct file *file)
+static __inline__ void proc_list_add(raw_spinlock_t *lock,
+                                     struct list_head *list,
+                                     struct task_struct *tsk,
+                                     struct file *file)
 {
 	struct proc_list *new;
 
@@ -40,8 +42,10 @@ static __inline__ void proc_list_add(spi
 	spin_unlock(lock);
 }
 
-static __inline__ void proc_list_del(spinlock_t *lock, struct list_head *list,
-				     struct task_struct *tsk, struct file *file)
+static __inline__ void proc_list_del(raw_spinlock_t *lock,
+                                     struct list_head *list,
+				     struct task_struct *tsk,
+                                     struct file *file)
 {
 	struct proc_list *pl;
 
@@ -64,7 +68,8 @@ static __inline__ void proc_list_del(spi
 	spin_unlock(lock);
 }
 
-static __inline__ void proc_list_flush(spinlock_t *lock, struct list_head *list)
+static __inline__ void proc_list_flush(raw_spinlock_t *lock,
+                                       struct list_head *list)
 {
 	struct proc_list *pl;
 
Index: linux-osk/arch/arm/plat-omap/dsp/task.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/dsp/task.c
+++ linux-osk/arch/arm/plat-omap/dsp/task.c
@@ -117,7 +117,7 @@ struct taskdev {
 	unsigned int usecount;
 	char name[TNM_LEN];
 	struct file_operations fops;
-	spinlock_t proc_list_lock;
+	raw_spinlock_t proc_list_lock;
 	struct list_head proc_list;
 	struct dsptask *task;
 
@@ -132,7 +132,7 @@ struct taskdev {
 	/* write stuff */
 	wait_queue_head_t write_wait_q;
 	struct mutex write_mutex;
-	spinlock_t wsz_lock;
+	raw_spinlock_t wsz_lock;
 	size_t wsz;
 
 	/* tctl stuff */
Index: linux-osk/arch/arm/plat-omap/mcbsp.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/mcbsp.c
+++ linux-osk/arch/arm/plat-omap/mcbsp.c
@@ -61,7 +61,7 @@ struct omap_mcbsp {
 	struct completion            tx_dma_completion;
 	struct completion            rx_dma_completion;
 
-	spinlock_t                   lock;
+	raw_spinlock_t                   lock;
 };
 
 static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
Index: linux-osk/drivers/input/touchscreen/ads7846.c
===================================================================
--- linux-osk.orig/drivers/input/touchscreen/ads7846.c
+++ linux-osk/drivers/input/touchscreen/ads7846.c
@@ -100,7 +100,7 @@ struct ads7846 {
 	u16			debounce_tol;
 	u16			debounce_rep;
 
-	spinlock_t		lock;
+	raw_spinlock_t		lock;
 	struct hrtimer		timer;
 	unsigned		pendown:1;	/* P: lock */
 	unsigned		pending:1;	/* P: lock */
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
+                                            HRTIMER_MODE_REL);
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
Index: linux-osk/sound/arm/omap/omap-alsa-dma.c
===================================================================
--- linux-osk.orig/sound/arm/omap/omap-alsa-dma.c
+++ linux-osk/sound/arm/omap/omap-alsa-dma.c
@@ -56,6 +56,7 @@
 #include <linux/sysrq.h>
 #include <linux/interrupt.h>
 #include <linux/dma-mapping.h>
+#include <linux/spinlock_types.h>
 
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -114,7 +115,7 @@
 
 /**************************** DATA STRUCTURES *****************************************/
 
-static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
+static raw_spinlock_t dma_list_lock = RAW_SPIN_LOCK_UNLOCKED(dma_list_lock);
 
 static char nr_linked_channels = 1;
 
Index: linux-osk/include/asm-arm/arch-omap/mailbox.h
===================================================================
--- linux-osk.orig/include/asm-arm/arch-omap/mailbox.h
+++ linux-osk/include/asm-arm/arch-omap/mailbox.h
@@ -37,7 +37,7 @@ struct omap_mbox_ops {
 
 struct omap_mbox {
 	char *name;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 	unsigned int irq;
 	struct omap_mbox_ops *ops;
 
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
Index: linux-osk/arch/arm/plat-omap/gpio.c
===================================================================
--- linux-osk.orig/arch/arm/plat-omap/gpio.c
+++ linux-osk/arch/arm/plat-omap/gpio.c
@@ -137,7 +137,7 @@ struct gpio_bank {
 	u32 saved_fallingdetect;
 	u32 saved_risingdetect;
 #endif
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 #define METHOD_MPUIO		0
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
+static inline irqreturn_t omap_32k_timer_interrupt(int irq, void *dev_id)
 {
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
+	struct clock_event_device *evt = &clockevent_32k_timer;
+  	omap_32k_timer_ack_irq();
 
-	/* Restart timer so we don't drift off due to modulo or dynamic tick.
-	 * By default we program the next timer to be continuous to avoid
-	 * latencies during high system load. During dynamic tick operation the
-	 * continuous timer can be overridden from pm_idle to be longer.
-	 */
-	omap_32k_timer_start(omap_32k_last_tick + OMAP_32K_TICKS_PER_HZ - now);
+  	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
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
+				   struct clock_event_device *evt)
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
+	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
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
+        clockevents_register_device(&clockevent_mpu_timer1);
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
 


--------------010204060502070901010708
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010204060502070901010708--
