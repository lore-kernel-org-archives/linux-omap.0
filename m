From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
 mach-omap2
Date: Sat, 28 Mar 2009 08:50:53 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E2357E930@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E2349AE08@dlee03.ent.ti.com>
	<20090325.151129.02294438.Hiroshi.DOYU@nokia.com>
	<8F7AF80515AF0D4D93307E594F3CB40E2357E193@dlee03.ent.ti.com>
 <20090327.173014.190372579.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54130 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbZC1NvM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 28 Mar 2009 09:51:12 -0400
In-Reply-To: <20090327.173014.190372579.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "2ameya@gmail.com" <2ameya@gmail.com>

Hi Doyu-San,

> 
> -obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
> +
> +dspbridge-$(CONFIG_MPU_BRIDGE)		:= dspbridge.o
> +obj-y					+= $(dspbridge-m) $(drpbridge-y)
>

-- Thanks for making this change. This change looks good to me, except looks like you have a small typo (drpbridge :)).

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Friday, March 27, 2009 10:30 AM
> To: Kanigeri, Hari
> Cc: linux-omap@vger.kernel.org; 2ameya@gmail.com
> Subject: Re: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
> mach-omap2
> 
> Hi Hari,
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: RE: [PATCH 1/1] DSPBRIDGE: move platform_device_register under
> mach-omap2
> Date: Fri, 27 Mar 2009 14:42:18 +0100
> 
> > Hi Doyu-San,
> >
> > > > I am still going through the patch, but one quick question regarding
> > > > this. One of the requirements of DSP memory pool is that it should
> > > > be physically contiguous and non-cacheable. I hope the below patch
> > > > is taking care of this requirement.
> > >
> > > This patch reserves a *contigious* physical memory area and passes
> > > this physical address to the bridge driver through
> > > ldm(platform_data). Then this area is ioremap()'ed in
> > > "MEM_ExtPhysPoolInit()". So it should be non-cachable and contigious.
> >
> > -- We validated your patch with TI's internal test suite and it looks
> good.
> 
> Thank you for your effort.
> 
> > The only comment I have is with this patch now we would require 2
> > modules to insert for DSP Bridge to work. I think it would be nice
> > if we compile these 2 modules into 1 module so that we have only
> > DSPBridge module.
> 
> Hm..then, how about the following?
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 1ed6621..d427c90 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -35,7 +35,9 @@ obj-$(CONFIG_ARCH_OMAP2)		+= clock24xx.o
>  obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  obj-$(CONFIG_OMAP_PM_SRF)		+=  resource34xx.o
> 
> -obj-$(CONFIG_MPU_BRIDGE)		+= dspbridge.o
> +
> +dspbridge-$(CONFIG_MPU_BRIDGE)		:= dspbridge.o
> +obj-y					+= $(dspbridge-m) $(drpbridge-y)
> 
>  # DSP
>  obj-$(CONFIG_OMAP_MMU_FWK)	+= mmu_mach.o
> 

