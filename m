From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 4/9] OMAP2430: hwmod data: add system DMA
Date: Sat, 18 Dec 2010 09:37:41 +0000
Message-ID: <20101218093741.GC3047@n2100.arm.linux.org.uk>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com> <1292600388-13094-5-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1012180203380.16875@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55867 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754108Ab0LRJiJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 04:38:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1012180203380.16875@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, b-cousson@ti.com, tony@atomide.com, khilman@deeprootsystems.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, Dec 18, 2010 at 02:11:50AM -0700, Paul Walmsley wrote:
> On Fri, 17 Dec 2010, G, Manjunath Kondaiah wrote:
> 
> > Add OMAP2430 DMA hwmod data and also add required
> > DMA device attributes.
> > 
> > Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_2430_data.c |   87 ++++++++++++++++++++++++++++
> >  arch/arm/plat-omap/include/plat/dma.h      |    1 +
> >  2 files changed, 88 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > index f68409e..b52ba66 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
> > @@ -43,6 +43,7 @@ static struct omap_hwmod omap2430_gpio2_hwmod;
> >  static struct omap_hwmod omap2430_gpio3_hwmod;
> >  static struct omap_hwmod omap2430_gpio4_hwmod;
> >  static struct omap_hwmod omap2430_gpio5_hwmod;
> > +static struct omap_hwmod omap2430_dma_system_hwmod;
> >  
> >  /* L3 -> L4_CORE interface */
> >  static struct omap_hwmod_ocp_if omap2430_l3_main__l4_core = {
> > @@ -840,6 +841,89 @@ static struct omap_hwmod omap2430_gpio5_hwmod = {
> >  	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
> >  };
> >  
> > +/* dma_system */
> > +static struct omap_hwmod_class_sysconfig omap2430_dma_sysc = {
> > +	.rev_offs	= 0x0000,
> > +	.sysc_offs	= 0x002c,
> > +	.syss_offs	= 0x0028,
> > +	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
> 
> The OMAP2430 TRM Silicon Rev. 2.1 [Rev. Z] [SWPU090Z] Table 9-25 
> 'DMA4_OCP_SYSCONFIG' does not list a SIDLEMODE register bitfield for this 
> IP block.  Is there a reason why you list one?
> 
> > +			   SYSC_HAS_MIDLEMODE | SYSC_HAS_CLOCKACTIVITY |
> > +			   SYSC_HAS_EMUFREE | SYSC_HAS_AUTOIDLE),
> > +	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
> 
> If there is no SIDLEMODE register bitfield, then none of these SIDLE_* 
> modes should be included.

I'm confused.  I thought the whole point of hwmod was that the data for
it was generated from a TI database of how the chip is actually setup.

However, from all the patching which seems to be going on, it looks to
me like that's not the case - and if that's true, hwmod was mis-sold.
It's just moved the problem rather than solving anything.

What's going on?
