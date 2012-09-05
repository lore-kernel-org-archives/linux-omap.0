From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v8 2/3] ARM: OMAP2+: gpmc: Adapt to HWMOD
Date: Wed, 5 Sep 2012 14:55:23 -0500
Message-ID: <5047AE2B.30807@ti.com>
References: <cover.1346846464.git.afzal@ti.com> <c14607ff57fca419dc9d7e0beaea197e001f4e25.1346846464.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46282 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754648Ab2IETz1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 15:55:27 -0400
In-Reply-To: <c14607ff57fca419dc9d7e0beaea197e001f4e25.1346846464.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 09/05/2012 07:37 AM, Afzal Mohammed wrote:
> Create API for platforms to adapt GPMC to HWMOD
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index dbc1ebc..c45f185 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -29,11 +29,14 @@
>  
>  #include <plat/gpmc.h>
>  #include <plat/sdrc.h>
> +#include <plat/omap_device.h>
>  
>  #include "soc.h"
>  
>  #include "common.h"
>  
> +#define	DEVICE_NAME		"omap-gpmc"
> +
>  /* GPMC register offsets */
>  #define GPMC_REVISION		0x00
>  #define GPMC_SYSCONFIG		0x10
> @@ -897,6 +900,29 @@ static int __init gpmc_init(void)
>  }
>  postcore_initcall(gpmc_init);
>  
> +static int __init omap_gpmc_init(void)
> +{
> +	struct omap_hwmod *oh;
> +	struct platform_device *pdev;
> +	char *oh_name = "gpmc";
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
> +		return -ENODEV;
> +	}
> +
> +	pdev = omap_device_build(DEVICE_NAME, -1, oh, NULL, 0, NULL, 0, 0);
> +	if (IS_ERR(pdev)) {
> +		WARN(1, "Can't build omap_device for %s:%s.\n",
> +						DEVICE_NAME, oh->name);
> +		return PTR_ERR(pdev);
> +	}
> +
> +	return 0;

Nit-pick, I see some devices writing the above as ...

	WARN(IS_ERR(pdev), "could not build omap_device for %s\n", oh_name);

 	return IS_ERR(pdev) ? PTR_ERR(pdev) : 0;

> +}
> +postcore_initcall(omap_gpmc_init);
> +
>  static irqreturn_t gpmc_handle_irq(int irq, void *dev)
>  {
>  	int i;
> 

Otherwise ...

Reviewed-by: Jon Hunter <jon-hunter@ti.com>

Cheers
Jon
