From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of
 sys_dev_class
Date: Fri, 17 Sep 2010 13:47:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6E9D122@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52955 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082Ab0IQIRO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 04:17:14 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <IMCEAEX-_O=TI_OU=EXCHANGE+20ADMINISTRATIVE+20GROUP+20+28FYDIBOHF23SPDLT+29_CN=RECIPIENTS_CN=X0016154@dlee86.itg.ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, August 10, 2010 5:51 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, 
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops 
> instead of sys_dev_class
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch makes GPIO driver to use dev_pm_ops instead of
> > sysdev_class. With this approach, gpio_bank_suspend & 
> gpio_bank_resume
> > are not part of sys_dev_class.

<<snip>>

> >  /*
> >   * OMAP1510 GPIO registers
> > @@ -179,7 +179,6 @@ struct gpio_bank {
> >   * related to all instances of the device
> >   */
> >  static struct gpio_bank *gpio_bank;
> > -
> >  static int bank_width;
> >  
> >  /* TODO: Analyze removing gpio_bank_count usage from driver code */
> > @@ -1045,6 +1044,9 @@ static int omap_gpio_request(struct 
> gpio_chip *chip, unsigned offset)
> >  	struct gpio_bank *bank = container_of(chip, struct 
> gpio_bank, chip);
> >  	unsigned long flags;
> >  
> > +	if (!bank->mod_usage)
> > +		pm_runtime_get_sync(bank->dev);
> > +
> 
> Would be fine to skip the 'if' here and let runtime PM continue the
> usecounting.  Since we'll have trace tools that instrument runtime PM,
> it will be nice to be able to trace all the users instead of just the
> first one to request a GPIO in a given bank.
> 
We are continuing to use mod_usage checks for the following reasons:

1. In the absence of mod_usage,
pm_runtime_getsync() would be called in the omap_gpio_request()once per
pin for each bank. However, a matching pm_runtime_putsync() would be
called in the CPU_Idle path only once for a given bank. This would lead to 
atomic_dec_and_test(&dev->power.usage_count) to return false and
the put_sync will not be effective.

2. Consider a case that a bank is not requested at all but in the CPU_Idle path we
 go-ahead and call pm_runtime_putsync() for that bank. Since usage_count is
already zero, this call makes it negative. Now, a subsequent call to
get_sync() will increment it to 0 and enable the clocks. 
This leads to an error-scenario where clocks are enabled with usage_cnt = 0.

3. Ideally we should not be even attempting to fiddle with the
un-requested GPIO banks in the CPU_Idle path.

> >  	spin_lock_irqsave(&bank->lock, flags);
> >  
> >  	/* Set trigger to none. You need to enable the desired 
> trigger with
> > @@ -1061,22 +1063,19 @@ static int omap_gpio_request(struct 
> gpio_chip *chip, unsigned offset)
> >  		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
> >  	}
> >  #endif
> > -	if (!cpu_class_is_omap1()) {
> > -		if (!bank->mod_usage) {
> > -			void __iomem *reg = bank->base;
> > -			u32 ctrl;
> > -
> > -			if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > -				reg += OMAP24XX_GPIO_CTRL;
> > -			else if (cpu_is_omap44xx())
> > -				reg += OMAP4_GPIO_CTRL;
> > -			ctrl = __raw_readl(reg);
> > -			/* Module is enabled, clocks are not gated */
> > -			ctrl &= 0xFFFFFFFE;
> > -			__raw_writel(ctrl, reg);
> > -		}
> > -		bank->mod_usage |= 1 << offset;
> > +	if ((!bank->mod_usage) && (!cpu_class_is_omap1())) {
> > +		void __iomem *reg = bank->base;
> > +		u32 ctrl;
> > +		if (bank->method == METHOD_GPIO_24XX)
> > +			reg += OMAP24XX_GPIO_CTRL;
> > +		else if (bank->method == METHOD_GPIO_44XX)
> > +			reg += OMAP4_GPIO_CTRL;
> > +		ctrl = __raw_readl(reg);
> > +		/* Module is enabled, clocks are not gated */
> > +		ctrl &= 0xFFFFFFFE;
> > +		__raw_writel(ctrl, reg);
> 
> If you get rid of the 'if (!mod_usage)' check above for the
> pm_runtime_get, you could just get rid of the mod_usage flag all
> together and do this section in the runtime_resume hook.

