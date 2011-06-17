From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 12/18] GPIO: OMAP: Clean omap_gpio_mod_init function
Date: Fri, 17 Jun 2011 10:41:31 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC571@dbde02.ent.ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-3-git-send-email-tarun.kanti@ti.com>
 <87fwn9mzu0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43302 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab1FQFLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 01:11:39 -0400
In-Reply-To: <87fwn9mzu0.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, June 16, 2011 11:19 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 12/18] GPIO: OMAP: Clean omap_gpio_mod_init
> function
> 
> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
> 
> > From: Charulatha V <charu@ti.com>
> >
> > With register offsets now defined for respective OMAP versions we can
> get rid
> > of cpu_class_* checks. In addition, organized common initialization for
> the
> > different OMAP silicon versions.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Since the SYSCONFIG register settings are OMAP1-only and init-time only,
> they could be done in the OMAP1-specific init functions.
Right, I will change.

> 
> Also, this could be quite a bit more compact by not duplicating code for
> both bank widths.  Instead, create some local function pointers for 16
> or 32-bit register access, and assign them based on bank width.
Sounds good! I will do that.
--
Tarun
> 
> Kevin
> 
> > ---
> >  arch/arm/mach-omap1/gpio16xx.c         |    1 +
> >  arch/arm/plat-omap/include/plat/gpio.h |    2 +
> >  drivers/gpio/gpio-omap.c               |  121 +++++++++++++++++++++----
> -------
> >  3 files changed, 84 insertions(+), 40 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-
> omap1/gpio16xx.c
> > index 4677ea5..efd9275 100644
> > --- a/arch/arm/mach-omap1/gpio16xx.c
> > +++ b/arch/arm/mach-omap1/gpio16xx.c
> > @@ -96,6 +96,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs =
> {
> >  	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
> >  	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
> >  	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
> > +	.sysconfig	= OMAP1610_GPIO_SYSCONFIG,
> >  };
> >
> >  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config
> = {
> > diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-
> omap/include/plat/gpio.h
> > index c0a92ea..30db400 100644
> > --- a/arch/arm/plat-omap/include/plat/gpio.h
> > +++ b/arch/arm/plat-omap/include/plat/gpio.h
> > @@ -200,6 +200,8 @@ struct omap_gpio_reg_offs {
> >  	u16 irqctrl;
> >  	u16 edgectrl1;
> >  	u16 edgectrl2;
> > +	/* Not applicable for OMAP2+ as hwmod layer takes care of sysconfig
> */
> > +	u16 sysconfig;
> >
> >  	bool irqenable_inv;
> >  };
> > diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> > index 53f2ea6..89d1ea5 100644
> > --- a/drivers/gpio/gpio-omap.c
> > +++ b/drivers/gpio/gpio-omap.c
> > @@ -887,47 +887,94 @@ static void __init omap_gpio_show_rev(struct
> gpio_bank *bank)
> >   */
> >  static struct lock_class_key gpio_lock_class;
> >
> > -/* TODO: Cleanup cpu_is_* checks */
> >  static void omap_gpio_mod_init(struct gpio_bank *bank)
> >  {
> > -	if (cpu_class_is_omap2()) {
> > -		if (cpu_is_omap44xx()) {
> > -			__raw_writel(0xffffffff, bank->base +
> > -					OMAP4_GPIO_IRQSTATUSCLR0);
> > -			__raw_writel(0x00000000, bank->base +
> > -					 OMAP4_GPIO_DEBOUNCENABLE);
> > -			/* Initialize interface clk ungated, module enabled */
> > -			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> > -		} else if (cpu_is_omap34xx()) {
> > -			__raw_writel(0x00000000, bank->base +
> > -					OMAP24XX_GPIO_IRQENABLE1);
> > -			__raw_writel(0xffffffff, bank->base +
> > -					OMAP24XX_GPIO_IRQSTATUS1);
> > -			__raw_writel(0x00000000, bank->base +
> > -					OMAP24XX_GPIO_DEBOUNCE_EN);
> > +	if (bank->width == 32) {
> > +		u32 clr_all = 0;		/* clear all the bits */
> > +		u32 set_all = 0xFFFFFFFF;	/* set all the bits */
> > +
> > +		if (bank_is_mpuio(bank)) {
> > +			__raw_writel(set_all, bank->base +
> > +						bank->regs->irqenable);
> > +
> > +			if (bank->suspend_support)
> > +				mpuio_init(bank);
> >
> > +			return;
> > +		}
> > +
> > +		if (bank->regs->ctrl)
> >  			/* Initialize interface clk ungated, module enabled */
> > -			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> > +			 __raw_writel(clr_all, bank->base + bank->regs->ctrl);
> > +
> > +		if (bank->regs->clr_irqenable) {
> > +			__raw_writel(set_all, bank->base +
> > +						bank->regs->clr_irqenable);
> > +		} else if (bank->regs->irqenable) {
> > +			u32 i;
> > +
> > +			if (bank->regs->irqenable_inv)
> > +				i = set_all;
> > +			else
> > +				i = clr_all;
> > +
> > +			__raw_writel(i, bank->base + bank->regs->irqenable);
> >  		}
> > -	} else if (cpu_class_is_omap1()) {
> > -		if (bank_is_mpuio(bank) && bank->suspend_support) {
> > -			__raw_writew(0xffff, bank->base +
> > -				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
> > -			mpuio_init(bank);
> > +
> > +		if (bank->regs->irqstatus) {
> > +			u32 i;
> > +
> > +			if (bank->regs->irqenable_inv)
> > +				i = clr_all;
> > +			else
> > +				i = set_all;
> > +
> > +			__raw_writel(i, bank->base + bank->regs->irqstatus);
> >  		}
> > -		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
> > -			__raw_writew(0xffff, bank->base
> > -						+ OMAP1510_GPIO_INT_MASK);
> > -			__raw_writew(0x0000, bank->base
> > -						+ OMAP1510_GPIO_INT_STATUS);
> > +
> > +		if (bank->regs->debounce_en)
> > +			__raw_writel(clr_all, bank->base +
> > +						bank->regs->debounce_en);
> > +
> > +	} else if (bank->width == 16) {
> > +		u16 clr_all = 0;	/* clear all the bits */
> > +		u16 set_all = 0xFFFF;	/* set all the bits */
> > +
> > +		if (bank_is_mpuio(bank)) {
> > +			__raw_writew(set_all, bank->base +
> > +						bank->regs->irqenable);
> > +
> > +			if (bank->suspend_support)
> > +				mpuio_init(bank);
> > +
> > +			return;
> >  		}
> > -		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
> > -			__raw_writew(0x0000, bank->base
> > -						+ OMAP1610_GPIO_IRQENABLE1);
> > -			__raw_writew(0xffff, bank->base
> > -						+ OMAP1610_GPIO_IRQSTATUS1);
> > -			__raw_writew(0x0014, bank->base
> > -						+ OMAP1610_GPIO_SYSCONFIG);
> > +
> > +		if (bank->regs->irqenable) {
> > +			u16 i;
> > +
> > +			if (bank->regs->irqenable_inv)
> > +				i = set_all;
> > +			else
> > +				i = clr_all;
> > +
> > +			__raw_writew(i, bank->base + bank->regs->irqenable);
> > +		}
> > +
> > +		if (bank->regs->irqstatus) {
> > +			u32 i;
> > +
> > +			if (bank->regs->irqenable_inv)
> > +				i = clr_all;
> > +			else
> > +				i = set_all;
> > +
> > +			__raw_writew(i, bank->base + bank->regs->irqstatus);
> > +		}
> > +
> > +		if (bank->regs->sysconfig) {
> > +			/* set wakeup-enable and smart-idle */
> > +			__raw_writew(0x14, bank->base + bank->regs->sysconfig);
> >
> >  			/*
> >  			 * Enable system clock for GPIO module.
> > @@ -936,12 +983,6 @@ static void omap_gpio_mod_init(struct gpio_bank
> *bank)
> >  			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> >  						ULPD_CAM_CLK_CTRL);
> >  		}
> > -		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> > -			__raw_writel(0xffffffff, bank->base
> > -						+ OMAP7XX_GPIO_INT_MASK);
> > -			__raw_writel(0x00000000, bank->base
> > -						+ OMAP7XX_GPIO_INT_STATUS);
> > -		}
> >  	}
> >  }
