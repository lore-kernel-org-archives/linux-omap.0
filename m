From: Mike Turquette <mturquette@ti.com>
Subject: Re: [PATCH] Registering sgx device and it's platform specific data
Date: Fri, 26 Mar 2010 12:02:03 -0500
Message-ID: <4BACE88B.8040303@ti.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBED02@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53094 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750795Ab0CZRCH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Mar 2010 13:02:07 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o2QH26S7028297
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Mar 2010 12:02:06 -0500
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBED02@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Agarwal, Preshit wrote:
> In this patch SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through 
> omap_pm_set_min_bus_tput.
> This patch removes the requirement of EXPORT_SYMBOL for the omap_pm_set_min_bus_tput
> function.
> 
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c                  |   26 ++++++++++++++++++++++-
>  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   13 ++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 7131d8d..32a06b6 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -26,7 +26,7 @@
>  #include <plat/mux.h>
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
> -
> +#include <mach/omap_sgxdef.h>

It is best to maintain the original whitespace.

>  #include "mux.h"
>  
>  #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
> @@ -773,6 +773,28 @@ static inline void omap_hdq_init(void)
>  static inline void omap_hdq_init(void) {}
>  #endif
>  
> +struct sgx_platform_data omap_sgx_data = {
> +	.set_min_bus_tput = omap_pm_set_min_bus_tput,
> +};
> +
> +static struct platform_device powervr_device = {
> +	.name            = "pvrsrvkm",
> +	.id              = -1,
> +#ifdef CONFIG_PM
> +	.dev            = {
> +	.platform_data = &omap_sgx_data,
> +       }
> +#else
> +	.dev            = {
> +	.platform_data = NULL,}
> +#endif
> +};
> +static void omap_init_sgx(void)
> +{
> +       (void) platform_device_register(&powervr_device);
> +}
> +
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int __init omap2_init_devices(void)
> @@ -787,7 +809,7 @@ static int __init omap2_init_devices(void)
>  	omap_hdq_init();
>  	omap_init_sti();
>  	omap_init_sha1_md5();
> -
> +	omap_init_sgx();

Same whitespace issue as above.

Regards,
Mike

>  	return 0;
>  }
>  arch_initcall(omap2_init_devices);
> diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> new file mode 100644
> index 0000000..08e24bb
> --- /dev/null
> +++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> @@ -0,0 +1,13 @@
> +#ifndef OMAP_SGXDEF_H
> +#define OMAP_SGXDEF_H
> +
> +#include <plat/omap-pm.h>
> +
> +#ifdef CONFIG_PM
> +struct sgx_platform_data {
> +	void(*set_min_bus_tput)(struct device *dev, u8 agent_id,
> +							unsigned long r);
> +};
> +
> +#endif
> +#endif

