From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/4] OMAP4: DSS2: Adding fclk support for DPI interface
Date: Thu, 17 Feb 2011 21:16:00 +0200
Message-ID: <1297970160.2031.155.camel@deskari>
References: <1296741419-9037-1-git-send-email-raghuveer.murthy@ti.com>
	 <1297699342.2951.62.camel@deskari> <4D5B9176.5060000@ti.com>
	 <alpine.DEB.2.00.1102170747590.1831@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52062 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754543Ab1BQTQG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 14:16:06 -0500
In-Reply-To: <alpine.DEB.2.00.1102170747590.1831@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Murthy, Raghuveer" <raghuveer.murthy@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, 2011-02-17 at 08:49 -0600, Paul Walmsley wrote:
> On Wed, 16 Feb 2011, Raghuveer Murthy wrote:
> 

<snip>

> > 
> > DPLL_PER post divider output for DSS core functional clock can be changed in
> > OMAP3xxx and OMAP4430, based on the requested pixel clock for a given display
> > resolution.
> > 
> > Additionally, the number of dividers available for DPLL_PER post dividors for
> > DSS has increased from 16 to 32, from OMAP3630 onwards.
> > 
> > Both these are added as dss_features.
> > 
> > Given the above comments from Tomi, can the same be included as part of the
> > clock framework?
> 
> Have you considered just calling clk_round_rate() on the DPLL_PER's output 
> divider and seeing if you can get a rate that you're happy with?

Hmm, yes, perhaps that would be possible.

Currently we iterate suitable clocks by going through all fck dividers,
then lck dividers and then pck dividers, and checking if one of the
resulting pixel clocks is close to the required one.

But we could start with the required pck, and go "up" from there with
pck dividers, lck dividers, and in the end using clk_round_rate() to see
if the set of dividers is possible.

And we know the maximum allowed fck rate, so we can use that as a
ceiling and forget any divider sets that lead to too high clocks.

This will probably need a bit more iterations, though, as we may be
trying multiple divider sets leading to the same fck rate, because the
code doesn't have any idea what the possible rates are.

I trust clk_round_rate() is quite simple function (ie. fast)?

 Tomi


