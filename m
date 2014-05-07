From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually
 round
Date: Wed, 7 May 2014 22:16:45 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1405072210360.23579@utopia.booyaka.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com> <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com> <20140424182914.GD4659@saruman.home> <20140424184457.GH22987@atomide.com> <20140429155111.GC633@saruman.home>
 <535FD2E0.1050806@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:35845 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbaEGWQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 18:16:46 -0400
In-Reply-To: <535FD2E0.1050806@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, nm@ti.com, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

Hi,

On Tue, 29 Apr 2014, Tomi Valkeinen wrote:

> On 29/04/14 18:51, Felipe Balbi wrote:
> > On Thu, Apr 24, 2014 at 11:44:58AM -0700, Tony Lindgren wrote:
> >> * Felipe Balbi <balbi@ti.com> [140424 11:29]:
> >>> Hi,
> >>>
> >>> On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
> >>>> omap2_dpll_round_rate() doesn't actually round the given rate, even if
> >>>> the name and the description so hints. Instead it only tries to find an
> >>>> exact rate match, or if that fails, return ~0 as an error.
> >>>>
> >>>> What this basically means is that the user of the clock needs to know
> >>>> what rates the dpll can support, which obviously isn't right.
> >>>>
> >>>> This patch adds a simple method of rounding: during the iteration, the
> >>>> code keeps track of the closest rate match. If no exact match is found,
> >>>> the closest is returned.
> >>>>
> >>>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>>
> >>> Tony, looks like this patch was lost. Are you taking it during the -rc ?
> >>
> >> Would like to hear what Paul thinks of the updated patch suggested
> >> by Tomi first.
> > 
> > Paul, any chance you can review Tomi's v2 ? It'd be very nice to get
> > display working on BBB.
> 
> Btw, I'm fine with my v2 patch, but I think the original one is fine also.
> 
> It's true that the original patch changes the dpll behavior when an
> exact match is not found. However, I think our drivers always request an
> exact match, and in that case the original patch doesn't change the
> behavior in practice.
> 
> In theory it's possible that a driver requests a non-exact clock from
> the dpll, and when it gets an error, it does something else.

The path that worries me at the moment is the set-rate path.  That calls 
__clk_round_rate() (if the user hasn't called it already) and silently 
tries to set the clock to the altered rate.

So I think I'd prefer the v2 patches - since at least then, we can control 
the scope of the altered behavior.  Tomi, care to address Nishanth's 
comments on your v2 patches from his April 30th mail?

> But, if I'm not mistaken, all our dplls have a clk-divider after them. 
> And as clk-divider doesn't handle the error from dpll in any way, and 
> instead returns bogus rates, I presume all our drivers use exact clocks.

Sigh, sounds like another bug to fix...


- Paul
