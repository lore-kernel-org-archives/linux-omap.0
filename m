From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 1/2] omap3sdp: Fix regulator mapping for ads7846 TS
 controller
Date: Thu, 3 Feb 2011 14:54:03 +0200
Message-ID: <20110203125403.GB28607@legolas.emea.dhcp.ti.com>
References: <1296737122-20765-1-git-send-email-rnayak@ti.com>
 <1296737122-20765-2-git-send-email-rnayak@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:34382 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab1BCMyI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 07:54:08 -0500
Received: by fxm11 with SMTP id 11so1115630fxm.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Feb 2011 04:54:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1296737122-20765-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org, balbi@ti.com

On Thu, Feb 03, 2011 at 06:15:21PM +0530, Rajendra Nayak wrote:
> On the OMAP3430SDP board, the ads7846 touchscreen controller
> is powered by VAUX3 regulator (supplying 2.8v).
> Fix this mapping in the board file, and hence prevent
> the ads7846 driver init to fail with the below error..
> 
> ads7846 spi1.0: unable to get regulator: -19
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/board-3430sdp.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
> index d4e41ef..8e18f21 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -427,6 +427,11 @@ static struct twl4030_madc_platform_data sdp3430_madc_data = {
>  	.irq_line	= 1,
>  };
>  
> +/* ads7846 on SPI */
> +static struct regulator_consumer_supply sdp3430_vaux3_supplies[] = {
> +	REGULATOR_SUPPLY("vcc", "spi1.0"),
> +};
> +
>  /*
>   * Apply all the fixed voltages since most versions of U-Boot
>   * don't bother with that initialization.
> @@ -469,6 +474,8 @@ static struct regulator_init_data sdp3430_vaux3 = {
>  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> +	.num_consumer_supplies		= ARRAY_SIZE(sdp3430_vaux3_supplies),
> +	.consumer_supplies		= sdp3430_vaux3_supplies,
>  };
>  
>  /* VAUX4 for OMAP VDD_CSI2 (camera) */
> -- 
> 1.7.0.4

-- 
balbi
