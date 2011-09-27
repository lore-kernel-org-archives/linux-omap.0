From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 8/9] regulator: helper to extract regulator node based on
 supply name
Date: Tue, 27 Sep 2011 13:21:55 +0100
Message-ID: <20110927122155.GE4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-9-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55793 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812Ab1I0MV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 08:21:57 -0400
Content-Disposition: inline
In-Reply-To: <1317118372-17052-9-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:51PM +0530, Rajendra Nayak wrote:

> +	if (!dev)
> +		return NULL;

So how do we handle CPUs?  cpufreq is one of the most active users of
regulators...

> +	snprintf(prop_name, 32, "%s-supply", supply);
> +
> +	prop = of_get_property(dev->of_node, prop_name, &sz);
> +	if (!prop || sz < 4)
> +		return NULL;

sz < 4?  Magic!  :)

> +extern struct device_node *of_get_regulator(struct device *dev,
> +	const char *supply);

This shouldn't be part of the public API, it should be transparently
handled within the core.
