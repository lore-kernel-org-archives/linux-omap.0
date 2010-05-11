From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 6/7] omap: init the gpio pinmux for mmc
Date: Tue, 11 May 2010 16:13:06 -0700
Message-ID: <20100511231306.GM13931@atomide.com>
References: <1271745212-4474-1-git-send-email-stanley.miao@windriver.com>
 <1271745212-4474-7-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55106 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab0EKXNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:13:04 -0400
Content-Disposition: inline
In-Reply-To: <1271745212-4474-7-git-send-email-stanley.miao@windriver.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org, hvaibhav@ti.com, srk@ti.com, anuj.aggarwal@ti.com

* Stanley.Miao <stanley.miao@windriver.com> [100419 23:20]:
> There is two gpio for mmc use, one is for card detecting, another is
> used for checking write protect. Intialize its pinmux in case the bootloader
> doesn't set it.
> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/devices.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 23e4d77..df9c62a 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -591,6 +591,13 @@ static inline void omap_hsmmc_reset(void) {}
>  static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
>  			int controller_nr)
>  {
> +	if (mmc_controller->slots[0].switch_pin > 0)
> +		omap_mux_init_gpio(mmc_controller->slots[0].switch_pin,
> +					OMAP_PIN_INPUT_PULLUP);
> +	if (mmc_controller->slots[0].gpio_wp > 0)
> +		omap_mux_init_gpio(mmc_controller->slots[0].gpio_wp,
> +					OMAP_PIN_INPUT_PULLUP);
> +
>  	if (cpu_is_omap2420() && controller_nr == 0) {
>  		omap_cfg_reg(H18_24XX_MMC_CMD);
>  		omap_cfg_reg(H15_24XX_MMC_CLKI);

The problem I see with this patch is that it attempts to mux
even for the GPIO pins on the companion chips, such as twl4030.

Got any ideas on how to prevent that?

Tony
