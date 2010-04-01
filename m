From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 1/8] OMAP:GPIO:Move architecture specific macros to
 specific header
Date: Thu, 1 Apr 2010 16:20:37 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C4C32944@dbde02.ent.ti.com>
References: <20100401094116.GJ31200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34568 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148Ab0DAKur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 06:50:47 -0400
In-Reply-To: <20100401094116.GJ31200@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, April 01, 2010 3:11 PM
> To: Varadarajan, Charulatha
> Cc: felipe.balbi@nokia.com; linux-omap@vger.kernel.org; Nayak, Rajendra;
> paul@pwsan.com
> Subject: Re: [PATCH 1/8] OMAP:GPIO:Move architecture specific macros to specific
> header
> 
> * Varadarajan, Charulatha <charu@ti.com> [100401 01:48]:
> > >
> > > Add prefixes to these defines and remove the ifdefs.
> > > This breaks multi-omap builds.
> >
> > AFAIK multi-omap build not applicable for OMAP1
> 
> Wrong. Multi-omap for omap1 has been mostly working for
> about 5 years. In general, we don't want to apply patches
> that obviously break things like that.
> 

These macros already existed in plat/gpio.c and I just moved
it to gpio.h. It was not newly introduced by me.

Please point to a defconfig that takes care of multi-omap1 build
similar to what we have for OMAP2PLUS so that we can take
care of this in the future.

> If you take a look at arch/arm/mach-omap1/Kconfig, there's
> no "choice" there between omap1 socs.
> 
> > >
> > > >-struct gpio_bank {
> > > >-       unsigned long pbase;
> > > >-       void __iomem *base;
> > > >-       u16 irq;
> > > >-       u16 virtual_irq_start;
> > > >-       int method;
> > > >-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
> > > >-       u32 suspend_wakeup;
> > > >-       u32 saved_wakeup;
> > > >-#endif
> > > >-#ifdef CONFIG_ARCH_OMAP2PLUS
> > > >-       u32 non_wakeup_gpios;
> > > >-       u32 enabled_non_wakeup_gpios;
> > > >-
> > > >-       u32 saved_datain;
> > > >-       u32 saved_fallingdetect;
> > > >-       u32 saved_risingdetect;
> > > >-#endif
> > > >-       u32 level_mask;
> > > >-       u32 toggle_mask;
> > > >-       spinlock_t lock;
> > > >-       struct gpio_chip chip;
> > > >-       struct clk *dbck;
> > > >-       u32 mod_usage;
> > > >-};
> > >
> > > defines are fine, but this structure belongs to this driver. Nobody else
> > > should need to poke on it. Keep it here.
> >
> > This would get used in mach-omap layers in the later patches.
> > Hence moving it to gpio.h
> 
> Why would the hwmod code need to know about the register layout?
> That's totally gpio specific.

Yes, they are GPIO specific and not used in hwmod code. They are 
used in the OMAP specific GPIO code (eg., set gpio triggering 
is handled different for different OMAPs and they need this structure).

> 
> > > >@@ -625,10 +421,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
> > > >        bank = get_gpio_bank(gpio);
> > > >        reg = bank->base;
> > > >
> > > >+#ifdef CONFIG_ARCH_OMAP2PLUS
> > > >        if (cpu_is_omap44xx())
> > > >                reg += OMAP4_GPIO_DEBOUNCENABLE;
> > > >        else
> > > >                reg += OMAP24XX_GPIO_DEBOUNCE_EN;
> > > >+#endif
> > >
> > > you should try to remove ifdefs not add more.
> >
> > As mentioned in the beginning of this patch, these are
> > only temporary and all possible #ifdefs are removed at
> > the end of this patch series when plat-omap/gpio.c handles
> > only common APIs.
> 
> You need to first implement just initializing things using the
> platform data. Only then start messing with the functions.

Okay.

> 
> Tony
