From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: OMAP2PLUS dpll rate calculation.
Date: Thu, 19 Aug 2010 12:46:03 +0200
Message-ID: <4C6D0B6B.6070802@ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB03242222B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54122 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751315Ab0HSKqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Aug 2010 06:46:10 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB03242222B5@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

Hi Thara,

On 8/18/2010 8:46 AM, Gopinath, Thara wrote:
> Hello Paul/Kevin,
>
> Recently I noticed that the dpll rate calculation code in
> arch/arm/mach-omap2/clkt_dpll.c is as follows
> 	dpll_clk = (long long)dd->clk_ref->rate * dpll_mult;
>          do_div(dpll_clk, dpll_div + 1);
>
> But the actual trm for both OMAP3 and OMAP4 (I believe this is
> true for OMAP2 also) shows that the dpll output rate should be
> calculated as
> 			ref_clk * 2 * M / (N + 1).

That's true, technically speaking the DPLL is locked at twice the 
required frequency. This is mandatory in order to generate the X2 output.

Fdpll = ref_clk * 2 * M / (N + 1).
In fact the DPLL IP has 3 outputs
CLKOUT_M2 = Fdpll / (2 x M2)
CLKOUTX2_M2 = Fdpll / M2
CLKOUTX2_M3 = (Fdpll or CLKINPHIF) / M3

For some reason, maybe because of legacy, Fdpll/2 is supposed to be the 
theoretical DPLL output clock, hence the X2 for all the others nodes.
In that case CLKOUT = ref_clk * M / (N + 1)
CLKOUTX2 = CLKOUT x 2

This is indeed a little bit confusing...

> We have not been hit by this bug in OMAP2 / OMAP3 as we have always
> had a X node X2 node for all the post dividers. And for the X2 node we do
> a *2 of the parent clock rate. This is again not according to spec as X2 nodes
> are direct derivatives from the dpll clock with just a post divider in between.
> Where as as per the spec the X nodes have to be /2 from the dpll clock rate in addition
> to applying the post divider.

Even if that does not stick to the spec diagram, the way it is written 
suggests to do that. Here is what the 3430 TRM is saying:
CLKOUT_M2 = CLKOUT/M2
CLKOUT_M2X2 = CLKOUTX2/M2
CLKOUT_M3X2 = CLKOUTX2/M3
CLKOUT_M4X2 = CLKOUTX2/M4
CLKOUT_M5X2 = CLKOUTX2/M5
CLKOUT_M6X2 = CLKOUTX2/M6

> But now in OMAP4 clock data base in auto generated. The auto generation does not
> generate a X node and a X2 node for the post dividers. It just generates one node
> and it expects it's rate to be dpll clock rate / post divider. But then these nodes
> now reflect wrong rates as the dpll clock rate itself is /2. Hence all the child
> clocks start displaying a wrong rate.
>
> This issue can be solved in two ways.
> 	1. Add explicit X2 nodes for all the post dividers let them be the parent
> 	   to rest of the child clocks for OMAP4. Before doing this I would like to
> 	   understand why the dpll rate calculation is not done according to the spec.

This is probably the thing to do for the short term. The spec is using 
CLKOUT and CLKOUTX2, so this is just following that terminology. 
Otherwise we will have CLKOUT and CLKOUTDIV2...
CLKOUT is considered as the reference output clock everywhere in the 
3430 spec, not Fdpll. On the other hand, the OMAP4 TRM is now using 
Fdpll as a reference:-(

> 	2. Correct the dpll rate calculation as per the spec. But then this change will be
> 	   intrusive. We will have to modify the OMAP2 and OMAP3 clock data base accordingly.
> 	   (Lot of X nodes can disappear).

Yes, but in that case you will have to add an extra divider by 2 for the 
clkout output. So the X2 nodes will be replaced by div2 nodes.

Both views are correct, this is mainly a matter of spec interpretation.
That being said, the second approach is probably the best for the long term.

Regards,
Benoit

