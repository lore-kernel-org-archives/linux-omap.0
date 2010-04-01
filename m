From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/8] OMAP:GPIO:Move architecture specific macros to
 specific header
Date: Thu, 1 Apr 2010 02:41:17 -0700
Message-ID: <20100401094116.GJ31200@atomide.com>
References: <20100401071713.GC16297@nokia.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F28D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49754 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688Ab0DAJj2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Apr 2010 05:39:28 -0400
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C4B8F28D@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>

* Varadarajan, Charulatha <charu@ti.com> [100401 01:48]:
> > 
> > Add prefixes to these defines and remove the ifdefs.
> > This breaks multi-omap builds.
> 
> AFAIK multi-omap build not applicable for OMAP1

Wrong. Multi-omap for omap1 has been mostly working for
about 5 years. In general, we don't want to apply patches
that obviously break things like that.

If you take a look at arch/arm/mach-omap1/Kconfig, there's
no "choice" there between omap1 socs.
 
> > 
> > >-struct gpio_bank {
> > >-       unsigned long pbase;
> > >-       void __iomem *base;
> > >-       u16 irq;
> > >-       u16 virtual_irq_start;
> > >-       int method;
> > >-#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
> > >-       u32 suspend_wakeup;
> > >-       u32 saved_wakeup;
> > >-#endif
> > >-#ifdef CONFIG_ARCH_OMAP2PLUS
> > >-       u32 non_wakeup_gpios;
> > >-       u32 enabled_non_wakeup_gpios;
> > >-
> > >-       u32 saved_datain;
> > >-       u32 saved_fallingdetect;
> > >-       u32 saved_risingdetect;
> > >-#endif
> > >-       u32 level_mask;
> > >-       u32 toggle_mask;
> > >-       spinlock_t lock;
> > >-       struct gpio_chip chip;
> > >-       struct clk *dbck;
> > >-       u32 mod_usage;
> > >-};
> > 
> > defines are fine, but this structure belongs to this driver. Nobody else
> > should need to poke on it. Keep it here.
> 
> This would get used in mach-omap layers in the later patches.
> Hence moving it to gpio.h

Why would the hwmod code need to know about the register layout?
That's totally gpio specific.
 
> > >@@ -625,10 +421,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
> > >        bank = get_gpio_bank(gpio);
> > >        reg = bank->base;
> > >
> > >+#ifdef CONFIG_ARCH_OMAP2PLUS
> > >        if (cpu_is_omap44xx())
> > >                reg += OMAP4_GPIO_DEBOUNCENABLE;
> > >        else
> > >                reg += OMAP24XX_GPIO_DEBOUNCE_EN;
> > >+#endif
> > 
> > you should try to remove ifdefs not add more.
> 
> As mentioned in the beginning of this patch, these are
> only temporary and all possible #ifdefs are removed at
> the end of this patch series when plat-omap/gpio.c handles
> only common APIs.

You need to first implement just initializing things using the
platform data. Only then start messing with the functions.

Tony
