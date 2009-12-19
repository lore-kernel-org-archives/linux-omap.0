From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCH v2 4/4] OMAP OPP: hide struct omap_opp internals in OPP
 layer implementation
Date: Sat, 19 Dec 2009 17:34:38 +0530
Message-ID: <4B2CC156.1010501@ti.com>
References: <1261177539-15429-1-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-2-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-3-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-4-git-send-email-khilman@deeprootsystems.com> <1261177539-15429-5-git-send-email-khilman@deeprootsystems.com>
Reply-To: nm@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45659 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbZLSMEl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Dec 2009 07:04:41 -0500
In-Reply-To: <1261177539-15429-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin Hilman said the following on 12/19/2009 04:35 AM:
> Now that we have accessor/helper functions for all the OPP layer
> details, move 'struct omap_opp' into the OPP layer so no direct
> accesses to OPP internals can be done.
>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/include/plat/opp.h |   19 +------------------
>  arch/arm/plat-omap/opp.c              |   19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
> index 6fe574c..9f91ad3 100644
> --- a/arch/arm/plat-omap/include/plat/opp.h
> +++ b/arch/arm/plat-omap/include/plat/opp.h
> @@ -17,24 +17,7 @@ extern struct omap_opp *mpu_opps;
>  extern struct omap_opp *dsp_opps;
>  extern struct omap_opp *l3_opps;
>  
> -/**
> - * struct omap_opp - OMAP OPP description structure
> - * @enabled:	true/false - marking this OPP as enabled/disabled
> - * @rate:	Frequency in hertz
> - * @opp_id:	(DEPRECATED) opp identifier
> - * @u_volt:     minimum microvolts DC required for this OPP to function
> - *
> - * This structure stores the OPP information for a given domain.
> - * Due to legacy reasons, this structure is currently exposed and
> - * will soon be removed elsewhere and will only be used as a handle
> - * from the OPP internal referencing mechanism
> - */
> -struct omap_opp {
> -	bool enabled;
> -	unsigned long rate;
> -	unsigned long u_volt;
> -	u8 __deprecated opp_id;
> -};
> +struct omap_opp;
>  
>  /**
>   * opp_get_voltage() - Gets the voltage corresponding to an opp
> diff --git a/arch/arm/plat-omap/opp.c b/arch/arm/plat-omap/opp.c
> index 4f7fa22..4fe1933 100644
> --- a/arch/arm/plat-omap/opp.c
> +++ b/arch/arm/plat-omap/opp.c
> @@ -19,6 +19,25 @@
>  #include <plat/opp_twl_tps.h>
>  #include <plat/opp.h>
>  
> +/**
> + * struct omap_opp - OMAP OPP description structure
> + * @enabled:	true/false - marking this OPP as enabled/disabled
> + * @rate:	Frequency in hertz
> + * @opp_id:	(DEPRECATED) opp identifier
> + * @u_volt:     minimum microvolts DC required for this OPP to function
> + *
> + * This structure stores the OPP information for a given domain.
> + * Due to legacy reasons, this structure is currently exposed and
> + * will soon be removed elsewhere and will only be used as a handle
> + * from the OPP internal referencing mechanism
> + */
> +struct omap_opp {
> +	bool enabled;
> +	unsigned long rate;
> +	unsigned long u_volt;
> +	u8 opp_id;
> +};
> +
>  /*
>   * DEPRECATED: Meant to detect end of opp array
>   * This is meant to help co-exist with current SRF etc
>   
big time ACK if we can fix the 2/3 patch
Acked-by: Nishanth Menon <nm@ti.com>
Thanks.

Regards,
Nishanth Menon

