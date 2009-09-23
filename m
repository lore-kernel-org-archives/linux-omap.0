From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH v2] Runtime detection of Si features
Date: Wed, 23 Sep 2009 19:11:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDA2D09E@dbde02.ent.ti.com>
References: <1250509858-7951-1-git-send-email-premi@ti.com>
 <20090922200905.GA4919@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbZIWNlk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Sep 2009 09:41:40 -0400
In-Reply-To: <20090922200905.GA4919@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com] 
> Sent: Wednesday, September 23, 2009 1:39 AM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v2] Runtime detection of Si features

[snip]---[snip]---[snip]

> > diff --git a/arch/arm/mach-omap2/mmc-twl4030.c 
> b/arch/arm/mach-omap2/mmc-twl4030.c
> > index 3c04c2f..d68284d 100644
> > --- a/arch/arm/mach-omap2/mmc-twl4030.c
> > +++ b/arch/arm/mach-omap2/mmc-twl4030.c
> > @@ -10,6 +10,7 @@
> >   * published by the Free Software Foundation.
> >   */
> >  #include <linux/err.h>
> > +#include <linux/bitops.h>
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/platform_device.h>
> 
> The mmc-twl4030.c change should not be related to this, right?
> 
> Other than that, let's plan on merging these after 2.6.32-rc1.
> 

[sp] Not really related to the runtime detection; but required to
     ensure successful compilation. Using BIT() macros in cpu.h
     (see below) make this necessary.

     Should I split this into patch-set; making this into a
     separate patch?

Best regards,
Sanjeev

> Regards,
> 
> Tony
>

[snip]---[snip]---[snip]
 
> > diff --git a/arch/arm/plat-omap/include/mach/cpu.h 
> b/arch/arm/plat-omap/include/mach/cpu.h
> > index 4fbc6a9..4a04f77 100644
> > --- a/arch/arm/plat-omap/include/mach/cpu.h
> > +++ b/arch/arm/plat-omap/include/mach/cpu.h
> > @@ -432,4 +432,27 @@ IS_OMAP_TYPE(3430, 0x3430)
> >  int omap_chip_is(struct omap_chip_id oci);
> >  void omap2_check_revision(void);
> >  
> > +/*
> > + * Runtime detection of OMAP3 features
> > + */
> > +extern u32 omap3_features;
> > +
> > +#define OMAP3_HAS_L2CACHE		BIT(0)
> > +#define OMAP3_HAS_IVA			BIT(1)
> > +#define OMAP3_HAS_SGX			BIT(2)
> > +#define OMAP3_HAS_NEON			BIT(3)
> > +#define OMAP3_HAS_ISP			BIT(4)
> > +
> > +#define OMAP3_HAS_FEATURE(feat,flag)			\
> > +static inline unsigned int omap3_has_ ##feat(void)	\
> > +{							\
> > +	return (omap3_features & OMAP3_HAS_ ##flag);	\
> > +}							\
> > +
> > +OMAP3_HAS_FEATURE(l2cache, L2CACHE)
> > +OMAP3_HAS_FEATURE(sgx, SGX)
> > +OMAP3_HAS_FEATURE(iva, IVA)
> > +OMAP3_HAS_FEATURE(neon, NEON)
> > +OMAP3_HAS_FEATURE(isp, ISP)
> > +
> >  #endif	/* __ASM_ARCH_OMAP_CPU_H */
> > -- 
> > 1.6.2.2
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 