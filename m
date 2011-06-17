From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend support
 flag
Date: Fri, 17 Jun 2011 21:23:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037B9AC86C@dbde02.ent.ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-7-git-send-email-tarun.kanti@ti.com>
	<87boxxpvi2.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037B9AC59F@dbde02.ent.ti.com>
 <87lix0cv6j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34776 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772Ab1FQPx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 11:53:56 -0400
In-Reply-To: <87lix0cv6j.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Friday, June 17, 2011 9:22 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Shilimkar, Santosh; tony@atomide.com
> Subject: Re: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend
> support flag
> 
> "DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:
> 
> [...]
> 
> >> > diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-
> >> omap1/gpio16xx.c
> >> > index 9a97e60..d1da7c8 100644
> >> > --- a/arch/arm/mach-omap1/gpio16xx.c
> >> > +++ b/arch/arm/mach-omap1/gpio16xx.c
> >> > @@ -52,6 +52,7 @@ static struct __initdata omap_gpio_platform_data
> >> omap16xx_mpu_gpio_config = {
> >> >     .bank_type              = METHOD_MPUIO,
> >> >     .bank_width             = 16,
> >> >     .bank_stride            = 1,
> >> > +   .suspend_support        = true,
> >> >     .regs                   = &omap16xx_mpuio_regs,
> >> >  };
> >> >
> >> > @@ -89,12 +90,16 @@ static struct omap_gpio_reg_offs
> omap16xx_gpio_regs
> >> = {
> >> >     .irqenable      = OMAP1610_GPIO_IRQENABLE1,
> >> >     .set_irqenable  = OMAP1610_GPIO_SET_IRQENABLE1,
> >> >     .clr_irqenable  = OMAP1610_GPIO_CLEAR_IRQENABLE1,
> >> > +   .wkup_status    = OMAP1610_GPIO_WAKEUPENABLE,
> >> > +   .wkup_clear     = OMAP1610_GPIO_CLEAR_WAKEUPENA,
> >> > +   .wkup_set       = OMAP1610_GPIO_SET_WAKEUPENA,
> >> >  };
> >> >
> >> >  static struct __initdata omap_gpio_platform_data
> omap16xx_gpio1_config
> >> = {
> >> >     .virtual_irq_start      = IH_GPIO_BASE,
> >> >     .bank_type              = METHOD_GPIO_1610,
> >> >     .bank_width             = 16,
> >> > +   .suspend_support        = true,
> >> >     .regs                   = &omap16xx_gpio_regs,
> >> >  };
> >> >
> >> > @@ -125,6 +130,7 @@ static struct __initdata omap_gpio_platform_data
> >> omap16xx_gpio2_config = {
> >> >     .virtual_irq_start      = IH_GPIO_BASE + 16,
> >> >     .bank_type              = METHOD_GPIO_1610,
> >> >     .bank_width             = 16,
> >> > +   .suspend_support        = true,
> >> >     .regs                   = &omap16xx_gpio_regs,
> >> >  };
> >> >
> >> > @@ -155,6 +161,7 @@ static struct __initdata omap_gpio_platform_data
> >> omap16xx_gpio3_config = {
> >> >     .virtual_irq_start      = IH_GPIO_BASE + 32,
> >> >     .bank_type              = METHOD_GPIO_1610,
> >> >     .bank_width             = 16,
> >> > +   .suspend_support        = true,
> >> >     .regs                   = &omap16xx_gpio_regs,
> >> >  };
> >> >
> >> > @@ -185,6 +192,7 @@ static struct __initdata omap_gpio_platform_data
> >> omap16xx_gpio4_config = {
> >> >     .virtual_irq_start      = IH_GPIO_BASE + 48,
> >> >     .bank_type              = METHOD_GPIO_1610,
> >> >     .bank_width             = 16,
> >> > +   .suspend_support        = true,
> >> >     .regs                   = &omap16xx_gpio_regs,
> >> >  };
> >>
> >> Notice that you add a 'suspend_support = true' everywhere you add a the
> >> wkup_* registers.  This suggests to me that checking for the presence
> of
> >> one of those registers would tell you the same thing.
> >
> > Agreed!
> >
> 
> Specifically, I recommend checking for wake_status, since wake_set and
> wake_clear are legacy registers and may not be recommended (or present)
> on OMAP4+.
OK.

> 
> Kevin
