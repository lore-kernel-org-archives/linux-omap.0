From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3/4] ARM: OMAP2+: Move iommu/iovmm headers to
 platform_data
Date: Mon, 15 Oct 2012 17:38:22 -0700
Message-ID: <20121016003821.GK15569@atomide.com>
References: <20121016003513.19701.71718.stgit@muffinssi.local>
 <20121016003640.19701.51749.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13669 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755454Ab2JPAi0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 20:38:26 -0400
Content-Disposition: inline
In-Reply-To: <20121016003640.19701.51749.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joerg.roedel@amd.com>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>, Mauro Carvalho Chehab <mchehab@redhat.com>

* Tony Lindgren <tony@atomide.com> [121015 17:38]:
> From: Ido Yariv <ido@wizery.com>
> 
> Move iommu/iovmm headers from plat/ to platform_data/ as part of the
> single zImage work.

Joerg, I'm planning to apply these four patches against -rc1 into
omap-for-v3.8/cleanup-headers-iommu branch if these look OK to you.

That branch won't contain other patches and you can pull it in too
if needed.

Regards,

Tony
 
> Cc: Joerg Roedel <joerg.roedel@amd.com>
> Cc: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Ido Yariv <ido@wizery.com>
> Acked-by: Mauro Carvalho Chehab <mchehab@redhat.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/devices.c              |    2 +-
>  arch/arm/mach-omap2/iommu2.c               |    2 +-
>  arch/arm/mach-omap2/omap-iommu.c           |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
>  drivers/iommu/omap-iommu-debug.c           |    4 ++--
>  drivers/iommu/omap-iommu.c                 |    2 +-
>  drivers/iommu/omap-iovmm.c                 |    4 ++--
>  drivers/media/platform/omap3isp/isp.h      |    5 +++--
>  drivers/media/platform/omap3isp/ispvideo.c |    5 ++---
>  include/linux/platform_data/iommu-omap.h   |    0 
>  include/linux/platform_data/iovmm-omap.h   |    0 
>  12 files changed, 15 insertions(+), 15 deletions(-)
>  rename arch/arm/plat-omap/include/plat/iommu.h => include/linux/platform_data/iommu-omap.h (100%)
>  rename arch/arm/plat-omap/include/plat/iovmm.h => include/linux/platform_data/iovmm-omap.h (100%)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index c8c2117..6cd0c2a 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -126,7 +126,7 @@ static struct platform_device omap2cam_device = {
>  
>  #if defined(CONFIG_IOMMU_API)
>  
> -#include <plat/iommu.h>
> +#include <linux/platform_data/iommu-omap.h>
>  
>  static struct resource omap3isp_resources[] = {
>  	{
> diff --git a/arch/arm/mach-omap2/iommu2.c b/arch/arm/mach-omap2/iommu2.c
> index c986880..82f9174 100644
> --- a/arch/arm/mach-omap2/iommu2.c
> +++ b/arch/arm/mach-omap2/iommu2.c
> @@ -18,7 +18,7 @@
>  #include <linux/slab.h>
>  #include <linux/stringify.h>
>  
> -#include <plat/iommu.h>
> +#include <linux/platform_data/iommu-omap.h>
>  
>  /*
>   * omap2 architecture specific register bit definitions
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
> index df298d4..a6a4ff8 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -13,7 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  
> -#include <plat/iommu.h>
> +#include <linux/platform_data/iommu-omap.h>
>  
>  #include "soc.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> index f67b7ee..621bc71 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> @@ -26,8 +26,8 @@
>  #include <plat/mmc.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
> +#include <linux/platform_data/iommu-omap.h>
>  #include <plat/dmtimer.h>
> -#include <plat/iommu.h>
>  
>  #include "am35xx.h"
>  
> diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> index 652d028..5850b3e 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> @@ -27,10 +27,10 @@
>  #include <plat/dma.h>
>  #include <linux/platform_data/spi-omap2-mcspi.h>
>  #include <linux/platform_data/asoc-ti-mcbsp.h>
> +#include <linux/platform_data/iommu-omap.h>
>  #include <plat/mmc.h>
>  #include <plat/dmtimer.h>
>  #include <plat/common.h>
> -#include <plat/iommu.h>
>  
>  #include "omap_hwmod_common_data.h"
>  #include "cm1_44xx.h"
> diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
> index a0b0309..8c1e30b 100644
> --- a/drivers/iommu/omap-iommu-debug.c
> +++ b/drivers/iommu/omap-iommu-debug.c
> @@ -19,8 +19,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/debugfs.h>
>  
> -#include <plat/iommu.h>
> -#include <plat/iovmm.h>
> +#include <linux/platform_data/iommu-omap.h>
> +#include <linux/platform_data/iovmm-omap.h>
>  
>  #include <plat/iopgtable.h>
>  
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 80844b3..6100334 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -24,7 +24,7 @@
>  
>  #include <asm/cacheflush.h>
>  
> -#include <plat/iommu.h>
> +#include <linux/platform_data/iommu-omap.h>
>  
>  #include <plat/iopgtable.h>
>  
> diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
> index b362fb5..b5ac2cd 100644
> --- a/drivers/iommu/omap-iovmm.c
> +++ b/drivers/iommu/omap-iovmm.c
> @@ -21,8 +21,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/mach/map.h>
>  
> -#include <plat/iommu.h>
> -#include <plat/iovmm.h>
> +#include <linux/platform_data/iommu-omap.h>
> +#include <linux/platform_data/iovmm-omap.h>
>  
>  #include <plat/iopgtable.h>
>  
> diff --git a/drivers/media/platform/omap3isp/isp.h b/drivers/media/platform/omap3isp/isp.h
> index 8be7487..62c76f9 100644
> --- a/drivers/media/platform/omap3isp/isp.h
> +++ b/drivers/media/platform/omap3isp/isp.h
> @@ -34,8 +34,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/wait.h>
>  #include <linux/iommu.h>
> -#include <plat/iommu.h>
> -#include <plat/iovmm.h>
> +
> +#include <linux/platform_data/iommu-omap.h>
> +#include <linux/platform_data/iovmm-omap.h>
>  
>  #include "ispstat.h"
>  #include "ispccdc.h"
> diff --git a/drivers/media/platform/omap3isp/ispvideo.c b/drivers/media/platform/omap3isp/ispvideo.c
> index a0b737fe..75ecfc8 100644
> --- a/drivers/media/platform/omap3isp/ispvideo.c
> +++ b/drivers/media/platform/omap3isp/ispvideo.c
> @@ -34,9 +34,8 @@
>  #include <linux/vmalloc.h>
>  #include <media/v4l2-dev.h>
>  #include <media/v4l2-ioctl.h>
> -#include <plat/iommu.h>
> -#include <plat/iovmm.h>
> -#include <plat/omap-pm.h>
> +#include <linux/platform_data/iommu-omap.h>
> +#include <linux/platform_data/iovmm-omap.h>
>  
>  #include "ispvideo.h"
>  #include "isp.h"
> diff --git a/arch/arm/plat-omap/include/plat/iommu.h b/include/linux/platform_data/iommu-omap.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/iommu.h
> rename to include/linux/platform_data/iommu-omap.h
> diff --git a/arch/arm/plat-omap/include/plat/iovmm.h b/include/linux/platform_data/iovmm-omap.h
> similarity index 100%
> rename from arch/arm/plat-omap/include/plat/iovmm.h
> rename to include/linux/platform_data/iovmm-omap.h
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
