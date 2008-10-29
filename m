From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
Date: Wed, 29 Oct 2008 09:35:19 -0700
Message-ID: <87abcnbbqw.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.0810171617420.3833@utopia.booyaka.com>
	<49075870.9020804@deeprootsystems.com>
	<alpine.DEB.2.00.0810290820470.4200@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from po-out-1718.google.com ([72.14.252.155]:22477 "EHLO
	po-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbYJ2QfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2008 12:35:23 -0400
Received: by po-out-1718.google.com with SMTP id y22so5307700pof.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Oct 2008 09:35:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.0810290820470.4200@utopia.booyaka.com> (Paul Walmsley's message of "Wed\, 29 Oct 2008 08\:24\:13 -0600 \(MDT\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, rick@efn.org, timo.t.kokkonen@nokia.com, sakari.poussa@nokia.com

Paul Walmsley <paul@pwsan.com> writes:

> From: Paul Walmsley <paul@pwsan.com>
> Subject: Re: [PATCH] OMAP3 clock: fix non-CORE DPLL rate assignment bugs
> To: Kevin Hilman <khilman@deeprootsystems.com>
> cc: linux-omap@vger.kernel.org, tomi.valkeinen@nokia.com, rick@efn.org,
>   timo.t.kokkonen@nokia.com, sakari.poussa@nokia.com
> Date: Wed, 29 Oct 2008 08:24:13 -0600 (MDT)
>
> On Tue, 28 Oct 2008, Kevin Hilman wrote:
>
>> Paul Walmsley wrote:
>> > Commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa introduced a bug that
>> > caused non-CORE DPLL rates to be incorrectly set on boot in
>> > omap3_noncore_dpll_enable().  Debugged by Tomi Valkeinen
>> > <tomi.valkeinen@nokia.com> - thanks Tomi.
>> > 
>> > Also fix omap3_noncore_dpll_set_rate() to assign clk->rate after a
>> > DPLL reprogram.
>> > 
>> > Tested on 3430SDP.
>> 
>> FYI, This patch breaks the ability to come out of retention in dynamic idle,
>> but I haven't yet discovered why.
>
> Hi Kevin,
>
> would you be willing to test this patch for me?  It's not for merging, but 
> I would be interested to know if it fixes the problem.

Hi Paul,

This patch doesn't fix the problem. :(

Kevin

>
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Wed Oct 29 08:16:09 2008 -0600
>
>     OMAP3 clock: reprogram DPLL when coming out of bypass
>     
>     The OMAP3 DPLL enable code has assumed that the contents of M, N,
>     etc. are preserved across disables and enables.  This assumption
>     appears to be wrong.  Test to see whether reprogramming the DPLL on
>     each re-enable fixes the problem that Kevin reported.
>     
>     This patch is not for merging.  It is intended to test a hypothesis.  A
>     mergeable version of this patch would preserve M, N, etc. across
>     DPLL disable/enable to avoid the time-consuming rate rounding step
>     upon return from dynamic idle.
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index cc43f4f..bfbd966 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -283,7 +283,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
>  	if (clk->rate == dd->bypass_clk->rate)
>  		r = _omap3_noncore_dpll_bypass(clk);
>  	else
> -		r = _omap3_noncore_dpll_lock(clk);
> +		r = omap3_noncore_dpll_set_rate(clk, clk->rate);
>  
>  	if (!r)
>  		clk->rate = omap2_get_dpll_rate(clk);
