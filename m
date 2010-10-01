From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv2 1/6] omap3: Add external VBUS power switch and
 overcurrent detect on IGEP v2 board.
Date: Fri, 1 Oct 2010 12:59:45 -0700
Message-ID: <20101001195945.GW3117@atomide.com>
References: <1285962353-9586-1-git-send-email-eballetbo@gmail.com>
 <1285962353-9586-2-git-send-email-eballetbo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54236 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219Ab0JAT7q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 15:59:46 -0400
Content-Disposition: inline
In-Reply-To: <1285962353-9586-2-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo i Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org

* Enric Balletbo i Serra <eballetbo@gmail.com> [101001 12:37]:
> GPIO for various devices are missing from the board initialization.
> This patch adds support for the VBUS and over current gpios.  Without this
> patch, input/outputs from these two sources are ignored.
> 
> Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
> ---
>  arch/arm/mach-omap2/board-igep0020.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
> index 175f043..1052a63 100644
> --- a/arch/arm/mach-omap2/board-igep0020.c
> +++ b/arch/arm/mach-omap2/board-igep0020.c
> @@ -274,6 +274,20 @@ static int igep2_twl_gpio_setup(struct device *dev,
>  	igep2_vmmc1_supply.dev = mmc[0].dev;
>  	igep2_vmmc2_supply.dev = mmc[1].dev;
>  
> +	/*
> +	 * REVISIT: need ehci-omap hooks for external VBUS
> +	 * power switch and overcurrent detect
> +	 */
> +	gpio_request(gpio + 1, "GPIO_EHCI_NOC");
> +	gpio_direction_input(gpio + 1);
> +
> +	/*
> +	 * TWL4030_GPIO_MAX + 0 == ledA, GPIO_USBH_CPEN
> +	 * (out, active low)
> +	 */
> +	gpio_request(gpio + TWL4030_GPIO_MAX, 0);
> +	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> +
>  	return 0;
>  };

Please check the result value.. gpio_request can fail.

Tony
