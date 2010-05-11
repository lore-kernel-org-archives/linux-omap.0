From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v3] OMAP3: Registering sgx device and it's platform data
Date: Tue, 11 May 2010 07:57:20 -0700
Message-ID: <87hbmeeban.fsf@deeprootsystems.com>
References: <1273560899-4449-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48177 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471Ab0EKO5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 10:57:25 -0400
Received: by pva18 with SMTP id 18so15890pva.19
        for <linux-omap@vger.kernel.org>; Tue, 11 May 2010 07:57:24 -0700 (PDT)
In-Reply-To: <1273560899-4449-1-git-send-email-manjugk@ti.com> (Manjunatha GK's message of "Tue\, 11 May 2010 12\:24\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Preshit Agarwal <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@ti.com>, Hemanth V <hemanthv@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

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
>  arch/arm/mach-omap2/devices.c                  |   26 ++++++++++++++++++++++-
>  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 ++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 20fa76e..aabbf7b 100644
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
> @@ -791,6 +791,28 @@ static inline void omap_hdq_init(void)
>  static inline void omap_hdq_init(void) {}
>  #endif
>  
> +struct sgx_platform_data omap_sgx_data = {
> +#ifdef CONFIG_PM
> +	.set_min_bus_tput = omap_pm_set_min_bus_tput,
> +#else
> +	.set_min_bus_tput = NULL,
> +#endif

Please explain why this should be dependent on CONFIG_PM?

I suspect you should be making these kinds of decisions in the driver
itself, not in device init.

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
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int __init omap2_init_devices(void)
> @@ -805,7 +827,7 @@ static int __init omap2_init_devices(void)
>  	omap_hdq_init();
>  	omap_init_sti();
>  	omap_init_sha1_md5();
> -
> +	omap_init_sgx();
>  	return 0;
>  }
>  arch_initcall(omap2_init_devices);
> diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> new file mode 100644
> index 0000000..5d90a6a
> --- /dev/null
> +++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> @@ -0,0 +1,11 @@
> +#ifndef OMAP_SGXDEF_H
> +#define OMAP_SGXDEF_H
> +
> +#include <plat/omap-pm.h>
> +
> +struct sgx_platform_data {
> +	void(*set_min_bus_tput)(struct device *dev, u8 agent_id,

need a space after 'void' and before '('
           
> +							unsigned long r);

minor nit: you could drop a tab of 3 for nicer looking alignment 

Kevin
