From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 5/9] ARM: OMAP3: set autoidle flags for a few clocks
Date: Thu, 12 Jul 2012 18:32:27 +0300
Message-ID: <1342107147.4672.37.camel@sokoban>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
	 <1338470942-20185-6-git-send-email-t-kristo@ti.com>
	 <4FFE9537.9080708@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57614 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932560Ab2GLPcr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 11:32:47 -0400
In-Reply-To: <4FFE9537.9080708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On Thu, 2012-07-12 at 14:43 +0530, Rajendra Nayak wrote:
> Hi Tero,
> 
> On Thursday 31 May 2012 06:58 PM, Tero Kristo wrote:
> > dpll3, dpll4 and sdrc_ick are controlled automatically by hardware.
> 
> sdrc_ick does not seem to have a software control to enable/disable
> this automatic control in hardware, so what you are doing in the
> patch below seems fine.
> However for dpll3 and dpll4, there is indeed a software control which
> is enabled/disabled through omap3_dpll_allow_idle/omap3_dpll_deny_idle
> functions respectively. So shouldn't the 'autoidle' flag for them be
> handled similar to what you do in omap2_clkt_iclk_allow_idle/
> omap2_clkt_iclk_deny_idle functions in your PATCH 2/9, instead of
> setting them to 'true' statically?

Yea, this is a good idea, and seems to work also. I'll add this change
to the next rev.

-Tero

> 
> regards,
> Rajendra
> 
> > Thus, reflect this with the autoidle flags, the clocks will no longer
> > show as active in usecount dumps and will allow the voltdm->sleep /
> > wakeup calls to work properly.
> >
> > Signed-off-by: Tero Kristo<t-kristo@ti.com>
> > Cc: Paul Walmsley<paul@pwsan.com>
> > Cc: Kevin Hilman<khilman@ti.com>
> > ---
> >   arch/arm/mach-omap2/clock3xxx_data.c |    3 +++
> >   1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
> > index 4e1a3b0..ca0de28 100644
> > --- a/arch/arm/mach-omap2/clock3xxx_data.c
> > +++ b/arch/arm/mach-omap2/clock3xxx_data.c
> > @@ -434,6 +434,7 @@ static struct clk dpll3_ck = {
> >   	.round_rate	=&omap2_dpll_round_rate,
> >   	.clkdm_name	= "dpll3_clkdm",
> >   	.recalc		=&omap3_dpll_recalc,
> > +	.autoidle	= true,
> >   };
> >
> >   /*
> > @@ -617,6 +618,7 @@ static struct clk dpll4_ck = {
> >   	.set_rate	=&omap3_dpll4_set_rate,
> >   	.clkdm_name	= "dpll4_clkdm",
> >   	.recalc		=&omap3_dpll_recalc,
> > +	.autoidle	= true,
> >   };
> >
> >   /*
> > @@ -1751,6 +1753,7 @@ static struct clk sdrc_ick = {
> >   	.flags		= ENABLE_ON_INIT,
> >   	.clkdm_name	= "core_l3_clkdm",
> >   	.recalc		=&followparent_recalc,
> > +	.autoidle	= true,
> >   };
> >
> >   static struct clk gpmc_fck = {
> 


