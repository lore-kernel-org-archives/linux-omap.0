From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP4: use CLK_SET_RATE_PARENT for dss_dss_clk
Date: Thu, 24 Oct 2013 06:28:35 -0700
Message-ID: <20131024132835.GX15154@atomide.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
 <5268D44D.5010205@ti.com>
 <52691F41.1030900@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:38473 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754528Ab3JXN2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Oct 2013 09:28:38 -0400
Content-Disposition: inline
In-Reply-To: <52691F41.1030900@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Archit Taneja <archit@ti.com>

* Tero Kristo <t-kristo@ti.com> [131024 06:23]:
> On 10/24/2013 11:03 AM, Tomi Valkeinen wrote:
> >Hi Tony, Tero,
> >
> >On 09/10/13 16:12, Tomi Valkeinen wrote:
> >>Set CLK_SET_RATE_PARENT flag for dss_dss_clk so that the DSS's fclk can
> >>be configured without the need to get the parent of the fclk.
> >>
> >>Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >>---
> >>  arch/arm/mach-omap2/cclock44xx_data.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
> >>index b237950..ec0dc0b 100644
> >>--- a/arch/arm/mach-omap2/cclock44xx_data.c
> >>+++ b/arch/arm/mach-omap2/cclock44xx_data.c
> >>@@ -830,7 +830,8 @@ DEFINE_CLK_GATE(dss_tv_clk, "extalt_clkin_ck", &extalt_clkin_ck, 0x0,
> >>  		OMAP4430_CM_DSS_DSS_CLKCTRL,
> >>  		OMAP4430_OPTFCLKEN_TV_CLK_SHIFT, 0x0, NULL);
> >>
> >>-DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck, 0x0,
> >>+DEFINE_CLK_GATE(dss_dss_clk, "dpll_per_m5x2_ck", &dpll_per_m5x2_ck,
> >>+		CLK_SET_RATE_PARENT,
> >>  		OMAP4430_CM_DSS_DSS_CLKCTRL, OMAP4430_OPTFCLKEN_DSSCLK_SHIFT,
> >>  		0x0, NULL);
> >
> >I was discussing with Tero about these three patches, and he was ok with
> >them being merged.
> >
> >Tony, it'd be great to have these for 3.13, so that I can start cleaning
> >up the DSS driver's fclk management.
> 
> Yea, am ok with these, I can incorporate the changes to my DT clk series.

OK. If you have fixes that should go in earlier, please put those into
a separate branch.

Regards,

Tony
