From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/6] OMAP3+: use DPLLs recalc function instead of
 omap2_get_dpll_rate
Date: Wed, 28 Sep 2011 01:03:00 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109280102480.4399@utopia.booyaka.com>
References: <1316195301-15025-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60230 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160Ab1I1HDA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 03:03:00 -0400
In-Reply-To: <1316195301-15025-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Jon Hunter <jon-hunter@ti.com>
> 
> This is a continuation of Mike Turquette's patch "OMAP3+: use
> DPLL's round_rate when setting rate".
> 
> omap3_noncore_dpll_set_rate() and omap3_noncore_dpll_enable() call
> omap2_get_dpll_rate() explicitly. It may be necessary for some
> DPLLs to use a different function and so use the DPLLs recalc()
> function pointer instead.
> 
> An example is the DPLL_ABE on OMAP4 which can have a 4X multiplier
> in addition to the usual MN multipler and dividers and therefore
> uses a different round_rate and recalc function.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Thanks, queued for 3.2.


- Paul
