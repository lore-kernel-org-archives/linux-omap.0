From: "Gopinath, Thara" <thara@ti.com>
Subject: OMAP2PLUS dpll rate calculation.
Date: Wed, 18 Aug 2010 12:16:56 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03242222B5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40323 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757Ab0HRGrU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Aug 2010 02:47:20 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>

Hello Paul/Kevin,

Recently I noticed that the dpll rate calculation code in 
arch/arm/mach-omap2/clkt_dpll.c is as follows
	dpll_clk = (long long)dd->clk_ref->rate * dpll_mult;
        do_div(dpll_clk, dpll_div + 1);

But the actual trm for both OMAP3 and OMAP4 (I believe this is
true for OMAP2 also) shows that the dpll output rate should be
calculated as 
			ref_clk * 2 * M / (N + 1).


We have not been hit by this bug in OMAP2 / OMAP3 as we have always
had a X node X2 node for all the post dividers. And for the X2 node we do
a *2 of the parent clock rate. This is again not according to spec as X2 nodes
are direct derivatives from the dpll clock with just a post divider in between.
Where as as per the spec the X nodes have to be /2 from the dpll clock rate in addition
to applying the post divider.

But now in OMAP4 clock data base in auto generated. The auto generation does not
generate a X node and a X2 node for the post dividers. It just generates one node
and it expects it's rate to be dpll clock rate / post divider. But then these nodes
now reflect wrong rates as the dpll clock rate itself is /2. Hence all the child
clocks start displaying a wrong rate.

This issue can be solved in two ways.
	1. Add explicit X2 nodes for all the post dividers let them be the parent
	   to rest of the child clocks for OMAP4. Before doing this I would like to
	   understand why the dpll rate calculation is not done according to the spec.

	2. Correct the dpll rate calculation as per the spec. But then this change will be
	   intrusive. We will have to modify the OMAP2 and OMAP3 clock data base accordingly.
	   (Lot of X nodes can disappear).

Do let me know your take on this.

Regards
Thara

Regards
Thara
