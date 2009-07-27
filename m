From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for omap4
 iommu
Date: Sun, 26 Jul 2009 19:19:28 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A941FEB@dlee03.ent.ti.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46@dlee03.ent.ti.com>
 <20090724.211715.71123038.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49994 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753465AbZG0ATn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 26 Jul 2009 20:19:43 -0400
In-Reply-To: <20090724.211715.71123038.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gupta, Ramesh" <grgupta@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "Pasam, Vijay" <vpasam@ti.com>

Hi Hiroshi,

> >  config OMAP_IOMMU
> > -	tristate
> > -
> > +	tristate "iommu"
> > +        depends on ARCH_OMAP
> 
> Is the above dependecy necessary?
>

-- Probably not. I will remove this.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Friday, July 24, 2009 1:17 PM
> To: Kanigeri, Hari
> Cc: tony@atomide.com; linux-omap@vger.kernel.org; Gupta, Ramesh;
> rmk@arm.linux.org.uk; Pasam, Vijay
> Subject: Re: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for
> omap4 iommu
> 
> From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
> Subject: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for omap4
> iommu
> Date: Fri, 24 Jul 2009 19:22:56 +0200
> 
> > This patch provides build support to build OMAP4
> > IOMMU module. This also adds the changes to Kconfig
> > file to make iommu option visible in menuconfig.
> >
> > Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> > ---
> >  arch/arm/mach-omap2/Makefile |    2 +-
> >  arch/arm/plat-omap/Kconfig   |    8 ++++++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> > index 735bae5..59e0865 100644
> > --- a/arch/arm/mach-omap2/Makefile
> > +++ b/arch/arm/mach-omap2/Makefile
> > @@ -41,7 +41,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
> >
> >  iommu-y					+= iommu2.o
> >  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
> > -
> > +iommu-$(CONFIG_ARCH_OMAP4)              += omap4-iommu.o
> >  obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
> >
> >  # Specific board support
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index efe85d0..00d7a1e 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -118,8 +118,12 @@ config OMAP_MBOX_FWK
> >  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
> >
> >  config OMAP_IOMMU
> > -	tristate
> > -
> > +	tristate "iommu"
> > +        depends on ARCH_OMAP
> 
> Is the above dependecy necessary?
> 
> > +	default y
> > +	help
> > +	  Select this option if you want to use IOMMU support for the
> > +	  Camera in OMAP3, and for Ducati processor in OMAP4.
> 
> So here, it goes visible because iommu will be an independent character
> device, right?
> 
> 
> >  choice
> >          prompt "System timer"
> >  	default OMAP_MPU_TIMER
> > --
> > 1.5.4.3
> >
> >
> > Thank you,
> > Best regards,
> > Hari
> >

