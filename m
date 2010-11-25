From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 3/3] OMAP3: remove OPP interfaces from OMAP PM layer
Date: Wed, 24 Nov 2010 19:08:46 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1011241908350.20215@utopia.booyaka.com>
References: <1290617647-3604-1-git-send-email-nm@ti.com> <1290617647-3604-4-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53127 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754332Ab0KYCIs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Nov 2010 21:08:48 -0500
In-Reply-To: <1290617647-3604-4-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Benoit <b-cousson@ti.com>, Tony <tony@atomide.com>, Kevin <khilman@deeprootsystems.com>, Thomas <thomas.petazzoni@free-electrons.com>

On Wed, 24 Nov 2010, Nishanth Menon wrote:

> From: Kevin Hilman <khilman@deeprootsystems.com>
> 
> With new OPP layer, OPP users will access OPP API directly instead of
> using OMAP PM layer, so remove all notions of OPPs from the OMAP PM
> layer.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

> ---
> 
> posted for completeness sake - no change involved
> v3: no longer explicitly calling the init_table, instead
>     depending on the device_initcall to initialize as needed
> 
> v2: https://patchwork.kernel.org/patch/266931/
> 
>  arch/arm/mach-omap2/io.c                  |    3 +-
>  arch/arm/plat-omap/include/plat/omap-pm.h |   31 +++++++++-------------------
>  arch/arm/plat-omap/omap-pm-noop.c         |   11 +---------
>  3 files changed, 12 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
> index 40562dd..2fe4e02 100644
> --- a/arch/arm/mach-omap2/io.c
> +++ b/arch/arm/mach-omap2/io.c
> @@ -327,8 +327,7 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>  	else if (cpu_is_omap44xx())
>  		omap44xx_hwmod_init();
>  
> -	/* The OPP tables have to be registered before a clk init */
> -	omap_pm_if_early_init(mpu_opps, dsp_opps, l3_opps);
> +	omap_pm_if_early_init();
>  
>  	if (cpu_is_omap2420())
>  		omap2420_clk_init();
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
> index 728fbb9..62c3fe9 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -17,27 +17,10 @@
>  #include <linux/device.h>
>  #include <linux/cpufreq.h>
>  #include <linux/clk.h>
> +#include <linux/opp.h>
>  
>  #include "powerdomain.h"
>  
> -/**
> - * struct omap_opp - clock frequency-to-OPP ID table for DSP, MPU
> - * @rate: target clock rate
> - * @opp_id: OPP ID
> - * @min_vdd: minimum VDD1 voltage (in millivolts) for this OPP
> - *
> - * Operating performance point data.  Can vary by OMAP chip and board.
> - */
> -struct omap_opp {
> -	unsigned long rate;
> -	u8 opp_id;
> -	u16 min_vdd;
> -};
> -
> -extern struct omap_opp *mpu_opps;
> -extern struct omap_opp *dsp_opps;
> -extern struct omap_opp *l3_opps;
> -
>  /*
>   * agent_id values for use with omap_pm_set_min_bus_tput():
>   *
> @@ -59,9 +42,11 @@ extern struct omap_opp *l3_opps;
>   * framework starts.  The "_if_" is to avoid name collisions with the
>   * PM idle-loop code.
>   */
> -int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
> -				 struct omap_opp *dsp_opp_table,
> -				 struct omap_opp *l3_opp_table);
> +#ifdef CONFIG_OMAP_PM_NONE
> +#define omap_pm_if_early_init() 0
> +#else
> +int __init omap_pm_if_early_init(void);
> +#endif
>  
>  /**
>   * omap_pm_if_init - OMAP PM init code called after clock fw init
> @@ -69,7 +54,11 @@ int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
>   * The main initialization code.  OPP tables are passed in here.  The
>   * "_if_" is to avoid name collisions with the PM idle-loop code.
>   */
> +#ifdef CONFIG_OMAP_PM_NONE
> +#define omap_pm_if_init() 0
> +#else
>  int __init omap_pm_if_init(void);
> +#endif
>  
>  /**
>   * omap_pm_if_exit - OMAP PM exit code
> diff --git a/arch/arm/plat-omap/omap-pm-noop.c b/arch/arm/plat-omap/omap-pm-noop.c
> index e129ce8..ca75abb 100644
> --- a/arch/arm/plat-omap/omap-pm-noop.c
> +++ b/arch/arm/plat-omap/omap-pm-noop.c
> @@ -26,10 +26,6 @@
>  
>  #include <plat/powerdomain.h>
>  
> -struct omap_opp *dsp_opps;
> -struct omap_opp *mpu_opps;
> -struct omap_opp *l3_opps;
> -
>  /*
>   * Device-driver-originated constraints (via board-*.c files)
>   */
> @@ -308,13 +304,8 @@ int omap_pm_get_dev_context_loss_count(struct device *dev)
>  
>  
>  /* Should be called before clk framework init */
> -int __init omap_pm_if_early_init(struct omap_opp *mpu_opp_table,
> -				 struct omap_opp *dsp_opp_table,
> -				 struct omap_opp *l3_opp_table)
> +int __init omap_pm_if_early_init(void)
>  {
> -	mpu_opps = mpu_opp_table;
> -	dsp_opps = dsp_opp_table;
> -	l3_opps = l3_opp_table;
>  	return 0;
>  }
>  
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
