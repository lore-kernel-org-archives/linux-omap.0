From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: CONFIG_PREEMPT_RT patch on OSK
Date: Thu, 30 Nov 2006 14:12:05 -0400
Message-ID: <a0580c510611301012t3985c696q88834c4960acdf8f@mail.gmail.com>
References: <455EBA92.5050804@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <455EBA92.5050804@gmail.com>
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
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hello Dirk Behme


   I'm currently trying to achieve CONFIG_PREEMPT_RT on my OSK5912. As
you already got it working with some success, I'm asking for some
help.
   I followed your instructions. Using the last git tree (commit
e4bbd3ec9084824eba003cdf91378138f239d03f):
- I applied the clock source patch
- I applied the 2.6.19-rc6-rt3 patch and corrected the fail in
arch/arm/plat-omap/gpio.c.
- I also applied your changes.

  The source compiled without problems, but during the boot process it
fails just after mouting my rootfs. Here are the log messages:
[   16.717895] IP-Config: Complete:
[   16.721343]       device=eth0, addr=172.18.216.204,
mask=255.255.0.0, gw=255.255.255.255,
[   16.729858]      host=10.0.0.2, domain=, nis-domain=(none),
[   16.736206]      bootserver=255.255.255.255, rootserver=10.0.0.1, rootpath=
[   16.745910] Looking up port of RPC 100003/2 on 172.18.216.230
[   16.760009] Looking up port of RPC 100005/1 on 172.18.216.230
[   16.786193] VFS: Mounted root (nfs filesystem).
[   16.791900] Freeing init memory: 116K
[   16.829315] BUG: scheduling while atomic: IRQ 160/0x00000001/709, CPU#0
[   18.828186] NETDEV WATCHDOG: eth0: transmit timed out
[   21.828155] NETDEV WATCHDOG: eth0: transmit timed out


   Have you already faced this problem? Any missing spinlock
translation to raw_spinlock?


BR,


Eduardo Valentin

On 11/18/06, Dirk Behme <dirk.behme@googlemail.com> wrote:
> Hi,
>
> after Tony updated to -rc6 (thanks!) I tried latest
> CONFIG_PREEMPT_RT patch on OSK. For more details see [1].
>
> First, I applied our clocksource patch [2], then preempt rt
> patch [3]. This doesn't apply totally cleanly, it fails in
> arch/arm/plat-omap/gpio.c which seems to be different in
> mainline and our git. Fixing this and converting some OMAP
> specific spinlocks to raw_spinlocks (is this correct?) not
> in mainline, system boots. Resulting OMAP specific patch in
> attachment, apply it on top of [2] & [3].
>
> Result:
>
> - System boots
> - Can play MP3 via NFS, however Oops after MP3 finished [4]
>
> Still not perfect, but a starting point :)
>
> Maybe this is interesting for other people as well,
>
> Dirk
>
> [1] rt.wiki.kernel.org
>
> [2]
> http://linux.omap.com/pipermail/linux-omap-open-source/2006-November/008370.html
>
> [3]
> http://people.redhat.com/mingo/realtime-preempt/patch-2.6.19-rc6-rt3
>
>
>
> [4] Oops after madplay finishes:
>
> kernel BUG at kernel/rtmutex.c:672!
> Unable to handle kernel NULL pointer dereference at virtual
> address 00000000
> pgd = c0004000
> [00000000] *pgd=00000000
> Internal error: Oops: 817 [#1]
> PC is at __bug+0x44/0x58
> LR is at rt_up+0x4c/0x6c
>
>
>
> Index: linux-osk/arch/arm/mach-omap2/gpmc.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap2/gpmc.c
> +++ linux-osk/arch/arm/mach-omap2/gpmc.c
> @@ -61,7 +61,7 @@
>
>  static struct resource gpmc_mem_root;
>  static struct resource gpmc_cs_mem[GPMC_CS_NUM];
> -static spinlock_t      gpmc_mem_lock = SPIN_LOCK_UNLOCKED;
> +static raw_spinlock_t  gpmc_mem_lock = SPIN_LOCK_UNLOCKED;
>  static unsigned                gpmc_cs_map;
>
>  static void __iomem *gpmc_base =
> Index: linux-osk/arch/arm/plat-omap/debug-leds.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/debug-leds.c
> +++ linux-osk/arch/arm/plat-omap/debug-leds.c
> @@ -34,7 +34,7 @@
>   * one, or both.
>   */
>
> -static spinlock_t                      lock;
> +static raw_spinlock_t                  lock;
>  static struct h2p2_dbg_fpga __iomem    *fpga;
>  static u16                             led_state, hw_led_state;
>
> Index: linux-osk/arch/arm/plat-omap/dma.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dma.c
> +++ linux-osk/arch/arm/plat-omap/dma.c
> @@ -62,7 +62,7 @@ struct omap_dma_lch {
>
>  static int dma_chan_count;
>
> -static spinlock_t dma_chan_lock;
> +static raw_spinlock_t dma_chan_lock;
>  static struct omap_dma_lch dma_chan[OMAP_LOGICAL_DMA_CH_COUNT];
>
>  static const u8 omap1_dma_irq[OMAP_LOGICAL_DMA_CH_COUNT] = {
> Index: linux-osk/arch/arm/plat-omap/dmtimer.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dmtimer.c
> +++ linux-osk/arch/arm/plat-omap/dmtimer.c
> @@ -129,7 +129,7 @@ static struct clk *dm_source_clocks[3];
>  #endif
>
>  static const int dm_timer_count = ARRAY_SIZE(dm_timers);
> -static spinlock_t dm_timer_lock;
> +static raw_spinlock_t dm_timer_lock;
>
>  static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, int reg)
>  {
> Index: linux-osk/arch/arm/plat-omap/dsp/fifo.h
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/fifo.h
> +++ linux-osk/arch/arm/plat-omap/dsp/fifo.h
> @@ -22,7 +22,7 @@
>   */
>
>  struct fifo_struct {
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>         char *buf;
>         size_t sz;
>         size_t cnt;
> Index: linux-osk/arch/arm/plat-omap/dsp/ipbuf.h
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/ipbuf.h
> +++ linux-osk/arch/arm/plat-omap/dsp/ipbuf.h
> @@ -79,7 +79,7 @@ extern struct ipbuf_sys *ipbuf_sys_da, *
>  #define dsp_mem_disable_ipbuf()        dsp_mem_disable(ipbcfg.base)
>
>  struct ipblink {
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>         u16 top;
>         u16 tail;
>  };
> Index: linux-osk/arch/arm/plat-omap/dsp/mblog.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/mblog.c
> +++ linux-osk/arch/arm/plat-omap/dsp/mblog.c
> @@ -116,7 +116,7 @@ struct mblogent {
>  };
>
>  static struct {
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>         int wp;
>         unsigned long cnt, cnt_ad, cnt_da;
>         struct mblogent ent[MBLOG_DEPTH];
> Index: linux-osk/arch/arm/plat-omap/dsp/proclist.h
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/proclist.h
> +++ linux-osk/arch/arm/plat-omap/dsp/proclist.h
> @@ -27,8 +27,10 @@ struct proc_list {
>         struct file *file;
>  };
>
> -static __inline__ void proc_list_add(spinlock_t *lock, struct list_head *list,
> -                                    struct task_struct *tsk, struct file *file)
> +static __inline__ void proc_list_add(raw_spinlock_t *lock,
> +                                     struct list_head *list,
> +                                     struct task_struct *tsk,
> +                                     struct file *file)
>  {
>         struct proc_list *new;
>
> @@ -40,8 +42,10 @@ static __inline__ void proc_list_add(spi
>         spin_unlock(lock);
>  }
>
> -static __inline__ void proc_list_del(spinlock_t *lock, struct list_head *list,
> -                                    struct task_struct *tsk, struct file *file)
> +static __inline__ void proc_list_del(raw_spinlock_t *lock,
> +                                     struct list_head *list,
> +                                    struct task_struct *tsk,
> +                                     struct file *file)
>  {
>         struct proc_list *pl;
>
> @@ -64,7 +68,8 @@ static __inline__ void proc_list_del(spi
>         spin_unlock(lock);
>  }
>
> -static __inline__ void proc_list_flush(spinlock_t *lock, struct list_head *list)
> +static __inline__ void proc_list_flush(raw_spinlock_t *lock,
> +                                       struct list_head *list)
>  {
>         struct proc_list *pl;
>
> Index: linux-osk/arch/arm/plat-omap/dsp/task.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/dsp/task.c
> +++ linux-osk/arch/arm/plat-omap/dsp/task.c
> @@ -118,7 +118,7 @@ struct taskdev {
>         unsigned int usecount;
>         char name[TNM_LEN];
>         struct file_operations fops;
> -       spinlock_t proc_list_lock;
> +       raw_spinlock_t proc_list_lock;
>         struct list_head proc_list;
>         struct dsptask *task;
>
> @@ -133,7 +133,7 @@ struct taskdev {
>         /* write stuff */
>         wait_queue_head_t write_wait_q;
>         struct mutex write_mutex;
> -       spinlock_t wsz_lock;
> +       raw_spinlock_t wsz_lock;
>         size_t wsz;
>
>         /* tctl stuff */
> Index: linux-osk/arch/arm/plat-omap/gpio.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/gpio.c
> +++ linux-osk/arch/arm/plat-omap/gpio.c
> @@ -137,7 +137,7 @@ struct gpio_bank {
>         u32 saved_fallingdetect;
>         u32 saved_risingdetect;
>  #endif
> -       spinlock_t lock;
> +       raw_spinlock_t lock;
>  };
>
>  #define METHOD_MPUIO           0
> Index: linux-osk/arch/arm/plat-omap/mcbsp.c
> ===================================================================
> --- linux-osk.orig/arch/arm/plat-omap/mcbsp.c
> +++ linux-osk/arch/arm/plat-omap/mcbsp.c
> @@ -61,7 +61,7 @@ struct omap_mcbsp {
>         struct completion            tx_dma_completion;
>         struct completion            rx_dma_completion;
>
> -       spinlock_t                   lock;
> +       raw_spinlock_t                   lock;
>  };
>
>  static struct omap_mcbsp mcbsp[OMAP_MAX_MCBSP_COUNT];
> Index: linux-osk/drivers/input/touchscreen/ads7846.c
> ===================================================================
> --- linux-osk.orig/drivers/input/touchscreen/ads7846.c
> +++ linux-osk/drivers/input/touchscreen/ads7846.c
> @@ -100,7 +100,7 @@ struct ads7846 {
>         u16                     debounce_tol;
>         u16                     debounce_rep;
>
> -       spinlock_t              lock;
> +       raw_spinlock_t          lock;
>         struct hrtimer          timer;
>         unsigned                pendown:1;      /* P: lock */
>         unsigned                pending:1;      /* P: lock */
> @@ -454,7 +454,7 @@ static void ads7846_rx(void *ads)
>                         ts->spi->dev.bus_id, ts->tc.ignore, Rt);
>  #endif
>                 hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
> -                             HRTIMER_REL);
> +                             HRTIMER_MODE_REL);
>                 return;
>         }
>
> @@ -473,7 +473,8 @@ static void ads7846_rx(void *ads)
>                 ads7846_sync_events(ts);
>         }
>
> -       hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD), HRTIMER_REL);
> +       hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_PERIOD),
> +                                            HRTIMER_MODE_REL);
>  }
>
>  static int ads7846_debounce(void *ads, int data_idx, int *val)
> @@ -609,7 +610,7 @@ static irqreturn_t ads7846_irq(int irq,
>                         disable_irq(ts->spi->irq);
>                         ts->pending = 1;
>                         hrtimer_start(&ts->timer, ktime_set(0, TS_POLL_DELAY),
> -                                       HRTIMER_REL);
> +                                       HRTIMER_MODE_REL);
>                 }
>         }
>         spin_unlock_irqrestore(&ts->lock, flags);
> @@ -747,7 +748,7 @@ static int __devinit ads7846_probe(struc
>         ts->input = input_dev;
>         ts->hwmon = hwmon;
>
> -       hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_REL);
> +       hrtimer_init(&ts->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
>         ts->timer.function = ads7846_timer;
>
>         spin_lock_init(&ts->lock);
> Index: linux-osk/sound/arm/omap/omap-alsa-dma.c
> ===================================================================
> --- linux-osk.orig/sound/arm/omap/omap-alsa-dma.c
> +++ linux-osk/sound/arm/omap/omap-alsa-dma.c
> @@ -56,6 +56,7 @@
>  #include <linux/sysrq.h>
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/spinlock_types.h>
>
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> @@ -114,7 +115,7 @@
>
>  /**************************** DATA STRUCTURES *****************************************/
>
> -static spinlock_t dma_list_lock = SPIN_LOCK_UNLOCKED;
> +static raw_spinlock_t dma_list_lock = RAW_SPIN_LOCK_UNLOCKED(dma_list_lock);
>
>  static char nr_linked_channels = 1;
>
>
>
>
> _______________________________________________
> Linux-omap-open-source mailing list
> Linux-omap-open-source@linux.omap.com
> http://linux.omap.com/mailman/listinfo/linux-omap-open-source
>
>
>


-- 
Eduardo Bezerra Valentin
