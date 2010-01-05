From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] AM35xx: Add clock support for new modules on AM35xx
Date: Tue, 5 Jan 2010 14:21:34 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001051134240.2083@utopia.booyaka.com>
References: <1260971823-8532-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com> <4B2B5A0F.9050304@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51196 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755289Ab0AEVVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 16:21:35 -0500
In-Reply-To: <4B2B5A0F.9050304@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Ranjith,

(please keep attribution lines in message replies, otherwise it becomes 
very difficult to keep track of who said what)

On Fri, 18 Dec 2009, Ranjith Lohithakshan wrote:

> On Fri, 18-Dec-09 7:12 AM +0530, Paul Walmsley wrote:
> 
>> +/* Clocks for AM35XX */
>> +static struct clk emac_ick = {
>> +    .name       = "emac_ick",
>> +    .ops        = &clkops_omap2_dflt,
>
> > Shouldn't this clock use &clkops_omap2_dflt_wait (or rather, some custom
> > version that knows how to read the _ACK bits in IPSS_CLK_CTRL) and test
> > CPGMAC_VBUSP_CLK_EN_ACK?  Same for the other IPSS VBUSP clocks?   (I
> guess
> > "VBUSP" is a synonym for "interface"?)
> 
> I will ad a custom clkops to address this. Do we need a find_companion
> to be defined?  The VBUSP clock ACK's do not depend on functional clocks
> and the functional clocks themselves don't have ant ACK or status bits.
> EMAC, VPFE amd MUSBOTG are initiators, but the their ACK bits are just
> for the target idle status.

I see four ACK bits marked as "clock status bits" in the TRM.  Are these 
interface clock status bits for initiator interfaces, or are they module 
target IdleAck bits?  If they are the former, then they are useless and 
there is no point waiting for these clocks.  If they are the latter, then 
yes, you'll need a find_companion, because the clock code must ensure that 
both the interface clock and main functional clock are both enabled before 
checking the module's target idle status, and the AM35xx IPSS does this in 
a completely different way than the OMAP35xx.  I guess the IPSS was just 
'bolted on' to the chip, rather than really integrated into the OMAP2 PRCM 
design.

> One of the issues on AM35xx is regarding the status indicator for new
> clocks. Here 1 indicates as enabled and 0 as not ready state, similar to
> 24xx case but just opposite to 34xx clocks. And now we have a mix of
> these two on AM35xx. 

Wow, that's really craptacular.

> In omap2_cm_wait_idlest, I do not get a per clock granularity to
> decide what should be the status check for that particular
> clock. One of the approach I am thinking is to define a new clock
> flag (say INVERT_ENABLE_STATUS) and set it for the new AM35xx
> clocks. And in omap2_module_wait_ready I will do the cpu check and
> flag check on a per clock basis and determine the status that need
> to be checked and pass it to omap2_module_wait_ready to check what
> we want. omap2_module_wait_ready will not be doing any cpu checks as
> its done today. Let me know what you think.

(I guess you mean  omap2_cm_wait_module_ready() in the last two sentences?)

How about extending find_idlest to pass back whether to test against 0 or 
1?  The cpu code will then move into the find_idlest code, and you can 
just create a few new find_idlest functions for the AM35xx clocks.  Let's 
try to avoid creating new clock flags for this, I'm trying to move all of 
this module IDLEST testing code out of the clock code and into the hwmod 
code where it belongs.

> >> +static struct clk emac_fck = {
> >> +	.name       = "emac_fck",
> >> +	.ops        = &clkops_omap2_dflt,
> >> +	.clkdm_name = "core_l3_clkdm",
> >
> > Is this the correct clockdomain for this clock?  It seems unlikely that a
> > 50MHz functional clock would be in core_l3_clkdm.  Usually these are all
> > interface clocks.  This applies for all the other functional clocks
> listed
> > in this file also.
> 
> Would it be OK if we just don't set clkdm_name. I am not sure whether we
> can map it to any existing OMAP3 clock domains that way

I'd like to see all new clocks added with a clockdomain, even if it is not 
a software-controllable clockdomain.  That makes it possible for others to 
understand what is really going on from a power management point of view.  
What is the clockdomain structure for these new clocks?

> >> +	.rate       = 50000000,
> >
> > What's the parent of this clock?  Looking at TRM section 4.7.7.12 it
> > appears that it gets this from an off-chip source, "rmii_clk"?  Guess
> that
> > should probably be defined as the fixed source clock, and emac_fck should
> > list rmii_clk as its parent?
> >
> >> +	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
> >> +	.enable_bit = AM35XX_CPGMAC_FCLK_SHIFT,
> >> +	.recalc     = &omap2_clksel_recalc,
> >
> > This .recalc field is wrong, since there's no .clksel field defined.  If
> > you define that parent, then this should be followparent_recalc.  The
> > parent should have .flags = RATE_FIXED and no .recalc.
> 
> Do we really need to define an rmii_ck? Can we make emac_fck itself as
> the root clock with no parent? Here is what I was thinking of. Let me
> know if you see any issues with this

Yes, please define the parent clocks appropriately.  They will probably be 
in different clockdomains from the downstream clocks.  Where does rmii_clk 
come from?  Is this an off-chip clock?  Is this coming from one of the 
on-chip DPLLs?  

> static struct clk emac_fck = {
>     .name       = "emac_fck",
>     .ops        = &clkops_omap2_dflt,
>     .flags      = RATE_FIXED,
>     .rate       = 50000000,
>     .enable_reg = OMAP343X_CTRL_REGADDR(OMAP3517_CONTROL_IP_CLK_CTRL),
>     .enable_bit = OMAP3517_CPGMAC_FCLK_SHIFT,
> };
> 
> >> +static struct clk vpfe_fck = {
> >> +	.name       = "vpfe_fck",
> >> +	.ops        = &clkops_omap2_dflt,
> >> +	.clkdm_name = "core_l3_clkdm",
> >> +	.rate       = 27000000,
> >> +	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
> >> +	.enable_bit = AM35XX_VPFE_FCLK_SHIFT,
> >> +	.recalc     = &omap2_clksel_recalc,
> >
> > This fixed rate clock isn't right, for the same reasons as described
> > above.
> 
> Would make it similar to emac_fck depending on what we decide.

- Paul
