From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [RFC/PATCH 4/7] ARM: OMAP: AM35x: remove redunant cpu_is checks
 for AM3505
Date: Thu, 5 Jan 2012 11:06:54 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A8071945@DBDE01.ent.ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
 <1325726206-11199-5-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51048 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754932Ab2AELHB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Jan 2012 06:07:01 -0500
In-Reply-To: <1325726206-11199-5-git-send-email-khilman@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: Hilman, Kevin
> Sent: Thursday, January 05, 2012 6:47 AM
> To: linux-omap@vger.kernel.org
> Cc: Paul Walmsley; Hiremath, Vaibhav
> Subject: [RFC/PATCH 4/7] ARM: OMAP: AM35x: remove redunant cpu_is checks
> for AM3505
> 
> There are several checks for AM35x devices done using
> 
>       if (cpu_is_omap3517() || cpu_is_omap3505())
> 
> However, since the 3505 is just a 3517 without an SGX, the 3505 check
> is redundant because cpu_is_omap3517() will always be true whenever
> cpu_is_omap3505() is true.  From <plat/cpu.h>:
> 
>  #define cpu_is_omap3505() (cpu_is_omap3517() && !omap3_has_sgx())
> 
> Therefore, remove the redunant 3505 checks.  This helps move towards
> removal of SoC detection that depends on specific IP detection.
> 
I think this make complete sense and right candidate for upstream.

Thanks,
Vaibhav


> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c                   |    8 ++++----
>  arch/arm/mach-omap2/usb-musb.c                |    2 +-
>  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index bd844af..c49a91d 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -353,7 +353,7 @@ static int __init omap_hsmmc_pdata_init(struct
> omap2_hsmmc_info *c,
>  	 *
>  	 * temporary HACK: ocr_mask instead of fixed supply
>  	 */
> -	if (cpu_is_omap3505() || cpu_is_omap3517())
> +	if (cpu_is_omap3517())
>  		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |
>  					 MMC_VDD_26_27 |
>  					 MMC_VDD_27_28 |
> @@ -363,7 +363,7 @@ static int __init omap_hsmmc_pdata_init(struct
> omap2_hsmmc_info *c,
>  	else
>  		mmc->slots[0].ocr_mask = c->ocr_mask;
> 
> -	if (!cpu_is_omap3517() && !cpu_is_omap3505())
> +	if (!cpu_is_omap3517())
>  		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
> 
>  	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
> @@ -386,7 +386,7 @@ static int __init omap_hsmmc_pdata_init(struct
> omap2_hsmmc_info *c,
>  			}
>  		}
> 
> -		if (cpu_is_omap3517() || cpu_is_omap3505())
> +		if (cpu_is_omap3517())
>  			mmc->slots[0].set_power = nop_mmc_set_power;
> 
>  		/* OMAP3630 HSMMC1 supports only 4-bit */
> @@ -398,7 +398,7 @@ static int __init omap_hsmmc_pdata_init(struct
> omap2_hsmmc_info *c,
>  		}
>  		break;
>  	case 2:
> -		if (cpu_is_omap3517() || cpu_is_omap3505())
> +		if (cpu_is_omap3517())
>  			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
> 
>  		if (c->ext_clock)
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
> index 8d5ed77..bf33b4d 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -90,7 +90,7 @@ void __init usb_musb_init(struct omap_musb_board_data
> *musb_board_data)
>  	musb_plat.mode = board_data->mode;
>  	musb_plat.extvbus = board_data->extvbus;
> 
> -	if (cpu_is_omap3517() || cpu_is_omap3505()) {
> +	if (cpu_is_omap3517()) {
>  		oh_name = "am35x_otg_hs";
>  		name = "musb-am35x";
>  	} else if (cpu_is_ti81xx()) {
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> index c005e2f..bdb82f1 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -116,7 +116,7 @@ void __init omap3xxx_voltagedomains_init(void)
>  		omap3_voltdm_core.volt_data = omap34xx_vddcore_volt_data;
>  	}
> 
> -	if (cpu_is_omap3517() || cpu_is_omap3505())
> +	if (cpu_is_omap3517())
>  		voltdms = voltagedomains_am35xx;
>  	else
>  		voltdms = voltagedomains_omap3;
> --
> 1.7.8.2

