From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 1/7] ARM: OMAP2xxx: hwmod: Convert SHAM crypto device
 data to hwmod
Date: Mon, 22 Oct 2012 12:33:36 -0700
Message-ID: <20121022193336.GA1708@animalcreek.com>
References: <1350683640-15044-1-git-send-email-mgreer@animalcreek.com>
 <1350683640-15044-2-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1210201934550.27264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:52696 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab2JVTdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Oct 2012 15:33:37 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210201934550.27264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Oct 20, 2012 at 07:40:19PM +0000, Paul Walmsley wrote:
> Hi

Hi Paul.

> a few comments:
> 
> On Fri, 19 Oct 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > Convert the device data for the OMAP2 SHAM crypto IP from
> > explicit platform_data to hwmod.  When bit 1 (OMAP24XX_ST_SHA_MASK)
> > of the CM_IDLEST4_CORE register is set, the SHA IP is present.
> > 
> > CC: Paul Walmsley <paul@pwsan.com>
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> 
> ...
> 
> > 
> > diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
> > index c3cde1a..a09603c 100644
> > --- a/arch/arm/mach-omap2/clock2420_data.c
> > +++ b/arch/arm/mach-omap2/clock2420_data.c
> > @@ -1905,6 +1905,7 @@ static struct omap_clk omap2420_clks[] = {
> >  	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
> >  	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
> >  	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
> > +	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
> 
> This isn't needed; this alias already exists two lines below.

Umm, yeah.  Oops.  :)

> >  	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
> >  	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
> >  	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),

> > diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> > index c8c2117..5b613fa 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c

> > @@ -500,17 +484,27 @@ static struct platform_device sham_device = {
> >  
> >  static void omap_init_sham(void)
> >  {
> > -	if (cpu_is_omap24xx()) {
> > -		sham_device.resource = omap2_sham_resources;
> > -		sham_device.num_resources = omap2_sham_resources_sz;
> > +	if (cpu_is_omap24xx() &&
> > +	    (omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_IDLEST4) &
> > +						 OMAP24XX_ST_SHA_MASK)) {
> 
> Hmm.  Not sure I understand the purpose of this CM read.  Don't we want to 
> initialize this device unconditionally?

No, the device doesn't exist on all parts.  This is the only way
to tell if its there (AFAIK).

> Also we're trying to get rid of all of the direct CM/PRM accesses outside 
> of the prm*.c/cm*.c code.  If we need something like this, we should add 
> some support for it in hwmod & CM code, since that's where the data lives.

Okay.

Mark
--
