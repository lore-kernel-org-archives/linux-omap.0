From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH 9/9] ARM: OMAP4: PM: Now remove L4 per clockdomain static depedency with MPU
Date: Wed, 27 Mar 2013 11:46:50 -0700
Message-ID: <87zjxo65ph.fsf@linaro.org>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
	<1361373527-21695-10-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f50.google.com ([209.85.210.50]:62009 "EHLO
	mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753579Ab3C0Sqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 27 Mar 2013 14:46:54 -0400
Received: by mail-da0-f50.google.com with SMTP id t1so2685539dae.9
        for <linux-omap@vger.kernel.org>; Wed, 27 Mar 2013 11:46:53 -0700 (PDT)
In-Reply-To: <1361373527-21695-10-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Wed, 20 Feb 2013 20:48:47 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> UART driver slave idle issue has been taken care by driver using hwmod
> framework.
>
> So we can now ger rid off the L4 per clockdomain static dependency with
> MPU which was used to wrok around UART wakeup and console sluggishnesh issue
> on OMAP4 SOCs.
>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Nice.

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/pm44xx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 1fd9662..1d03110 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -134,7 +134,7 @@ int __init omap4_pm_init(void)
>  {
>  	int ret;
>  	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
> -	struct clockdomain *ducati_clkdm, *l3_2_clkdm, *l4_per_clkdm;
> +	struct clockdomain *ducati_clkdm, *l3_2_clkdm;
>  
>  	if (omap_rev() == OMAP4430_REV_ES1_0) {
>  		WARN(1, "Power Management not supported on OMAP4430 ES1.0\n");
> @@ -159,16 +159,14 @@ int __init omap4_pm_init(void)
>  	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
>  	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
>  	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
> -	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
>  	ducati_clkdm = clkdm_lookup("ducati_clkdm");
>  	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
> -		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
> +		(!l3_2_clkdm) || (!ducati_clkdm))
>  		goto err2;
>  
>  	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
> -	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
>  	if (ret) {
