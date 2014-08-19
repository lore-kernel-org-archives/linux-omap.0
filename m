From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/8] clk: ti: add gpio controlled clock
Date: Tue, 19 Aug 2014 13:37:11 +0100
Message-ID: <20140819123711.GK3302@leverpostej>
References: <cover.1408397864.git.jsarha@ti.com>
 <f080a02691e0f1b45607d7a1afe89698b7f911da.1408397864.git.jsarha@ti.com>
 <20140819113200.GJ3302@leverpostej>
 <53F341B0.3090904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63046 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753058AbaHSMhS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Aug 2014 08:37:18 -0400
Content-Disposition: inline
In-Reply-To: <53F341B0.3090904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, mturquette@linaro.org
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "airlied@linux.ie" <airlied@linux.ie>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "detheridge@ti.com" <detheridge@ti.com>, "ezequiel.garcia@free-electrons.com" <ezequiel.garcia@free-electrons.com>, "t-kristo@ti.com" <t-kristo@ti.com>

On Tue, Aug 19, 2014 at 01:23:12PM +0100, Jyri Sarha wrote:
> On 08/19/2014 02:32 PM, Mark Rutland wrote:
> > On Mon, Aug 18, 2014 at 10:46:39PM +0100, Jyri Sarha wrote:
> >> The added ti,gpio-clock is a basic clock that can be enabled and
> >> disabled trough a gpio output. The DT binding document for the clock
> >> is also added. For EPROBE_DEFER handling the registering of the clock
> >> has to be delayed until of_clk_get() call time.
> >
> > I guess this is basically an AND gate with the GPIO and parent clock as
> > inputs? Or is this something more complex that we might want to do more
> > things with later?
> >
> > If it's the former it sounds like this could be a completely generic
> > "gpio-gate-clock".
> >
> 
> Yes, its completely generic. However, since there has been no response 
> to my several earlier attempts to get this patch in I finally gave up 
> and moved it under clk/ti.

Ah. Apolgoies for that having happened.

> "gpio-gate-clock" sound like more accurate name for ti. I'll change that.
> 
> Do you think I should give this one more try to get it in as generic 
> basic clock?

I'd certainly be happy with a generic gpio-gate-clock.

Mike, thoughts?

Thanks,
Mark.
