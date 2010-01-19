From: "Kauppi Ari (EXT-Ixonos/Oulu)" <ext-ari.kauppi@nokia.com>
Subject: Re: [PATCHV2 2/2] OMAP3630: Clock: Fixing HSDivider Limitation
Date: Tue, 19 Jan 2010 07:55:57 +0200
Message-ID: <1263880557.2532.204.camel@kauppi-desktop>
References: <E0D41E29EB0DAC4E9F3FF173962E9E94026B2DBC17@dbde02.ent.ti.com>
	 <alpine.DEB.2.00.1001181042530.3977@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:38519 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752075Ab0ASF4c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jan 2010 00:56:32 -0500
In-Reply-To: <alpine.DEB.2.00.1001181042530.3977@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Paul Walmsley <paul@pwsan.com>
Cc: "G.N, Vijayakumar" <vijaykumar.gn@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Turquette, Mike" <mturquette@ti.com>

On Mon, 2010-01-18 at 19:04 +0100, ext Paul Walmsley wrote:
> Vijayakumar, Mike,
> > Without this workaround the divider value goes
> > to its reset state after the corresponding PWRDN bit is set from the
> > CM_CLKEN_PLL register. The correct divider value can be restored by
> > writing a dummy value to the register different than what is in there, and
> > then re-writing the desired value.
> > This Work around is applicable for below HS Dividers.
> >  1. DPLL3_M3
> >  2. DPLL4_M2
> >  3. DPLL4_M3
> >  4. DPLL4_M4
> >  5. DPLL4_M5
> >  6. DPLL4_M6
> > 
> > Signed-off-by: Mike Turquette <mturquette@ti.com>
> > Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> > Signed-off-by: Vijaykumar GN <vijaykumar.gn@ti.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.c      |   36 ++++++++++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/clock34xx.h      |    1 +
> >  arch/arm/mach-omap2/clock34xx_data.c |   15 ++++++++++++++
> >  3 files changed, 52 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> > index 0d30e53..e5213f8 100644
> > --- a/arch/arm/mach-omap2/clock34xx.c
> > +++ b/arch/arm/mach-omap2/clock34xx.c
> > @@ -146,6 +146,42 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait = {
> >  	.find_companion = omap2_clk_dflt_find_companion,
> >  };
> >  
> > +/** omap3_pwrdn_clk_enable_with_hsdiv_restore - enable clocks suffering
> > + *         from HSDivider problem.
> 
> The '/**' needs to be on its own line.  I appreciate the useful comments, 
> but please make sure they conform to 
> Documentation/kernel-doc-nano-HOWTO.txt
> 
> > + * @clk: DPLL output struct clk
> > + *
> > + * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck, dpll4_m5_ck
> > + * & dpll4_m6_ck dividers get lost after their respective PWRDN bits are set.
> > + * Any write to the corresponding CM_CLKSEL register will refresh the
> > + * dividers.  Only x2 clocks are affected, so it is safe to trust the parent
> > + * clock information to refresh the CM_CLKSEL registers.
> > + */
> > +int omap3_pwrdn_clk_enable_with_hsdiv_restore(struct clk *clk)
> > +{
> > +	u32 v;
> > +	int ret;
> > +
> > +	/* enable the clock */
> > +	ret = omap2_dflt_clk_enable(clk);
> > +
> > +	/* Restore the dividers */
> > +	if (!ret) {
> > +		v = __raw_readl(clk->parent->clksel_reg);
> > +		v += (1 << clk->parent->clksel_shift);
> 
> Using += here could affect many bits in the register if the add carries.  
> This doesn't seem like what you want.
> 
> Also, isn't there a risk of side-effects here, that if this bit was not 
> already set, that everything further down the clock tree from this could 
> be affected?  Wouldn't it be best to just rewrite the correct clksel 
> value?

The assumption is that the divider is correct in the register so I guess
the clock tree should be fine? The proper clksel/divider has been
earlier set but for some reason HW loses the divider if PWRDN is
toggled.

Our experiments with this issue show that just read/write of same value
is not enough to refresh the HW. The clksel has to be written with a
different divider first and then write the original divider back.

--
Ari

