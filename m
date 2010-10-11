From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
Date: Mon, 11 Oct 2010 15:28:22 +0300 (EEST)
Message-ID: <20101011.152822.226794892.Hiroshi.DOYU@nokia.com>
References: <1286790830-13505-1-git-send-email-felipe.contreras@gmail.com>
	<1286790830-13505-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:62107 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754366Ab0JKM3T (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Oct 2010 08:29:19 -0400
In-Reply-To: <1286790830-13505-2-git-send-email-felipe.contreras@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, greg@kroah.com, felipe.contreras@nokia.com, fernando.lugo@ti.com, yogesh_marathe@ti.com, linux-arm-kernel@lists.infradead.org

From: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] omap: iommu: make iva2 iommu selectable
Date: Mon, 11 Oct 2010 11:53:49 +0200

> From: Felipe Contreras <felipe.contreras@nokia.com>
> 
> It seems dsp-link will do this, and tidspbridge too at some point, but
> right now it's not possible to select CONFIG_MPU_BRIDGE_IOMMU.

Why does it have to be selectable?

Please Cc: linux-arm-kernel@lists.infradead.org too.

> 
> Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>
> Cc: Yogesh Marathe <yogesh_marathe@ti.com>
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---
>  arch/arm/mach-omap2/omap-iommu.c |    2 +-
>  arch/arm/plat-omap/Kconfig       |    3 +++
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-iommu.c
> index f5a1aad..adc0904 100644
> --- a/arch/arm/mach-omap2/omap-iommu.c
> +++ b/arch/arm/mach-omap2/omap-iommu.c
> @@ -35,7 +35,7 @@ static struct iommu_device omap3_devices[] = {
>  			.clk_name = "cam_ick",
>  		},
>  	},
> -#if defined(CONFIG_MPU_BRIDGE_IOMMU)
> +#if defined(CONFIG_OMAP_IOMMU_IVA2)
>  	{
>  		.base = 0x5d000000,
>  		.irq = 28,
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index e39a417..e0b41b6 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -109,6 +109,9 @@ config OMAP_IOMMU_DEBUG
>  
>           Say N unless you know you need this.
>  
> +config OMAP_IOMMU_IVA2
> +	bool
> +
>  choice
>  	prompt "System timer"
>  	default OMAP_32K_TIMER if !ARCH_OMAP15XX
> -- 
> 1.7.3.1.2.g7fe2b
> 
