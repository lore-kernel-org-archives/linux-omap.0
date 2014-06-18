From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC PATCH] clk: ti: set CLK_SET_RATE_NO_REPARENT for
 ti,mux-clock
Date: Wed, 18 Jun 2014 06:57:22 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406180639290.32511@utopia.booyaka.com>
References: <1402992272-21413-1-git-send-email-tomi.valkeinen@ti.com> <1402992272-21413-2-git-send-email-tomi.valkeinen@ti.com> <alpine.DEB.2.02.1406170814220.31106@utopia.booyaka.com> <20140617213404.32686.34311@quantum>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:60528 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756579AbaFRG5W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Jun 2014 02:57:22 -0400
In-Reply-To: <20140617213404.32686.34311@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Felipe Balbi <balbi@ti.com>

On Tue, 17 Jun 2014, Mike Turquette wrote:

> Quoting Paul Walmsley (2014-06-17 01:15:09)
> > On Tue, 17 Jun 2014, Tomi Valkeinen wrote:
> > 
> > > When setting the rate of a clock, by default the clock framework will
> > > change the parent of the clock to the most suitable one in
> > > __clk_mux_determine_rate() (most suitable by looking at the clock rate).
> > 
> > That is just insane.
> 
> The patch description is insane. The framework has nothing to do with
> this dynamic re-parenting behavior and certainly the framework does not
> force this behavior on clock providers. This behavior is specific to
> users of __clk_mux_determine_rate.

drivers/clk/clk-mux.c and drivers/clk/clk.c aren't considered part of the 
clock framework?

> Those are:
> 
> 1) drivers/clk/clk-mux.c
> 2) drivers/clk/qcom/mmcc-msm8960.c
> 3) drivers/clk/samsung/clk-s3c2410-dclk.c
> 4) drivers/clk/ti/mux.c
> 
> If dynamic re-parenting by default doesn't work for your platform then
> you have two choices:
> 
> 1) use the CLK_SET_RATE_NO_REPARENT flag (as this patch does)
> 2) don't use the basic divider type and write your own
> 
> If you choose #2 then all you have to do when implementing
> .determine_rate is ignore the best_parent_rate argument.
> 
> Finally when the .determine_rate callback was introduced (allowing
> dynamic re-parenting from a call to clk_set_rate) the
> CLK_SET_RATE_NO_REPARENT flag was applied to all affected users to
> maintain prior behavior and prevent regressions.

I don't disagree that some platforms might want this behavior.  But it's 
not a safe default, the flag should be the other way around.  Rare is the 
software engineer that knows whether the clock muxes on their platform are 
glitchless.


- Paul
