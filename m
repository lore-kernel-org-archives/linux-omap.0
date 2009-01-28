From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH A 01/10] OMAP2/3: Add non-CORE DPLL rate set code and M, N programming
Date: Wed, 28 Jan 2009 22:26:12 +0000
Message-ID: <20090128222612.GK23301@n2100.arm.linux.org.uk>
References: <20090128020447.7244.80496.stgit@localhost.localdomain> <20090128021243.7244.6362.stgit@localhost.localdomain> <20090128221056.GJ23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44192 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753742AbZA1W02 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 17:26:28 -0500
Content-Disposition: inline
In-Reply-To: <20090128221056.GJ23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 10:10:56PM +0000, Russell King - ARM Linux wrote:
> Since it's been posted to lists, comments are going to be made...
> 
> On Tue, Jan 27, 2009 at 07:12:47PM -0700, Paul Walmsley wrote:
> > +	/*
> > +	 * According to the 12-5 CDP code from TI, "Limitation 2.5"
> > +	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
> > +	 * on DPLL4.
> > +	 */
> > +	if (omap_rev() == OMAP3430_REV_ES1_0 &&
> > +	    !strcmp("dpll4_ck", clk->name)) {
> > +		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
> > +		       "silicon 'Limitation 2.5' on 3430ES1.\n");
> > +		return -EINVAL;
> > +	}
> 
> Yuck.  That's revolting and extremely fragile.  Don't play these games.
> You've got plenty of free flag bits in clk->flags which could be used
> to prevent the DPLL from being changed.  You've also got other ways to
> prevent it - eg, setting dpll_data to NULL.
> 
> To do exception handling based on strcmp(), or even worse register offset
> and bit position (as is done elsewhere in the OMAP code) is utterly insane.

To further expand on this point, this patch also has:

@@ -588,6 +595,7 @@ static struct clk dpll4_ck = {
        .enable         = &omap3_noncore_dpll_enable,
        .disable        = &omap3_noncore_dpll_disable,
        .round_rate     = &omap2_dpll_round_rate,
+       .set_rate       = &omap3_noncore_dpll_set_rate,
        .recalc         = &omap3_dpll_recalc,
 };


We can handle this exception by replacing that set_rate function with
one which knows about this explicit quirk for this clock.  In other
words, rather than having that strcmp(), the following would be a much
better way to handle this exception:

static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
{
	if (omap_rev() == OMAP3430_REV_ES1_0) {
		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
		       "silicon 'Limitation 2.5' on 3430ES1.\n");
		return -EINVAL;
	}
	return omap3_noncore_dpll_set_rate(clk, rate);
}
