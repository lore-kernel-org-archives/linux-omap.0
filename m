From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4] OMAP3: Registering sgx device and it's platform data
Date: Fri, 14 May 2010 09:40:13 -0700
Message-ID: <87vdaqmo7m.fsf@deeprootsystems.com>
References: <1273727200-4811-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37649 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab0ENQkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 12:40:17 -0400
Received: by pvh1 with SMTP id 1so619200pvh.19
        for <linux-omap@vger.kernel.org>; Fri, 14 May 2010 09:40:16 -0700 (PDT)
In-Reply-To: <1273727200-4811-1-git-send-email-manjugk@ti.com> (Manjunatha GK's message of "Thu\, 13 May 2010 10\:36\:40 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Manjunatha GK <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Preshit Agarwal <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Mike Turquette <mturquette@ti.com>, Hemanth V <hemanthv@ti.com>

Manjunatha GK <manjugk@ti.com> writes:

> The SGX powervr_device is registered with it's platform specific
> data to provide information about setting constraint through
> omap_pm_set_min_bus_tput.

Now the patch content doesn't match the description as you no
longer call omap_pm_set_min_bus_tput()...

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

When I suggested you remove the #ifdef CONFIG_PM, I was expecting
you to leave the omap_pm_set_min_bus_tput() part.

The point was that the driver itself should choose whether or not to call
pdata->set_min_bus_tput() using #ifdef or other runtime decisions.

Kevin
