From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH] ARM: OMAP: dpll: enable bypass clock only when attempting
 dpll bypass
Date: Fri, 29 Mar 2013 10:24:28 -0700
Message-ID: <20130329172428.13785.20600@quantum>
References: <1364468381-10560-1-git-send-email-rnayak@ti.com>
 <20130328163257.5161.10373@quantum> <515525ED.8040605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <515525ED.8040605@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rogerq@ti.com
List-Id: linux-omap@vger.kernel.org

Quoting Rajendra Nayak (2013-03-28 22:26:05)
> On Thursday 28 March 2013 10:02 PM, Mike Turquette wrote:
> > Quoting Rajendra Nayak (2013-03-28 03:59:41)
> >> omap3_noncore_dpll_set_rate() attempts an enable of bypass clk as well
> >> as ref clk for every .set_rate attempt on a noncore DPLL, regardless of
> >> whether the .set_rate results in the DPLL being locked or put in bypass.
> >> Early at boot, while some of these DPLLs are programmed and locked
> >> (using .set_rate for the DPLL), this causes an ordering issue.
> >>
> >> For instance, on OMAP5, the USB DPLL derives its bypass clk from ABE DPLL.
> >> If a .set_rate of USB DPLL which programmes the M,N and locks it is called
> >> before the one for ABE, the enable of USB bypass clk (derived from ABE DPLL)
> >> then attempts to lock the ABE DPLL and fails as the M,N values for ABE
> >> are yet to be programmed.
> >>
> >> To get rid of this ordering needs, enable bypass clk for a DPLL as part
> >> of its .set_rate only when its being put in bypass, and only enable the
> >> ref clk when its locked.
> >>
> > 
> > Hi Rajendra,
> > 
> > Another way to solve this problem would be to model the DPLLs as mux
> > clocks with a list of possible parents (e.g. clk->parents[2]).  Then set
> > the CLK_SET_RATE_PARENT flag on the USB DPLL which will allow to
> 
> But isn't this applicable only to the _current_ parent? The bypass_clk isn't
> the parent of DPLL USB when I try a .set_rate on it. Its the ref_clk.
> 

Oops.  Yeah, I got that one mixed up.

Another interesting idea is for the .prepare of a DPLL to check to see
if M/N values have been populated or not, and if they are not populated
then to put some known-good defaults in there.

But this is just kicking around ideas really and I'm not nacking this
patch based on the above idea.

Regards,
Mike

> > propagate the rate request up to the ABE DPLL.  This should set the MN
> > dividers appropriately.
> > 
> >> Reported-by: Roger Quadros <rogerq@ti.com>
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/dpll3xxx.c |   19 +++++++++----------
> >>  1 file changed, 9 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> >> index 3aed4b0..6e9873f 100644
> >> --- a/arch/arm/mach-omap2/dpll3xxx.c
> >> +++ b/arch/arm/mach-omap2/dpll3xxx.c
> >> @@ -480,20 +480,22 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
> >>         if (!dd)
> >>                 return -EINVAL;
> >>  
> >> -       __clk_prepare(dd->clk_bypass);
> >> -       clk_enable(dd->clk_bypass);
> >> -       __clk_prepare(dd->clk_ref);
> >> -       clk_enable(dd->clk_ref);
> > 
> > Is this safe?  I always thought that the programming sequence in the TRM
> > was to enable both the ref and bypass clocks during DPLL reprogramming.
> > Maybe I am misremembering or assuming that the code strictly followed
> > the TRM.
> 
> hmm, I didn't bother to check either. Will check, it would be strange though
> if such a sequence is indeed needed.
> 
> regards,
> Rajendra
> 
> > 
> > Regards,
> > Mike
> > 
> >> -
> >>         if (__clk_get_rate(dd->clk_bypass) == rate &&
> >>             (dd->modes & (1 << DPLL_LOW_POWER_BYPASS))) {
> >>                 pr_debug("%s: %s: set rate: entering bypass.\n",
> >>                          __func__, __clk_get_name(hw->clk));
> >>  
> >> +               __clk_prepare(dd->clk_bypass);
> >> +               clk_enable(dd->clk_bypass);
> >>                 ret = _omap3_noncore_dpll_bypass(clk);
> >>                 if (!ret)
> >>                         new_parent = dd->clk_bypass;
> >> +               clk_disable(dd->clk_bypass);
> >> +               __clk_unprepare(dd->clk_bypass);
> >>         } else {
> >> +               __clk_prepare(dd->clk_ref);
> >> +               clk_enable(dd->clk_ref);
> >> +
> >>                 if (dd->last_rounded_rate != rate)
> >>                         rate = __clk_round_rate(hw->clk, rate);
> >>  
> >> @@ -514,6 +516,8 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
> >>                 ret = omap3_noncore_dpll_program(clk, freqsel);
> >>                 if (!ret)
> >>                         new_parent = dd->clk_ref;
> >> +               clk_disable(dd->clk_ref);
> >> +               __clk_unprepare(dd->clk_ref);
> >>         }
> >>         /*
> >>         * FIXME - this is all wrong.  common code handles reparenting and
> >> @@ -525,11 +529,6 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
> >>         if (!ret)
> >>                 __clk_reparent(hw->clk, new_parent);
> >>  
> >> -       clk_disable(dd->clk_ref);
> >> -       __clk_unprepare(dd->clk_ref);
> >> -       clk_disable(dd->clk_bypass);
> >> -       __clk_unprepare(dd->clk_bypass);
> >> -
> >>         return 0;
> >>  }
> >>  
> >> -- 
> >> 1.7.9.5
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
