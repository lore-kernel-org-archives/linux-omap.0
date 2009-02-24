From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 11/14] OMAP clock: track child clocks
Date: Tue, 24 Feb 2009 09:43:08 +0000
Message-ID: <20090224094308.GA16262@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192756.29333.41541.stgit@localhost.localdomain> <20090129151401.GC18233@n2100.arm.linux.org.uk> <20090129220608.GJ18233@n2100.arm.linux.org.uk> <20090209141156.GB16626@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0902122345160.14667@utopia.booyaka.com> <20090214112325.GA17965@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0902221635530.16648@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34533 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754252AbZBXJnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2009 04:43:25 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0902221635530.16648@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, r-woodruff2@ti.com, Tony Lindgren <tony@atomide.com>

On Sun, Feb 22, 2009 at 04:37:31PM -0700, Paul Walmsley wrote:
> Hello Russell,
> 
> On Sat, 14 Feb 2009, Russell King - ARM Linux wrote:
> > However, looking a little deeper, there's more issues in the reparenting
> > area.  I don't think this code has been tested at all...  In
> > _omap2_clksel_get_src_field, there is this:
> > 
> > 	for (clkr = clks->rates; clkr->div; clkr++) {
> > 		if (clkr->flags & (cpu_mask | DEFAULT_RATE))
> > 			break; /* Found the default rate for this platform */
> > 	}
> > 
> > which is bogus - it will find the first entry which is _either_ marked
> > as a default rate _or_ is supported by the SoC.  This means (for
> > instance) that:
> > 
> > static const struct clksel_rate core_l3_core_rates[] = {
> >         { .div = 1, .val = 1, .flags = RATE_IN_24XX },
> >         { .div = 2, .val = 2, .flags = RATE_IN_242X },
> >         { .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
> > 
> > will give us divisor 1 rather than presumably the one we want, that being
> > divisor 4.  I think the test above should be:
> > 
> > 	for (clkr = clks->rates; clkr->div; clkr++) {
> > 		if (clkr->flags & cpu_mask &&
> > 		    clkr->flags & DEFAULT_RATE)
> > 			break; /* Found the default rate for this platform */
> > 	}
> > 
> > so we find an entry which is supported _and_ is the default for the SoC.
> 
> Agreed.
> 
> > There's also a second issue - the comments before omap2_divisor_to_clksel()
> > indicate that this function returns 0xffffffff on error.  Unfortunately,
> > this is not so, it actually returns zero on error.  Moreover, we test
> > the result of the function against ~0, so we'll never deal with the error
> > case.  This really should be fixed so that we return the right value for
> > the error case.  (Further comments on this in a follow up.)
> 
> Agreed here also.
> 
> > So, below is a patch which fixes both of these issues.
> 
> Looks good, thanks Russell.
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

You're too late; it went to Linus last Thursday and is in -rc6.
