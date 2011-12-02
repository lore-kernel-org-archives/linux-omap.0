From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 14:00:45 +0000
Message-ID: <20111202140044.GS8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
 <4ED8C57B.2000503@ti.com>
 <20111202130242.GO8245@opensource.wolfsonmicro.com>
 <4ED8D321.7030904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42108 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756596Ab1LBOAs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 09:00:48 -0500
Content-Disposition: inline
In-Reply-To: <4ED8D321.7030904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Dec 02, 2011 at 02:31:13PM +0100, Cousson, Benoit wrote:

> Even if the reg-names and interrupts-names are accepted, which is
> still not obvious due to a little bit of resistance, we still do not

Yeah, it seems like there's very little traction on any of the problems
with legacy bindings that device tree has.  

> have dma request bindings, nor clock bindings, nor pin mux.
> All these information are provided today by hwmod, so it will still
> be there for a couple of more merge windows.

At least the DMA bindings seem fairly well sorted - we just merged the
Tegra audio bindings which define a Tegra property for the DMA request
signal.  There's a reasonable amount of variation in how these things
get plumbed together.

> The important point for me, it to avoid having to change the driver
> whenever these bindings will be there. This will be OK today for reg
> and interrupts since they both go through Linux resources.

This is also OK for clocks since they'll go through the clock API so
nothing needs doing there either.

> >Could we define and implement the "real" version now (it should be reasonable to
> >code blind except possibly for the DMA channel as it's such a direct
> >mapping) with hwmod left in there as something that's legacy for old
> >kernels?

> I think DT churn is unavoidable due to the ongoing effort to add
> clock, regulator, dma, pin mux into DT core.
> I don't think we should wait to have all that ready to start
> migrating to DT.

Well, it does make the whole process a bit silly.  If we're planning to
discard hwmod it seems like we shouldn't be transitioning it into device
tree in the first place and instead just add the new properties to the
bindings as we go.  If hwmod must go into the device tree somehow is it
not possible to keep the hwmod data in its own binding (referencing the
nodes it affects rather than being in their bindings).
