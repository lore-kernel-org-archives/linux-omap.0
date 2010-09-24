From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Fri, 24 Sep 2010 11:06:21 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1009241053400.10678@utopia.booyaka.com>
References: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com> <alpine.DEB.2.00.1009240920370.10678@utopia.booyaka.com> <4C9CD72E.40407@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:44464 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756857Ab0IXRGW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 13:06:22 -0400
In-Reply-To: <4C9CD72E.40407@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Ramirez Luna, Omar" <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Russell King <linux@arm.linux.org.uk>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, 24 Sep 2010, Nishanth Menon wrote:

> Paul Walmsley had written, on 09/24/2010 10:34 AM, the following:
> [...]
> > >   u32 omap3_features;
> > > +EXPORT_SYMBOL(omap3_features);
> > >   unsigned int omap_rev(void)
> > >  {
> > > -- 
> > > 1.7.1
> > > 
> > 
> > This omap3_features variable should not be used directly by any device
> > drivers since it is an OMAP-ism.  This type of feature info should be passed
> > through struct platform_data.  Looks like this would be quite easy to add by
> > editing mach-omap2/devices.c and adding platform_data?
> > 
> > ...
> > 
> > In the medium-term, definitely all of those 
> >     #if defined(CONFIG_ARCH_OMAP*)
> > 
> > and 
> >     if (cpu_is_omap*()) {
> > 
> > in this driver need to be removed.  The integration code (currently in
> > mach-omap2/devices.c) is what should handle this, or better yet, struct
> > dev_attr from hwmod.
> > 
> > Also the entire mailboxes driver at some point should be moved into
> > drivers/* ...
> just my 2 cents:
> 
> The intent of omap_has_featureX() is to ensure that the drivers dont do
> cpu_is_omap123(). Now if we had OMAP dma driver which has DMA chaining - what
> options do we have DMA driver?
> 
> a) we introduce it based on cpu_is_omap123() -> bad bad nightmare for
> maintenance
> b) we introduce it based on module h/w block(TI internal terminology "IP
> block") revision -> unfortunately no luck in some of the h/w blocks.
> c) we use if (omap_has_dma_chaining())

d) you pass in errata/feature flags via a platform_data struct, like 
McBSP, McSPI, MMC, MUSB, I2C, etc. already do on OMAP.  On OMAP1, which 
doesn't have hwmod support, you set your platform_data in your OMAP1 
integration code.  On OMAP2+ (which has hwmod support), you define your 
errata/feature flags and any other integration data that you need to pass 
via the struct omap_hwmod.dev_attr field, then pass that data via struct 
platform_data in the OMAP2+ integration code.  See for example

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg13288.html

and

http://marc.info/?l=linux-omap&m=124419789124570&w=2

(search for "dev_attr" in both cases)

...

As an aside, I think that any errata/features that can be automatically 
discriminated by the IP block revision register are better handled that 
way than by platform_data; but of course, as you mention, the hardware 
people sometimes neglect to bump that when they change something.


- Paul
