From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v4] OMAP3: Registering sgx device and it's platform data
Date: Thu, 13 May 2010 10:32:01 -0500
Message-ID: <4BEC1B71.3070204@ti.com>
References: <1273727200-4811-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab0EMPcK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 11:32:10 -0400
In-Reply-To: <1273727200-4811-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>

G, Manjunath Kondaiah had written, on 05/13/2010 12:06 AM, the following:
> The SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through
> omap_pm_set_min_bus_tput.
> 
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Mike Turquette <mturquette@ti.com>
> Cc: Hemanth V <hemanthv@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c                  |   21 +++++++++++++++++++--
>  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 +++++++++++
>  2 files changed, 30 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2271b9b..6349ee5 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -26,7 +26,7 @@
>  #include <plat/mux.h>
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
> -
> +#include <mach/omap_sgxdef.h>
>  #include "mux.h"
>  
>  #if defined(CONFIG_VIDEO_OMAP2) || defined(CONFIG_VIDEO_OMAP2_MODULE)
> @@ -786,6 +786,23 @@ static inline void omap_hdq_init(void)
>  static inline void omap_hdq_init(void) {}
>  #endif
>  
> +struct sgx_platform_data omap_sgx_data = {
> +	.set_min_bus_tput = NULL,
> +};
> +
> +static struct platform_device powervr_device = {
> +	.name            = "pvrsrvkm",
> +	.id              = -1,
> +	.dev            = {
> +	.platform_data = &omap_sgx_data,
> +       }
> +};
> +
> +static void omap_init_sgx(void)
> +{
> +       (void) platform_device_register(&powervr_device);
> +}
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int __init omap2_init_devices(void)
> @@ -800,7 +817,7 @@ static int __init omap2_init_devices(void)
>  	omap_hdq_init();
>  	omap_init_sti();
>  	omap_init_sha1_md5();
> -
> +	omap_init_sgx();
should'nt we depend on has_sgx_feature?
>  	return 0;
>  }
>  arch_initcall(omap2_init_devices);
> diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> new file mode 100644
> index 0000000..e03ad8b
> --- /dev/null
> +++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> @@ -0,0 +1,11 @@
> +#ifndef OMAP_SGXDEF_H
> +#define OMAP_SGXDEF_H
> +
> +#include <plat/omap-pm.h>
> +
> +struct sgx_platform_data {
> +	void (*set_min_bus_tput)(struct device *dev, u8 agent_id,
> +				unsigned long r);
> +};
> +
> +#endif


-- 
Regards,
Nishanth Menon
