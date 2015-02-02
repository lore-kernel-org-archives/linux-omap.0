From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v13 3/6] clk: Make clk API return per-user struct clk
 instances
Date: Mon, 02 Feb 2015 09:32:28 -0800
Message-ID: <20150202173228.421.87108@quantum>
References: <1422011024-32283-1-git-send-email-tomeu.vizoso@collabora.com>
 <1422011024-32283-4-git-send-email-tomeu.vizoso@collabora.com>
 <20150201212432.22722.70917@quantum> <20150202170458.GB9418@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150202170458.GB9418@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-kernel@vger.kernel.org, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2015-02-02 09:04:59)
> * Mike Turquette <mturquette@linaro.org> [150201 13:27]:
> > Quoting Tomeu Vizoso (2015-01-23 03:03:30)
> > > Moves clock state to struct clk_core, but takes care to change as little API as
> > > possible.
> > > 
> > > struct clk_hw still has a pointer to a struct clk, which is the
> > > implementation's per-user clk instance, for backwards compatibility.
> > > 
> > > The struct clk that clk_get_parent() returns isn't owned by the caller, but by
> > > the clock implementation, so the former shouldn't call clk_put() on it.
> > > 
> > > Because some boards in mach-omap2 still register clocks statically, their clock
> > > registration had to be updated to take into account that the clock information
> > > is stored in struct clk_core now.
> > 
> > Tero, Paul & Tony,
> > 
> > Tomeu's patch unveils a problem with omap3_noncore_dpll_enable and
> > struct dpll_data, namely this snippet from
> > arch/arm/mach-omap2/dpll3xxx.c:
> > 
> >         parent = __clk_get_parent(hw->clk);
> > 
> >         if (__clk_get_rate(hw->clk) == __clk_get_rate(dd->clk_bypass)) {
> >                 WARN(parent != dd->clk_bypass,
> >                                 "here0, parent name is %s, bypass name is %s\n",
> >                                 __clk_get_name(parent), __clk_get_name(dd->clk_bypass));
> >                 r = _omap3_noncore_dpll_bypass(clk);
> >         } else {
> >                 WARN(parent != dd->clk_ref,
> >                                 "here1, parent name is %s, ref name is %s\n",
> >                                 __clk_get_name(parent), __clk_get_name(dd->clk_ref));
> >                 r = _omap3_noncore_dpll_lock(clk);
> >         }
> > 
> > struct dpll_data has members clk_ref and clk_bypass which are struct clk
> > pointers. This was always a bit of a violation of the clk.h contract
> > since drivers are not supposed to deref struct clk pointers. Now that we
> > generate unique pointers for each call to clk_get (clk_ref & clk_bypass
> > are populated by of_clk_get in ti_clk_register_dpll) then the pointer
> > comparisons above will never be equal (even if they resolve down to the
> > same struct clk_core). I added the verbose traces to the WARNs above to
> > illustrate the point: the names are always the same but the pointers
> > differ.
> > 
> > AFAICT this doesn't break anything, but booting on OMAP3+ results in
> > noisy WARNs.
> 
> Also on at least omap4 like I posted.

Right, hence the + after OMAP3 ;-)

> So sounds like the check for
> WARN is wrong but harmless. Paul & Tero, what do you want to do
> about that?

I would be fine to simply silence the WARNs since we're so closed to the
merge window and then revisit it with a proper fix. Of course the ideal
solution would be to convert the pointer comparison scheme to one using
parent_index.

Regards,
Mike

>  
> > I think the correct fix is to replace clk_bypass and clk_ref pointers
> > with a simple integer parent_index. In fact we already have this index.
> > See how the pointers are populated in ti_clk_register_dpll:
> > 
> > 
> >         dd->clk_ref = of_clk_get(node, 0);
> >         dd->clk_bypass = of_clk_get(node, 1);
> > 
> > Tony, the same problem affects the FAPLL code which copy/pastes some of
> > the DPLL code.
> > 
> > Thoughts?
> 
> Not seeing these warnings with dm186x as fapll.c does not use
> dpll3xxx.c. This is because of the way the PLL's child synthesizers
> need to also access the PLL registers for power and bypass mode.
> 
> Not related to the $subject bug, but to me it seems that we could
> possibly have Linux generic PLL code if we add support for
> parent_in_bypass_mode in addition to the parent_rate. This is because
> the PLL can in theory generate the same rate both in bypass mode and
> regular mode so parent_rate is not enough to tell it to the child
> synthesizers. Not sure how the PLL registers enabling and disabling
> it's children should be handled, maybe regmap would work there.
> 
> Regards,
> 
> Tony
