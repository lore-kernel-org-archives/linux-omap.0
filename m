From: "Basak, Partha" <p-basak2@ti.com>
Subject: RE: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of
 sys_dev_class
Date: Tue, 10 Aug 2010 18:07:01 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E80AC458@dbde02.ent.ti.com>
References: <1281098065-24177-1-git-send-email-charu@ti.com>
	<1281098065-24177-2-git-send-email-charu@ti.com>
	<1281098065-24177-3-git-send-email-charu@ti.com>
	<1281098065-24177-4-git-send-email-charu@ti.com>
	<1281098065-24177-5-git-send-email-charu@ti.com>
	<1281098065-24177-6-git-send-email-charu@ti.com>
	<1281098065-24177-7-git-send-email-charu@ti.com>
	<1281098065-24177-8-git-send-email-charu@ti.com>
	<1281098065-24177-9-git-send-email-charu@ti.com>
	<1281098065-24177-10-git-send-email-charu@ti.com>
	<1281098065-24177-11-git-send-email-charu@ti.com>
	<1281098065-24177-12-git-send-email-charu@ti.com>
	<1281098065-24177-13-git-send-email-charu@ti.com>
 <871va79v28.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48192 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757541Ab0HJMhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 08:37:08 -0400
In-Reply-To: <871va79v28.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Tuesday, August 10, 2010 5:51 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; paul@pwsan.com; Cousson, Benoit; Nayak,
> Rajendra; Basak, Partha
> Subject: Re: [PATCH 12/13 v5] OMAP: GPIO: Use dev_pm_ops instead of
> sys_dev_class
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch makes GPIO driver to use dev_pm_ops instead of
> > sysdev_class. With this approach, gpio_bank_suspend & gpio_bank_resume
> > are not part of sys_dev_class.
> >
> > According to this patch, a GPIO bank relinquishes the clock using
> > PM runtime APIs when all the gpios in that bank are freed.
> 
> This does not match the code.
> 
> The only clock associated with a GPIO hwmod is the optional clock for
> the debounce clock.  This clock is managed by the driver itself, not
> by using the PM runtime API.
> 
> > It also
> > relinquishes the clocks in the idle-path too, as it is possible to
> > have a GPIO bank requested and still allow PER domain to go to OFF
> state.
> 
> This doesn't make sense to me.  What clocks are you referring to?
> 

The main clock is there for OMAP24xx, but not relevant for OMAP3 & 4.

> > In the idle path (interrupt disabled context), PM runtime APIs cannot
> > be used as they are not mutex-free functions. Hence omap_device APIs
> > are used in the idle and resume after idle path.
> 
> This needs much more fleshing out.
> 
> Exactly what mutexes are causing the problems here.  As pointed out in
> previous discussions, the ones in the PM runtime core should not be a
> problem in this path.  Therefore, I'll assume the problems are coming
> from the mutexes when the device code (mach-omap2/gpio.c) calls into the
> hwmod layer.  More on this in comments on the next patch.
> 

Sorry, this has not been documented correctly. The issue has more to do unconditional enabling of interrupts. We have received a patch from you on using pm_runtime functions in Idle path. We will try on GPIO and revert back.

> > To summarize,
> > 1. pm_runtime_get_sync() for any gpio bank is called when one of the
> gpios
> >    is requested on the bank, in which, no other gpio is being used (when
> >    mod_usage becomes non-zero)
> > 2. omap_device_enable() is called during gpio resume after idle, only
> >    if the particular bank is being used (if mod_usage is non-zero)
> 
> context is saved/restored in the idle path, but...
> 
> > 3. pm_runtime_put_sync() is called when the last used gpio in that
> >    gpio bank is freed (when mod_usage becomes zero)
> 
> in this path, the bank is now runtime suspended, but context has not
> been saved for it.  That should be fine, since this bank is no longer
> used, but now let's assume there was an off-mode transition and context
> is lost.  Then, gpio_request() is called which will trigger
> a pm_runtime_get_sync() and gpio_bank_runtime_resume() will be called.
> 
> In this case, it's not terribly clear that runtime_resume is doing sane
> things if context has just been lost.  Seems like runtime_resume should
> be a nop in this case since any re-init will be be done in gpio_request().

Runtime_suspend/resume for GPIO is not doing any save/restore context. In that sense, they are NOP. Context save/restore is taken care of only in the Idle path based on target power state and last power state respectively.

> 
> > 4. omap_device_idle() is called during idle, if the particular bank
> >    is being used (if mod_usage is non-zero)
> 
> This mixture of pm_runtime_* and omap_device_* APIs is confusing at
> best.
> 
> There should be a single path into the drivers runtime_suspend hooks.
> Namely, when pm_runtime_put_* is called and the usecount goes to zero.
> If you can't use the runtime PM APIs, then we need to understand
> *exactly* why and work on a solution for that particular problem.
> 
> On my omap34xx/omap3evm, I had to disable the omap_device_* calls in the
> idle path since as they were causing strange crashes, and as stated
> above, I'm not sure what the purpose is.
> 
> > With this patch, GPIO's prepare_for_idle and resume_after_idle APIs
> > makes use of the parameter save_context and restore_context respectively
> > inorder to identify if save context/restore context needs to be done.
> 
> Why?
> 
> > Links to related discussion:
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32833.html
> >
> > For suspend/resume path to work, this patch has dependency of
> > 1. reverting the following patch:
> > OMAP: bus-level PM: enable use of runtime PM API for suspend/resume
> > http://dev.omapzoom.org/?p=swarch/linux-omap-adv.git;a=commitdiff;
> > h=8041359e18e49bf8a3d41f15894db9e476f3a8fc
> > (or)
> > 2. Remove the locking in the omap_hwmod_for_each* function
> 
> Did you mean 'and' instead of 'or'?  If you meant 'or', then clearly
> (20 is preferred over (1), and I have a patch to fix that in the current
> pm-wip/runtime branch.
> 
> If you meant 'and', then you need to describe the root cause for (1).
> 
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Basak, Partha <p-basak2@ti.com>
> > ---
> >  arch/arm/mach-omap2/pm24xx.c           |    4 +-
> >  arch/arm/mach-omap2/pm34xx.c           |   23 +-
> >  arch/arm/plat-omap/gpio.c              |  561 ++++++++++++++++---------
> -------
> >  arch/arm/plat-omap/include/plat/gpio.h |    6 +-
> >  4 files changed, 297 insertions(+), 297 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> > index 6aeedea..c01e156 100644
> > --- a/arch/arm/mach-omap2/pm24xx.c
> > +++ b/arch/arm/mach-omap2/pm24xx.c
> > @@ -106,7 +106,7 @@ static void omap2_enter_full_retention(void)
> >  	l = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0) |
> OMAP24XX_USBSTANDBYCTRL;
> >  	omap_ctrl_writel(l, OMAP2_CONTROL_DEVCONF0);
> >
> > -	omap2_gpio_prepare_for_idle(PWRDM_POWER_RET);
> > +	omap2_gpio_prepare_for_idle(false);
> >
> >  	if (omap2_pm_debug) {
> >  		omap2_pm_dump(0, 0, 0);
> > @@ -140,7 +140,7 @@ no_sleep:
> >  		tmp = timespec_to_ns(&ts_idle) * NSEC_PER_USEC;
> >  		omap2_pm_dump(0, 1, tmp);
> >  	}
> > -	omap2_gpio_resume_after_idle();
> > +	omap2_gpio_resume_after_idle(false);
> >
> >  	clk_enable(osc_ck);
> >
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index fb4994a..66c7e11 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -79,16 +79,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
> >  static struct powerdomain *core_pwrdm, *per_pwrdm;
> >  static struct powerdomain *cam_pwrdm;
> >
> > -static inline void omap3_per_save_context(void)
> > -{
> > -	omap_gpio_save_context();
> > -}
> > -
> > -static inline void omap3_per_restore_context(void)
> > -{
> > -	omap_gpio_restore_context();
> > -}
> > -
> >  static void omap3_enable_io_chain(void)
> >  {
> >  	int timeout = 0;
> > @@ -395,15 +385,17 @@ void omap_sram_idle(void)
> >  	/* PER */
> >  	if (per_next_state < PWRDM_POWER_ON) {
> >  		omap_uart_prepare_idle(2);
> > -		omap2_gpio_prepare_for_idle(per_next_state);
> >  		if (per_next_state == PWRDM_POWER_OFF) {
> >  			if (core_next_state == PWRDM_POWER_ON) {
> >  				per_next_state = PWRDM_POWER_RET;
> >  				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
> >  				per_state_modified = 1;
> > -			} else
> > -				omap3_per_save_context();
> > +			}
> >  		}
> > +		if (per_next_state == PWRDM_POWER_OFF)
> > +			omap2_gpio_prepare_for_idle(true);
> > +		else
> > +			omap2_gpio_prepare_for_idle(false);
> 
> Why is this better than passing the next power state?

This would keep the GPIO function omap2_gpio_prepare_for_idle agnostic of Power state definition dependencies.
> 
> >  	}
> >
> >  	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
> > @@ -471,9 +463,10 @@ void omap_sram_idle(void)
> >  	/* PER */
> >  	if (per_next_state < PWRDM_POWER_ON) {
> >  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> > -		omap2_gpio_resume_after_idle();
> >  		if (per_prev_state == PWRDM_POWER_OFF)
> > -			omap3_per_restore_context();
> > +			omap2_gpio_resume_after_idle(true);
> > +		else
> > +			omap2_gpio_resume_after_idle(false);
> >  		omap_uart_resume_idle(2);
> >  		if (per_state_modified)
> >  			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
> > diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> > index 6a5cf43..6686f9f 100644
> > --- a/arch/arm/plat-omap/gpio.c
> > +++ b/arch/arm/plat-omap/gpio.c
> > @@ -25,12 +25,12 @@
> >  #include <linux/pm_runtime.h>
> >
> >  #include <plat/omap_device.h>
> > +#include <plat/powerdomain.h>
> >  #include <mach/hardware.h>
> >  #include <asm/irq.h>
> >  #include <mach/irqs.h>
> >  #include <mach/gpio.h>
> >  #include <asm/mach/irq.h>
> > -#include <plat/powerdomain.h>
> >
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
> > @@ -1045,6 +1044,9 @@ static int omap_gpio_request(struct gpio_chip
> *chip, unsigned offset)
> >  	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
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
> >  	spin_lock_irqsave(&bank->lock, flags);
> >
> >  	/* Set trigger to none. You need to enable the desired trigger with
> > @@ -1061,22 +1063,19 @@ static int omap_gpio_request(struct gpio_chip
> *chip, unsigned offset)
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
> 
> >  	}
> > +	bank->mod_usage |= 1 << offset;
> >  	spin_unlock_irqrestore(&bank->lock, flags);
> >
> >  	return 0;
> > @@ -1109,24 +1108,26 @@ static void omap_gpio_free(struct gpio_chip
> *chip, unsigned offset)
> >  		__raw_writel(1 << offset, reg);
> >  	}
> >  #endif
> > -	if (!cpu_class_is_omap1()) {
> > -		bank->mod_usage &= ~(1 << offset);
> > -		if (!bank->mod_usage) {
> > -			void __iomem *reg = bank->base;
> > -			u32 ctrl;
> > -
> > -			if (cpu_is_omap24xx() || cpu_is_omap34xx())
> > -				reg += OMAP24XX_GPIO_CTRL;
> > -			else if (cpu_is_omap44xx())
> > -				reg += OMAP4_GPIO_CTRL;
> > -			ctrl = __raw_readl(reg);
> > -			/* Module is disabled, clocks are gated */
> > -			ctrl |= 1;
> > -			__raw_writel(ctrl, reg);
> > -		}
> > +	bank->mod_usage &= ~(1 << offset);
> > +	if ((!bank->mod_usage) && (!cpu_class_is_omap1())) {
> > +		void __iomem *reg = bank->base;
> > +		u32 ctrl;
> > +
> > +		if (bank->method == METHOD_GPIO_24XX)
> > +			reg += OMAP24XX_GPIO_CTRL;
> > +		else if (bank->method == METHOD_GPIO_44XX)
> > +			reg += OMAP4_GPIO_CTRL;
> > +		ctrl = __raw_readl(reg);
> > +		/* Module is disabled, clocks are gated */
> > +		ctrl |= 1;
> > +		__raw_writel(ctrl, reg);
> 
> ditto, but in the runtime_suspend hook
> 
> >  	}
> > +
> >  	_reset_gpio(bank, bank->chip.base + offset);
> >  	spin_unlock_irqrestore(&bank->lock, flags);
> > +
> > +	if (!bank->mod_usage)
> > +		pm_runtime_put_sync(bank->dev);
> 
> see above
> 
> >  }
> >
> >  /*
> > @@ -1728,7 +1729,6 @@ static int __devinit omap_gpio_probe(struct
> platform_device *pdev)
> >  	}
> >
> >  	pm_runtime_enable(bank->dev);
> > -	pm_runtime_get_sync(bank->dev);
> 
> as mentioned before, this should stay, otherwise mod_init will fault if
> GPIO hwmod is disabled.
> 
> >  	omap_gpio_mod_init(bank, id);
> >  	omap_gpio_chip_init(bank);
> > @@ -1741,294 +1741,222 @@ static int __devinit omap_gpio_probe(struct
> platform_device *pdev)
> 
> and you'd need a matching 'put' here.

Agreed.

> 
> [...]
> 
> Kevin
