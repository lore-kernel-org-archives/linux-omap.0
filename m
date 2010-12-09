From: Jamie Iles <jamie@jamieiles.com>
Subject: Re: [PATCH 8/8] arm: omap: add minimal support for RM-680
Date: Thu, 9 Dec 2010 17:03:10 +0000
Message-ID: <20101209170310.GC2763@pulham.picochip.com>
References: <1291912764-12823-1-git-send-email-aaro.koskinen@nokia.com>
 <1291912764-12823-9-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34656 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753944Ab0LIRDO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 12:03:14 -0500
Received: by wyb28 with SMTP id 28so2482419wyb.19
        for <linux-omap@vger.kernel.org>; Thu, 09 Dec 2010 09:03:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1291912764-12823-9-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Aaro,

A couple of small comments below, otherwise looks nice to me.

Jamie

On Thu, Dec 09, 2010 at 06:39:24PM +0200, Aaro Koskinen wrote:
> Add minimal support for Nokia RM-680 board.
> 
> Tested with omap2plus_defconfig.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
[...]
> +#if defined(CONFIG_MTD_ONENAND_OMAP2) || \
> +	defined(CONFIG_MTD_ONENAND_OMAP2_MODULE)
> +static struct omap_onenand_platform_data board_onenand_data[] = {
> +	{
> +		.gpio_irq	= 65,
> +		.flags		= ONENAND_SYNC_READWRITE,
> +	}
> +};
> +#endif
> +
> +/* eMMC */
> +static struct omap2_hsmmc_info mmc[] __initdata = {
> +	{
> +		.name		= "internal",
> +		.mmc		= 2,
> +		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
> +		.gpio_cd	= -EINVAL,
> +		.gpio_wp	= -EINVAL,
> +	},
> +	{ /* Terminator */ }
> +};
> +
> +static void __init rm680_peripherals_init(void)
> +{
> +	platform_add_devices(rm680_peripherals_devices,
> +				ARRAY_SIZE(rm680_peripherals_devices));
> +	rm680_i2c_init();
> +	gpmc_onenand_init(board_onenand_data);
What happens if CONFIG_MTD_ONENAND_OMAP2=n and 
CONFIG_MTD_ONENAND_OMAP2_MODULE=n? Do you need to define board_onenand_data to 
NULL if these aren't enabled?

> +	omap2_hsmmc_init(mmc);
> +}
> +
> +static void __init rm680_init_irq(void)
> +{
> +	struct omap_sdrc_params *sdrc_params;
> +
> +	sdrc_params = nokia_get_sdram_timings();
> +	omap2_init_common_hw(sdrc_params, sdrc_params);
> +	omap_init_irq();
> +	omap_gpio_init();
> +}
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#endif
> +
> +static struct omap_musb_board_data rm680_musb_data = {
> +	.interface_type	= MUSB_INTERFACE_ULPI,
> +	.mode		= MUSB_PERIPHERAL,
> +	.power		= 100,
> +};
> +
> +static void __init rm680_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
The same here as with the onenand data.
