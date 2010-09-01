From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv2 5/13] dmtimer: hwmod: OMAP: conversion to platform
 driver
Date: Wed, 1 Sep 2010 16:11:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03291AD3B7@dbde02.ent.ti.com>
References: <1281800254-15160-1-git-send-email-tarun.kanti@ti.com>
 <87sk24sybw.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57628 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752155Ab0IAKlY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 06:41:24 -0400
In-Reply-To: <87sk24sybw.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Kevin,

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 24, 2010 4:59 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha; Nayak,
> Rajendra; Paul Walmsley; Tony Lindgren
> Subject: Re: [PATCHv2 5/13] dmtimer: hwmod: OMAP: conversion to platform
> driver
>
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>
> > From: Thara Gopinath <thara@ti.com>
> >
> > This essentially involves moving out interrupt and base address
> > related info from plat-omap/dmtimer.c and making certain clock related
> > functions platform data. This patch also initializes dmtimer driver
> > as a earlydriver. This is to enable early timer devices required during
> > system boot initialized early.
>
> no need for 'hwmod' in $SUBJECT
>
Will change in the next posts!

> > incorporated comments:
> > (1) use list instead of array to manage timers
> > (2) introduced appropriate cleanup in failure paths of probe function
> > (3) made spinlock a static variable initialized at bootup so that it
> > is available both during early init and later.
> > (4) pm_runtime support
> > (5) corrected un-even number of pm_runtime_enable() associated with
> > early millisecond timers
>
> This patch needs to be broken up into more pieces.
>
> The conversion to platform_device should be patch on its own.  The
> addition of runtime PM support followed by the addition of the new timer
> types should also be separate patches.
Will organize better in the next posts!

>
> > Signed-off-by: Partha Basak <p-basak2@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/dmtimer.c              |  549 +++++++++++++---------
> -------
> >  arch/arm/plat-omap/include/plat/dmtimer.h |   10 +-
> >  2 files changed, 255 insertions(+), 304 deletions(-)
> >  mode change 100644 => 100755 arch/arm/plat-omap/dmtimer.c
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index 44bafda..0915a37
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -10,6 +10,12 @@
> >   * Copyright (C) 2009 Texas Instruments
> >   * Added OMAP4 support - Santosh Shilimkar <santosh.shilimkar@ti.com>
> >   *
> > + * Copyright (C) 2010 Texas Instruments, Inc.
> > + * Thara Gopinath <thara@ti.com>
> > + * Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > + * - hwmod support
> > + * - omap4 support
> > + *
> >   * This program is free software; you can redistribute it and/or modify
> it
> >   * under the terms of the GNU General Public License as published by
> the
> >   * Free Software Foundation; either version 2 of the License, or (at
> your
> > @@ -37,9 +43,13 @@
> >  #include <linux/delay.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> > +#include <linux/slab.h>
> >  #include <mach/hardware.h>
> > +#include <linux/pm_runtime.h>
> >  #include <plat/dmtimer.h>
> > +#include <plat/omap_device.h>
> >  #include <mach/irqs.h>
> > +#include <linux/interrupt.h>
> >
> >  /* register offsets */
> >  #define _OMAP_TIMER_ID_OFFSET              0x00
> > @@ -151,144 +161,30 @@
> >             (_OMAP_TIMER_TICK_INT_MASK_COUNT_OFFSET | (WP_TOWR << WPSHIFT))
> >
> >  struct omap_dm_timer {
> > -   unsigned long phys_base;
> > +   int id;
> > +   unsigned long fclk_rate;
> >     int irq;
> > -#ifdef CONFIG_ARCH_OMAP2PLUS
> > -   struct clk *iclk, *fclk;
> > -#endif
> >     void __iomem *io_base;
> >     unsigned reserved:1;
> >     unsigned enabled:1;
> >     unsigned posted:1;
> > +   unsigned is_initialized:1;
> > +   struct platform_device *pdev;
> > +   struct list_head node;
> >  };
> >
> > -static int dm_timer_count;
> > -
> > -#ifdef CONFIG_ARCH_OMAP1
> > -static struct omap_dm_timer omap1_dm_timers[] = {
> > -   { .phys_base = 0xfffb1400, .irq = INT_1610_GPTIMER1 },
> > -   { .phys_base = 0xfffb1c00, .irq = INT_1610_GPTIMER2 },
> > -   { .phys_base = 0xfffb2400, .irq = INT_1610_GPTIMER3 },
> > -   { .phys_base = 0xfffb2c00, .irq = INT_1610_GPTIMER4 },
> > -   { .phys_base = 0xfffb3400, .irq = INT_1610_GPTIMER5 },
> > -   { .phys_base = 0xfffb3c00, .irq = INT_1610_GPTIMER6 },
> > -   { .phys_base = 0xfffb7400, .irq = INT_1610_GPTIMER7 },
> > -   { .phys_base = 0xfffbd400, .irq = INT_1610_GPTIMER8 },
> > -};
> > -
> > -static const int omap1_dm_timer_count = ARRAY_SIZE(omap1_dm_timers);
> > -
> > -#else
> > -#define omap1_dm_timers                    NULL
> > -#define omap1_dm_timer_count               0
> > -#endif     /* CONFIG_ARCH_OMAP1 */
> > -
> > -#ifdef CONFIG_ARCH_OMAP2
> > -static struct omap_dm_timer omap2_dm_timers[] = {
> > -   { .phys_base = 0x48028000, .irq = INT_24XX_GPTIMER1 },
> > -   { .phys_base = 0x4802a000, .irq = INT_24XX_GPTIMER2 },
> > -   { .phys_base = 0x48078000, .irq = INT_24XX_GPTIMER3 },
> > -   { .phys_base = 0x4807a000, .irq = INT_24XX_GPTIMER4 },
> > -   { .phys_base = 0x4807c000, .irq = INT_24XX_GPTIMER5 },
> > -   { .phys_base = 0x4807e000, .irq = INT_24XX_GPTIMER6 },
> > -   { .phys_base = 0x48080000, .irq = INT_24XX_GPTIMER7 },
> > -   { .phys_base = 0x48082000, .irq = INT_24XX_GPTIMER8 },
> > -   { .phys_base = 0x48084000, .irq = INT_24XX_GPTIMER9 },
> > -   { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> > -   { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> > -   { .phys_base = 0x4808a000, .irq = INT_24XX_GPTIMER12 },
> > -};
> > -
> > -static const char *omap2_dm_source_names[] __initdata = {
> > -   "sys_ck",
> > -   "func_32k_ck",
> > -   "alt_ck",
> > -   NULL
> > -};
> > -
> > -static struct clk *omap2_dm_source_clocks[3];
> > -static const int omap2_dm_timer_count = ARRAY_SIZE(omap2_dm_timers);
> > -
> > -#else
> > -#define omap2_dm_timers                    NULL
> > -#define omap2_dm_timer_count               0
> > -#define omap2_dm_source_names              NULL
> > -#define omap2_dm_source_clocks             NULL
> > -#endif     /* CONFIG_ARCH_OMAP2 */
> > -
> > -#ifdef CONFIG_ARCH_OMAP3
> > -static struct omap_dm_timer omap3_dm_timers[] = {
> > -   { .phys_base = 0x48318000, .irq = INT_24XX_GPTIMER1 },
> > -   { .phys_base = 0x49032000, .irq = INT_24XX_GPTIMER2 },
> > -   { .phys_base = 0x49034000, .irq = INT_24XX_GPTIMER3 },
> > -   { .phys_base = 0x49036000, .irq = INT_24XX_GPTIMER4 },
> > -   { .phys_base = 0x49038000, .irq = INT_24XX_GPTIMER5 },
> > -   { .phys_base = 0x4903A000, .irq = INT_24XX_GPTIMER6 },
> > -   { .phys_base = 0x4903C000, .irq = INT_24XX_GPTIMER7 },
> > -   { .phys_base = 0x4903E000, .irq = INT_24XX_GPTIMER8 },
> > -   { .phys_base = 0x49040000, .irq = INT_24XX_GPTIMER9 },
> > -   { .phys_base = 0x48086000, .irq = INT_24XX_GPTIMER10 },
> > -   { .phys_base = 0x48088000, .irq = INT_24XX_GPTIMER11 },
> > -   { .phys_base = 0x48304000, .irq = INT_34XX_GPT12_IRQ },
> > -};
> > -
> > -static const char *omap3_dm_source_names[] __initdata = {
> > -   "sys_ck",
> > -   "omap_32k_fck",
> > -   NULL
> > -};
> > -
> > -static struct clk *omap3_dm_source_clocks[2];
> > -static const int omap3_dm_timer_count = ARRAY_SIZE(omap3_dm_timers);
> > -
> > -#else
> > -#define omap3_dm_timers                    NULL
> > -#define omap3_dm_timer_count               0
> > -#define omap3_dm_source_names              NULL
> > -#define omap3_dm_source_clocks             NULL
> > -#endif     /* CONFIG_ARCH_OMAP3 */
> > -
> > -#ifdef CONFIG_ARCH_OMAP4
> > -static struct omap_dm_timer omap4_dm_timers[] = {
> > -   { .phys_base = 0x4a318000, .irq = OMAP44XX_IRQ_GPT1 },
> > -   { .phys_base = 0x48032000, .irq = OMAP44XX_IRQ_GPT2 },
> > -   { .phys_base = 0x48034000, .irq = OMAP44XX_IRQ_GPT3 },
> > -   { .phys_base = 0x48036000, .irq = OMAP44XX_IRQ_GPT4 },
> > -   { .phys_base = 0x40138000, .irq = OMAP44XX_IRQ_GPT5 },
> > -   { .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT6 },
> > -   { .phys_base = 0x4013a000, .irq = OMAP44XX_IRQ_GPT7 },
> > -   { .phys_base = 0x4013e000, .irq = OMAP44XX_IRQ_GPT8 },
> > -   { .phys_base = 0x4803e000, .irq = OMAP44XX_IRQ_GPT9 },
> > -   { .phys_base = 0x48086000, .irq = OMAP44XX_IRQ_GPT10 },
> > -   { .phys_base = 0x48088000, .irq = OMAP44XX_IRQ_GPT11 },
> > -   { .phys_base = 0x4a320000, .irq = OMAP44XX_IRQ_GPT12 },
> > -};
> > -static const char *omap4_dm_source_names[] __initdata = {
> > -   "sys_clkin_ck",
> > -   "sys_32k_ck",
> > -   NULL
> > -};
> > -static struct clk *omap4_dm_source_clocks[2];
> > -static const int omap4_dm_timer_count = ARRAY_SIZE(omap4_dm_timers);
> > -
> > -#else
> > -#define omap4_dm_timers                    NULL
> > -#define omap4_dm_timer_count               0
> > -#define omap4_dm_source_names              NULL
> > -#define omap4_dm_source_clocks             NULL
> > -#endif     /* CONFIG_ARCH_OMAP4 */
> > -
> > -static struct omap_dm_timer *dm_timers;
> > -static const char **dm_source_names;
> > -static struct clk **dm_source_clocks;
> > -
> > -static spinlock_t dm_timer_lock;
> > +static LIST_HEAD(omap_timer_list);
> > +static DEFINE_SPINLOCK(dm_timer_lock);
> >
> > -/*
> > - * Reads timer registers in posted and non-posted mode. The posted mode
> bit
> > - * is encoded in reg. Note that in posted mode write pending bit must
> be
> > - * checked. Otherwise a read of a non completed write will produce an
> error.
> > - */
> > +/**
> > + * omap_dm_timer_read_reg - read timer registers in posted and non-
> posted mode
> > + * @timer: timer pointer over which read operation to perform
> > + * @reg: lowest byte holds the register offset
> > + *
> > + * The posted mode bit is encoded in reg. Note that in posted mode
> write
> > + * pending bit must be checked. Otherwise a read of a non completed
> write
> > + * will produce an error.
> > + **/
> >  static inline u32 omap_dm_timer_read_reg(struct omap_dm_timer *timer,
> u32 reg)
> >  {
> >     if (timer->posted)
> > @@ -298,12 +194,16 @@ static inline u32 omap_dm_timer_read_reg(struct
> omap_dm_timer *timer, u32 reg)
> >     return readl(timer->io_base + (reg & 0xff));
> >  }
> >
> > -/*
> > - * Writes timer registers in posted and non-posted mode. The posted
> mode bit
> > - * is encoded in reg. Note that in posted mode the write pending bit
> must be
> > - * checked. Otherwise a write on a register which has a pending write
> will be
> > - * lost.
> > - */
> > +/**
> > + * omap_dm_timer_write_reg - write timer registers in posted and non-
> posted mode
> > + * @timer: timer pointer over which write operation is to perform
> > + * @reg: lowest byte holds the register offset
> > + * @value: data to write into the register
> > + *
> > + * The posted mode bit is encoded in reg. Note that in posted mode the
> write
> > + * pending bit must be checked. Otherwise a write on a register which
> has a
> > + * pending write will be lost.
> > + **/
> >  static void omap_dm_timer_write_reg(struct omap_dm_timer *timer, u32
> reg,
> >                                             u32 value)
> >  {
> > @@ -330,25 +230,12 @@ static void omap_dm_timer_wait_for_reset(struct
> omap_dm_timer *timer)
> >
> >  static void omap_dm_timer_reset(struct omap_dm_timer *timer)
> >  {
> > -   u32 l;
> > -
> > -   if (!cpu_class_is_omap2() || timer != &dm_timers[0]) {
> > +   if (!cpu_class_is_omap2() || timer->id != 0) {
> >             omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG, 0x06);
> >             omap_dm_timer_wait_for_reset(timer);
> >     }
> >     omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> >
> > -   l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> > -   l |= 0x02 << 3;  /* Set to smart-idle mode */
>
> ok, this part is done by hwmod core
>
> > -   l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle */
>
> this is not done (by default) in the hwmod core unless you use
> HWMOD_SET_DEFAULT_CLOCKACT (which I have not seen.)
>
Right. I will change the HWMOD database with the above configuration.

> This is just one of many reasons this patch needs to be broken up.  This
> is potentially changing behavior with no clear description of the
> change, why it isn't needed anymore, or what equivalent behavior is
> preserving the change.
>
Agreed! I will break up patches appropriately.

> > -   /*
> > -    * Enable wake-up on OMAP2 CPUs.
> > -    */
> > -   if (cpu_class_is_omap2())
> > -           l |= 1 << 2;
> > -   omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> > -
>
> again, I don't think this is the default in the hwmod core.
>
OK, will take care.

> >     /* Match hardware reset default of posted mode */
> >     omap_dm_timer_write_reg(timer, OMAP_TIMER_IF_CTRL_REG,
> >                     OMAP_TIMER_CTRL_POSTED);
> > @@ -363,23 +250,24 @@ static void omap_dm_timer_prepare(struct
> omap_dm_timer *timer)
> >
> >  struct omap_dm_timer *omap_dm_timer_request(void)
> >  {
> > -   struct omap_dm_timer *timer = NULL;
> > +   struct omap_dm_timer *timer;
>
> leave this...
>
OK.

> >     unsigned long flags;
> > -   int i;
> > +   int found = 0;
>
> drop the 'found' flag and just use a temp *timer...
>
OK.

> >     spin_lock_irqsave(&dm_timer_lock, flags);
> > -   for (i = 0; i < dm_timer_count; i++) {
> > -           if (dm_timers[i].reserved)
> > +   list_for_each_entry(timer, &omap_timer_list, node) {
>
>       list_for_each_entry(tmp_timer, &omap_timer_list, node) {
>
> > +           if (timer->reserved)
> >                     continue;
> > -
> > -           timer = &dm_timers[i];
> >             timer->reserved = 1;
> > +           found = 1;
>
>                 timer = tmp_timer;
>
> >             break;
> >     }
> >     spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > -   if (timer != NULL)
> > +   if (found)
>
> and keep the null check here
>
OK.

> >             omap_dm_timer_prepare(timer);
> > +   else
> > +           timer = NULL;
> >
> >     return timer;
> >  }
> > @@ -389,22 +277,22 @@ struct omap_dm_timer
> *omap_dm_timer_request_specific(int id)
> >  {
> >     struct omap_dm_timer *timer;
> >     unsigned long flags;
> > +   int found = 0;
>
> ditto
>
OK.

> >     spin_lock_irqsave(&dm_timer_lock, flags);
> > -   if (id <= 0 || id > dm_timer_count || dm_timers[id-1].reserved) {
> > -           spin_unlock_irqrestore(&dm_timer_lock, flags);
> > -           printk("BUG: warning at %s:%d/%s(): unable to get timer %d\n",
> > -                  __FILE__, __LINE__, __func__, id);
> > -           dump_stack();
> > -           return NULL;
> > +   list_for_each_entry(timer, &omap_timer_list, node) {
> > +           if (timer->id == id-1 && !timer->reserved) {
> > +                   found = 1;
> > +                   timer->reserved = 1;
> > +                   break;
> > +           }
> >     }
> > -
> > -   timer = &dm_timers[id-1];
> > -   timer->reserved = 1;
> >     spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > -   omap_dm_timer_prepare(timer);
> > -
> > +   if (found)
> > +           omap_dm_timer_prepare(timer);
> > +   else
> > +           timer = NULL;
> >     return timer;
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_request_specific);
> > @@ -422,15 +310,13 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_free);
> >
> >  void omap_dm_timer_enable(struct omap_dm_timer *timer)
> >  {
> > +   struct omap_dmtimer_platform_data *pdata = \
>
> '\' is not needed in C.  Also, rather than wrapping, sometims it's nicer
> looking to do:
>
OK, I will remove.

>         struct platform_device *pdev = timer->pdev;
>         struct omap_dmtimer_plaform_data *pdata = pdev->dev.platform_data;
>
> the same usage of '\' later on multiple times.
>
OK.

> > +                           timer->pdev->dev.platform_data;
> > +
> >     if (timer->enabled)
> >             return;
> > -
> > -#ifdef CONFIG_ARCH_OMAP2PLUS
> > -   if (cpu_class_is_omap2()) {
> > -           clk_enable(timer->fclk);
> > -           clk_enable(timer->iclk);
> > -   }
> > -#endif
> > +   if (pdata->omap_dm_clk_enable)
> > +           pdata->omap_dm_clk_enable(timer->pdev);
>
> still confused about the need for this, seemingly used only for early
> devices.
>
> Why not just a pm_runtime_get(), with a matching put later?
>
OK.

> >     timer->enabled = 1;
> >  }
> > @@ -438,15 +324,14 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_enable);
> >
> >  void omap_dm_timer_disable(struct omap_dm_timer *timer)
> >  {
> > +   struct omap_dmtimer_platform_data *pdata = \
> > +                           timer->pdev->dev.platform_data;
> > +
> >     if (!timer->enabled)
> >             return;
> >
> > -#ifdef CONFIG_ARCH_OMAP2PLUS
> > -   if (cpu_class_is_omap2()) {
> > -           clk_disable(timer->iclk);
> > -           clk_disable(timer->fclk);
> > -   }
> > -#endif
> > +   if (pdata->omap_dm_clk_disable)
> > +           pdata->omap_dm_clk_disable(timer->pdev);
> >
> >     timer->enabled = 0;
> >  }
> > @@ -458,45 +343,19 @@ int omap_dm_timer_get_irq(struct omap_dm_timer
> *timer)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_get_irq);
> >
> > -#if defined(CONFIG_ARCH_OMAP1)
> > -
> > -/**
> > - * omap_dm_timer_modify_idlect_mask - Check if any running timers use
> ARMXOR
> > - * @inputmask: current value of idlect mask
> > - */
> > -__u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> > +struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> >  {
> > -   int i;
> > -
> > -   /* If ARMXOR cannot be idled this function call is unnecessary */
> > -   if (!(inputmask & (1 << 1)))
> > -           return inputmask;
> > +   struct omap_dmtimer_platform_data *pdata = \
> > +                           timer->pdev->dev.platform_data;
> >
> > -   /* If any active timer is using ARMXOR return modified mask */
> > -   for (i = 0; i < dm_timer_count; i++) {
> > -           u32 l;
> > +   if (pdata->omap_dm_get_timer_clk)
> > +           return pdata->omap_dm_get_timer_clk(timer->pdev);
> >
> > -           l = omap_dm_timer_read_reg(&dm_timers[i], OMAP_TIMER_CTRL_REG);
> > -           if (l & OMAP_TIMER_CTRL_ST) {
> > -                   if (((omap_readl(MOD_CONF_CTRL_1) >> (i * 2)) & 0x03) == 0)
> > -                           inputmask &= ~(1 << 1);
> > -                   else
> > -                           inputmask &= ~(1 << 2);
> > -           }
> > -   }
> > -
> > -   return inputmask;
> > -}
> > -EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> > -
> > -#else
> > -
> > -struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
> > -{
> > -   return timer->fclk;
> > +   return NULL;
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_get_fclk);
> >
> > +
>
> stray whitespace change
>
> >  __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
> >  {
> >     BUG();
> > @@ -505,7 +364,6 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32
> inputmask)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_modify_idlect_mask);
> >
> > -#endif
> >
> >  void omap_dm_timer_trigger(struct omap_dm_timer *timer)
> >  {
> > @@ -536,58 +394,27 @@ void omap_dm_timer_stop(struct omap_dm_timer
> *timer)
> >  #ifdef CONFIG_ARCH_OMAP2PLUS
> >             /* Readback to make sure write has completed */
> >             omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> > -            /*
> > -             * Wait for functional clock period x 3.5 to make sure that
> > -             * timer is stopped
> > -             */
> > -           udelay(3500000 / clk_get_rate(timer->fclk) + 1);
>
> Again, functionality removed, with no clear description as to what
> replaces this, or why it's no longer necessary.  Another good candidate
> for a separate (pre-) patch.
>
OK.

> > -#endif
> > -   }
> > +
> >     /* Ack possibly pending interrupt */
> >     omap_dm_timer_write_reg(timer, OMAP_TIMER_STAT_REG,
> >                     OMAP_TIMER_INT_OVERFLOW);
> > +#endif
> > +   }
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_stop);
> >
> > -#ifdef CONFIG_ARCH_OMAP1
> > -
> >  int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> >  {
> > -   int n = (timer - dm_timers) << 1;
> > -   u32 l;
> > -
> > -   l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
> > -   l |= source << n;
> > -   omap_writel(l, MOD_CONF_CTRL_1);
> > +   struct omap_dmtimer_platform_data *pdata = \
> > +                           timer->pdev->dev.platform_data;
> >
> > +   if (pdata->omap_dm_set_source_clk)
> > +           timer->fclk_rate = pdata->omap_dm_set_source_clk
> > +                           (timer->pdev, source);
> >     return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
> >
> > -#else
> > -
> > -int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
> > -{
> > -   int ret = -EINVAL;
> > -
> > -   if (source < 0 || source >= 3)
> > -           return -EINVAL;
> > -
> > -   clk_disable(timer->fclk);
> > -   ret = clk_set_parent(timer->fclk, dm_source_clocks[source]);
> > -   clk_enable(timer->fclk);
> > -
> > -   /*
> > -    * When the functional clock disappears, too quick writes seem
> > -    * to cause an abort. XXX Is this still necessary?
> > -    */
> > -   __delay(150000);
> > -
> > -   return ret;
> > -}
> > -EXPORT_SYMBOL_GPL(omap_dm_timer_set_source);
> > -
> > -#endif
> >
> >  void omap_dm_timer_set_load(struct omap_dm_timer *timer, int
> autoreload,
> >                         unsigned int load)
> > @@ -680,6 +507,18 @@ void omap_dm_timer_set_int_enable(struct
> omap_dm_timer *timer,
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_enable);
> >
> > +void omap_dm_timer_set_int_disable(struct omap_dm_timer *timer,
> > +                                   unsigned int value)
> > +{
> > +   u32 l;
> > +
> > +   l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
> > +   l &= ~value;
> > +   omap_dm_timer_write_reg(timer, OMAP_TIMER_INT_EN_REG, l);
> > +   omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
> > +}
> > +EXPORT_SYMBOL_GPL(omap_dm_timer_set_int_disable);
>
> again, another separate patch is needed for a new API which is
> completely unrelated to other changes here.
>
> >  unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
> >  {
> >     unsigned int l;
> > @@ -714,13 +553,9 @@ EXPORT_SYMBOL_GPL(omap_dm_timer_write_counter);
> >
> >  int omap_dm_timers_active(void)
> >  {
> > -   int i;
> > -
> > -   for (i = 0; i < dm_timer_count; i++) {
> > -           struct omap_dm_timer *timer;
> > -
> > -           timer = &dm_timers[i];
> > +   struct omap_dm_timer *timer;
> >
> > +   list_for_each_entry(timer, &omap_timer_list, node) {
> >             if (!timer->enabled)
> >                     continue;
> >
> > @@ -733,61 +568,169 @@ int omap_dm_timers_active(void)
> >  }
> >  EXPORT_SYMBOL_GPL(omap_dm_timers_active);
> >
> > -int __init omap_dm_timer_init(void)
> > +/**
> > + * omap_dm_timer_probe - probe function called for every registered
> device
> > + * @pdev: pointer to current timer platform device
> > + *
> > + * called by driver framework at the end of device registration for all
> > + * timer devices
> > + **/
> > +static int __devinit omap_dm_timer_probe(struct platform_device *pdev)
> >  {
> > +   int ret;
> > +   unsigned long flags;
> >     struct omap_dm_timer *timer;
> > -   int i, map_size = SZ_8K;        /* Module 4KB + L4 4KB except on omap1 */
> > +   struct resource *mem, *irq, *ioarea;
> > +   struct omap_dmtimer_platform_data *pdata = pdev->dev.platform_data;
> > +
> > +   dev_dbg(&pdev->dev, "%s:+\n", __func__);
> >
> > -   if (!(cpu_is_omap16xx() || cpu_class_is_omap2()))
> > +   if (!pdata) {
> > +           dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> >             return -ENODEV;
> > +   }
> > +   /*
> > +   * early timers are already registered and in list.
>
> mis-aligned indentation in multi-line comment style
Ok, will take care.

>
> > +   * what we need to do during second phase of probe
> > +   * is to assign the newly allocated/configured pdev
> > +   * to already registered timer->pdev. early pdev
> > +   * is already freed as part of early cleanup.
> > +   */
> > +   spin_lock_irqsave(&dm_timer_lock, flags);
> > +   list_for_each_entry(timer, &omap_timer_list, node)
> > +           if (timer->id == pdev->id) {
> > +                   timer->pdev = pdev;
> > +                   pm_runtime_enable(&pdev->dev);
> > +                   spin_unlock_irqrestore(&dm_timer_lock, flags);
> > +                   return 0;
> > +           }
> > +   spin_unlock_irqrestore(&dm_timer_lock, flags);
> > +
> > +   irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > +   if (unlikely(!irq)) {
> > +           dev_err(&pdev->dev, "%s: no IRQ resource\n", __func__);
> > +           ret = -ENODEV;
> > +           goto err_free_pdev;
> > +   }
> > +
> > +   mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   if (unlikely(!mem)) {
> > +           dev_err(&pdev->dev, "%s: no memory resource\n", __func__);
> > +           ret = -ENODEV;
> > +           goto err_free_pdev;
> > +   }
> >
> > -   spin_lock_init(&dm_timer_lock);
> > -
> > -   if (cpu_class_is_omap1()) {
> > -           dm_timers = omap1_dm_timers;
> > -           dm_timer_count = omap1_dm_timer_count;
> > -           map_size = SZ_2K;
> > -   } else if (cpu_is_omap24xx()) {
> > -           dm_timers = omap2_dm_timers;
> > -           dm_timer_count = omap2_dm_timer_count;
> > -           dm_source_names = omap2_dm_source_names;
> > -           dm_source_clocks = omap2_dm_source_clocks;
> > -   } else if (cpu_is_omap34xx()) {
> > -           dm_timers = omap3_dm_timers;
> > -           dm_timer_count = omap3_dm_timer_count;
> > -           dm_source_names = omap3_dm_source_names;
> > -           dm_source_clocks = omap3_dm_source_clocks;
> > -   } else if (cpu_is_omap44xx()) {
> > -           dm_timers = omap4_dm_timers;
> > -           dm_timer_count = omap4_dm_timer_count;
> > -           dm_source_names = omap4_dm_source_names;
> > -           dm_source_clocks = omap4_dm_source_clocks;
> > +   ioarea = request_mem_region(mem->start, resource_size(mem),
> > +                   pdev->name);
> > +   if (!ioarea) {
> > +           dev_err(&pdev->dev, "%s: region already claimed\n", __func__);
> > +           ret = -EBUSY;
> > +           goto err_free_pdev;
> >     }
> >
> > -   if (cpu_class_is_omap2())
> > -           for (i = 0; dm_source_names[i] != NULL; i++)
> > -                   dm_source_clocks[i] = clk_get(NULL, dm_source_names[i]);
> > +   timer = kzalloc(sizeof(struct omap_dm_timer), GFP_KERNEL);
> > +   if (!timer) {
> > +           dev_err(&pdev->dev, "%s: no memory for omap_dm_timer\n",
> > +                   __func__);
> > +           ret = -ENOMEM;
> > +           goto err_release_ioregion;
> > +   }
> > +   timer->io_base = ioremap(mem->start, resource_size(mem));
> > +   if (!timer->io_base) {
> > +           dev_err(&pdev->dev, "%s: ioremap failed\n", __func__);
> > +           ret = -ENOMEM;
> > +           goto err_free_mem;
> > +   }
> > +   timer->irq = irq->start;
> > +   timer->pdev = pdev;
> > +   timer->id = pdev->id;
> > +   timer->reserved = 0;
> > +   timer->is_initialized = 1;
>
> why the need for the 'is_initialized' flag...
Will be removed.

>
> > -   if (cpu_is_omap243x())
> > -           dm_timers[0].phys_base = 0x49018000;
> > +   list_add_tail(&timer->node, &omap_timer_list);
>
> its presence in the list should indicate it's been initialized?
>
Right!

> > -   for (i = 0; i < dm_timer_count; i++) {
> > -           timer = &dm_timers[i];
> > +   if (pdata->timer_ip_type != OMAP_TIMER_MILLISECOND)
> > +           pm_runtime_enable(&pdev->dev);
>
> missing explanation as to why
This would change with our current option of allowing all timers to be early timers.

> > -           /* Static mapping, never released */
> > -           timer->io_base = ioremap(timer->phys_base, map_size);
> > -           BUG_ON(!timer->io_base);
> > +   dev_dbg(&pdev->dev, " registered\n");
> >
> > -#ifdef CONFIG_ARCH_OMAP2PLUS
> > -           if (cpu_class_is_omap2()) {
> > -                   char clk_name[16];
> > -                   sprintf(clk_name, "gpt%d_ick", i + 1);
> > -                   timer->iclk = clk_get(NULL, clk_name);
> > -                   sprintf(clk_name, "gpt%d_fck", i + 1);
> > -                   timer->fclk = clk_get(NULL, clk_name);
> > +   return 0;
> > +
> > +err_free_mem:
> > +   kfree(timer);
> > +
> > +err_release_ioregion:
> > +   release_mem_region(mem->start, resource_size(mem));
> > +
> > +err_free_pdev:
> > +   platform_device_put(pdev);
> > +
> > +   return ret;
> > +}
> > +
> > +/**
> > + * omap_dm_timer_remove - cleanup a registered timer device
> > + * @pdev: pointer to current timer platform device
> > + *
> > + * called by driver framework whenever a timer device is unregistered.
> > + * it addition to freeing platform resources it also deletes the timer
> > + * entry from the local list.
> > + **/
> > +static int __devexit omap_dm_timer_remove(struct platform_device *pdev)
> > +{
> > +   struct resource *mem;
> > +   struct omap_dm_timer *timer, *tmp;
> > +   unsigned long flags;
> > +   int ret = -EINVAL;
> > +   struct omap_dmtimer_platform_data *pdata = pdev->dev.platform_data;
> > +
> > +   if (!pdata) {
> > +           dev_err(&pdev->dev, "%s: no platform data\n", __func__);
> > +           return -ENODEV;
> > +   }
> > +
> > +   spin_lock_irqsave(&dm_timer_lock, flags);
> > +   list_for_each_entry_safe(timer, tmp, &omap_timer_list, node) {
> > +           if (timer->id == pdev->id && timer->is_initialized) {
> > +                   free_irq(timer->irq, timer);
> > +                   iounmap(timer->io_base);
> > +                   kfree(timer);
> > +                   mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +                   release_mem_region(mem->start, resource_size(mem));
>
> platform_device_del() will do this for you
>
OK.

> > +                   list_del(&timer->node);
>
> The pointer 'timer' is undefined here as it was just free'd above.
>
Oops, I will change.

> > +                   platform_device_put(pdev);
>
> What is this 'put' for?
I will use platform_device_del().

>
> > +                   ret = 0;
> > +                   break;
> >             }
> > -#endif
> >     }
> > +   spin_unlock_irqrestore(&dm_timer_lock, flags);
> >
> > -   return 0;
> > +   return ret;
> > +}
> > +
> > +static struct platform_driver omap_dmtimer_driver = {
> > +   .probe          = omap_dm_timer_probe,
> > +   .remove         = omap_dm_timer_remove,
> > +   .driver         = {
> > +           .name   = "dmtimer",
> > +   },
> > +};
> > +
> > +static int __init omap_dm_timer_init(void)
> > +{
> > +   return platform_driver_register(&omap_dmtimer_driver);
> >  }
> > +
> > +static void __exit omap_dm_timer_exit(void)
> > +{
> > +   platform_driver_unregister(&omap_dmtimer_driver);
> > +}
> > +
> > +early_platform_init("earlytimer", &omap_dmtimer_driver);
> > +module_init(omap_dm_timer_init);
> > +module_exit(omap_dm_timer_exit);
> > +
> > +MODULE_DESCRIPTION("OMAP DUAL MODE TIMER DRIVER");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:" DRIVER_NAME);
> > +MODULE_AUTHOR("Texas Instruments Inc");
> > diff --git a/arch/arm/plat-omap/include/plat/dmtimer.h b/arch/arm/plat-
> omap/include/plat/dmtimer.h
> > index 2926dc6..044970b 100755
> > --- a/arch/arm/plat-omap/include/plat/dmtimer.h
> > +++ b/arch/arm/plat-omap/include/plat/dmtimer.h
> > @@ -29,6 +29,7 @@
> >  #ifndef __ASM_ARCH_DMTIMER_H
> >  #define __ASM_ARCH_DMTIMER_H
> >
> > +#include <linux/platform_device.h>
> >  /* clock sources */
> >  #define OMAP_TIMER_SRC_SYS_CLK                     0x00
> >  #define OMAP_TIMER_SRC_32_KHZ                      0x01
> > @@ -52,7 +53,14 @@
> >  struct omap_dm_timer;
> >  struct clk;
> >
> > -int omap_dm_timer_init(void);
> > +struct omap_dmtimer_platform_data {
> > +   void (*omap_dm_clk_enable) (struct platform_device *pdev);
> > +   void (*omap_dm_clk_disable) (struct platform_device *pdev);
> > +   int (*omap_dm_set_source_clk)
> > +                   (struct platform_device *pdev, int source);
> > +   struct clk* (*omap_dm_get_timer_clk) (struct platform_device *pdev);
> > +   int timer_ip_type;
> > +};
>
> You should drop the 'omap_dm_' prefix from these functions as they are
> obviously specific to the DM timer, and they are causing you to wrap
> lines into ugly code.
>
OK.

-tarun

> >  struct omap_dm_timer *omap_dm_timer_request(void);
> >  struct omap_dm_timer *omap_dm_timer_request_specific(int timer_id);
>
> Kevin
