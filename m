From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH, RFC] default machine descriptor for multiplatform
Date: Thu, 31 Jan 2013 20:57:13 +0000
Message-ID: <201301312057.13913.arnd@arndb.de>
References: <20130131092024.GN2637@n2100.arm.linux.org.uk> <1638002.UJ7zfj1Wn5@wuerfel> <510ABD70.1020408@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:63164 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab3AaU55 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Jan 2013 15:57:57 -0500
In-Reply-To: <510ABD70.1020408@wwwdotorg.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Tony Lindgren <tony@atomide.com>, Olof Johansson <olof@lixom.net>, linux-omap@vger.kernel.org, Fabio Estevam <festevam@gmail.com>

On Thursday 31 January 2013, Stephen Warren wrote:

> With that change, we can remove the custom .init_machine() functions for
> all of Tegra, since they just do that:-)

Yes, actually quite a lot of them have the same code, and we also have
an increasing number of users of the irqchip_init and clocksource_of_init,
so those can also be cleaned up as a follow-on to this patch.

The main thing that has to remain for a lot of the platforms is SMP
support, and I don't see a good way around that yet.
 
> > diff --git a/drivers/irqchip/irqchip.c b/drivers/irqchip/irqchip.c
> 
> > +#ifdef CONFIG_IRQCHIP
> >  void __init irqchip_init(void)
> >  {
> >  	of_irq_init(__irqchip_begin);
> >  }
> > +#else
> > +static inline void irqchip_init(void)
> > +{
> > +}
> > +#endif
> 
> That'd need to go in a header file.

Yep, you're right, my mistake.

	Arnd
