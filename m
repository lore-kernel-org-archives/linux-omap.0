From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH 1/2] OMAP3+: PM: VP: use uV for max and min voltage limits
Date: Fri, 03 Jun 2011 09:51:35 -0700
Message-ID: <87pqmug8o8.fsf@ti.com>
References: <1306827232-27728-1-git-send-email-nm@ti.com>
	<1306827232-27728-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:52904 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750965Ab1FCQvi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 12:51:38 -0400
Received: by mail-px0-f182.google.com with SMTP id 20so1529659pxi.27
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 09:51:37 -0700 (PDT)
In-Reply-To: <1306827232-27728-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Tue, 31 May 2011 02:33:51 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Every PMIC has it's own eccentricities, For example, one of the
> PMIC has MSB set to 1 for a specific function - voltage enable!
> using an hardcoded value specific for TWL when copied over to
> such an implementation causes the system to crash as the MSB bit
> was 0 and the voltage got disabled!.
>
> Instead we use actual values and depend on the convertion routines
> to abstract out the eccentricities of each PMIC.
>
> With this, we can now move the voltages to a common location in
> voltage.h as they are no longer dependent on PMICs and expect the
> PMIC's conversion routines to set a cap if the voltage is out of
> reach for the PMIC.
>
> Reported-by: Jon Hunter <jon-hunter@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Nice.

Minor comment for consideration while you're update this work...

[...]

> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
> index f079167..7366793 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -109,6 +109,24 @@ struct omap_volt_data {
>  	u8	vp_errgain;
>  };
>  
> +/* Min and max voltages from OMAP perspective */
> +#define OMAP3430_VP1_VLIMITTO_VDDMIN	850000
> +#define OMAP3430_VP1_VLIMITTO_VDDMAX	1425000
> +#define OMAP3430_VP2_VLIMITTO_VDDMIN	900000
> +#define OMAP3430_VP2_VLIMITTO_VDDMAX	1150000
> +
> +#define OMAP3630_VP1_VLIMITTO_VDDMIN	900000
> +#define OMAP3630_VP1_VLIMITTO_VDDMAX	1350000
> +#define OMAP3630_VP2_VLIMITTO_VDDMIN	900000
> +#define OMAP3630_VP2_VLIMITTO_VDDMAX	1200000
> +
> +#define OMAP4_VP_MPU_VLIMITTO_VDDMIN	830000
> +#define OMAP4_VP_MPU_VLIMITTO_VDDMAX	1410000
> +#define OMAP4_VP_IVA_VLIMITTO_VDDMIN	830000
> +#define OMAP4_VP_IVA_VLIMITTO_VDDMAX	1260000
> +#define OMAP4_VP_CORE_VLIMITTO_VDDMIN	830000
> +#define OMAP4_VP_CORE_VLIMITTO_VDDMAX	1200000
> +

Plese reference what doc/TRM/appnote etc. these values come from.

Kevin
