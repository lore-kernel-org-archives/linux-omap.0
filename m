From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/11] arm/dts: OMAP4: Add a main ocp entry bound to
 l3-noc driver
Date: Fri, 23 Sep 2011 15:58:26 -0700
Message-ID: <20110923225825.GB6324@atomide.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
 <1316809399-19579-11-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61376 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533Ab1IWW63 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 18:58:29 -0400
Content-Disposition: inline
In-Reply-To: <1316809399-19579-11-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

* Benoit Cousson <b-cousson@ti.com> [110923 12:50]:
> Used the main OCP node to add bindings with the l3_noc driver.
> Remove l3_noc static device creation if DT is populated.
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -16,6 +16,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/irqs.h>
> @@ -77,6 +78,10 @@ static int __init omap4_l3_init(void)
>  	struct platform_device *pdev;
>  	char oh_name[L3_MODULES_MAX_LEN];
>  
> +	/* If dtb is there, the devices will be created dynamically */
> +	if (of_have_populated_dt())
> +		return -ENODEV;
> +
>  	/*
>  	 * To avoid code running on other OMAPs in
>  	 * multi-omap builds

How about just remove omap3_l3_init and omap4_l3_init completely
instead?

There should not be any need for the platform glue code if the
driver, it's OK for us to require that either DT is passed from
the bootloader or as appended DT as soon as the appended DT patches
are merged.

Regards,

Tony
