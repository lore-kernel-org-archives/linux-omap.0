From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RFC 20/26] ARM: omap: clean up DMA register accesses
Date: Thu, 2 Jan 2014 16:07:37 +0000
Message-ID: <20140102160737.GK32243@n2100.arm.linux.org.uk>
References: <20140102150836.GA3826@n2100.arm.linux.org.uk> <E1VyjwR-0005FH-RH@rmk-PC.arm.linux.org.uk> <1388677778.1871.255.camel@smile>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:54210 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751528AbaABQIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Jan 2014 11:08:10 -0500
Content-Disposition: inline
In-Reply-To: <1388677778.1871.255.camel@smile>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Jan 02, 2014 at 05:49:38PM +0200, Andy Shevchenko wrote:
> On Thu, 2014-01-02 at 15:12 +0000, Russell King wrote:
> > We can do much better with this by using a structure to describe each
> > register, rather than code.
> > 
> 
> One comment bellow.
> 
> 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  arch/arm/mach-omap1/dma.c |  121 +++++++++++++++++++++------------------------
> >  arch/arm/mach-omap2/dma.c |   99 ++++++++++++++++++-------------------
> >  include/linux/omap-dma.h  |   13 +++++
> >  3 files changed, 117 insertions(+), 116 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
> > index 11f0b0ee67a3..de30e28ff487 100644
> > --- a/arch/arm/mach-omap1/dma.c
> > +++ b/arch/arm/mach-omap1/dma.c
> > @@ -32,53 +32,52 @@
> >  
> >  #define OMAP1_DMA_BASE			(0xfffed800)
> >  #define OMAP1_LOGICAL_DMA_CH_COUNT	17
> > -#define OMAP1_DMA_STRIDE		0x40
> 
> Does this belong to patch 19/26 ?

Why?

> >  static void __iomem *dma_base;
> >  static inline void dma_write(u32 val, int reg, int lch)
> >  {
> > -	u8  stride;
> > -	u32 offset;
> > +	void __iomem *addr = dma_base;
> >  
> > -	stride = (reg >= CPC) ? OMAP1_DMA_STRIDE : 0;
                                ^^^^^^^^^^^^^^^^
The code here still uses it prior to this patch.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
