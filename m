From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 03/11] OMAP2430: DMA: HWMOD: Add hwmod data	structures
Date: Tue, 24 Aug 2010 20:02:25 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270D6B95C@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
 <1282647866-6918-4-git-send-email-manjugk@ti.com>
 <20100824113054.GG25559@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59101 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751407Ab0HXOcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Aug 2010 10:32:41 -0400
In-Reply-To: <20100824113054.GG25559@gw.healthdatacare.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mika Westerberg <mika.westerberg@iki.fi>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>



> -----Original Message-----
> From: Mika Westerberg [mailto:mika.westerberg@gmail.com] On 
> Behalf Of Mika Westerberg
> Sent: Tuesday, August 24, 2010 5:01 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Kevin 
> Hilman; Shilimkar, Santosh
> Subject: Re: [PATCH v2 03/11] OMAP2430: DMA: HWMOD: Add hwmod 
> data structures
> 
> Hi,
> 
> On Tue, Aug 24, 2010 at 04:34:18PM +0530, Manjunatha GK wrote:
> > This patch adds OMAP2430 DMA hwmod structures.
> > 
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   85 
> ++++++++++++++++++++++++++++
> >  1 files changed, 85 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c 
> b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > index 4526628..3d79a52 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > @@ -33,6 +33,7 @@ static struct omap_hwmod omap2430_mpu_hwmod;
> >  static struct omap_hwmod omap2430_iva_hwmod;
> >  static struct omap_hwmod omap2430_l3_main_hwmod;
> >  static struct omap_hwmod omap2430_l4_core_hwmod;
> > +static struct omap_hwmod omap2430_dma_system_hwmod;
> >  
> >  /* L3 -> L4_CORE interface */
> >  static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
> > @@ -165,12 +166,96 @@ static struct omap_hwmod 
> omap2430_iva_hwmod = {
> >  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430)
> >  };
> >  
> > +/* dma_system */
> > +static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
> > +	.rev_offs	= 0x0000,
> > +	.sysc_offs	= 0x002c,
> > +	.syss_offs	= 0x0028,
> > +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> > +			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> > +			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
> > +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> > +			   MSTANDBY_FORCE | MSTANDBY_NO | 
> MSTANDBY_SMART),
> > +	.sysc_fields	= &omap_hwmod_sysc_type1,
> > +};
> > +
> > +static struct omap_hwmod_class omap2430_dma_hwmod_class = {
> > +	.name = "dma",
> > +	.sysc = &omap2430_dma_sysc,
> > +};
> > +
> > +/* dma attributes */
> > +static struct omap_dma_dev_attr dma_dev_attr = {
> > +	.dev_caps  = DMA_LINKED_LCH | GLOBAL_PRIORITY |
> > +				IS_CSSA_32 | IS_CDSA_32 | IS_RW_PRIORIY,
>                                                           
> ^^^^^^^^^^^^^
> 
> Should this be IS_RW_PRIORITY? Same typo seems to be also in 
> other patches which
> add hwmod structures.

Thanks for identifying this typo. I will take care of it.

-Manjunath
