From: Anand Gadiyar <gadiyar@ti.com>
Subject: RE: [PATCH] OMAP4: PandaBoard: remove unused power regulators
Date: Thu, 17 Mar 2011 15:42:54 +0530
Message-ID: <245b521f7b2cb8026dcabffa011dbcda@mail.gmail.com>
References: <1300216227-21138-1-git-send-email-x0132446@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:58327 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752120Ab1CQKNF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 06:13:05 -0400
Received: by mail-fx0-f41.google.com with SMTP id 18so2847614fxm.28
        for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 03:13:03 -0700 (PDT)
In-Reply-To: <1300216227-21138-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Anders <x0132446@ti.com>, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, andy.green@linaro.org, tony@atomide.com

David Anders wrote:
> the pandaboard does not use the VUSIM or VAUX1 power regulators on the
TWL6030
> and are left floating. if the VUSIM and VAUX1 power regulators are
initilized,
> noise on the unloaded regulators generates an overcurrent interrupt
causing the
> system to power down. this patch removes the initialization of the
unused power
> regulators of VUSIM and VAUX1.
>
> Signed-off-by: David Anders <x0132446@ti.com>

For what it's worth, thanks for tracking this down!

Acked-by: Anand Gadiyar <gadiyar@ti.com>

> ---
>  arch/arm/mach-omap2/board-omap4panda.c |   28
----------------------------
>  1 files changed, 0 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c
> b/arch/arm/mach-omap2/board-omap4panda.c
> index e944025..abc913b 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -220,19 +220,6 @@ static int __init
> omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  	return 0;
>  }
>
> -static struct regulator_init_data omap4_panda_vaux1 = {
> -	.constraints = {
> -		.min_uV			= 1000000,
> -		.max_uV			= 3000000,
> -		.apply_uV		= true,
> -		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> -					| REGULATOR_MODE_STANDBY,
> -		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
> -					| REGULATOR_CHANGE_MODE
> -					| REGULATOR_CHANGE_STATUS,
> -	},
> -};
> -
>  static struct regulator_init_data omap4_panda_vaux2 = {
>  	.constraints = {
>  		.min_uV			= 1200000,
> @@ -288,19 +275,6 @@ static struct regulator_init_data omap4_panda_vpp =
{
>  	},
>  };
>
> -static struct regulator_init_data omap4_panda_vusim = {
> -	.constraints = {
> -		.min_uV			= 1200000,
> -		.max_uV			= 2900000,
> -		.apply_uV		= true,
> -		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> -					| REGULATOR_MODE_STANDBY,
> -		.valid_ops_mask	 = REGULATOR_CHANGE_VOLTAGE
> -					| REGULATOR_CHANGE_MODE
> -					| REGULATOR_CHANGE_STATUS,
> -	},
> -};
> -
>  static struct regulator_init_data omap4_panda_vana = {
>  	.constraints = {
>  		.min_uV			= 2100000,
> @@ -356,12 +330,10 @@ static struct twl4030_platform_data
omap4_panda_twldata = {
>  	/* Regulators */
>  	.vmmc		= &omap4_panda_vmmc,
>  	.vpp		= &omap4_panda_vpp,
> -	.vusim		= &omap4_panda_vusim,
>  	.vana		= &omap4_panda_vana,
>  	.vcxio		= &omap4_panda_vcxio,
>  	.vdac		= &omap4_panda_vdac,
>  	.vusb		= &omap4_panda_vusb,
> -	.vaux1		= &omap4_panda_vaux1,
>  	.vaux2		= &omap4_panda_vaux2,
>  	.vaux3		= &omap4_panda_vaux3,
>  	.usb		= &omap4_usbphy_data,
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
