From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
Date: Thu, 9 Sep 2010 10:40:05 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301F6D3661A@dbde02.ent.ti.com>
References: <1283957481-16682-1-git-send-email-premi@ti.com>
 <20100909.080445.193715829.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0IIFKR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 01:10:17 -0400
In-Reply-To: <20100909.080445.193715829.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com] 
> Sent: Thursday, September 09, 2010 10:35 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
> 
> Hi Sanjeev,
> 
> From: ext Sanjeev Premi <premi@ti.com>
> Subject: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
> Date: Wed, 8 Sep 2010 16:51:21 +0200
> 
> > The menu option to select CONFIG_OMAP_IOMMU
> > was not visible in the menuconfig due to missing
> > description.
> 
> There's no point to make OMAP_IOMMU visible since this is a kind of
> feature used by other device implicitly. OMAP_IOMMU on menu 
> might confuse
> users at kernel menuconfig. Instead this should be automatically
> selected by its clients when it is selected. For exmaple, the case
> that DSP or Tesla is selected. There was a discussion about this
> before.

[sp] You would have noticed that there are mnay OMAP3 variants and
     some of them are ARM only - detection being runtime, not compile
     time.

     All these processors share same defconfig.

     Keeping/ maintaining specific defconfigs for each processor will
     be too difficult.

~sanjeev

> 
> > 
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > ---
> >  arch/arm/plat-omap/Kconfig |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index e39a417..2a114a9 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -98,7 +98,7 @@ config OMAP_MBOX_KFIFO_SIZE
> >  	  module parameter).
> >  
> >  config OMAP_IOMMU
> > -	tristate
> > +	tristate "OMAP IOMMU support"
> >  
> >  config OMAP_IOMMU_DEBUG
> >         tristate "Export OMAP IOMMU internals in DebugFS"
> > -- 
> > 1.6.2.4
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 