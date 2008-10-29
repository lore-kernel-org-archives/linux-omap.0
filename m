From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
Date: Wed, 29 Oct 2008 08:24:13 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0810290820470.4200@utopia.booyaka.com>
References: <alpine.DEB.2.00.0810171617420.3833@utopia.booyaka.com> <49075870.9020804@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47179 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753366AbYJ2OYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 10:24:14 -0400
In-Reply-To: <49075870.9020804@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, rick@efn.org, timo.t.kokkonen@nokia.com, sakari.poussa@nokia.com

On Tue, 28 Oct 2008, Kevin Hilman wrote:

> Paul Walmsley wrote:
> > Commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa introduced a bug that
> > caused non-CORE DPLL rates to be incorrectly set on boot in
> > omap3_noncore_dpll_enable().  Debugged by Tomi Valkeinen
> > <tomi.valkeinen@nokia.com> - thanks Tomi.
> > 
> > Also fix omap3_noncore_dpll_set_rate() to assign clk->rate after a
> > DPLL reprogram.
> > 
> > Tested on 3430SDP.
> 
> FYI, This patch breaks the ability to come out of retention in dynamic idle,
> but I haven't yet discovered why.

Hi Kevin,

would you be willing to test this patch for me?  It's not for merging, but 
I would be interested to know if it fixes the problem.


- Paul

Author: Paul Walmsley <paul@pwsan.com>
Date:   Wed Oct 29 08:16:09 2008 -0600

    OMAP3 clock: reprogram DPLL when coming out of bypass
    
    The OMAP3 DPLL enable code has assumed that the contents of M, N,
    etc. are preserved across disables and enables.  This assumption
    appears to be wrong.  Test to see whether reprogramming the DPLL on
    each re-enable fixes the problem that Kevin reported.
    
    This patch is not for merging.  It is intended to test a hypothesis.  A
    mergeable version of this patch would preserve M, N, etc. across
    DPLL disable/enable to avoid the time-consuming rate rounding step
    upon return from dynamic idle.

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index cc43f4f..bfbd966 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -283,7 +283,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (clk->rate == dd->bypass_clk->rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
-		r = _omap3_noncore_dpll_lock(clk);
+		r = omap3_noncore_dpll_set_rate(clk, clk->rate);
 
 	if (!r)
 		clk->rate = omap2_get_dpll_rate(clk);
