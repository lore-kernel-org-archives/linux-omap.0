From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 26 Jul 2012 16:08:24 -0700
Message-ID: <20120726230824.GB20413@animalcreek.com>
References: <alpine.DEB.2.00.1207131217590.25585@utopia.booyaka.com>
 <20120717004010.GA6612@animalcreek.com>
 <alpine.DEB.2.00.1207161841260.28834@utopia.booyaka.com>
 <WC20120717100848.280191@terrafix.co.uk>
 <alpine.DEB.2.00.1207171326510.28834@utopia.booyaka.com>
 <20120718022035.GC18663@animalcreek.com>
 <WC20120718100634.8301FB@terrafix.co.uk>
 <20120718172654.GA27904@animalcreek.com>
 <CAKvrXUpeC2N-CRLuVGPKNVEV_tqRfGF1EgsYJ8f4mHjo7oEY5w@mail.gmail.com>
 <20120726230630.GA21004@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:56912 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009Ab2GZXIo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jul 2012 19:08:44 -0400
Content-Disposition: inline
In-Reply-To: <20120726230630.GA21004@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Juha Kuikka <juha.kuikka@gmail.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On Thu, Jul 26, 2012 at 04:06:30PM -0700, Mark A. Greer wrote:
> On Thu, Jul 26, 2012 at 02:09:33PM -0700, Juha Kuikka wrote:

> > Just applying Mark's patch on top of
> > 55936cdfaaf11ac352b56bc58e42d6661e65ee13 (linux-omap) is not enough, I
> > also need to set the OMAP3_HAS_IVA_REGS for the 3430 as well.
> > 
> > Inlined patch:
> > 
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 4072fbd..45d3eb4 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -244,7 +244,7 @@ void __init omap3xxx_check_features(void)
> >         if (cpu_is_omap3630())
> >                 omap_features |= OMAP3_HAS_192MHZ_CLK | OMAP3_HAS_IVA_REGS;
> >         if (cpu_is_omap3430() || cpu_is_omap3630())
> > -               omap_features |= OMAP3_HAS_IO_WAKEUP;
> > +               omap_features |= OMAP3_HAS_IO_WAKEUP | OMAP3_HAS_IVA_REGS;
> >         if (cpu_is_omap3630() || omap_rev() == OMAP3430_REV_ES3_1 ||
> >             omap_rev() == OMAP3430_REV_ES3_1_2)
> >                 omap_features |= OMAP3_HAS_IO_CHAIN_CTRL;
> 
> Thank you.

I meant to add, "Please make a formal patch for review so you can
get credit for your work."

Mark
