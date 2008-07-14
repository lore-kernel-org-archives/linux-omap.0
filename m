From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH 04/09] OMAP PM srf implementation
Date: Mon, 14 Jul 2008 16:29:09 +0300
Message-ID: <20080714132909.GA4639@codecarver.research.nokia.com>
References: <030b01c8e0ef$46c859c0$68bf18ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:20554 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbYGNN3h (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Jul 2008 09:29:37 -0400
Content-Disposition: inline
In-Reply-To: <030b01c8e0ef$46c859c0$68bf18ac@ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Rajendra,

> +void omap_pm_set_min_bus_tput(struct device *dev, struct bus_type *bus,
> +				    unsigned long r)

According to Paul's prototypes this should be 
void omap_pm_set_min_bus_tput(struct device *dev, u8 agent_id, 
			      unsigned long r)
				
> +{
> +	if (!dev) {
> +		WARN_ON(1);
> +		return;
> +	};
> +
> +	if (r == 0)
> +		pr_debug("OMAP PM: remove min bus tput constraint: "
> +			 "dev %p for bus %s\n", dev, bus->name);
> +	else
> +		pr_debug("OMAP PM: add min bus tput constraint: "
> +			 "dev %p for bus %s: rate %ld KiB\n", dev,
> +			 bus->name, r);
> +
> +	/*
> +	 * This code should model the bus and compute the required
> +	 * bus frequency, convert that to a VDD2 OPP ID, then set the VDD2
> +	 * OPP appropriately.
> +	 *
> +	 * TI CDP code can call constraint_set here on the VDD2 OPP.
> +	 */
> +}
> +

omap_pm_if_early_init and omap_pm_if_init are missing. I added dummy
functions for those.

With all of these changes it seems to work.

Cheers,

Peter.

-- 
goa is a state of mind
