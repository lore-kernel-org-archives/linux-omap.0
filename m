From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 0/4] OMAP4: DSS2: Adding fclk support for DPI interface
Date: Thu, 17 Feb 2011 07:49:41 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102170747590.1831@utopia.booyaka.com>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com> <1297699342.2951.62.camel@deskari> <4D5B9176.5060000@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56484 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1BQOtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 09:49:42 -0500
In-Reply-To: <4D5B9176.5060000@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Raghuveer Murthy <x0075817@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Wed, 16 Feb 2011, Raghuveer Murthy wrote:

> On Monday 14 February 2011 09:32 PM, Valkeinen, Tomi wrote:
> > On Thu, 2011-02-03 at 07:56 -0600, Murthy, Raghuveer wrote:
> > > - Adding dss_feature for DPLL fclk
> > > - Enabling pixel clock generation for DPI interface
> > 
> > A bit more description what the patch set is about would be nice. Also,
> > one line patch descriptions are a bit too short for anything else than
> > the most trivial patches.
> > 
> > Now to the actual patch contents:
> > 
> > DPLL is not a feature of the DSS, and I don't think we should have
> > dss_features for that. In fact, I think the whole DPLL code should be
> > moved from DSS to somewhere under arch/arm.
> > 
> > In a perfect world DSS could just set the dss_fck to whatever rate it
> > requires, but as the clock rate can only be set to certain rates, and we
> > need a precise control for the rate, some other method has to be in
> > place.
> > 
> > I am not sure what this method should be. Perhaps there is something in
> > the clock framework that could help us here, or perhaps we just need a
> > bunch of function pointers in the DSS's platform data which can be used
> > to configure the clock.
> > 
> >   Tomi
> > 
> > 
> 
> Hi Paul, Benoit,
> 
> DPLL_PER post divider output for DSS core functional clock can be changed in
> OMAP3xxx and OMAP4430, based on the requested pixel clock for a given display
> resolution.
> 
> Additionally, the number of dividers available for DPLL_PER post dividors for
> DSS has increased from 16 to 32, from OMAP3630 onwards.
> 
> Both these are added as dss_features.
> 
> Given the above comments from Tomi, can the same be included as part of the
> clock framework?

Have you considered just calling clk_round_rate() on the DPLL_PER's output 
divider and seeing if you can get a rate that you're happy with?


- Paul
