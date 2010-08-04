From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap3: Remove non-existent config option
Date: Wed, 4 Aug 2010 14:11:47 +0300
Message-ID: <20100804111147.GL9881@atomide.com>
References: <1279790027-2509-1-git-send-email-premi@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0D93@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:50765 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932201Ab0HDLLV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:11:21 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7ED0D93@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Premi, Sanjeev" <premi@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

* Marathe, Yogesh <yogesh_marathe@ti.com> [100803 11:03]:
> ping..

Hiroshi ack/nak?

Tony
 
> > -----Original Message-----
> > From: Premi, Sanjeev
> > Sent: Thursday, July 22, 2010 2:44 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Marathe, Yogesh; Premi, Sanjeev
> > Subject: [PATCH] omap3: Remove non-existent config option
> > 
> > From: Yogesh Marathe <yogesh_marathe@ti.com>
> > 
> > The definition of "iva2" device in iommu_device
> > is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> > this option is not defined in KConfig.
> > 
> > This patch removes the wrapper and makes "iva2"
> > available as another iommu_device.
> > 
> > Signed-off-by: Yogesh Marathe <yogesh_marathe@ti.com>
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap-iommu.c |    2 --
> >  1 files changed, 0 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap-iommu.c b/arch/arm/mach-omap2/omap-
> > iommu.c
> > index f5a1aad..bb8c01d 100644
> > --- a/arch/arm/mach-omap2/omap-iommu.c
> > +++ b/arch/arm/mach-omap2/omap-iommu.c
> > @@ -35,7 +35,6 @@ static struct iommu_device omap3_devices[] = {
> >  			.clk_name = "cam_ick",
> >  		},
> >  	},
> > -#if defined(CONFIG_MPU_BRIDGE_IOMMU)
> >  	{
> >  		.base = 0x5d000000,
> >  		.irq = 28,
> > @@ -45,7 +44,6 @@ static struct iommu_device omap3_devices[] = {
> >  			.clk_name = "iva2_ck",
> >  		},
> >  	},
> > -#endif
> >  };
> >  #define NR_OMAP3_IOMMU_DEVICES ARRAY_SIZE(omap3_devices)
> >  static struct platform_device
> > *omap3_iommu_pdev[NR_OMAP3_IOMMU_DEVICES];
> > --
> > 1.6.6.1
> 
> Regards,
> Yogesh.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
