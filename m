From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 0/4 RFC]OMAP:GPIO: Make GPIO an early init device
Date: Wed, 17 Mar 2010 19:40:21 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C489C445@dbde02.ent.ti.com>
References: <20100216194618.GR21755@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48703 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754903Ab0CQOKh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Mar 2010 10:10:37 -0400
In-Reply-To: <20100216194618.GR21755@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony, 

> > > >
> > > > http://www.pwsan.com/omap/patches/gpio/0002-OMAP-GPIO-split-omap1-and-
> > > omap2.patch
> > >
> > > What, make two almost identical copies of the shared code? No way!
> > > Instead, please keep the common code under plat-omap:
> > >
> > > arch/arm/plat-omap/gpio.c
> > >
> > > Then implement the processor specific functions:
> > >
> > > arch/arm/mach-omap1/gpio.c
> > > arch/arm/mach-omap2/gpio.c
> > > arch/arm/mach-omap2/gpio24xx.c
> > > arch/arm/mach-omap2/gpio44xx.c
> > >
> > > Then have a subsys_initcall in processor specific implementation
> > > that sets the function pointers in the common code.
> > >
> > Tony,
> >
> > The current gpio.c has functions with code similar as mentioned below:
> > {
> > 	#ifdef CONFIG_ARCH_OMAP1
> > 		Get the reg offset for OMAP1
> > 	#endif
> > 	#ifdef CONFIG_ARCH_OMAP15XX
> > 		Get the reg offset for OMAP15XX
> > 	#endif
> > 	#ifdef CONFIG_ARCH_OMAP16XX
> > 		Get the reg offset for OMAP16XX
> > 	#endif
> > 	#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> > 		Get the reg offset for this OMAP
> > 	#endif
> > 	#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> > 		Get the reg offset for OMAP2&3
> > 	#endif
> > 	#if defined(CONFIG_ARCH_OMAP4)
> > 		Get the reg offset for OMAP4
> > 	#endif
> >
> > 	Read/write the register
> > }
> >
> > If function pointers are used in common code (plat-omap/gpio.c), the API's in
> this file would essentially do nothing but invoke these pointers. IMHO this is
> simply adding one unnecessary level of indirection.
> > Please correct me if I am missing out something.
> 
> For those you can just set the various reg offsets once
> during __init based on the omap type and then the function
> stays the same.
> 
> For example, in arch/arm/mach-omap2/gpio44xx.c you could
> have something like the following (completely untested):
> 
> static const struct gpio_reg omap4_gpio_reg[] = {
> 	...
> };
> 
> static const struct gpio_bank omap4_gpio_bank[] = {
> 	...
> };
> 
> static int omap_gpio_suspend(struct sys_device *dev, pm_message_t mesg)
> {
> 	...
> }
> 
> static int omap_gpio_resume(struct sys_device *dev)
> {
> 	...
> }
> 
> const struct omap_gpio omap4_gpio = {
> 	.regs		= omap4_gpio_reg,
> 	.banks		= omap4_gpio_bank,
> 	.suspend	= omap4_gpio_suspend,
> 	.resume		= omap4_gpio_resume,
> 	...
> };
> 
> ...
> 
> static int __init omap_gpio_init(void)
> {
> 	if (!cpu_is_omap44xx())
> 		return -ENODEV;
> 
> 	return omap_gpio_init(omap4_gpio);
> }
> arch_initcall(omap44xx_gpio_init);
> 
> For some of them, you want to be able to implement the whole
> function depending on the omap type that you boot.
> 
> We're already doing it like this in most places, the gpio.c code
> just needs to be updated for that.

Thanks. Can you please specify some example code & location in the 
current code base, so that I can align exactly before sending my
next version of patches? 

> 
> Regards,
> 
> Tony

