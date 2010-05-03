From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/3] omap: gpmc-nand: add ability to keep timings
 defined by the bootloader
Date: Mon, 3 May 2010 11:24:26 -0700
Message-ID: <20100503182426.GX29604@atomide.com>
References: <cover.1272530653.git.mike@compulab.co.il>
 <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65127 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971Ab0ECSY2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:24:28 -0400
Content-Disposition: inline
In-Reply-To: <f20c8d0dc1c81a0cc5a334d03c9c7dc73046293d.1272530653.git.mike@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Rapoport <mike@compulab.co.il>
Cc: linux-omap@vger.kernel.org, vimal.newwork@gmail.com, s-ghorai@ti.com

* Mike Rapoport <mike@compulab.co.il> [100429 01:44]:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>

Please add a proper description to all the patches.

> --- a/arch/arm/mach-omap2/gpmc-nand.c
> +++ b/arch/arm/mach-omap2/gpmc-nand.c
> @@ -116,6 +124,11 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *_nand_data)
>  		return err;
>  	}
>  
> +	if (gpmc_nand_data->keep_timings) {
> +		gpmc_cs_get_timings(gpmc_nand_data->cs, &gpmc_default_timings);
> +		gpmc_nand_data->gpmc_t = &gpmc_default_timings;
> +	}
> +
>  	err = gpmc_nand_setup();
>  	if (err < 0) {
>  		dev_err(dev, "NAND platform setup failed: %d\n", err);

Hmm, so you're setting the timings based on the bootloader values?

I' think the problem with that is that chances are that it still won't
work for other L3 frequencies because of rounding errors.

With gpmc_cs_get_timings() you're already using tick rounded timings,
so you won't get the required accuracy out of those for the other
L3 frequencies.

So maybe just not do anything, and print a warning on gpmc L3 changes
if the timings are not set?

Regards,

Tony
