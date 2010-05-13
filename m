From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH 2/3] omap3 nand: cleanup for not to use GPMC virtual
 address
Date: Fri, 14 May 2010 00:18:13 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030D8FB10F@dbde02.ent.ti.com>
References: <s-ghorai@ti.com>
 <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
 <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
 <1273657718-12517-3-git-send-email-s-ghorai@ti.com>
 <20100513154103.GI29368@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57446 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab0EMSsb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 14:48:31 -0400
In-Reply-To: <20100513154103.GI29368@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "sakoman@gmail.com" <sakoman@gmail.com>, "mike@compulab.co.il" <mike@compulab.co.il>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>

Tony,

> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: 2010-05-13 21:11
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org;
> sakoman@gmail.com; mike@compulab.co.il; Artem.Bityutskiy@nokia.com
> Subject: Re: [PATCH 2/3] omap3 nand: cleanup for not to use GPMC virtual
> address
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100512 02:43]:
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -64,16 +64,32 @@ static void __iomem *gpmc_base;
> >
> >  static struct clk *gpmc_l3_clk;
> >
> > -static void gpmc_write_reg(int idx, u32 val)
> > +void gpmc_write_reg(int idx, u32 val)
> >  {
> >  	__raw_writel(val, gpmc_base + idx);
> >  }
> >
> > -static u32 gpmc_read_reg(int idx)
> > +u32 gpmc_read_reg(int idx)
> >  {
> >  	return __raw_readl(gpmc_base + idx);
> >  }
> >
> > +void gpmc_cs_write_byte(int cs, int idx, u32 val)
> > +{
> > +	void __iomem *reg_addr;
> > +
> > +	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
> > +	__raw_writeb(val, reg_addr);
> > +}
> > +
> > +u8 gpmc_cs_read_byte(int cs, int idx)
> > +{
> > +	void __iomem *reg_addr;
> > +
> > +	reg_addr = gpmc_base + GPMC_CS0_BASE + (cs * GPMC_CS_SIZE) + idx;
> > +	return __raw_readb(reg_addr);
> > +}
> > +
> 
> This will not improve the situation unfortunately.
> We for sure don't want to export functions to mess
> with the GPMC registers all over the place.
> 
> > @@ -432,15 +448,6 @@ void gpmc_prefetch_reset(void)
> >  }
> >  EXPORT_SYMBOL(gpmc_prefetch_reset);
> >
> > -/**
> > - * gpmc_prefetch_status - reads prefetch status of engine
> > - */
> > -int  gpmc_prefetch_status(void)
> > -{
> > -	return gpmc_read_reg(GPMC_PREFETCH_STATUS);
> > -}
> > -EXPORT_SYMBOL(gpmc_prefetch_status);
> > -
> 
> And we don't want to remove GPMC functions like this,
> instead we need to implement more functions like this
> for the platform init code to use.

[Ghorai] 
1. NAND IO address needed by core NAND driver. So we can't move that access to GMPC.
2. And is it ok if we add functions as below and all need to be as EXPORT_SYMBOL too? 
get_gpmc_status()
get_gpmc_irq_status()
set_gpmc_irq_status()
set_gpmc_irq_enable()
get_gpmc_config
set_gpmc_config
get_gpmc_status()
get_gpmc_prefetch_config()
gpmc_prefetch_status 
set_gpmc_ecc_config
set_gpmc_ecc_contol
set_gpmc_ecc_size
get_gpmc_ecc_result

Regards,
Sukumar


> Regards,
> 
> Tony
