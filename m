From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH] ARM: OMAP: make iommu subsys_initcall to fix builtin omap3isp
Date: Sun, 26 Feb 2012 18:34:28 +0100
Message-ID: <3215700.hj2jFm3b0A@avalon>
References: <1330251254-14693-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:42596 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838Ab2BZReV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Feb 2012 12:34:21 -0500
In-Reply-To: <1330251254-14693-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, Hiroshi Doyu <hdoyu@nvidia.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

Hi Ohad,

On Sunday 26 February 2012 12:14:14 Ohad Ben-Cohen wrote:
> omap3isp depends on omap's iommu and will fail to probe if
> initialized before it (which always happen if they are builtin).
> 
> Make omap's iommu subsys_initcall as an interim solution until
> the probe deferral mechanism is merged.

How will that fix the problem ?

I'm fine with this patch, as it fixes the problem as well, although I still 
believe modifying the link order would be a better fix in this case.

> Reported-by: James <angweiyang@gmail.com>
> Debugged-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> Cc: stable <stable@vger.kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hiroshi Doyu <hdoyu@nvidia.com>
> Cc: Joerg Roedel <Joerg.Roedel@amd.com>
> ---
>  arch/arm/mach-omap2/mailbox.c |    3 ++-
>  drivers/iommu/omap-iommu.c    |    3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 609ea2d..a6db1e4 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -412,7 +412,8 @@ static void __exit omap2_mbox_exit(void)
>  	platform_driver_unregister(&omap2_mbox_driver);
>  }
> 
> -module_init(omap2_mbox_init);
> +/* must be ready before omap3isp is probed */

The problem is not limited to the omap3isp driver, the DSP driver could be 
affected as well.

> +subsys_initcall(omap2_mbox_init);
>  module_exit(omap2_mbox_exit);
> 
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index 4e661f0..821062a 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -1222,7 +1222,8 @@ static int __init omap_iommu_init(void)
> 
>  	return platform_driver_register(&omap_iommu_driver);
>  }
> -module_init(omap_iommu_init);
> +/* must be ready before omap3isp is probed */
> +subsys_initcall(omap_iommu_init);
> 
>  static void __exit omap_iommu_exit(void)
>  {
-- 
Regards,

Laurent Pinchart
