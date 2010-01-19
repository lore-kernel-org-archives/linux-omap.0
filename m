From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHV2 2/2] OMAP3630: Clock: Fixing HSDivider Limitation
Date: Tue, 19 Jan 2010 11:08:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001191031420.3977@utopia.booyaka.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC17@dbde02.ent.ti.com>  <alpine.DEB.2.00.1001181042530.3977@utopia.booyaka.com> <1263880557.2532.204.camel@kauppi-desktop> <4B55EB18.1090003@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48560 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab0ASSJB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 13:09:01 -0500
In-Reply-To: <4B55EB18.1090003@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>, "G.N, Vijayakumar" <vijaykumar.gn@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>

Hi,

On Tue, 19 Jan 2010, Mike Turquette wrote:

> Kauppi Ari (EXT-Ixonos/Oulu) wrote:
> > On Mon, 2010-01-18 at 19:04 +0100, ext Paul Walmsley wrote:

(some missing attribution here)

> > > > +int omap3_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
> > > > +{
> > > > +	u32 v;
> > > > +	int ret;
> > > > +
> > > > +	/* enable the clock */
> > > > +	ret = omap2_dflt_clk_enable(clk);
> > > > +
> > > > +	/* Restore the dividers */
> > > > +	if (!ret) {
> > > > +		v = __raw_readl(clk->parent->clksel_reg);
> > > > +		v += (1 << clk->parent->clksel_shift);
> > > Using += here could affect many bits in the register if the add carries.
> > > This doesn't seem like what you want.
> > > 
> > > Also, isn't there a risk of side-effects here, that if this bit was not
> > > already set, that everything further down the clock tree from this could
> > > be affected?  Wouldn't it be best to just rewrite the correct clksel
> > > value?
> > 
> > The assumption is that the divider is correct in the register so I guess
> > the clock tree should be fine? The proper clksel/divider has been
> > earlier set but for some reason HW loses the divider if PWRDN is
> > toggled.
> 
> In my testing that assumption was always correct.  In fact that is what made
> this bug very difficult to track down: the register values were always the
> correct value programmed initially but the actual clocks were wrong.
> 
> > Our experiments with this issue show that just read/write of same value
> > is not enough to refresh the HW. The clksel has to be written with a
> > different divider first and then write the original divider back.
> 
> ACK to the above comment.  Registers need to be changed to a different value
> and back.

Please put that into the comments on the function.  Right now it says "Any 
write to the corresponding CM_CLKSEL register will refresh the dividers."

Also, in that case the v += / v -= seems more appropriate.  The concern 
then is, what happens if the divider is already at its maximum value?  
Won't it wrap around, which could potentially result in excessively high 
clocks further down the tree?  In this case it might be best to step down 
to the next lowest divider, rather than wrapping.  Maybe something like 
this?  (untested)

    u32 orig_v, v, c, clksel_shift, max_div;

    [...]

    v = __raw_readl(clk->parent->clksel_reg);
    orig_v = v;

    clksel_shift = __ffs(clk->parent->clksel_mask);

    max_div = clk->parent->clksel_mask >> clksel_shift;

    /* Isolate the current divider */
    c = v & clk->parent->clksel_mask;
    c >>= clksel_shift;

    /* Prevent excessively high clock rates if divider would wrap */
    c += (c == max_div) ? -1 : 1;

    /* Write the temporarily altered divider back */
    c <<= clksel_shift;
    v &= ~c;
    v |= c;
    __raw_writel(v, clk->parent->clksel_reg);

    /* Write the original divider */
    __raw_writel(orig_v, clk->parent->clksel_reg);
    

- Paul
