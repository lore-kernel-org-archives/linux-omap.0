From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/9] regulator: helper routine to extract
 regulator_init_data
Date: Tue, 27 Sep 2011 13:10:04 +0100
Message-ID: <20110927121003.GB4289@opensource.wolfsonmicro.com>
References: <1317118372-17052-1-git-send-email-rnayak@ti.com>
 <1317118372-17052-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:47621 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753497Ab1I0MKF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Sep 2011 08:10:05 -0400
Content-Disposition: inline
In-Reply-To: <1317118372-17052-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org

On Tue, Sep 27, 2011 at 03:42:45PM +0530, Rajendra Nayak wrote:

> +	init_data = devm_kzalloc(dev, sizeof(struct regulator_init_data),
> +						 GFP_KERNEL);
> +	if (!init_data)
> +		return NULL; /* Out of memory? */

This means that the init data will be kept around for the entire
lifetime of the device rather than being discarded.

> +	init_data->supply_regulator = (char *)of_get_property(dev->of_node,
> +						"regulator-supplies", NULL);

I'd expect that in the device tree world the supply regulator would
reference the node for that regulator.

>  	/* voltage output range (inclusive) - for voltage control */
> -	int min_uV;
> -	int max_uV;
> +	u32 min_uV;
> +	u32 max_uV;
>  
> -	int uV_offset;
> +	u32 uV_offset;
>  
>  	/* current output range (inclusive) - for current control */
> -	int min_uA;
> -	int max_uA;
> +	u32 min_uA;
> +	u32 max_uA;

Hrm, I think loosing the signs here is bad karma - negative voltages do
exist after all.
