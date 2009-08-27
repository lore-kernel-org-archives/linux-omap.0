From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH] OMAP3: PM: Fix for MPU power domain MEM BANK position
Date: Thu, 27 Aug 2009 12:39:41 -0500
Message-ID: <A24693684029E5489D1D202277BE89444BE28394@dlee02.ent.ti.com>
References: <1251391660-10327-1-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751569AbZH0Rfp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 13:35:45 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7RHZgZ6025614
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 12:35:47 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n7RHZfNu029016
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 12:35:42 -0500 (CDT)
Received: from dlee75.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n7RHZfkS001830
	for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 12:35:41 -0500 (CDT)
In-Reply-To: <1251391660-10327-1-git-send-email-thara@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Gopinath, Thara" <thara@ti.com>

Thara,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Thara Gopinath
> Sent: Thursday, August 27, 2009 11:48 AM
> To: linux-omap@vger.kernel.org
> Cc: Gopinath, Thara
> Subject: [PATCH] OMAP3: PM: Fix for MPU power domain MEM BANK position
> 
> MPU power domain bank 0 bits are displayed in position of bank 1
> in PWRSTS and PREPWRSTS registers. So read them from correct
> position
> 
> Signed-off-by: Thara Gopinath <thara@ti.com>
> ---
>  arch/arm/mach-omap2/powerdomain.c |   19 +++++++++++++++++++
>  1 files changed, 19 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-
> omap2/powerdomain.c
> index 2594cbf..6c5fee9 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -971,6 +971,16 @@ int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm,
> u8 bank)
>  		return -EEXIST;
> 
>  	/*
> +	 * In 3430, for MPU domain bank 0 status bits
> +	 * are displayed in the position of bank1 status bits
> +	 * in PWST  . So the hack. Think of a cleaner
> +	 * way of doing this
> +	 */
> +	if (cpu_is_omap34xx)

AFAIK, above should be:

	if (cpu_is_omap34xx())

Instead, which is how it's being used everywhere else in the kernel.

> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> +			bank = 1;
> +
> +	/*
>  	 * The register bit names below may not correspond to the
>  	 * actual names of the bits in each powerdomain's register,
>  	 * but the type of value returned is the same for each
> @@ -1018,6 +1028,15 @@ int pwrdm_read_prev_mem_pwrst(struct powerdomain
> *pwrdm, u8 bank)
>  		return -EEXIST;
> 
>  	/*
> +	 * In 3430, for MPU domain bank 0 status bits
> +	 * are displayed in the position of bank1 status bits
> +	 * in PREPWST  . So the hack. Think of a cleaner
> +	 * way of doing this
> +	 */
> +	if (cpu_is_omap34xx)

Same here.

Regards,
Sergio
> +		if (!strcmp("mpu_pwrdm", pwrdm->name))
> +			bank = 1;
> +	/*
>  	 * The register bit names below may not correspond to the
>  	 * actual names of the bits in each powerdomain's register,
>  	 * but the type of value returned is the same for each
> --
> 1.5.4.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

