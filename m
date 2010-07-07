From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 2/3] omap3 nand: cleanup virtual address usages
Date: Wed, 7 Jul 2010 17:52:42 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E10C777@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1275637205-489-1-git-send-email-s-ghorai@ti.com>
 <1275637205-489-2-git-send-email-s-ghorai@ti.com>
 <1275637205-489-3-git-send-email-s-ghorai@ti.com>
 <20100707102131.GG1920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33694 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755018Ab0GGMWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 08:22:55 -0400
In-Reply-To: <20100707102131.GG1920@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "mike@compulab.co.il" <mike@compulab.co.il>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, July 07, 2010 3:52 PM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> mike@compulab.co.il
> Subject: Re: [PATCH v5 2/3] omap3 nand: cleanup virtual address usages
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100604 10:34]:
> > --- a/arch/arm/plat-omap/include/plat/gpmc.h
> > +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> > @@ -63,7 +60,6 @@
> >  #define GPMC_CONFIG1_DEVICESIZE_16      GPMC_CONFIG1_DEVICESIZE(1)
> >  #define GPMC_CONFIG1_DEVICETYPE(val)    ((val & 3) << 10)
> >  #define GPMC_CONFIG1_DEVICETYPE_NOR     GPMC_CONFIG1_DEVICETYPE(0)
> > -#define GPMC_CONFIG1_DEVICETYPE_NAND    GPMC_CONFIG1_DEVICETYPE(2)
> >  #define GPMC_CONFIG1_MUXADDDATA         (1 << 9)
> >  #define GPMC_CONFIG1_TIME_PARA_GRAN     (1 << 4)
> >  #define GPMC_CONFIG1_FCLK_DIV(val)      (val & 3)
> 
> Is this no longer needed?
[Ghorai] we pass GPMC_CONFIG_DEV_TYPE and GPMC_DEVICETYPE_NAND to gpmc_hwcontrol(); And GPMC_DEVICETYPE_NAND define in previous patch of the same series.

> 
> > --- a/arch/arm/plat-omap/include/plat/nand.h
> > +++ b/arch/arm/plat-omap/include/plat/nand.h
> > @@ -21,13 +21,11 @@ struct omap_nand_platform_data {
> >  	int			(*dev_ready)(struct omap_nand_platform_data *);
> >  	int			dma_channel;
> >  	unsigned long		phys_base;
> > -	void __iomem		*gpmc_cs_baseaddr;
> > -	void __iomem		*gpmc_baseaddr;
> >  	int			devsize;
> >  };
> 
> Glad to see these finally going away!
> 
> Regards,
> 
> Tony
