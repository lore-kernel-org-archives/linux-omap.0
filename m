From: Nishanth Menon <nm@ti.com>
Subject: Re: [PM-WIP-OPP][PATCH] OMAP3630 PM: Update for OPP 1GHz
Date: Tue, 6 Apr 2010 10:58:16 -0500
Message-ID: <4BBB5A18.4090406@ti.com>
References: <> <1270577169-8831-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42158 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752218Ab0DFP6R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Apr 2010 11:58:17 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o36FwGSp022784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 10:58:17 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o36FwGCW002515
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 10:58:16 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o36FwGdG022688
	for <linux-omap@vger.kernel.org>; Tue, 6 Apr 2010 10:58:16 -0500 (CDT)
In-Reply-To: <1270577169-8831-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sripathy, Vishwanath had written, on 04/06/2010 01:06 PM, the following:
> It is found that system is not very stable with current 1GHz OPP configuration 
> (ARM@1G, IVA@880M, VDD1@1.31V) and it has been recommended to 
> use below configuration for stable 1GHz OPP. 
> (ARM@1G, IVA@800M, VDD1@1.35V).
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> ---
> diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/cpufreq34xx.c
> index c453ec5..189c42e
> --- a/arch/arm/mach-omap2/cpufreq34xx.c
> +++ b/arch/arm/mach-omap2/cpufreq34xx.c
> @@ -82,7 +82,7 @@ static struct omap_opp_def __initdata omap36xx_mpu_rate_table[] = {
>  	/* OPP3 - OPP-Turbo */
>  	OMAP_OPP_DEF(false, 800000000, 1260000),
>  	/* OPP4 - OPP-SB */
> -	OMAP_OPP_DEF(false, 1000000000, 1310000),
> +	OMAP_OPP_DEF(false, 1000000000, 1350000),
>  	/* Terminator */
>  	OMAP_OPP_DEF(0, 0, 0)
>  };
> @@ -104,7 +104,7 @@ static struct omap_opp_def __initdata omap36xx_dsp_rate_table[] = {
>  	/* OPP3 - OPP-Turbo */
>  	OMAP_OPP_DEF(false, 660000000, 1260000),
>  	/* OPP4 - OPP-SB */
> -	OMAP_OPP_DEF(false, 875000000, 1310000),
> +	OMAP_OPP_DEF(false, 800000000, 1350000),
>  	/* Terminator */
>  	OMAP_OPP_DEF(0, 0, 0)
>  };

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
