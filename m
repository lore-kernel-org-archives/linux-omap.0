From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
Date: Tue, 16 Feb 2010 11:46:18 -0800
Message-ID: <20100216194618.GR21755@atomide.com>
References: <20100215174928.GC21755@atomide.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF809F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51451 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757060Ab0BPTpa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 14:45:30 -0500
Content-Disposition: inline
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C3CF809F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Varadarajan, Charulatha <charu@ti.com> [100216 07:03]:
> > -----Original Message-----
> > From: Tony Lindgren [mailto:tony@atomide.com]
> > Sent: Monday, February 15, 2010 11:19 PM
> > To: Paul Walmsley
> > Cc: Varadarajan, Charulatha; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
> > 
> > * Paul Walmsley <paul@pwsan.com> [100214 17:38]:
> > > On Fri, 12 Feb 2010, Paul Walmsley wrote:
> > >
> > > > On Fri, 12 Feb 2010, Varadarajan, Charulatha wrote:
> > > >
> > > > >   OMAP: Convert GPIO into a early driver
> > > >
> > > > The above patch appears to be missing.  Could you please re-send?
> > >
> > > This patch was too big for the mailing list, so it's been posted here:
> 
> 
> Thanks Paul.
> 
> > >
> > > http://www.pwsan.com/omap/patches/gpio/0002-OMAP-GPIO-split-omap1-and-
> > omap2.patch
> > 
> > What, make two almost identical copies of the shared code? No way!
> > Instead, please keep the common code under plat-omap:
> > 
> > arch/arm/plat-omap/gpio.c
> > 
> > Then implement the processor specific functions:
> > 
> > arch/arm/mach-omap1/gpio.c
> > arch/arm/mach-omap2/gpio.c
> > arch/arm/mach-omap2/gpio24xx.c
> > arch/arm/mach-omap2/gpio44xx.c
> > 
> > Then have a subsys_initcall in processor specific implementation
> > that sets the function pointers in the common code.
> > 
> Tony,
> 
> The current gpio.c has functions with code similar as mentioned below:
> {
> 	#ifdef CONFIG_ARCH_OMAP1
> 		Get the reg offset for OMAP1
> 	#endif
> 	#ifdef CONFIG_ARCH_OMAP15XX
> 		Get the reg offset for OMAP15XX
> 	#endif
> 	#ifdef CONFIG_ARCH_OMAP16XX
> 		Get the reg offset for OMAP16XX
> 	#endif
> 	#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> 		Get the reg offset for this OMAP
> 	#endif
> 	#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> 		Get the reg offset for OMAP2&3
> 	#endif
> 	#if defined(CONFIG_ARCH_OMAP4)
> 		Get the reg offset for OMAP4
> 	#endif
> 
> 	Read/write the register 
> }
> 
> If function pointers are used in common code (plat-omap/gpio.c), the API's in this file would essentially do nothing but invoke these pointers. IMHO this is simply adding one unnecessary level of indirection. 
> Please correct me if I am missing out something.

For those you can just set the various reg offsets once
during __init based on the omap type and then the function
stays the same.

For example, in arch/arm/mach-omap2/gpio44xx.c you could
have something like the following (completely untested):

static const struct gpio_reg omap4_gpio_reg[] = {
	...
};

static const struct gpio_bank omap4_gpio_bank[] = {
	...
};

static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
{
	...
}

static int omap_gpio_resume(struct sys_device *dev)
{
	...
}

const struct omap_gpio omap4_gpio = {
	.regs		= omap4_gpio_reg,
	.banks		= omap4_gpio_bank,
	.suspend	= omap4_gpio_suspend,
	.resume		= omap4_gpio_resume,
	...
};

...

static int __init omap_gpio_init(void)
{
	if (!cpu_is_omap44xx())
		return -ENODEV;

	return omap_gpio_init(omap4_gpio);
}
arch_initcall(omap44xx_gpio_init);

For some of them, you want to be able to implement the whole
function depending on the omap type that you boot.

We're already doing it like this in most places, the gpio.c code
just needs to be updated for that.

Regards,

Tony

