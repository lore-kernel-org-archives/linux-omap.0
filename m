From: Ivan Djelic <ivan.djelic@parrot.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: gpmc: update nand register helper
Date: Tue, 15 May 2012 09:22:15 +0200
Message-ID: <20120515072215.GB14401@parrot.com>
References: <cover.1336748974.git.afzal@ti.com>
 <b1a955469e6968b369e89f8e47bfc14c7051e6bb.1336748974.git.afzal@ti.com>
 <20120511200214.GZ21851@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from co202.xi-lite.net ([149.6.83.202]:36621 "EHLO co202.xi-lite.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754419Ab2EOHWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 03:22:36 -0400
Content-Disposition: inline
In-Reply-To: <20120511200214.GZ21851@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Afzal Mohammed <afzal@ti.com>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

On Fri, May 11, 2012 at 09:02:14PM +0100, Tony Lindgren wrote:
> * Afzal Mohammed <afzal@ti.com> [120511 08:48]:
> > Provide helper function for updating NAND register details for
> > the necessary chip select. NAND drivers platform data can be
> > updated with this information so that NAND driver can handle
> > GPMC NAND operations by itself.
> 
> Hmm this seems that it might be a more future proof path.

OK, I'll try to rewrite my patch on top of these.

Best Regards,
--
Ivan

> 
> Tony
> 
>  
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c             |   21 +++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/gpmc.h |   18 ++++++++++++++++++
> >  2 files changed, 39 insertions(+)
> > 
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> > index 46b09da..a409a3e 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -49,6 +49,7 @@
> >  #define GPMC_ECC_CONTROL	0x1f8
> >  #define GPMC_ECC_SIZE_CONFIG	0x1fc
> >  #define GPMC_ECC1_RESULT        0x200
> > +#define GPMC_ECC_BCH_RESULT_0	0x240
> >  
> >  /* GPMC ECC control settings */
> >  #define GPMC_ECC_CTRL_ECCCLEAR		0x100
> > @@ -681,6 +682,26 @@ int gpmc_prefetch_reset(int cs)
> >  }
> >  EXPORT_SYMBOL(gpmc_prefetch_reset);
> >  
> > +void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs)
> > +{
> > +	reg->gpmc_status = gpmc_base + GPMC_STATUS;
> > +	reg->gpmc_nand_command = gpmc_base + GPMC_CS0_OFFSET +
> > +				GPMC_CS_NAND_COMMAND + GPMC_CS_SIZE * cs;
> > +	reg->gpmc_nand_address = gpmc_base + GPMC_CS0_OFFSET +
> > +				GPMC_CS_NAND_ADDRESS + GPMC_CS_SIZE * cs;
> > +	reg->gpmc_nand_data = gpmc_base + GPMC_CS0_OFFSET +
> > +				GPMC_CS_NAND_DATA + GPMC_CS_SIZE * cs;
> > +	reg->gpmc_prefetch_config1 = gpmc_base + GPMC_PREFETCH_CONFIG1;
> > +	reg->gpmc_prefetch_config2 = gpmc_base + GPMC_PREFETCH_CONFIG2;
> > +	reg->gpmc_prefetch_control = gpmc_base + GPMC_PREFETCH_CONTROL;
> > +	reg->gpmc_prefetch_status = gpmc_base + GPMC_PREFETCH_STATUS;
> > +	reg->gpmc_ecc_config = gpmc_base + GPMC_ECC_CONFIG;
> > +	reg->gpmc_ecc_control = gpmc_base + GPMC_ECC_CONTROL;
> > +	reg->gpmc_ecc_size_config = gpmc_base + GPMC_ECC_SIZE_CONFIG;
> > +	reg->gpmc_ecc1_result = gpmc_base + GPMC_ECC1_RESULT;
> > +	reg->gpmc_bch_result0 = gpmc_base + GPMC_ECC_BCH_RESULT_0;
> > +}
> > +
> >  static void __init gpmc_mem_init(void)
> >  {
> >  	int cs;
> > diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
> > index 1527929..6a8078e 100644
> > --- a/arch/arm/plat-omap/include/plat/gpmc.h
> > +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> > @@ -131,6 +131,24 @@ struct gpmc_timings {
> >  	u16 wr_data_mux_bus;	/* WRDATAONADMUXBUS */
> >  };
> >  
> > +struct gpmc_nand_regs {
> > +	void __iomem	*gpmc_status;
> > +	void __iomem	*gpmc_nand_command;
> > +	void __iomem	*gpmc_nand_address;
> > +	void __iomem	*gpmc_nand_data;
> > +	void __iomem	*gpmc_prefetch_config1;
> > +	void __iomem	*gpmc_prefetch_config2;
> > +	void __iomem	*gpmc_prefetch_control;
> > +	void __iomem	*gpmc_prefetch_status;
> > +	void __iomem	*gpmc_ecc_config;
> > +	void __iomem	*gpmc_ecc_control;
> > +	void __iomem	*gpmc_ecc_size_config;
> > +	void __iomem	*gpmc_ecc1_result;
> > +	void __iomem	*gpmc_bch_result0;
> > +};
> > +
> > +extern void gpmc_update_nand_reg(struct gpmc_nand_regs *reg, int cs);
> > +
> >  extern unsigned int gpmc_ns_to_ticks(unsigned int time_ns);
> >  extern unsigned int gpmc_ps_to_ticks(unsigned int time_ps);
> >  extern unsigned int gpmc_ticks_to_ns(unsigned int ticks);
> > -- 
> > 1.7.10
> > 

-- 
Ivan Djelic
Operating System Team Manager
tel + 33 01 48 03 70 16
-----------------------------------------
Parrot
174, Quai de Jemmapes
75010 Paris, France
tel + 33 01 48 03 60 60
fax + 33 01 48 03 70 08
-----------------------------------------
http://www.parrot.com
