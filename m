From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH] Registering sgx device and it's platform specific data
Date: Fri, 26 Mar 2010 12:49:11 -0500
Message-ID: <72c9300b4f04ccdb0184d1595a257e2f@secure211.sgcpanel.com>
References: <19F8576C6E063C45BE387C64729E7394044DEBED02@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48318 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0CZRtE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 13:49:04 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394044DEBED02@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Agarwal, Preshit" <preshit.agarwal@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, 26 Mar 2010 16:03:26 +0530, "Agarwal, Preshit"
<preshit.agarwal@ti.com> wrote:
> In this patch SGX powervr_device is registered with it's platform
specific
> data to provide information about setting constraint through 
> omap_pm_set_min_bus_tput.
> This patch removes the requirement of EXPORT_SYMBOL for the
> omap_pm_set_min_bus_tput
> function.
> 
> Signed-off-by: Allen Pais <allen.pais@ti.com>
> Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> ---
>  arch/arm/mach-omap2/devices.c                  |   26
>  ++++++++++++++++++++++-
>  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   13 ++++++++++++
>  2 files changed, 37 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> 
> diff --git a/arch/arm/mach-omap2/devices.c
b/arch/arm/mach-omap2/devices.c
> index 7131d8d..32a06b6 100644
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

it would be better that you move the ifdef to the implementation
of omap_pm_set_min_bus_tput() and if I remember correctly,
you're supposed to provide your own user of omap_pm_set_min_bus_tput()
instead of just passing that to driver. So you would

#ifdef CONFIG_PM
static void omap_sgx_pm_constraints(struct device *dev)
{
	return omap_pm_set_min_bus_tput(dev, blablablabla);
}
#else
static inline void omap_sgx_pm_constrainsts(struct device *dev)
{  }
#endif

struct sgx_platform_data omap_sgx_data = {
	.set_min_bus_tput = omap_pm_set_min_bus_tput,
};

static struct platform_device powervr_device = {
	.name            = "pvrsrvkm",
	.id              = -1,
	.dev            = {
		.platform_data = &omap_sgx_data,
       },
};

-- 
balbi
