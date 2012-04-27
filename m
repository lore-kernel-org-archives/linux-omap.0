From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH] arm: omap3: am35x: Don't mark missing features as
 present
Date: Fri, 27 Apr 2012 14:30:02 -0700
Message-ID: <20120427213002.GC19196@animalcreek.com>
References: <1334861927-1741-1-git-send-email-mgreer@animalcreek.com>
 <871un827m0.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:52573 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626Ab2D0VaE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 17:30:04 -0400
Content-Disposition: inline
In-Reply-To: <871un827m0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Fri, Apr 27, 2012 at 02:21:59PM -0700, Kevin Hilman wrote:
> "Mark A. Greer" <mgreer@animalcreek.com> writes:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> >
> > The Chip Identification register on the am35x family of SoCs
> > has bits 12, 7:5, and 3:2 marked as reserved and are read as
> > zeroes.  Unfortunately, on other omap SoCs, a 0 bit means a
> > feature is "Full Use" so the OMAP3_CHECK_FEATURE() macro
> > called by omap3_check_features() will incorrectly interpret
> > those zeroes to mean that a feature is present even though it
> > isn't.  To fix that, the feature bits that are incorrectly
> > set (namely, OMAP3_HAS_IVA and OMAP3_HAS_ISP) need to be
> > cleared after all of the calls to OMAP3_CHECK_FEATURE() in
> > omap3_check_features() are made.
> >
> > Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
> > ---
> >  arch/arm/mach-omap2/id.c |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> > index 0e79b7b..9736049 100644
> > --- a/arch/arm/mach-omap2/id.c
> > +++ b/arch/arm/mach-omap2/id.c
> > @@ -248,6 +248,17 @@ void __init omap3xxx_check_features(void)
> >  	omap_features |= OMAP3_HAS_SDRC;
> >  
> >  	/*
> > +	 * am35x fixups:
> > +	 * - The am35x Chip ID register has bits 12, 7:5, and 3:2 marked as
> > +	 *   reserved and therefore return 0 when read.  Unfortunately,
> > +	 *   OMAP3_CHECK_FEATURE() will interpret some of those zeroes to
> > +	 *   mean that a feature is present even though it isn't so clear
> > +	 *   the incorrectly set feature bits.
> > +	 */
> > +	if (cpu_is_omap3505() || cpu_is_omap3517())
> > +		omap_features &= ~(OMAP3_HAS_IVA | OMAP3_HAS_ISP);
> 
> I just sent a series that removes these cpu_is macros:
> 
>    http://marc.info/?l=linux-omap&m=133548306205953&w=2
> 
> It looks like I can just replace the above with 'if (cpu_is_am35xx()', correct?

Yes.

> Since you have various AM35x devices, could you could give my series a
> spin and make this change?  If it works, and acked-by/tested-by on my
> series would be appreciated as well.

Sure.  I already have them ported to your series.  I have to leave early
today but I'll test them & get them to you on Monday.  Sorry for the delay.

Mark
