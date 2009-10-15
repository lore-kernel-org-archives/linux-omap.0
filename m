From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
 access
Date: Thu, 15 Oct 2009 11:40:54 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BB37CDA1@dbde02.ent.ti.com>
References: <E0D41E29EB0DAC4E9F3FF173962E9E940253DAF74A@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB2@dbde02.ent.ti.com>,<EAF47CD23C76F840A9E7FCE10091EFAB02BB255576@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB7@dbde02.ent.ti.com>,<19F8576C6E063C45BE387C64729E73940436DB248C@dbde02.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53523 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbZJOGLf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Oct 2009 02:11:35 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9F6AuYc014123
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 15 Oct 2009 01:10:59 -0500
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BA31ADB9@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charu Latha" <charu@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Syed, Rafiuddin" <rafiuddin.syed@ti.com>

<snip>
> -----Original Message-----
> From: Varadarajan, Charu Latha
> Sent: Thursday, October 15, 2009 10:59 AM
> To: Shilimkar, Santosh; linux-omap@vger.kernel.org
> Cc: Syed, Rafiuddin
> Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for 32bit reg
> access
> 
> ______________________
> 
> > > > Subject: RE: [PATCH] OMAP3: Fix McBSP poll read and write for
> > > > 32bit reg access
> > > >
> > > > Charu,
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > > > > owner@vger.kernel.org] On Behalf Of Varadarajan, Charu Latha
> > > > > Sent: Wednesday, October 14, 2009 3:00 PM
> > > > > To: linux-omap@vger.kernel.org
> > > > > Cc: Varadarajan, Charu Latha; Syed, Rafiuddin
> > > > > Subject: [PATCH] OMAP3: Fix McBSP poll read and write for
> > > > 32bit reg access
> > > > >
> > > > > omap_mcbsp_pollwrite and omap_mcbsp_pollread functions access
> > > > > McBSP registers as 16-bit registers.
> > > > >
> > > > > The McBSP registers (DRR_REG and DXR_REG) are limited to
> > > > > 32-bit data accesses (L4 Interconnect). 16-bit and 8-bit is
> > > > > not allowed and can corrupt register content.
> > > > >
> > > > > This patch modifies omap_mcbsp_pollwrite and
> > > > > omap_mcbsp_pollread functions to do 32 bit access for above
> > > > > mentioned McBSP registers. Data accepted by these
> > > > > functions is also modified to 32-bit.
> > > > >
> > > > > Signed-off-by: Charulatha V <charu@ti.com>
> > > > > Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
> > > > > ---
> > > > >  arch/arm/plat-omap/include/mach/mcbsp.h |    4 +-
> > > > >  arch/arm/plat-omap/mcbsp.c              |   46
> > > > ++++++++++++++------------
> > > > > -----
> > > > >  2 files changed, 23 insertions(+), 27 deletions(-)
> > > > >
> > > > > diff --git a/arch/arm/plat-omap/include/mach/mcbsp.h
> > > > b/arch/arm/plat-
> > > > > omap/include/mach/mcbsp.h
> > > > > index 7e9cae3..05b0d8d 100644
> > > > > --- a/arch/arm/plat-omap/include/mach/mcbsp.h
> > > > > +++ b/arch/arm/plat-omap/include/mach/mcbsp.h
> > > > > @@ -455,8 +455,8 @@ int
> > > > omap_mcbsp_spi_master_recv_word_poll(unsigned int
> > > > > id, u32 * word);
> > > > >  void omap_mcbsp_set_spi_mode(unsigned int id, const struct
> > > > > omap_mcbsp_spi_cfg * spi_cfg);
> > > > >
> > > > >  /* Polled read/write functions */
> > > > > -int omap_mcbsp_pollread(unsigned int id, u16 * buf);
> > > > > -int omap_mcbsp_pollwrite(unsigned int id, u16 buf);
> > > > > +int omap_mcbsp_pollread(unsigned int id, u32 *buf);
> > > > > +int omap_mcbsp_pollwrite(unsigned int id, u32 buf);
> > > > If the issue is with DRR_REG and DXR_REG, why are you
> > > > changing the signature of the generic API. You can handle
> > > > these registers as a exceptions in the code.
> > > If 32 bit data could be read and written on McBSP, why should we
> restrict
> > > poll read and
> > > poll write functions only for 16 bit data read and write?
> > If these API's are only accessing the DXR and DRR regs then this is OK.
> >
> > > > >  int omap_mcbsp_set_io_type(unsigned int id, omap_mcbsp_io_type_t
> > > > > io_type);
> > > > >
> > > > >  #endif
> > > > > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-
> omap/mcbsp.c
> > > > > index 88ac976..1f278a2 100644
> > > > > --- a/arch/arm/plat-omap/mcbsp.c
> > > > > +++ b/arch/arm/plat-omap/mcbsp.c
> > > > > @@ -613,7 +613,7 @@ void omap_mcbsp_stop(unsigned int id,
> > > > int tx, int rx)
> > > > >  EXPORT_SYMBOL(omap_mcbsp_stop);
> > > > >
> > > > >  /* polled mcbsp i/o operations */
> > > > > -int omap_mcbsp_pollwrite(unsigned int id, u16 buf)
> > > > > +int omap_mcbsp_pollwrite(unsigned int id, u32 buf)
> > > > >  {
> > > > >     struct omap_mcbsp *mcbsp;
> > > > >     void __iomem *base;
> > > > > @@ -626,26 +626,24 @@ int omap_mcbsp_pollwrite(unsigned int
> > > > id, u16 buf)
> > > > >     mcbsp = id_to_mcbsp_ptr(id);
> > > > >     base = mcbsp->io_base;
> > > > >
> > > > > -   writew(buf, base + OMAP_MCBSP_REG_DXR1);
> > > > > +   OMAP_MCBSP_WRITE(base, DXR, buf);
> > > > Why do you need this? Is writew()/readw() not doing 16 bit
> > > > operations  ?
> > > The intension is to use 32 bit access and not 16 bit access
> > Use readl() / writel() then.
> >
> Yes,  OMAP_MCBSP_WRITE macro makes use of readl() / writel() for OMAP3

Good!! Then get rid of this macro and directly use kernel standard API-	readl() / writel()
