From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap: Add macros to evaluate cpu revision
Date: Wed, 21 Jul 2010 10:23:07 -0500
Message-ID: <4C4710DB.6060901@ti.com>
References: <1279725163-3481-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41773 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752517Ab0GUPXJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Jul 2010 11:23:09 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6LFN8om005899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 10:23:08 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o6LFN74G029823
	for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 10:23:07 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id o6LFN7cA015858
	for <linux-omap@vger.kernel.org>; Wed, 21 Jul 2010 10:23:07 -0500 (CDT)
In-Reply-To: <1279725163-3481-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Premi, Sanjeev had written, on 07/21/2010 10:12 AM, the following:
> This patch adds macros to evaluate the cpu revision.
> These macros increase readability by reducing the
> repetitive code when multiple silicon and their
> revisions have to be tested.
> 
> Example usage would be:
>   if (cpu_rev_eq(omap34xx, ES_1_0))
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/plat-omap/include/plat/cpu.h |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
> index aa2f4f0..14b1a44 100644
> --- a/arch/arm/plat-omap/include/plat/cpu.h
> +++ b/arch/arm/plat-omap/include/plat/cpu.h
> @@ -70,6 +70,7 @@ unsigned int omap_rev(void);
>  #define OMAP_REVBITS_20		0x20
>  #define OMAP_REVBITS_30		0x30
>  #define OMAP_REVBITS_40		0x40
> +#define OMAP_REVBITS_50		0x50
>  
>  /*
>   * Get the CPU revision for OMAP devices
> @@ -460,4 +461,35 @@ OMAP3_HAS_FEATURE(isp, ISP)
>  OMAP3_HAS_FEATURE(192mhz_clk, 192MHZ_CLK)
>  OMAP3_HAS_FEATURE(io_wakeup, IO_WAKEUP)
>  
> +/*
> + * Map revision bits to silicon specific revisions
> + */
> +#define ES_1_0		OMAP_REVBITS_00
probably need ES_1_1, 1_2 (considering 3630)
> +#define ES_2_0		OMAP_REVBITS_10
> +#define ES_2_1		OMAP_REVBITS_20
makes sense to go to 2_2
> +#define ES_3_0		OMAP_REVBITS_30
> +#define ES_3_1		OMAP_REVBITS_40
> +#define ES_3_1_2	OMAP_REVBITS_50
3_2?

> +
> +/*
> + * Macros to evaluate CPU revision
> + */
> +#define cpu_rev_lt(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() < (rev))) ? 1 : 0)
> +
> +#define cpu_rev_le(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() <= (rev))) ? 1 : 0)
> +
> +#define cpu_rev_eq(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() == (rev))) ? 1 : 0)
> +
> +#define cpu_rev_ne(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() != (rev))) ? 1 : 0)
> +
> +#define cpu_rev_ge(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() >= (rev))) ? 1 : 0)
> +
> +#define cpu_rev_gt(cpu,rev)	\
> +	((cpu_is_omap ##cpu() && (GET_OMAP_REVISION() > (rev))) ? 1 : 0)
> +
>  #endif


-- 
Regards,
Nishanth Menon
