From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
Date: Fri, 7 Aug 2009 11:23:25 +0300
Message-ID: <20090807082322.GZ2358@atomide.com>
References: <1249554967-20394-1-git-send-email-premi@ti.com> <20090806110359.GD2358@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301D8C80741@dbde02.ent.ti.com> <20090806115025.GG2358@atomide.com> <B85A65D85D7EB246BE421B3FB0FBB59301D8C80860@dbde02.ent.ti.com> <87fxc56lfz.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:52638 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757249AbZHGIXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Aug 2009 04:23:34 -0400
Content-Disposition: inline
In-Reply-To: <87fxc56lfz.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Kevin Hilman <khilman@deeprootsystems.com> [090806 17:56]:
> "Premi, Sanjeev" <premi@ti.com> writes:
> 
> >> -----Original Message-----
> >> From: Tony Lindgren [mailto:tony@atomide.com] 
> >> Sent: Thursday, August 06, 2009 5:20 PM
> >> To: Premi, Sanjeev
> >> Cc: linux-omap@vger.kernel.org
> >> Subject: Re: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
> >> 
> >> * Premi, Sanjeev <premi@ti.com> [090806 14:34]:
> >> >  
> >> > > -----Original Message-----
> >> > > From: Tony Lindgren [mailto:tony@atomide.com] 
> >> > > Sent: Thursday, August 06, 2009 4:34 PM
> >> > > To: Premi, Sanjeev
> >> > > Cc: linux-omap@vger.kernel.org
> >> > > Subject: Re: [PATCH 3/6] OMAP3: Add runtime check for OMAP35x
> >> > > 
> >> > > Hi,
> >> > > 
> >> > > * Sanjeev Premi <premi@ti.com> [090806 13:36]:
> >> > > > Added runtime check via omap2_set_globals_35xx().
> >> > > > 
> >> > > > Parts of this patch have been derived from an earlier
> >> > > > earlier patch submitted by Tony Lindgren <tony@atomide.com>
> >> > > > 
> >> > > >  [1] http://marc.info/?l=linux-omap&m=123301852702797&w=2
> >> > > >  [2] http://marc.info/?l=linux-omap&m=123334055822212&w=2
> >> > > > 
> >> > > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> >> > > > ---
> >> > > >  arch/arm/mach-omap2/id.c                 |  115 
> >> > > ++++++++++++++++++++++++------
> >> > > >  arch/arm/plat-omap/common.c              |   18 +++++-
> >> > > >  arch/arm/plat-omap/include/mach/common.h |    1 +
> >> > > >  arch/arm/plat-omap/include/mach/cpu.h    |   64 
> >> ++++++++++++++++-
> >> > > >  4 files changed, 173 insertions(+), 25 deletions(-)
> >> > > > 
> >> > > > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> >> > > > index a98201c..06770aa 100644
> >> > > > --- a/arch/arm/mach-omap2/id.c
> >> > > > +++ b/arch/arm/mach-omap2/id.c
> >> > > > @@ -28,6 +28,14 @@
> >> > > >  static struct omap_chip_id omap_chip;
> >> > > >  static unsigned int omap_revision;
> >> > > >  
> >> > > > +/* The new OMAP35x devices have assymetric names - 
> >> > > OMAP3505 and OMAP3517.
> >> > > > + * It is not possible to define a common macro to 
> >> identify them.
> >> > > > + *
> >> > > > + * A quick way is to separate them across 
> >> 'generations' as below.
> >> > > > + */
> >> > > > +#define OMAP35XX_G1	0x1	/* Applies to 3503, 
> >> > > 3515, 3525 and 3530 */
> >> > > > +#define OMAP35XX_G2	0x2	/* Applies to 3505 and 3517 */
> >> > > > +
> >> > > >  
> >> > > >  unsigned int omap_rev(void)
> >> > > >  {
> >> > > > @@ -155,12 +163,71 @@ void __init omap24xx_check_revision(void)
> >> > > >  	pr_info("\n");
> >> > > >  }
> >> > > >  
> >> > > > +static void __init omap34xx_set_revision(u8 rev, char 
> >> *rev_name)
> >> > > > +{
> >> > > > +	switch (rev) {
> >> > > > +	case 0:
> >> > > > +		omap_revision = OMAP3430_REV_ES2_0;
> >> > > > +		strcat(rev_name, "ES2.0");
> >> > > > +		break;
> >> > > > +	case 2:
> >> > > > +		omap_revision = OMAP3430_REV_ES2_1;
> >> > > > +		strcat(rev_name, "ES2.1");
> >> > > > +		break;
> >> > > > +	case 3:
> >> > > > +		omap_revision = OMAP3430_REV_ES3_0;
> >> > > > +		strcat(rev_name, "ES3.0");
> >> > > > +		break;
> >> > > > +	case 4:
> >> > > > +		omap_revision = OMAP3430_REV_ES3_1;
> >> > > > +		strcat(rev_name, "ES3.1");
> >> > > > +		break;
> >> > > > +	default:
> >> > > > +		/* Use the latest known revision as default */
> >> > > > +		omap_revision = OMAP3430_REV_ES3_1;
> >> > > > +		strcat(rev_name, "Unknown revision");
> >> > > > +	}
> >> > > > +}
> >> > > > +
> >> > > > +static void __init omap35xx_set_revision(u8 rev, u8 gen, 
> >> > > char *rev_name)
> >> > > > +{
> >> > > > +	omap_revision = OMAP35XX_CLASS ;
> >> > > > +
> >> > > > +	if (gen == OMAP35XX_G1) {
> >> > > > +		switch (rev) {
> >> > > > +		case 0:	/* Take care of some older boards */
> >> > > > +		case 1:
> >> > > > +			omap_revision |= OMAP35XX_MASK_ES2_0;
> >> > > > +			strcat(rev_name, "ES2.0");
> >> > > > +			break;
> >> > > > +		case 2:
> >> > > > +			omap_revision |= OMAP35XX_MASK_ES2_1;
> >> > > > +			strcat(rev_name, "ES2.1");
> >> > > > +			break;
> >> > > > +		case 3:
> >> > > > +			omap_revision |= OMAP35XX_MASK_ES3_0;
> >> > > > +			strcat(rev_name, "ES3.0");
> >> > > > +			break;
> >> > > > +		case 4:
> >> > > > +			omap_revision |= OMAP35XX_MASK_ES3_1;
> >> > > > +			strcat(rev_name, "ES3.1");
> >> > > > +			break;
> >> > > > +		default:
> >> > > > +			/* Use the latest known 
> >> revision as default */
> >> > > > +			omap_revision |= OMAP35XX_MASK_ES3_0;
> >> > > > +			strcat(rev_name, "Unknown revision");
> >> > > > +		}
> >> > > > +	} else {
> >> > > > +		strcat(rev_name, "ES1.0");
> >> > > > +	}
> >> > > > +}
> >> > > > +
> >> > > 
> >> > > To me it looks like you're checking the exact same cores as 
> >> > > we already do
> >> > > for 34xx. That is, (idcode >> 28) & 0xff for both 34xx and 
> >> > > 35xx. So basically
> >> > > they have the same omap cores.
> >> > 
> >> > No, the cores in OMAP3505 and OMAP3517 are very different.
> >> > I have listed major differences in PATCH 2/6.
> >> > 
> >> > These devices differ in following areas:
> >> >  - Power management capabilities
> >> >    (Only 1 power domain, 1 OPP, etc.)
> >> >  - EMIF4 instead of SDRC
> >> >  - Support for DDR2
> >> >  - EMAC
> >> >  - USB
> >> >  - HECC
> >> 
> >> Sure, but from compiler flags and io point of view they can still
> >> be treated as 34xx.
> >> 
> >> How about just add the individual type detection for 35xx processors,
> >> and then have something like this:
> >> 
> >> #define cpu_is_omap35xx()	(cpu_is_omap34xx() && 
> >> (cpu_is_omap3510() || \
> >> 					cpu_is_omap3520() || 
> >> cpu_is_omap3530())
> >> 
> >> That should pretty much shrink this patch series down to 
> >> about 50 lines or
> >> so of code.
> >
> > Okay, I will try this. Just not sure if some of the differences
> > in OMAP3530 and OMAP3430 can be detected.
> >
> > Will submit a patch soon.
> 
> 
> IMO, we should not be using cpu_is_* for detecting the differences
> between 34xx and 35xx, but rather we could query the features like
> you're doing in PATCH 4/6.
> 
> Adding conditionals like
> 
>   if (omap3_has_iva2())
>      ...
> 
> and
> 
>   if (omap3_has_sgx()) 
>      ...
> 
> rather than having a long list of cpu_is checks that have to be changed
> each time a new SoC comes out.

Agreed.

Tony
