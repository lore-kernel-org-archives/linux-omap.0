From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] OMAP4: hsmmc: Initialise the mmc mux pins
Date: Thu, 18 Nov 2010 11:03:00 -0800
Message-ID: <20101118190300.GJ9264@atomide.com>
References: <1289806685-20688-1-git-send-email-r.sricharan@ti.com>
 <1289806685-20688-2-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:46330 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755858Ab0KRTDE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 14:03:04 -0500
Content-Disposition: inline
In-Reply-To: <1289806685-20688-2-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sricharan <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org

* sricharan <r.sricharan@ti.com> [101114 23:26]:
> Use the mux framework to initialise the mmc mux pins.
> 
> Signed-off-by: sricharan <r.sricharan@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c |   83 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 83 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index eaf3799..56b1ac9 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -784,6 +784,89 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  		 * For MMC3 the pins need to be muxed in the board-*.c files
>  		 */
>  	}
> +
> +	if (cpu_is_omap44xx()) {
> +		switch (controller_nr) {
> +		case 0:
> +			/* MMC 1 */
> +			omap_mux_init_signal("sdmmc1_clk.sdmmc1_clk",
> +						OMAP_PIN_INPUT_PULLUP);
> +			omap_mux_init_signal("sdmmc1_cmd.sdmmc1_cmd",
> +						OMAP_PIN_INPUT_PULLUP);
> +			omap_mux_init_signal("sdmmc1_dat0.sdmmc1_dat0",
> +						OMAP_PIN_INPUT_PULLUP);
> +			if (mmc_controller->slots[0].caps &
> +				(MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA)) {
> +				omap_mux_init_signal("sdmmc1_dat1.sdmmc1_dat1",
> +						OMAP_PIN_INPUT_PULLUP);
> +				omap_mux_init_signal("sdmmc1_dat2.sdmmc1_dat2",
> +						OMAP_PIN_INPUT_PULLUP);
> +				omap_mux_init_signal("sdmmc1_dat3.sdmmc1_dat3",
> +						OMAP_PIN_INPUT_PULLUP);
> +			}

This does not solve the selected pins issue. For example, you don't know
if it's sdmmc1_dat1.sdmmc1_dat1 or gpmc_ad9.sdmmc_dat1. That selection
is board specific.

So you either have to pass the selected pins from the board-*.c file,
or do the muxing in board-*.c file. It depends on the the case.

How about take a look at specifying the pin names in board-*.c in
struct omap_mmc_platform_data?

Regards,

Tony
