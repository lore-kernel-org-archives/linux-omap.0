From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC v2 2/6] ARM: PRCM: split PRCM module init to their own
 driver files
Date: Mon, 16 Jun 2014 04:48:05 -0700
Message-ID: <20140616114805.GF17845@atomide.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1401274255-16845-1-git-send-email-archit@ti.com>
 <1401274255-16845-3-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21887 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751039AbaFPLsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Jun 2014 07:48:09 -0400
Content-Disposition: inline
In-Reply-To: <1401274255-16845-3-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org

* Archit Taneja <archit@ti.com> [140528 03:53]:
> Currently, clock providers coming from CM, PRM, and SCRM are all initialized in
> prm_common.c.
> 
> Move the DT-match tables to their respective files, and create separate init
> functions for each module.
> 
> Originally worked on by: Tero Kristo <t-kristo@ti.com>
> 
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Archit Taneja <archit@ti.com>
> ---
>  arch/arm/mach-omap2/cm_common.c   | 18 ++++++++++++++
>  arch/arm/mach-omap2/control.c     | 15 +++++++++++
>  arch/arm/mach-omap2/control.h     |  1 +
>  arch/arm/mach-omap2/io.c          |  4 +++
>  arch/arm/mach-omap2/prcm-common.h |  5 ++++
>  arch/arm/mach-omap2/prm_common.c  | 52 +++++++++++++++++++++++----------------
>  6 files changed, 74 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
> index 40b3b5a..8506990 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/errno.h>
> +#include <linux/of.h>
>  
>  #include "cm2xxx.h"
>  #include "cm3xxx.h"
> @@ -138,3 +139,20 @@ int cm_unregister(struct cm_ll_data *cld)
>  
>  	return 0;
>  }
> +
> +static struct of_device_id omap_cm_dt_match_table[] = {
> +	{ .compatible = "ti,omap3-cm" },
> +	{ .compatible = "ti,omap4-cm1" },
> +	{ .compatible = "ti,omap4-cm2" },
> +	{ .compatible = "ti,omap5-cm-core-aon" },
> +	{ .compatible = "ti,omap5-cm-core" },
> +	{ .compatible = "ti,dra7-cm-core-aon" },
> +	{ .compatible = "ti,dra7-cm-core" },
> +	{ }
> +};
> +
> +
> +int __init of_cm_init(void)
> +{
> +	return of_prcm_module_init(omap_cm_dt_match_table);
> +}
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 44bb4d5..12cd736 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -581,3 +581,18 @@ void omap3_ctrl_set_iva_bootmode_idle(void)
>  			 OMAP343X_CONTROL_IVA2_BOOTMOD);
>  }
>  #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
> +
> +static struct of_device_id omap_scrm_dt_match_table[] = {
> +	{ .compatible = "ti,am3-scrm" },
> +	{ .compatible = "ti,am4-scrm" },
> +	{ .compatible = "ti,omap2-scrm" },
> +	{ .compatible = "ti,omap3-scrm" },
> +	{ .compatible = "ti,omap4-scrm" },
> +	{ .compatible = "ti,omap5-scrm" },
> +	{ }
> +};
> +
> +int __init of_scrm_init(void)
> +{
> +	return of_prcm_module_init(omap_scrm_dt_match_table);
> +}

I think you may be able to leave out this driver like code
from arch/arm/mach-omap2 by using the existing syscon mapping
we have in the .dtsi files? See for example how the PBIAS
is using the syscon in drivers/regulator/pbias-regulator.c.

If the clock registers don't fall into the existing SCM syscon
area, we can also set up more syscon areas.

Regards,

Tony
