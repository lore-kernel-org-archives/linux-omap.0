From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Fri, 7 May 2010 12:22:04 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387A66@dbde02.ent.ti.com>
References: <877hni5akk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56278 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499Ab0EGGwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 02:52:14 -0400
In-Reply-To: <877hni5akk.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, May 06, 2010 2:30 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com; tony@atomide.com
> Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
>
> "Varadarajan, Charulatha" <charu@ti.com> writes:
>
> >> -----Original Message-----
> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> >> Sent: Saturday, May 01, 2010 5:34 AM
> >> To: Varadarajan, Charulatha
> >> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
> tony@atomide.com
> >> Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
> >>
> >> Charulatha V <charu@ti.com> writes:
> >>
> >> > This patch implements GPIO as a early platform device. Also it
> >> > implements OMAP2PLUS specific GPIO as HWMOD FW adapted driver.
> >>
> >> Should include a summary explanation of why you're converting to an
> >> early platform device as well.
> >
> > Okay.
> >
> >>
> >> > Inorder to convert GPIO as platform device, modifications are
> >> > required in clockxxxx_data.c files so that device names can be
> >> > used to obtain clock instead of getting clocks by name/NULL ptr.
> >>
> >> ok
> >>
> >> > Currently early platform device register does not do device_pm_init.
> >> > Hence pm_runtime functions are not used to enable the GPIO device
> >> > since gpio is early platform device.
> >>
> >> OK for now, since this isn't using runtime PM, but maybe we need a
> >> late_initcall() here to do the device_pm_init() + pm_runtime_enable()
> >>
> >> This change log needs more description of the intended init sequence.
> >> Right now it seems that there are multiple init paths.  Now that GPIO
> >> is an early_platform_device, we should be able to at least make
> >> omap_gpio_init() static and remove its usage from all the board files.
> >
> > This was the implementation that I initially did in my previous patch
> > series. The following needs to be considered:
> >
> > 1. omap2_init_devices() might be too late for early_gpio_init() to
> > be placed in it.
> >
> > 2. omap_init_irq() needs to be completed before calling early_gpio_init().
> > So, if early_gpio_init() is called from omap2_init_common_hw(), we need to
> > have omap_init_irq() called before omap2_init_common_hw(). But Tony
> > objected this approach mentioning that board might not boot up as
> > omap2_init_common_hw() has to be done asap.
> >
> > That's why, I had not moved the omap_gpio_init() usage from board files.
>
> OK... for now.  I'd still like to see GPIO init consolidated as there's
> no (good) reason why every board file has to init GPIOs when it's common
> for all SoCs, but this doesn't necessarily have to be done in your series.
> Although, if you do it for OMAP1 (as proposed below) you should do similar
> for OMAP2+.

Okay. Will use arch/subsys_initcall for starting the GPIO as per Tony's
suggestion.

>
> >>
> >> Also, the driver and device separation and init is totally mixed
> >> together and very confusing. The platform_driver is in
> >
> > Agreed. Please see my comment at the end of this patch in reply to your
> > other similar comment.
> >
> >
> >> plat-omap/gpio.c and should be doing the driver init:
> >> [early_]platform_driver_register() and _probe(). The platform_device
> >> setup is in mach-omapX/gpio*.c and where the device init should be, in
> >> this case early_platform_add_devices().
> >
> > In early_gpio_init, omap_device_build() (device specific) and
> > early_platform_driver_register_all() (driver specific), _probe() are
> > done in a sequence. This is because early_gpio_init needs to be called
> > asap and if we try to split this device specific and driver specific
> > early_inits, we will end up having two init calls for each early drivers.
> >
> > I feel that multiple function calls for early_init (one for driver probe and
> > one for device register) should be avoided as we need to find the right place
> > to call them.
>
> But your driver probe is already in a separate init path (via
> arch_initcall) from your device init path omap_gpio_init().
>
> My problem is that there is a 2nd driver init path:
> board file -> [driver]omap_gpio_init() -> [device] <soc>_gpio_init()
>
> The fact that it goes through the driver is what I don't like.
>

Okay.

> >>
> >>
> >> > Signed-off-by: Charulatha V <charu@ti.com>
> >> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> > ---
> >> >  arch/arm/mach-omap1/Makefile           |    6 +
> >> >  arch/arm/mach-omap1/clock_data.c       |    2 +-
> >> >  arch/arm/mach-omap2/Makefile           |    2 +-
> >> >  arch/arm/mach-omap2/clock2420_data.c   |   10 +-
> >> >  arch/arm/mach-omap2/clock2430_data.c   |   14 +-
> >> >  arch/arm/mach-omap2/clock3xxx_data.c   |   24 +-
> >> >  arch/arm/mach-omap2/clock44xx_data.c   |   24 +-
> >> >  arch/arm/plat-omap/gpio.c              |  405 ++++++++++++------------------
> --
> >> >  arch/arm/plat-omap/include/plat/gpio.h |   21 ++
> >> >  9 files changed, 220 insertions(+), 288 deletions(-)
> >>
> >> [...]
> >>
> >> > @@ -1621,6 +1501,34 @@ static void __init omap_gpio_show_rev(void)
> >> >   */
> >> >  static struct lock_class_key gpio_lock_class;
> >> >
> >> > +static int init_gpio_info(void)
> >> > +{
> >> > +   gpio_bank_bits = 32;
> >> > +
> >> > +   if (cpu_is_omap15xx()) {
> >> > +           gpio_bank_count = 2;
> >> > +           gpio_bank_bits = 16;
> >> > +   } else if (cpu_is_omap16xx()) {
> >> > +           gpio_bank_count = 5;
> >> > +           gpio_bank_bits = 16;
> >> > +   } else if (cpu_is_omap7xx())
> >> > +           gpio_bank_count = 7;
> >> > +   else if (cpu_is_omap242x())
> >> > +           gpio_bank_count = 4;
> >> > +   else if (cpu_is_omap243x())
> >> > +           gpio_bank_count = 5;
> >> > +   else if (cpu_is_omap34xx() || cpu_is_omap44xx())
> >> > +           gpio_bank_count = OMAP34XX_NR_GPIOS;
> >>
> >> Both the bank count and bank bits could be part of platform_data
> >> and set in the SoC specific init.  This is the GPIO driver part
> >> and we're trying to make this as SoC independent as possible.  Anytime
> >> you need to add a cpu_is* or #ifdef in this code indicates something
> >> that should be part of SoC specific init and passed in.
> >
> > bank count and bank bits are not specific to each device, but SoC specific.
> > Hence I did not consider passing it as part of platform_data, because this
> information would be duplicated across all devices in that SoC.
> >
> > It would be good if we have a way to pass the SoC specific data which is
> > common for all the devices rather than duplicating them by sending them via
> > platform_data.
> >
> > Anyways, I can move it to platform_data if there is no other way.
>
> Probably the right place for the SoC specifics is attached to the SoC
> specific hwmod using the dev_attr pointer.  That struct can then
> be passed in via platform_data.
>
> You can see how Thara did this for SmartReflex as an example.

Okay.

>
> >>
> >> > +   gpio_bank = kzalloc(gpio_bank_count * sizeof(struct gpio_bank),
> >> > +                           GFP_KERNEL);
> >> > +   if (!gpio_bank) {
> >> > +           pr_err("Memory allocation failed for gpio_bank\n");
> >> > +           return -ENOMEM;
> >> > +   }
> >> > +   return 0;
> >> > +}
> >> > +
> >> >  static void omap_gpio_mod_init(struct gpio_bank *bank, int id)
> >> >  {
> >> >     if (cpu_class_is_omap2()) {
> >> > @@ -1686,16 +1594,9 @@ static void omap_gpio_mod_init(struct gpio_bank *bank,
> >> int id)
> >> >
> >> >  static void __init omap_gpio_chip_init(struct gpio_bank *bank)
> >> >  {
> >> > -   int j, gpio_bank_bits = 16;
> >> > +   int j;
> >> >     static int gpio;
> >> >
> >> > -   if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX)
> >> > -           gpio_bank_bits = 32; /* 7xx has 32-bit GPIOs */
> >> > -
> >> > -   if ((bank->method == METHOD_GPIO_24XX) ||
> >> > -                   (bank->method == METHOD_GPIO_44XX))
> >> > -           gpio_bank_bits = 32;
> >> > -
> >> >     bank->mod_usage = 0;
> >> >     /* REVISIT eventually switch from OMAP-specific gpio structs
> >> >      * over to the generic ones
> >> > @@ -1737,140 +1638,103 @@ static void __init omap_gpio_chip_init(struct
> >> gpio_bank *bank)
> >> >     set_irq_data(bank->irq, bank);
> >> >  }
> >> >
> >> > -static int __init _omap_gpio_init(void)
> >> > +static inline void get_gpio_dbck(struct platform_device *pdev,
> >> > +                           struct gpio_bank *bank)
> >> >  {
> >> > -   int i;
> >> > -   int gpio = 0;
> >> > +   if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> >> > +           bank->dbck = clk_get(&pdev->dev, "dbck");
> >> > +           if (IS_ERR(bank->dbck))
> >> > +                   pr_err("GPIO: Could not get dbck\n");
> >> > +   }
> >> > +}
> >> > +static int __devinit omap_gpio_probe(struct platform_device *pdev)
> >> > +{
> >> > +   static int gpio_init_done;
> >> > +   struct omap_gpio_platform_data *pdata;
> >> > +   int id;
> >> >     struct gpio_bank *bank;
> >> > -   int bank_size = SZ_8K;  /* Module 4KB + L4 4KB except on omap1 */
> >> > -   char clk_name[11];
> >> > +   struct resource *res;
> >> >
> >> > -   initialized = 1;
> >> > +   if (!gpio_init_done)
> >> > +           init_gpio_info();
> >> >
> >> > -#if defined(CONFIG_ARCH_OMAP1)
> >> > -   if (cpu_is_omap15xx()) {
> >> > -           gpio_ick = clk_get(NULL, "arm_gpio_ck");
> >> > -           if (IS_ERR(gpio_ick))
> >> > -                   printk("Could not get arm_gpio_ck\n");
> >> > -           else
> >> > -                   clk_enable(gpio_ick);
> >> > +   if (!pdev || !pdev->dev.platform_data) {
> >> > +           pr_err("GPIO device initialize without"
> >> > +                                   "platform data\n");
> >> > +           return -EINVAL;
> >> >     }
> >> > -#endif
> >> > -#if defined(CONFIG_ARCH_OMAP2)
> >> > -   if (cpu_class_is_omap2()) {
> >> > -           gpio_ick = clk_get(NULL, "gpios_ick");
> >> > -           if (IS_ERR(gpio_ick))
> >> > -                   printk("Could not get gpios_ick\n");
> >> > -           else
> >> > -                   clk_enable(gpio_ick);
> >> > -           gpio_fck = clk_get(NULL, "gpios_fck");
> >> > -           if (IS_ERR(gpio_fck))
> >> > -                   printk("Could not get gpios_fck\n");
> >> > -           else
> >> > -                   clk_enable(gpio_fck);
> >> >
> >> > -           /*
> >> > -            * On 2430 & 3430 GPIO 5 uses CORE L4 ICLK
> >> > -            */
> >> > -#if defined(CONFIG_ARCH_OMAP2430)
> >> > -           if (cpu_is_omap2430()) {
> >> > -                   gpio5_ick = clk_get(NULL, "gpio5_ick");
> >> > -                   if (IS_ERR(gpio5_ick))
> >> > -                           printk("Could not get gpio5_ick\n");
> >> > -                   else
> >> > -                           clk_enable(gpio5_ick);
> >> > -                   gpio5_fck = clk_get(NULL, "gpio5_fck");
> >> > -                   if (IS_ERR(gpio5_fck))
> >> > -                           printk("Could not get gpio5_fck\n");
> >> > -                   else
> >> > -                           clk_enable(gpio5_fck);
> >> > -           }
> >> > -#endif
> >> > -   }
> >> > -#endif
> >> > +   pdata = pdev->dev.platform_data;
> >> >
> >> > -#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
> >> > -   if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> >> > -           for (i = 0; i < OMAP34XX_NR_GPIOS; i++) {
> >> > -                   sprintf(clk_name, "gpio%d_ick", i + 1);
> >> > -                   gpio_iclks[i] = clk_get(NULL, clk_name);
> >> > -                   if (IS_ERR(gpio_iclks[i]))
> >> > -                           printk(KERN_ERR "Could not get %s\n", clk_name);
> >> > -                   else
> >> > -                           clk_enable(gpio_iclks[i]);
> >> > -           }
> >> > +   id = pdev->id;
> >> > +   if (id > gpio_bank_count) {
> >> > +           pr_err("Invalid GPIO device id (%d)\n", id);
> >> > +           return -EINVAL;
> >> >     }
> >> > -#endif
> >> >
> >> > +   bank = &gpio_bank[id];
> >> >
> >> > -#ifdef CONFIG_ARCH_OMAP15XX
> >> > -   if (cpu_is_omap15xx()) {
> >> > -           gpio_bank_count = 2;
> >> > -           gpio_bank = gpio_bank_1510;
> >> > -           bank_size = SZ_2K;
> >> > -   }
> >> > -#endif
> >> > -#if defined(CONFIG_ARCH_OMAP16XX)
> >> > -   if (cpu_is_omap16xx()) {
> >> > -           gpio_bank_count = 5;
> >> > -           gpio_bank = gpio_bank_1610;
> >> > -           bank_size = SZ_2K;
> >> > -   }
> >> > -#endif
> >> > -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> >> > -   if (cpu_is_omap7xx()) {
> >> > -           gpio_bank_count = 7;
> >> > -           gpio_bank = gpio_bank_7xx;
> >> > -           bank_size = SZ_2K;
> >> > -   }
> >> > -#endif
> >> > -#ifdef CONFIG_ARCH_OMAP2
> >> > -   if (cpu_is_omap242x()) {
> >> > -           gpio_bank_count = 4;
> >> > -           gpio_bank = gpio_bank_242x;
> >> > -   }
> >> > -   if (cpu_is_omap243x()) {
> >> > -           gpio_bank_count = 5;
> >> > -           gpio_bank = gpio_bank_243x;
> >> > -   }
> >> > -#endif
> >> > -#ifdef CONFIG_ARCH_OMAP3
> >> > -   if (cpu_is_omap34xx()) {
> >> > -           gpio_bank_count = OMAP34XX_NR_GPIOS;
> >> > -           gpio_bank = gpio_bank_34xx;
> >> > +   if (bank->initialized == 1) {
> >>
> >> is_early_platform_device() can be used to tell if the _probe() is
> >> being called as part of early platform driver probe or "regular".
> >
> > Okay.
> >
> >>
> >> > +           /*
> >> > +            * Currently, for early platform_devices,
> >> > +            * clk_get() using dev ptr does not seem to be working
> >> > +            * Hence getting dbck during regular device probe
> >> > +            */
> >>
> >> Need a better explanation here.  "does not seem to work" is not
> >> quite good enough.
> >
> > Okay.
> > The reason for "does not seem to work" is that device_initialize()
> > is not called as part of omap_early_device_register and the clk_get
> > could not find the clock using dev pointer.
>
> OK, should be as part of this comment if you keep it here.
>
> >>
> >> > +           get_gpio_dbck(pdev, bank);
> >>
> >> In any case, maybe it's better to defer the clk_get() into
> >> the debounce setup and only use if needed.
> >
> > Then, this needs to be done only in omap_set_gpio_debounce() which does
> > not have pdev->dev info. I can take care of this.
>
> OK good. That's probably cleaner than doing it at init time anyways.
>
> >>
> >> > +           return 0;
> >> >     }
> >> > -#endif
> >> > -#ifdef CONFIG_ARCH_OMAP4
> >> > -   if (cpu_is_omap44xx()) {
> >> > -           gpio_bank_count = OMAP34XX_NR_GPIOS;
> >> > -           gpio_bank = gpio_bank_44xx;
> >> > +
> >> > +   res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> >> > +   if (unlikely(!res)) {
> >> > +           pr_err("GPIO Bank %i Invalid IRQ resource\n", id);
> >> > +           return -ENODEV;
> >> >     }
> >> > -#endif
> >> > -   for (i = 0; i < gpio_bank_count; i++) {
> >> > +   bank->irq = res->start;
> >> > +   bank->virtual_irq_start = pdata->virtual_irq_start;
> >> > +   bank->base = pdata->base;
> >>
> >> Why are you using pdata->base for OMAP2+ base addresses...
> > Thanks for pointing this. I will correct it.
> >
> >>
> >> > +   bank->method = pdata->method;
> >> >
> >> > -           bank = &gpio_bank[i];
> >> > -           spin_lock_init(&bank->lock);
> >> > +   spin_lock_init(&bank->lock);
> >> >
> >> > +   if (cpu_class_is_omap2()) {
> >> > +           bank->device_enable = pdata->device_enable;
> >> > +           bank->device_idle = pdata->device_idle;
> >> > +           bank->device_shutdown = pdata->device_shutdown;
> >> > +           pdata->device_enable(pdev);
> >> > +   } else if (cpu_class_is_omap1()) {
> >> >             /* Static mapping, never released */
> >> > -           bank->base = ioremap(bank->pbase, bank_size);
> >> > -           if (!bank->base) {
> >> > -                   printk(KERN_ERR "Could not ioremap gpio bank%i\n", i);
> >> > -                   continue;
> >> > +           res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>
> >> ... and doing it the right way here for OMAP1?
> >>
> >> platform_get_resource() should be used for both.
> >
> > Yes.
> >
> >>
> >> > +           if (unlikely(!res)) {
> >> > +                   pr_err("GPIO Bank %i Invalid mem resource\n", id);
> >> > +                   return -ENODEV;
> >> >             }
> >> >
> >> > -           omap_gpio_mod_init(bank, i);
> >> > -           omap_gpio_chip_init(bank);
> >> > +           bank->base = ioremap(res->start, resource_size(res));
> >> > +           if (!bank->base) {
> >> > +                   pr_err("Could not ioremap gpio bank%i\n", id);
> >> > +                   return -ENOMEM;
> >> > +           }
> >> >
> >> > -           if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
> >> > -                   sprintf(clk_name, "gpio%d_dbck", i + 1);
> >> > -                   bank->dbck = clk_get(NULL, clk_name);
> >> > -                   if (IS_ERR(bank->dbck))
> >> > -                           printk(KERN_ERR "Could not get %s\n", clk_name);
> >> > +           if (cpu_is_omap15xx() && (id == 0)) {
> >> > +                   static struct clk *gpio_clk;
> >> > +                   gpio_clk = clk_get(&pdev->dev, "arm_gpio_ck");
> >> > +                   if (IS_ERR(gpio_clk))
> >> > +                           pr_err("Could not get arm_gpio_ck\n");
> >> > +                   else
> >> > +                           clk_enable(gpio_clk);
> >> >             }
> >> >     }
> >> >
> >> > -   omap_gpio_show_rev();
> >> > +   omap_gpio_mod_init(bank, id);
> >> > +   omap_gpio_chip_init(bank);
> >> >
> >> > +   if (!gpio_init_done) {
> >> > +           omap_gpio_show_rev();
> >> > +           gpio_init_done = 1;
> >> > +   }
> >> > +
> >> > +   bank->initialized = 1;
> >>
> >> I think you can drop this flag, and use is_early_platform_device() if
> >> needed.
> >
> > Sure.
> >>
> >> >     return 0;
> >> >  }
> >> >
> >> > @@ -2210,16 +2074,42 @@ void omap_gpio_restore_context(void)
> >> >  }
> >> >  #endif
> >> >
> >> > -/*
> >> > - * This may get called early from board specific init
> >> > - * for boards that have interrupts routed via FPGA.
> >> > - */
> >> > +static struct platform_driver omap_gpio_driver = {
> >> > +   .probe          = omap_gpio_probe,
> >> > +   .driver         = {
> >> > +           .name   = "omap-gpio",
> >> > +   },
> >> > +};
> >> > +
> >> > +int __init omap_gpio_drv_reg(void)
> >> > +{
> >> > +   return platform_driver_register(&omap_gpio_driver);
> >> > +}
> >> > +
> >> > +early_platform_init("earlygpio", &omap_gpio_driver);
> >> > +
> >> >  int __init omap_gpio_init(void)
> >> >  {
> >> > -   if (!initialized)
> >> > -           return _omap_gpio_init();
> >> > -   else
> >> > +   int ret = 0;
> >> > +
> >> > +   if (initialized)
> >> >             return 0;
> >> > +
> >> > +#ifdef CONFIG_ARCH_OMAP1
> >> > +   if (cpu_is_omap7xx())
> >> > +           ret = omap7xx_gpio_init();
> >> > +   if (cpu_is_omap15xx())
> >> > +           ret = omap15xx_gpio_init();
> >> > +   if (cpu_is_omap16xx())
> >> > +           ret = omap16xx_gpio_init();
> >> > +#endif
> >> > +#ifdef CONFIG_ARCH_OMAP2PLUS
> >> > +   if (cpu_class_is_omap2())
> >> > +           ret = omap2_gpio_init();
> >> > +#endif
> >>
> >> No thanks.  driver init should not be calling device init.  The device
> >> init should have it's own initcall or be called by other early device
> >> init.
> >
> > Agreed. omap_gpio_init() does nothing but calling device_init().
> >
> > But having omap_gpio_init() isn't a problem for OMAP2+, whereas it
> > would break multi-omap build for OMAP1 because there are 3 files in
> > mach-omap1 for each omap.
> >
> > 1. I can club all the 3 gpio files in mach-omap1 in to one file
> > mach-omap1/gpio.c and use omap_gpio_init() in it. But the patch
> > size and file size might be much bigger as the platform_data for all
> > OMAP1 GPIO devices would be available in this file.
> >
> > 2. (or) While maintaining 3 different files for mach-omap1/gpio_xxx.c,
> > modify the board files (about 20 files) of mach-omap1 and make use
> > of SoC specific omap_gpio_init.
> >
> > 3. (or) Call gpio_init() from omap_init_common_hw() by removing the calls
> > from board files and do a cpu_is check (for mach-omap1) in it.
> >
> > Please suggest if we have any other ways to handle this and the better
> > way to handle this.
>
> I prefer 3.

Okay. New patch series would be posted in another 2 weeks.

>
> Kevin
