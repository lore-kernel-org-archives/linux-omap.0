From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v5 10/12] OMAP: dmtimer: switch-over to platform device
 driver
Date: Mon, 13 Dec 2010 16:07:53 +0100
Message-ID: <4D0636C9.4050108@ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com> <1291679059-13419-11-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37048 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755113Ab0LMPH7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Dec 2010 10:07:59 -0500
In-Reply-To: <1291679059-13419-11-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, kevin Hilman <khilman@deeprootsystems.com>

Hi Tarun,

I'm just re-sending to a wider audience my comments.

On 12/7/2010 12:44 AM, DebBarma, Tarun Kanti wrote:
> switch-over to platform device driver through following changes:
> (a) call to dmtimer initialization routine from timer-gp.c is
> removed (b) initiate dmtimer early initialization from omap2_init_common_hw
> in io.c (c) modify plat-omap/dmtimer routines to use new register map and
> platform data.

[...]

> diff --git a/arch/arm/mach-omap2/dmtimer.c b/arch/arm/mach-omap2/dmtimer.c
> index b639082..50509c7 100644
> --- a/arch/arm/mach-omap2/dmtimer.c
> +++ b/arch/arm/mach-omap2/dmtimer.c
> @@ -172,3 +172,43 @@ static int __init omap_timer_init(struct omap_hwmod *oh, void *user)
>
>          return ret;
>   }
> +
> +/**
> + * omap2_dm_timer_early_init - top level early timer initialization
> + * called in the last part of omap2_init_common_hw
> + *
> + * Uses dedicated hwmod api to parse through hwmod database for
> + * given class name and then build and register the timer device.
> + * At the end driver is registered and early probe initiated.
> + */
> +void __init omap2_dm_timer_early_init(void)
> +{
> +       int early_init = 1; /* identify early init in omap2_timer_init() */
> +       int ret = omap_hwmod_for_each_by_class("timer",
> +               omap_timer_init,&early_init);
> +
> +       if (unlikely(ret)) {
> +               pr_debug("%s: device registration FAILED!\n", __func__);
> +               return;
> +       }
> +
> +       early_platform_driver_register_all("earlytimer");
> +       early_platform_driver_probe("earlytimer", early_timer_count, 0);
> +}
> +
> +/**
> + * omap2_dm_timer_init - top level timer normal device initialization
> + *
> + * Uses dedicated hwmod API to parse through hwmod database for
> + * given class names and then build and register the timer device.
> + */
> +static int __init omap2_dm_timer_init(void)
> +{
> +       int ret = omap_hwmod_for_each_by_class("timer", omap_timer_init, NULL);

Because of this second iteration, you are creating each device twice, 
and the early one is never deleted.

What should be done to avoid that and to avoid the double hwmod 
iteration is:
The first hwmod iteration will create the early device and populate the 
timer list, here you call the omap_device_build.
Then during the regular device init, you should not iterate again on the 
hwmod list, you just have to iterate through the timer list and
call omap_device_register. That will avoid to re-allocate the internal 
omap_device structures, and will simplify the code as well.

Removing the dmtimer list is probably something that will require some 
hacks in the early driver code itself of potentially in the omap_device 
one. This is clearly out of the scope for the series for my point of view.

Regards,
Benoit


> +
> +       if (unlikely(ret))
> +               pr_debug("%s: device registration FAILED!\n", __func__);
> +
> +       return ret;
> +}
> +arch_initcall(omap2_dm_timer_init);
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 40562dd..e6128b5 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -46,6 +46,7 @@
>   #include "clockdomains.h"
>
>   #include<plat/omap_hwmod.h>
> +#include "dmtimer.h"
>
>   /*
>    * The machine specific code may provide the extra mapping besides the
> @@ -352,4 +353,5 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>                  _omap2_init_reprogram_sdrc();
>          }
>          gpmc_init();
> +       omap2_dm_timer_early_init();
>   }
> diff --git a/arch/arm/mach-omap2/timer-gp.c b/arch/arm/mach-omap2/timer-gp.c
> index e13c29e..54fafac 100644
> --- a/arch/arm/mach-omap2/timer-gp.c
> +++ b/arch/arm/mach-omap2/timer-gp.c
> @@ -235,7 +235,6 @@ static void __init omap2_gp_timer_init(void)
>                  BUG_ON(!twd_base);
>          }
>   #endif
> -       omap_dm_timer_init();
>
>          omap2_gp_clockevent_init();
>          omap2_gp_clocksource_init();
> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> index ddc875b..ac6a498 100644
> --- a/arch/arm/plat-omap/dmtimer.c
> +++ b/arch/arm/plat-omap/dmtimer.c
> @@ -159,11 +159,8 @@
>                  (_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR<<  WPSHIFT))
>
>   struct omap_dm_timer {
> -       unsigned long phys_base;
>          int irq;
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -       struct clk *iclk, *fclk;
> -#endif
> +       struct clk *fclk;
>          void __iomem *io_base;
>          unsigned reserved:1;
>          unsigned enabled:1;
> @@ -172,117 +169,25 @@ struct omap_dm_timer {
>          struct list_head node;
>   };
>
> -static int dm_timer_count;
> -
> -#ifdef CONFIG_ARCH_OMAP2
> -static struct omap_dm_timer omap2_dm_timers[] = {
> -       { .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> -       { .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
> -       { .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
> -       { .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
> -       { .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
> -       { .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
> -       { .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
> -       { .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
> -       { .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
> -       { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -       { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -       { .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
> -};
> -
> -static const char *omap2_dm_source_names[] __initdata = {
> -       "sys_ck",
> -       "func_32k_ck",
> -       "alt_ck",
> -       NULL
> -};
> -
> -static struct clk *omap2_dm_source_clocks[3];
> -static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
> -
> -#else
> -#define omap2_dm_timers                        NULL
> -#define omap2_dm_timer_count           0
> -#define omap2_dm_source_names          NULL
> -#define omap2_dm_source_clocks         NULL
> -#endif /* CONFIG_ARCH_OMAP2 */
> -
> -#ifdef CONFIG_ARCH_OMAP3
> -static struct omap_dm_timer omap3_dm_timers[] = {
> -       { .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
> -       { .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
> -       { .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
> -       { .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
> -       { .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
> -       { .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
> -       { .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
> -       { .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
> -       { .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
> -       { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> -       { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> -       { .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
> -};
> -
> -static const char *omap3_dm_source_names[] __initdata = {
> -       "sys_ck",
> -       "omap_32k_fck",
> -       NULL
> -};
> -
> -static struct clk *omap3_dm_source_clocks[2];
> -static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
> -
> -#else
> -#define omap3_dm_timers                        NULL
> -#define omap3_dm_timer_count           0
> -#define omap3_dm_source_names          NULL
> -#define omap3_dm_source_clocks         NULL
> -#endif /* CONFIG_ARCH_OMAP3 */
> -
> -#ifdef CONFIG_ARCH_OMAP4
> -static struct omap_dm_timer omap4_dm_timers[] = {
> -       { .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
> -       { .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
> -       { .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
> -       { .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
> -       { .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
> -       { .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
> -       { .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
> -       { .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
> -       { .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
> -       { .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
> -       { .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
> -       { .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
> -};
> -static const char *omap4_dm_source_names[] __initdata = {
> -       "sys_clkin_ck",
> -       "sys_32k_ck",
> -       NULL
> -};
> -static struct clk *omap4_dm_source_clocks[2];
> -static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
> -
> -#else
> -#define omap4_dm_timers                        NULL
> -#define omap4_dm_timer_count           0
> -#define omap4_dm_source_names          NULL
> -#define omap4_dm_source_clocks         NULL
> -#endif /* CONFIG_ARCH_OMAP4 */
> -
> -static struct omap_dm_timer *dm_timers;
> -static const char **dm_source_names;
> -static struct clk **dm_source_clocks;
> -
>   static LIST_HEAD(omap_timer_list);
>   static DEFINE_SPINLOCK(dm_timer_lock);
>
> -/*
> - * Reads timer registers in posted and non-posted mode. The posted mode bit
> - * is encoded in reg. Note that in posted mode write pending bit must be
> - * checked. Otherwise a read of a non completed write will produce an error.
> +/**
> + * omap_dm_timer_read_reg - read timer registers in posted and non-posted mode
> + * @timer:      timer pointer over which read operation to perform
> + * @reg:        lowest byte holds the register offset
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode write
> + * pending bit must be checked. Otherwise a read of a non completed write
> + * will produce an error.
>    */
>   static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
>   {
> +       struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> +       if (reg>= OMAP_TIMER_WAKEUP_EN_REG)
> +               reg += pdata->func_offset;
> +       else if (reg>= OMAP_TIMER_STAT_REG)
> +               reg += pdata->intr_offset;
>          if (timer->posted)
>                  while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG&  0xff))
>                                  &  (reg>>  WPSHIFT))
> @@ -290,15 +195,24 @@ static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer, u32 reg)
>          return readl(timer->io_base + (reg&  0xff));
>   }
>
> -/*
> - * Writes timer registers in posted and non-posted mode. The posted mode bit
> - * is encoded in reg. Note that in posted mode the write pending bit must be
> - * checked. Otherwise a write on a register which has a pending write will be
> - * lost.
> +/**
> + * omap_dm_timer_write_reg - write timer registers in posted and non-posted mode
> + * @timer:      timer pointer over which write operation is to perform
> + * @reg:        lowest byte holds the register offset
> + * @value:      data to write into the register
> + *
> + * The posted mode bit is encoded in reg. Note that in posted mode the write
> + * pending bit must be checked. Otherwise a write on a register which has a
> + * pending write will be lost.
>    */
>   static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>                                                  u32 value)
>   {
> +       struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
> +       if (reg>= OMAP_TIMER_WAKEUP_EN_REG)
> +               reg += pdata->func_offset;
> +       else if (reg>= OMAP_TIMER_STAT_REG)
> +               reg += pdata->intr_offset;
>          if (timer->posted)
>                  while (readl(timer->io_base + (OMAP_TIMER_WRITE_PEND_REG&  0xff))
>                                  &  (reg>>  WPSHIFT))
> @@ -306,6 +220,8 @@ static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32 reg,
>          writel(value, timer->io_base + (reg&  0xff));
>   }
>
> +#if defined(CONFIG_ARCH_OMAP1)
> +
>   static void omap_dm_timer_wait_for_reset(struct omap_dm_timer *timer)
>   {
>          int c;
> @@ -324,54 +240,77 @@ static void omap_dm_timer_reset(struct omap_dm_timer *timer)
>   {
>          u32 l;
>
> -       if (!cpu_class_is_omap2() || timer !=&dm_timers[0]) {
> +       if (!cpu_class_is_omap2() || timer->pdev->id != 1) {
>                  omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
>                  omap_dm_timer_wait_for_reset(timer);
>          }
> -       omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>
>          l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
>          l |= 0x02<<  3;  /* Set to smart-idle mode */
>          l |= 0x2<<  8;   /* Set clock activity to perserve f-clock on idle */
>
> -       /*
> -        * Enable wake-up on OMAP2 CPUs.
> -        */
> -       if (cpu_class_is_omap2())
> -               l |= 1<<  2;
>          omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
>
> -       /* Match hardware reset default of posted mode */
> -       omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> -                       OMAP_TIMER_CTRL_POSTED);
> -       timer->posted = 1;
>   }
> +#endif
>
>   static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
>   {
> +       u32 l;
> +
> +       timer->fclk = clk_get(&timer->pdev->dev, "fck");
> +       if (IS_ERR_OR_NULL(timer->fclk)) {
> +               pr_info("omap_timer: failed to acquire fclk handle.\n");
> +               WARN_ON(1);
> +               return;
> +       }
> +
>          omap_dm_timer_enable(timer);
> +
> +#if defined(CONFIG_ARCH_OMAP1)
>          omap_dm_timer_reset(timer);
> +#endif
> +
> +       /*
> +        * Enable wake-up on OMAP2420, OMAP2430 and OMAP3430 CPUs.
> +        * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod.
> +        * But on OMAP2 code does not work without following configuration.
> +        * Need to investigate why this is happening.
> +        */
> +       if (is_omap2430() || is_omap2420() || is_omap3430()) {
> +               l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> +               l |= 1<<  2;
> +               omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> +       }
> +
> +       omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> +
> +       /* Match hardware reset default of posted mode */
> +       omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> +                       OMAP_TIMER_CTRL_POSTED);
> +       timer->posted = 1;
>   }
>
>   struct omap_dm_timer *omap_dm_timer_request(void)
>   {
> -       struct omap_dm_timer *timer = NULL;
> +       struct omap_dm_timer *timer = NULL, *t;
>          unsigned long flags;
> -       int i;
>
>          spin_lock_irqsave(&dm_timer_lock, flags);
> -       for (i = 0; i<  dm_timer_count; i++) {
> -               if (dm_timers[i].reserved)
> +       list_for_each_entry(t,&omap_timer_list, node) {
> +               if (t->reserved)
>                          continue;
>
> -               timer =&dm_timers[i];
> +               timer = t;
>                  timer->reserved = 1;
>                  break;
>          }
>          spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> -       if (timer != NULL)
> +       if (timer)
>                  omap_dm_timer_prepare(timer);
> +       else
> +               pr_debug("%s: free timer not available.\n", __func__);
>
>          return timer;
>   }
> @@ -379,23 +318,23 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request);
>
>   struct omap_dm_timer *omap_dm_timer_request_specific(int id)
>   {
> -       struct omap_dm_timer *timer;
> +       struct omap_dm_timer *timer = NULL, *t;
>          unsigned long flags;
>
>          spin_lock_irqsave(&dm_timer_lock, flags);
> -       if (id<= 0 || id>  dm_timer_count || dm_timers[id-1].reserved) {
> -               spin_unlock_irqrestore(&dm_timer_lock, flags);
> -               printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> -                      __FILE__, __LINE__, __func__, id);
> -               dump_stack();
> -               return NULL;
> +       list_for_each_entry(t,&omap_timer_list, node) {
> +               if (t->pdev->id == id&&  !t->reserved) {
> +                       timer = t;
> +                       timer->reserved = 1;
> +                       break;
> +               }
>          }
> -
> -       timer =&dm_timers[id-1];
> -       timer->reserved = 1;
>          spin_unlock_irqrestore(&dm_timer_lock, flags);
>
> -       omap_dm_timer_prepare(timer);
> +       if (timer)
> +               omap_dm_timer_prepare(timer);
> +       else
> +               pr_debug("%s: timer%d not available.\n", __func__, id);
>
>          return timer;
>   }
> @@ -403,10 +342,10 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
>
>   void omap_dm_timer_free(struct omap_dm_timer *timer)
>   {
> -       omap_dm_timer_enable(timer);
> -       omap_dm_timer_reset(timer);
>          omap_dm_timer_disable(timer);
>
> +       clk_put(timer->fclk);
> +
>          WARN_ON(!timer->reserved);
>          timer->reserved = 0;
>   }
> @@ -417,12 +356,7 @@ void omap_dm_timer_enable(struct omap_dm_timer *timer)
>          if (timer->enabled)
>                  return;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -       if (cpu_class_is_omap2()) {
> -               clk_enable(timer->fclk);
> -               clk_enable(timer->iclk);
> -       }
> -#endif
> +       clk_enable(timer->fclk);
>
>          timer->enabled = 1;
>   }
> @@ -433,12 +367,7 @@ void omap_dm_timer_disable(struct omap_dm_timer *timer)
>          if (!timer->enabled)
>                  return;
>
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -       if (cpu_class_is_omap2()) {
> -               clk_disable(timer->iclk);
> -               clk_disable(timer->fclk);
> -       }
> -#endif
> +       clk_disable(timer->fclk);
>
>          timer->enabled = 0;
>   }
> @@ -458,24 +387,29 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
>    */
>   __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
>   {
> -       int i;
> +       int i = 0;
> +       struct omap_dm_timer *timer = NULL;
> +       unsigned long flags;
>
>          /* If ARMXOR cannot be idled this function call is unnecessary */
>          if (!(inputmask&  (1<<  1)))
>                  return inputmask;
>
>          /* If any active timer is using ARMXOR return modified mask */
> -       for (i = 0; i<  dm_timer_count; i++) {
> +       spin_lock_irqsave(&dm_timer_lock, flags);
> +       list_for_each_entry(timer,&omap_timer_list, node) {
>                  u32 l;
>
> -               l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
> +               l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>                  if (l&  OMAP_TIMER_CTRL_ST) {
>                          if (((omap_readl(MOD_CONF_CTRL_1)>>  (i * 2))&  0x03) == 0)
>                                  inputmask&= ~(1<<  1);
>                          else
>                                  inputmask&= ~(1<<  2);
>                  }
> +               i++;
>          }
> +       spin_unlock_irqrestore(&dm_timer_lock, flags);
>
>          return inputmask;
>   }
> @@ -544,13 +478,17 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
>   int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
>   {
>          int ret = -EINVAL;
> +       struct dmtimer_platform_data *pdata = timer->pdev->dev.platform_data;
>
>          if (source<  0 || source>= 3)
>                  return -EINVAL;
>
> -       clk_disable(timer->fclk);
> -       ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
> -       clk_enable(timer->fclk);
> +       omap_dm_timer_disable(timer);
> +
> +       /* change the timer clock source */
> +       ret = pdata->set_timer_src(timer->pdev, source);
> +
> +       omap_dm_timer_enable(timer);
>
>          /*
>           * When the functional clock disappears, too quick writes seem
> @@ -687,13 +625,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
>
>   int omap_dm_timers_active(void)
>   {
> -       int i;
> -
> -       for (i = 0; i<  dm_timer_count; i++) {
> -               struct omap_dm_timer *timer;
> -
> -               timer =&dm_timers[i];
> +       struct omap_dm_timer *timer;
>
> +       list_for_each_entry(timer,&omap_timer_list, node) {
>                  if (!timer->enabled)
>                          continue;
>
> @@ -855,56 +789,3 @@ MODULE_LICENSE("GPL");
>   MODULE_ALIAS("platform:" DRIVER_NAME);
>   MODULE_AUTHOR("Texas Instruments Inc");
>
> -int __init omap_dm_timer_init(void)
> -{
> -       struct omap_dm_timer *timer;
> -       int i, map_size = SZ_8K;        /* Module 4KB + L4 4KB except on omap1 */
> -
> -       if (!cpu_class_is_omap2())
> -               return -ENODEV;
> -
> -
> -       if (cpu_is_omap24xx()) {
> -               dm_timers = omap2_dm_timers;
> -               dm_timer_count = omap2_dm_timer_count;
> -               dm_source_names = omap2_dm_source_names;
> -               dm_source_clocks = omap2_dm_source_clocks;
> -       } else if (cpu_is_omap34xx()) {
> -               dm_timers = omap3_dm_timers;
> -               dm_timer_count = omap3_dm_timer_count;
> -               dm_source_names = omap3_dm_source_names;
> -               dm_source_clocks = omap3_dm_source_clocks;
> -       } else if (cpu_is_omap44xx()) {
> -               dm_timers = omap4_dm_timers;
> -               dm_timer_count = omap4_dm_timer_count;
> -               dm_source_names = omap4_dm_source_names;
> -               dm_source_clocks = omap4_dm_source_clocks;
> -       }
> -
> -       if (cpu_class_is_omap2())
> -               for (i = 0; dm_source_names[i] != NULL; i++)
> -                       dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
> -
> -       if (cpu_is_omap243x())
> -               dm_timers[0].phys_base = 0x49018000;
> -
> -       for (i = 0; i<  dm_timer_count; i++) {
> -               timer =&dm_timers[i];
> -
> -               /* Static mapping, never released */
> -               timer->io_base = ioremap(timer->phys_base, map_size);
> -               BUG_ON(!timer->io_base);
> -
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -               if (cpu_class_is_omap2()) {
> -                       char clk_name[16];
> -                       sprintf(clk_name, "gpt%d_ick", i + 1);
> -                       timer->iclk = clk_get(NULL, clk_name);
> -                       sprintf(clk_name, "gpt%d_fck", i + 1);
> -                       timer->fclk = clk_get(NULL, clk_name);
> -               }
> -#endif
> -       }
> -
> -       return 0;
> -}
> diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-omap/include/plat/dmtimer.h
> index b90b906..89f81ff 100644
> --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> @@ -79,8 +79,6 @@ struct dmtimer_platform_data {
>          u32 is_early_init:1;
>   };
>
> -int omap_dm_timer_init(void);
> -
>   struct omap_dm_timer *omap_dm_timer_request(void);
>   struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
>   void omap_dm_timer_free(struct omap_dm_timer *timer);
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

