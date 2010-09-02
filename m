From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4]  Low-level init of hsmmc controller for LogicPD's
	OMAP3530LV SOM and OMAP 35x Torpedo dev boards
Date: Thu, 2 Sep 2010 14:22:11 +0100
Message-ID: <20100902132211.GF26319@n2100.arm.linux.org.uk>
References: <1282708420-26418-1-git-send-email-Jacob.Tanenbaum@logicpd.com> <1282708420-26418-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41382 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752319Ab0IBNWY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 09:22:24 -0400
Content-Disposition: inline
In-Reply-To: <1282708420-26418-2-git-send-email-Jacob.Tanenbaum@logicpd.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Aug 24, 2010 at 11:53:38PM -0400, Jacob Tanenbaum wrote:
> From: jake <jake@Glados.(none)>

Not a valid address... please fix.

> 
>     	ARM: OMAP3LOGIC: Adding SDMMC support
>              Add low-level initialization for hsmmc controller for
>              LogicPD's OMAP 3530 LV SOM and OMAP 35x Torpedo board.
> 
> 	Tested against: 81e09f50c93edff607259cbe374a3006c9c5fa74
> 	Signed-off-by: Jacob Tanenbaum <Jacob.Tanenbaum@logicpd.com>

I'm confused why these comments are indented.

> +static void __init board_mmc_init(void)
> +{
> +	/* OMAP3530 LV SOM board */
> +	if (machine_is_omap3530_lv_som()) {
> +		board_mmc_info[0].gpio_cd = OMAP3530_LV_SOM_MMC_GPIO_CD;
> +		board_mmc_info[0].gpio_wp = OMAP3530_LV_SOM_MMC_GPIO_WP;
> +		omap_mux_init_signal("gpio_110", OMAP_PIN_OUTPUT);
> +		omap_mux_init_signal("gpio_126", OMAP_PIN_OUTPUT);
> +
> +
> +	/* OMAP3 Torpedo board */

missing tab?

> +	} else if (machine_is_omap3_torpedo()) {
> +		board_mmc_info[0].gpio_cd = OMAP3_TORPEDO_MMC_GPIO_CD;
> +		omap_mux_init_signal("gpio_127", OMAP_PIN_OUTPUT);
> +	/* unsupported board */

missing tab?

> +	} else {
> +		printk(KERN_ERR "%s(): unknown machine type\n", __func__);
> +	return;

missing tab?
