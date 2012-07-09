From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] ARM: OMAP AM35x: clockdomain data: fix resolving
 dependency problem
Date: Mon, 9 Jul 2012 09:16:23 -0700
Message-ID: <20120709161623.GA17180@animalcreek.com>
References: <A874F61F95741C4A9BA573A70FE3998FCB33@DQHE02.ent.ti.com>
 <20120702174138.GA9669@animalcreek.com>
 <20120707124131.GA9034@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:53734 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab2GIQQ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 12:16:26 -0400
Content-Disposition: inline
In-Reply-To: <20120707124131.GA9034@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: "Kim, Milo" <Milo.Kim@ti.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sat, Jul 07, 2012 at 02:41:31PM +0200, Ladislav Michl wrote:
> On Mon, Jul 02, 2012 at 10:41:38AM -0700, Mark A. Greer wrote:
> > On Mon, Jul 02, 2012 at 05:54:57AM +0000, Kim, Milo wrote:
> > > In am35x board , iva2 clock domain doesn't be used.
> > > So mpu_am35x_clkdm should be used rather than mpu_3xxx_clkdm.
> > > OMAP3430 : mpu_3xxx_clkdm (with iva2 clkdm)
> > > AM35x    : mpu_am35x_clkdm (without iva2 clkdm)

> > > diff --git a/arch/arm/mach-omap2/clockdomains3xxx_data.c b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > > index d625844..56089c4 100644
> > > --- a/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > > +++ b/arch/arm/mach-omap2/clockdomains3xxx_data.c
> > > @@ -454,7 +454,6 @@ static struct clkdm_autodep clkdm_am35x_autodeps[] = {
> > >  
> > >  static struct clockdomain *clockdomains_common[] __initdata = {
> > >  	&wkup_common_clkdm,
> > > -	&mpu_3xxx_clkdm,
> > >  	&neon_clkdm,
> > >  	&core_l3_3xxx_clkdm,
> > >  	&core_l4_3xxx_clkdm,
> > > -- 
> > > 1.7.2.5
> > 
> > Hi Milo.
> > 
> > Thanks for the patch but this issue should already be fixed in a patch
> > that Tony just made a pull request for
> > (http://www.spinics.net/lists/linux-omap/msg73080.html).
> > 
> > >From that email (and branch in the email), look for this patch:
> > 
> > > Mark A. Greer (4):
> > 
> > >      ARM: OMAP AM35x: clockdomain data: Fix clockdomain dependencies
> > 
> > Please take a look as another set of eyes never hurts. :)
> 
> Hi Mark,
> 
> just tested above patch on Technexion's TAM-3517 and it indeed fixes above
> warning. Without patch, warning is generated. Tested on Tony's master branch.

Great, thanks for the follow up, Ladis.

Mark
