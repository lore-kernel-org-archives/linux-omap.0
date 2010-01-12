From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PM-WIP-OPP][PATCH] OPP: Introduces enum for addressing different OPP types
Date: Tue, 12 Jan 2010 09:19:28 -0800
Message-ID: <87iqb7fdgf.fsf@deeprootsystems.com>
References: <1263299979.1536.7.camel@boson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:51182 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754036Ab0ALRTb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 12:19:31 -0500
Received: by qw-out-2122.google.com with SMTP id 8so3402731qwh.37
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 09:19:31 -0800 (PST)
In-Reply-To: <1263299979.1536.7.camel@boson> (Romit Dasgupta's message of "Tue\, 12 Jan 2010 18\:09\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: romit@ti.com
Cc: nm@ti.com, linux-omap@vger.kernel.org

Romit Dasgupta <romit@ti.com> writes:

> Introduces enum for identifying OPP types. This helps in querying the OPP
> layer by passing the type of OPP (enum types) and gets away from maintaining
> the pointer to the OPP data list outside the OPP layer.
>
> Signed-off-by: Romit Dasgupta <romit@ti.com>

I like this idea... but I have some questions about how we should
cleanly handle SMP and future SoCs.

> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index 9f91ad3..c4d5bf9 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -13,9 +13,18 @@
>  #ifndef __ASM_ARM_OMAP_OPP_H
>  #define __ASM_ARM_OMAP_OPP_H
>  
> -extern struct omap_opp *mpu_opps;
> -extern struct omap_opp *dsp_opps;
> -extern struct omap_opp *l3_opps;
> +#ifdef CONFIG_ARCH_OMAP3
> +#define OPP_TYPES 3
> +#else
> +#error "You need to put the number of OPP types for OMAP chip type."
> +#endif

Rather than the #ifdef...
> +enum opp_t {
> +	OPP_NONE,
> +	OPP_MPU,
> +	OPP_L3,
> +	OPP_DSP

add OPP_MAX_TYPES here

> +};

And with that, how do you suggest handling SMP.  Do we assume that the
OPP_MPU OPPs are common across all CPUs?  Do we possibly need other 
types for other busses on future SoCs?

We don't need the answeres to all these questions today, but I'd like
to know your thoughts on how this would be extended or made SoC
specific.

Thanks,

Kevin
