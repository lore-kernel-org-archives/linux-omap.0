From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 9/9] regulator: map consumer regulator based on device
 tree
Date: Tue, 27 Sep 2011 13:23:57 +0100
Message-ID: <20110927122357.GF4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-10-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55813 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753812Ab1I0MX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 08:23:59 -0400
Content-Disposition: inline
In-Reply-To: <1317118372-17052-10-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:52PM +0530, Rajendra Nayak wrote:
> Look up the regulator for a given consumer from device tree, during
> a regulator_get(). If not found fallback and lookup through
> the regulator_map_list instead.

As with the fixed voltage regulator patch just use the code along with
adding it, no need to split it just makes it harder to review.

> +	if (dev->of_node) {
> +		node = of_get_regulator(dev, id);
> +		if (!node)
> +			goto retry; /* fallback and chk regulator_map_list */
> +		list_for_each_entry(rdev, &regulator_list, list)
> +			if (node == rdev->node)
> +				goto found;
> +	}
> +retry:

retry is a confusing name for the target, we don't ever actually retry
using it.  Given the simplicity of the code I'd be inclined to just
intert the if (!node) check.
