From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based on
 supply name
Date: Tue, 27 Sep 2011 19:59:13 +0100
Message-ID: <20110927185913.GU4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-9-git-send-email-rnayak@ti.com>
 <20110927122155.GE4289@opensource.wolfsonmicro.com>
 <4E81E281.505@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:42951 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752472Ab1I0S7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 14:59:15 -0400
Content-Disposition: inline
In-Reply-To: <4E81E281.505@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 08:19:37PM +0530, Rajendra Nayak wrote:
> On Tuesday 27 September 2011 05:51 PM, Mark Brown wrote:
> >On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:

> >>+	if (!dev)
> >>+		return NULL;

> >So how do we handle CPUs?  cpufreq is one of the most active users of
> >regulators...

> Hmm, never thought of it :(
> Maybe I should associate a supply name with all
> regulators and then lookup from the global registered
> list.

I'm not sure how this should work in a device tree world, I'd *hope*
we'd get a device tree node for the CPU and could then just make this a
regular consumer thing but then the cpufreq drivers would need to be
updated to make use of it.  The only reason we allow null devices right
now is the fact that cpufreq doesn't have a struct device it can use.

> >>+	snprintf(prop_name, 32, "%s-supply", supply);
> >>+
> >>+	prop = of_get_property(dev->of_node, prop_name,&sz);
> >>+	if (!prop || sz<  4)
> >>+		return NULL;

> >sz<  4?  Magic!  :)

> Its the valid phandle size.
> I guess I need a sz != 4

I think we need an of_get_phandle(), it'd be clearer what the check is,
more type safe and would avoid needing to replicate the check.
