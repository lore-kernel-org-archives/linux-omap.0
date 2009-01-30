From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH A 01/10] OMAP2/3: Add non-CORE DPLL rate set code and M,
 N programming
Date: Thu, 29 Jan 2009 22:57:24 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901292255530.26985@utopia.booyaka.com>
References: <20090128020447.7244.80496.stgit@localhost.localdomain> <20090128021243.7244.6362.stgit@localhost.localdomain> <20090129142303.GA18233@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40055 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbZA3F50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 00:57:26 -0500
In-Reply-To: <20090129142303.GA18233@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Thu, 29 Jan 2009, Russell King - ARM Linux wrote:

> On Tue, Jan 27, 2009 at 07:12:47PM -0700, Paul Walmsley wrote:
> > +/* Non-CORE DPLL rate set code */
> > +
> > +/*
> > + * omap3_noncore_dpll_program - set non-core DPLL M,N values directly
> > + * @clk: struct clk * of DPLL to set
> > + * @m: DPLL multiplier to set
> > + * @n: DPLL divider to set
> > + * @freqsel: FREQSEL value to set
> > + *
> > + * Program the DPLL with the supplied M, N values, and wait for the DPLL to
> > + * lock..  Returns -EINVAL upon error, or 0 upon success.
> > + */
> > +static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
> > +{
> > +	struct dpll_data *dd;
> > +	u32 v;
> > +
> > +	if (!clk)
> > +		return -EINVAL;
> > +
> > +	dd = clk->dpll_data;
> > +	if (!dd)
> > +		return -EINVAL;
> 
> Final point... this is only called from the function below, which also
> checks that clk and clk->dpll_data are both non-NULL.  So these checks
> are unnecessary.

Okay.  Do you want to take care of that in your merged version of this 
patch, or would you like me to send an updated version, along with that 
custom dpll4 set_rate function?


- Paul
