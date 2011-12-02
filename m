From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5] ASoC: omap-dmic: Add device tree bindings
Date: Fri, 2 Dec 2011 15:29:16 +0000
Message-ID: <20111202152916.GW8245@opensource.wolfsonmicro.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
 <1322819580-7424-2-git-send-email-peter.ujfalusi@ti.com>
 <20111202122558.GM8245@opensource.wolfsonmicro.com>
 <4ED8C57B.2000503@ti.com>
 <20111202130242.GO8245@opensource.wolfsonmicro.com>
 <4ED8D321.7030904@ti.com>
 <20111202140044.GS8245@opensource.wolfsonmicro.com>
 <4ED8E7B5.2010209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36039 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065Ab1LBP3U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 10:29:20 -0500
Content-Disposition: inline
In-Reply-To: <4ED8E7B5.2010209@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On Fri, Dec 02, 2011 at 03:59:01PM +0100, Cousson, Benoit wrote:
> On 12/2/2011 3:00 PM, Mark Brown wrote:

> >At least the DMA bindings seem fairly well sorted - we just merged the
> >Tegra audio bindings which define a Tegra property for the DMA request
> >signal.  There's a reasonable amount of variation in how these things
> >get plumbed together.

> Mmm, I missed that series, but I'm not sure it is doing the right thing.
> - First the name is missing :-(
> - Secondly a dma-channel is not a dma-request... So I'm not sure
> what that series is supposed to add...

The idea is that the thing going into the block is the request line,
this is sufficient to identify to the DMA controller code which hardware
is being talked about.

> >This is also OK for clocks since they'll go through the clock API so
> >nothing needs doing there either.

> Yep, my point was about the DT churn that this will generate.

Adding new things isn't churn in quite the same way - extending bindings
is a more natural process than dropping old bits of binding.

> At the end, the effort should be only at OMAP core level, so the
> driver should not be affected if we decide to move hwmod stuff into
> DT or not.

Well, the binding will at least need to be updated.  Though of course
if we manage to ship the DTS for the OMAP with the kernel then it won't
really matter if we churn the binding and we may as well not document it
at all, treating it as an internal part of the kernel that happens to go
through device tree.
