From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 08/12] arm: omap3: am35x: Fix clockdomain dependencies
Date: Wed, 11 Apr 2012 14:55:13 -0700
Message-ID: <20120411215513.GA31197@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
 <1334171147-7517-9-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:58110 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761211Ab2DKVzO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 17:55:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1204111540060.29473@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

On Wed, Apr 11, 2012 at 03:44:38PM -0600, Paul Walmsley wrote:
> Hi

Hello & thx for the feedback.

> On Wed, 11 Apr 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > The am35x family of SoCs do not have an IVA so
> > a parallel set of clockdomain dependencies are
> > required that are simililar to OMAP3 but without
> > any IVA dependencies.
> > 
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > ---

> > diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > index b84e138..a05a8cb 100644
> > --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > @@ -59,6 +59,12 @@ static struct clkdm_dep gfx_sgx_3xxx_wkdeps[] = {
> >  	{ NULL },
> >  };
> >  
> > +static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
> > +	{ .clkdm_name = "mpu_clkdm", },
> > +	{ .clkdm_name = "wkup_clkdm", },
> > +	{ NULL },
> > +};
> 
> Looks like there are an extra set of commas here, maybe just use:
> 
> static struct clkdm_dep gfx_sgx_am35x_wkdeps[] = {
> 	{ .clkdm_name = "mpu_clkdm" },
> 	{ .clkdm_name = "wkup_clkdm" },
> 	{ NULL },

Yes, there are extra commas but they come from the code I'm copying
and removing iva2_clkdm from.  I was keeping things consistent so I
kept the commas.  Given that, do you still want them removed?
(I'm indifferent.)

> > @@ -366,6 +473,26 @@ static struct clockdomain *clockdomains_omap3430_common[] __initdata = {
> >  	NULL
> >  };
> >  
> > +static struct clockdomain *clockdomains_am35x_common[] __initdata = {
> > +	&wkup_common_clkdm,
> > +	&cm_common_clkdm,
> > +	&prm_common_clkdm,
> > +	&mpu_am35x_clkdm,
> > +	&neon_clkdm,
> > +	&sgx_am35x_clkdm,
> > +	&core_l3_3xxx_clkdm,
> > +	&core_l4_3xxx_clkdm,
> > +	&dss_am35x_clkdm,
> > +	&per_am35x_clkdm,
> > +	&emu_clkdm,
> > +	&usbhost_am35x_clkdm,
> > +	&dpll1_clkdm,
> > +	&dpll3_clkdm,
> > +	&dpll4_clkdm,
> > +	&dpll5_clkdm,
> > +	NULL
> > +};
> 
> Looks like many of these clockdomains are shared with the rest of 
> OMAP3xxx.  Maybe move the shared ones into a common array, remove them 
> from clockdomains_omap3430_common, and in the init function below, first 
> register the shared ones?  That will avoid duplicate listings.

Okay.

Mark
--
