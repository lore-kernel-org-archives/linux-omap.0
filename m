From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: regression: Clock changes in next-20141205 break at least
 omap4
Date: Fri, 19 Dec 2014 16:45:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412191641310.3102@utopia.booyaka.com>
References: <20141212194238.20398.33333@quantum>  <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>  <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>  <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com>  <20141216202301.GF11502@n2100.arm.linux.org.uk>  <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>  <20141216205754.GG11502@n2100.arm.linux.org.uk>  <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
 <1418809957.3347.1.camel@pengutronix.de> <5491703A.2080506@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbaLSQph (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Dec 2014 11:45:37 -0500
In-Reply-To: <5491703A.2080506@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, Paul Walmsley <pwalmsley@nvidia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 17 Dec 2014, Tero Kristo wrote:

> The dual parent issue required by the DPLL code is caused by the introduction
> of determine-rate / set-parent / set-rate-and-parent logic to OMAP DPPLs. I
> took a short-cut here, making the assumption that every DPLL has both of these
> clocks defined (which basically they do have, as every DPLL technically has
> both reference and bypass clocks, but which can be the same clock => thus the
> declaration itself is missing in some cases.) The clock data is modelled like
> this for every other TI SoC (which use DT clock data), except for omap3 legacy
> clock data, thus the patch to tweak the clock data itself. It would be much
> harder to modify the clock code itself to take this into account, rather than
> just add the missing parents to the clock data, thus the approach taken in the
> patch. We can of course discuss whether it is okay to have DPLLs modelled as
> they are right now. I think them as composite clocks containing mux, gate and
> divider/multiplier logic within a single black box, we could split them up,
> but I don't see much need for that. If it works, don't break it.
> 
> Regarding the omap3 clock data patch, I have also just posted new patch set
> that will move the omap3 legacy clock data under clock driver, until we figure
> out what to finally do with this (use the DT clocks, or introduce loadable
> clock data modules or something.) Thus, the data patch is kind of a temporary
> one, or thats the intention at least, but I wouldn't call it a hack. It is
> there to fix the issues introduced by the set-parent / set-rate-and-parent
> logic, which was required by the changes to the core clock set-rate.

OK, I understand now why the OMAP3 clock DT data takes two of the same 
clock - one is for the reference and one is for bypass.  So I retract my 
earlier statement about it being a hack, and am fine with Tero's original 
patch.

I suppose I should resuscitate the uImage booter for the OMAP3 boards here 
at least.  I dropped those out of the testbed thinking that we'd switch 
over to DT-only fairly quickly; that turned out not to be the case.


- Paul
