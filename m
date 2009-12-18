From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: Re: [PATCH] AM35xx: Add clock support for new modules on AM35xx
Date: Fri, 18 Dec 2009 16:01:43 +0530
Message-ID: <4B2B5A0F.9050304@ti.com>
References: <1260971823-8532-1-git-send-email-ranjithl@ti.com> <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45138 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbZLRKbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Dec 2009 05:31:48 -0500
In-Reply-To: <alpine.DEB.2.00.0912171818150.12561@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Paul,

Thanks for the review comments. My replies below.

On Fri, 18-Dec-09 7:12 AM +0530, Paul Walmsley wrote:

>> +/* Clocks for AM35XX */
>> +static struct clk emac_ick = {
>> +	.name       = "emac_ick",
>> +	.ops        = &clkops_omap2_dflt,
>
> Shouldn't this clock use &clkops_omap2_dflt_wait (or rather, some custom
> version that knows how to read the _ACK bits in IPSS_CLK_CTRL) and test
> CPGMAC_VBUSP_CLK_EN_ACK?  Same for the other IPSS VBUSP clocks?   (I
guess
> "VBUSP" is a synonym for "interface"?)

I will ad a custom clkops to address this. Do we need a find_companion
to be defined? The VBUSP clock ACK's do not depend on functional clocks
and the functional clocks themselves don't have ant ACK or status bits.
EMAC, VPFE amd MUSBOTG are initiators, but the their ACK bits are just
for the target idle status.

One of the issues on AM35xx is regarding the status indicator for new
clocks. Here 1 indicates as enabled and 0 as not ready state, similar to
24xx case but just opposite to 34xx clocks. And now we have a mix of
these two on AM35xx. In omap2_cm_wait_idlest, I do not get a per clock
granularity to decide what should be the status check for that
particular clock. One of the approach I am thinking is to define a new
clock flag (say INVERT_ENABLE_STATUS) and set it for the new AM35xx
clocks. And in omap2_module_wait_ready I will do the cpu check and flag
check on a per clock basis and determine the status that need to be
checked and pass it to        omap2_module_wait_ready to check what we
want. omap2_module_wait_ready will not be doing any cpu checks as its
done today. Let me know what you think.

>> +static struct clk emac_fck = {
>> +	.name       = "emac_fck",
>> +	.ops        = &clkops_omap2_dflt,
>> +	.clkdm_name = "core_l3_clkdm",
>
> Is this the correct clockdomain for this clock?  It seems unlikely that a
> 50MHz functional clock would be in core_l3_clkdm.  Usually these are all
> interface clocks.  This applies for all the other functional clocks
listed
> in this file also.

Would it be OK if we just don't set clkdm_name. I am not sure whether we
can map it to any existing OMAP3 clock domains that way

>
>> +	.rate       = 50000000,
>
> What's the parent of this clock?  Looking at TRM section 4.7.7.12 it
> appears that it gets this from an off-chip source, "rmii_clk"?  Guess
that
> should probably be defined as the fixed source clock, and emac_fck should
> list rmii_clk as its parent?
>
>> +	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
>> +	.enable_bit = AM35XX_CPGMAC_FCLK_SHIFT,
>> +	.recalc     = &omap2_clksel_recalc,
>
> This .recalc field is wrong, since there's no .clksel field defined.  If
> you define that parent, then this should be followparent_recalc.  The
> parent should have .flags = RATE_FIXED and no .recalc.

Do we really need to define an rmii_ck? Can we make emac_fck itself as
the root clock with no parent? Here is what I was thinking of. Let me
know if you see any issues with this
static struct clk emac_fck = {
    .name       = "emac_fck",
    .ops        = &clkops_omap2_dflt,
    .flags      = RATE_FIXED,
    .rate       = 50000000,
    .enable_reg = OMAP343X_CTRL_REGADDR(OMAP3517_CONTROL_IP_CLK_CTRL),
    .enable_bit = OMAP3517_CPGMAC_FCLK_SHIFT,
};

>> +static struct clk vpfe_fck = {
>> +	.name       = "vpfe_fck",
>> +	.ops        = &clkops_omap2_dflt,
>> +	.clkdm_name = "core_l3_clkdm",
>> +	.rate       = 27000000,
>> +	.enable_reg = OMAP343X_CTRL_REGADDR(AM35XX_CONTROL_IPSS_CLK_CTRL),
>> +	.enable_bit = AM35XX_VPFE_FCLK_SHIFT,
>> +	.recalc     = &omap2_clksel_recalc,
>
> This fixed rate clock isn't right, for the same reasons as described
> above.

Would make it similar to emac_fck depending on what we decide.

>> +	CLK("musb_hdrc", "ick", &hsotgusb_ick_am35xx, CK_AM35XX),
>> +	CLK("musb_hdrc", "fck", &hsotgusb_fck_am35xx, CK_AM35XX),
>> +	CLK(NULL, "hecc_ck", &hecc_ck, CK_AM35XX),
>> +	CLK("vpfe-capture", "master", &vpfe_ick, CK_AM35XX),
>> +	CLK("vpfe-capture", "slave", &vpfe_fck, CK_AM35XX),
>> +	CLK(NULL, "uart4_ick", &uart4_ick, CK_AM35XX),
>
> Please align the new structure entries with the previous entries.

Will do that.


 - Ranjith
