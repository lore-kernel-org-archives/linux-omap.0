From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: RE: [PATCH] omap3: Remove non-existent config option
Date: Tue, 3 Aug 2010 13:39:48 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0D93@dbde02.ent.ti.com>
References: <1279790027-2509-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46788 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753991Ab0HCIJx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 04:09:53 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id o7389nop025471
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Aug 2010 03:09:52 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o7389n3u017889
	for <linux-omap@vger.kernel.org>; Tue, 3 Aug 2010 13:39:49 +0530 (IST)
In-Reply-To: <1279790027-2509-1-git-send-email-premi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Premi, Sanjeev" <premi@ti.com>

ping..

> -----Original Message-----
> From: Premi, Sanjeev
> Sent: Thursday, July 22, 2010 2:44 PM
> To: linux-omap@vger.kernel.org
> Cc: Marathe, Yogesh; Premi, Sanjeev
> Subject: [PATCH] omap3: Remove non-existent config option
> 
> From: Yogesh Marathe <yogesh_marathe@ti.com>
> 
> The definition of "iva2" device in iommu_device
> is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> this option is not defined in KConfig.
> 
> This patch removes the wrapper and makes "iva2"
> available as another iommu_device.
> 
> Signed-off-by: Yogesh Marathe <yogesh_marathe@ti.com>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/omap-iommu.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-
> iommu.c
> index f5a1aad..bb8c01d 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -35,7 +35,6 @@ static struct iommu_device omap3_devices[] = {
>  			.clk_name = "cam_ick",
>  		},
>  	},
> -#if defined(CONFIG_MPU_BRIDGE_IOMMU)
>  	{
>  		.base = 0x5d000000,
>  		.irq = 28,
> @@ -45,7 +44,6 @@ static struct iommu_device omap3_devices[] = {
>  			.clk_name = "iva2_ck",
>  		},
>  	},
> -#endif
>  };
>  #define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
>  static struct platform_device
> *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
> --
> 1.6.6.1

Regards,
Yogesh.

