From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk
 info from DT
Date: Wed, 14 Aug 2013 14:59:50 +0100
Message-ID: <20130814135950.GD13141@e106331-lin.cambridge.arm.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <20130814134537.GB13141@e106331-lin.cambridge.arm.com>
 <520B8C31.8020803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64211 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757587Ab3HNN7x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 09:59:53 -0400
Content-Disposition: inline
In-Reply-To: <520B8C31.8020803@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "t-kristo@ti.com" <t-kristo@ti.com>, "benoit.cousson@gmail.com" <benoit.cousson@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@linaro.org" <mturquette@linaro.org>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "galak@codeaurora.org" <galak@codeaurora.org>

On Wed, Aug 14, 2013 at 02:54:57PM +0100, Rajendra Nayak wrote:
> On Wednesday 14 August 2013 07:15 PM, Mark Rutland wrote:
> > [Adding Mike Turquette and dt maintainers to Cc]
> > 
> > On Tue, Jul 23, 2013 at 07:24:38AM +0100, Rajendra Nayak wrote:
> >> With clocks for OMAP moving to DT, its now possible to pass all optional clock
> >> data for each device from DT instead of having it in hwmod.
> >>
> >> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/omap_hwmod.c |   66 ++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 64 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> >> index 12fa589..e5c804b 100644
> >> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
> >>  	return ret;
> >>  }
> >>  
> >> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
> >> +				       struct device_node *np,
> >> +				       int *opt_clks_cnt)
> >> +{
> >> +	int i, clks_cnt;
> >> +	const char *clk_name;
> >> +	const char **opt_clk_names;
> >> +
> >> +	clks_cnt = of_property_count_strings(np, "clock-names");
> >> +	if (!clks_cnt)
> >> +		return NULL;
> >> +
> >> +	opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
> >> +	if (!opt_clk_names)
> >> +		return NULL;
> >> +
> >> +	for (i = 0; i < clks_cnt; i++) {
> >> +		of_property_read_string_index(np, "clock-names", i, &clk_name);
> >> +		if (!strcmp(clk_name, "fck"))
> >> +			continue;
> >> +		opt_clks_cnt++;
> >> +		opt_clk_names[i] = clk_name;
> >> +	}
> >> +	return opt_clk_names;
> >> +}
> >> +
> >> +static int _init_opt_clks_dt(struct omap_hwmod *oh, struct device_node *np)
> >> +{
> >> +	struct clk *c;
> >> +	int i, opt_clks_cnt = 0;
> >> +	int ret = 0;
> >> +	const char **opt_clk_names;
> >> +
> >> +	opt_clk_names = _parse_opt_clks_dt(oh, np, &opt_clks_cnt);
> >> +	if (!opt_clk_names)
> >> +		return -EINVAL;
> >> +
> >> +	oh->opt_clks = kzalloc(sizeof(struct omap_hwmod_opt_clk *)
> >> +			       * opt_clks_cnt, GFP_KERNEL);
> >> +	if (!oh->opt_clks)
> >> +		return -ENOMEM;
> >> +
> >> +	oh->opt_clks_cnt = opt_clks_cnt;
> >> +
> >> +	for (i = 0; i < oh->opt_clks_cnt; i++) {
> >> +		c = of_clk_get_by_name(np, opt_clk_names[i]);
> >> +		if (IS_ERR(c)) {
> >> +			pr_warn("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
> >> +				oh->name, opt_clk_names[i]);
> >> +			ret = -EINVAL;
> >> +		}
> >> +		oh->opt_clks[i]._clk = c;
> >> +		oh->opt_clks[i].role = opt_clk_names[i];
> >> +		oh->opt_clks_cnt++;
> >> +		clk_prepare(oh->opt_clks[i]._clk);
> >> +	}
> >> +	return ret;
> >> +}
> > 
> > I don't like this. 
> > 
> > clock-names is used to represent the names of clocks as inputs to the
> > device. The driver must know the names of each and every one of the
> > clock inputs it intends to use -- there's a finite number, and if it
> > doesn't know about it it clearly has no idea how that clock's meant to
> > be used.
> > 
> > Consider a future revision of the hardware that has an additional clock
> > input. Some new feature may require that clock, but your driver won't
> > support that new feature, so you don't need it. Preparing that clock is
> > a waste of power, and could cause issues if for some reason the clock
> > was mutually exlcusive with another clock (so preparing it would make
> > the hardware unusable). If the new revision *requires* that clock to
> > provide the same interface otherwise, it's not backwards compatible and
> > needs a new binding, and the driver needs to be extended to support it.
> > 
> > Given that, preparing all the clocks you've been handed is a hack.
> 
> Mark, this is a piece of platform code (hwmod framework for omap) which
> does a enable/reset/idle of all devices on the SoC early at boot to get
> rid of bootloader dependencies. This isn;t something used by the drivers
> when they enable the devices. I don't see any issue with 'waste of power'.
> The framework (unlike the driver) has no knowledge of what clocks are
> needed and hence does a enable all momentarily to reset and put the device in a
> known state.

Ok, I'd misunderstood there. Apologies for the noise.

Thanks,
Mark.
