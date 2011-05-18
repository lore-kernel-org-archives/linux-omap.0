From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP/voltdm_c][PATCH 07/11] OMAP4: PM: TWL6030: fix voltage conversion formula
Date: Wed, 18 May 2011 11:38:38 +0200
Message-ID: <877h9owdpd.fsf@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
	<1305695854-9638-8-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:55773 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756036Ab1ERJix (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 05:38:53 -0400
Received: by wyb28 with SMTP id 28so1554506wyb.22
        for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 02:38:51 -0700 (PDT)
In-Reply-To: <1305695854-9638-8-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 00:17:30 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Patrick Titiano <p-titiano@ti.com>

Nishanth Menon <nm@ti.com> writes:

> From: Patrick Titiano <p-titiano@ti.com>
>
> omap_twl_vsel_to_uv() and omap_twl_uv_to_vsel() functions used to convert
> voltages to TWL6030 SMPS commands (a.k.a "vsel") implement incorrect conversion
> formula.
> It uses legacy OMAP3 formula, but OMAP4 Power IC has different offset and
> voltage step:
>  - Voltage Step is now 12.66mV (instead of 12.5mV)
>  - Offset is either 607.7mV or 709mV depending on TWL6030 chip revision
>    (instead of 600mV)
> This leads to setting voltages potentially higher than expected, and so
> potentially some (limited) power overconsumption.
>
> For reference, see formula and tables in section 8.5.2.3
> "Output Voltage Selection (Standard Mode / Extended Mode with or without offset)"
>  in TWL6030 functional specifications document.
>
> [nm@ti.com: ported to voltdm_c]
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Patrick Titiano <p-titiano@ti.com>

Thanks, adding to voltdm queue.

Kevin

> ---
>  arch/arm/mach-omap2/omap_twl.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
> index 82a91be..78fd985 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -106,9 +106,9 @@ static unsigned long twl6030_vsel_to_uv(const u8 vsel)
>  		return 1350000;
>  
>  	if (smps_offset & 0x8)
> -		return ((((vsel - 1) * 125) + 7000)) * 100;
> +		return ((((vsel - 1) * 1266) + 70900)) * 10;
>  	else
> -		return ((((vsel - 1) * 125) + 6000)) * 100;
> +		return ((((vsel - 1) * 1266) + 60770)) * 10;
>  }
>  
>  static u8 twl6030_uv_to_vsel(unsigned long uv)
> @@ -138,9 +138,9 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
>  		return 0x3A;
>  
>  	if (smps_offset & 0x8)
> -		return DIV_ROUND_UP(uv - 700000, 12500) + 1;
> +		return DIV_ROUND_UP(uv - 709000, 12660) + 1;
>  	else
> -		return DIV_ROUND_UP(uv - 600000, 12500) + 1;
> +		return DIV_ROUND_UP(uv - 607700, 12660) + 1;
>  }
>  
>  static struct omap_voltdm_pmic omap3_mpu_pmic = {
> @@ -187,7 +187,7 @@ static struct omap_voltdm_pmic omap3_core_pmic = {
>  
>  static struct omap_voltdm_pmic omap4_mpu_pmic = {
>  	.slew_rate		= 4000,
> -	.step_size		= 12500,
> +	.step_size		= 12660,
>  	.on_volt		= 1350000,
>  	.onlp_volt		= 1350000,
>  	.ret_volt		= 837500,
> @@ -212,7 +212,7 @@ static struct omap_voltdm_pmic omap4_mpu_pmic = {
>  
>  static struct omap_voltdm_pmic omap4_iva_pmic = {
>  	.slew_rate		= 4000,
> -	.step_size		= 12500,
> +	.step_size		= 12660,
>  	.on_volt		= 1100000,
>  	.onlp_volt		= 1100000,
>  	.ret_volt		= 837500,
> @@ -237,7 +237,7 @@ static struct omap_voltdm_pmic omap4_iva_pmic = {
>  
>  static struct omap_voltdm_pmic omap4_core_pmic = {
>  	.slew_rate		= 4000,
> -	.step_size		= 12500,
> +	.step_size		= 12660,
>  	.on_volt		= 1100000,
>  	.onlp_volt		= 1100000,
>  	.ret_volt		= 837500,
