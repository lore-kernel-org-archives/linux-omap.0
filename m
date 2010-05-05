From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2] OMAP3: Registering sgx device and it's platform data
Date: Wed, 5 May 2010 14:54:49 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F8C7157@dbde02.ent.ti.com>
References: <1272988786-2005-1-git-send-email-manjugk@ti.com>
 <1272988786-2005-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60533 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934205Ab0EEJY4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 05:24:56 -0400
In-Reply-To: <1272988786-2005-2-git-send-email-manjugk@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>



> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of G, 
> Manjunath Kondaiah
> Sent: Tuesday, May 04, 2010 9:30 PM
> To: linux-omap@vger.kernel.org
> Cc: Agarwal, Preshit; Tony Lindgren; Kevin Hilman; Turquette, 
> Mike; V, Hemanth
> Subject: [PATCH v2] OMAP3: Registering sgx device and it's 
> platform data
> 
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
>  arch/arm/mach-omap2/devices.c                  |   26 
> ++++++++++++++++++++++-
>  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 ++++++++++
>  2 files changed, 35 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> 
> diff --git a/arch/arm/mach-omap2/devices.c 
> b/arch/arm/mach-omap2/devices.c
> index 2271b9b..b624f13 100644
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
> @@ -786,6 +786,28 @@ static inline void omap_hdq_init(void)
>  static inline void omap_hdq_init(void) {}
>  #endif
>  
> +struct sgx_platform_data omap_sgx_data = {
> +#ifdef CONFIG_PM
> +	.set_min_bus_tput = omap_pm_set_min_bus_tput,
> +#else
> +	.set_min_bus_tput = NULL;

This seems to be breaking build if we disable the PM. 
I will fix it and post the next version.

-Manjunath

