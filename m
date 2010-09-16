From: Roger Quadros <roger.quadros@nokia.com>
Subject: Re: [PATCH 1/4] OMAP: introduce OPP layer for device-specific OPPs
Date: Thu, 16 Sep 2010 16:54:55 +0300
Message-ID: <4C9221AF.9000804@nokia.com>
References: <1284587799-9637-1-git-send-email-khilman@deeprootsystems.com> <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:36222 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754954Ab0IPNzb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 09:55:31 -0400
In-Reply-To: <1284587799-9637-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Nishant,

Since you are anyways re-sending this you might as well fix these nits.

On 09/16/2010 12:56 AM, ext Kevin Hilman wrote:
> From: Nishanth Menon<nm@ti.com>
>

> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> new file mode 100644
> index 0000000..17f93b2
> --- /dev/null
> +++ b/arch/arm/plat-omap/opp.c
> @@ -0,0 +1,461 @@
> +/*
> + * OMAP OPP Interface
> + *
> + * Copyright (C) 2009-2010 Texas Instruments Incorporated.
> + *     Nishanth Menon
> + *     Romit Dasgupta<romit@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +

> +/**
> + * opp_get_voltage() - Gets the voltage corresponding to an opp
> + * @opp:       opp for which voltage has to be returned for
> + *
> + * Return voltage in micro volt corresponding to the opp, else
> + * return 0
> + */
> +unsigned long opp_get_voltage(const struct omap_opp *opp)
> +{
> +       if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {

If !opp->enabled, then is it really an invalid parameter being passed?

I'm not user if people need to know the voltage of a disabled OPP, but 
do we need to limit it?

> +               pr_err("%s: Invalid parameters being passed\n", __func__);
> +               return 0;
> +       }
> +
> +       return opp->u_volt;
> +}
> +
> +/**
> + * opp_get_freq() - Gets the frequency corresponding to an opp
> + * @opp:       opp for which frequency has to be returned for
> + *
> + * Return frequency in hertz corresponding to the opp, else
> + * return 0
> + */
> +unsigned long opp_get_freq(const struct omap_opp *opp)
> +{
> +       if (unlikely(!opp || IS_ERR(opp)) || !opp->enabled) {

ditto.

> +               pr_err("%s: Invalid parameters being passed\n", __func__);
> +               return 0;
> +       }
> +
> +       return opp->rate;
> +}
> +
> +/**
> + * opp_get_opp_count() - Get number of opps enabled in the opp list
> + * @opp_type:  OPP type we want to count
> + *
> + * This functions returns the number of opps if there are any OPPs enabled,
> + * else returns corresponding error value.
> + */
> +int opp_get_opp_count(struct device *dev)
> +{
> +       struct device_opp *dev_opp;
> +
> +       dev_opp = find_device_opp(dev);
> +       if (IS_ERR(dev_opp))
> +               return -ENODEV;
> +
> +       return dev_opp->enabled_opp_count;
> +}
> +
> +/**
> + * opp_find_freq_exact() - search for an exact frequency
> + * @opp_type:  OPP type we want to search in.
> + * @freq:      frequency to search for
> + * @enabled:   enabled/disabled OPP to search for
> + *
> + * Searches for exact match in the opp list and returns handle to the matching
> + * opp if found, else returns ERR_PTR in case of error and should be handled
> + * using IS_ERR.
> + *
> + * Note enabled is a modifier for the search. if enabled=true, then the match is

Good to add some punctuation after 'Note'.

> + * for exact matching frequency and is enabled. if false, the match is for exact
> + * frequency which is disabled.
> + */

cheers,
-roger
