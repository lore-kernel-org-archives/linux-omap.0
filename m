From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
Date: Wed, 5 May 2010 16:41:27 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D1781@dbde02.ent.ti.com>
References: <1273016270-31452-1-git-send-email-jorge.candelaria@ti.com>
	<1273016270-31452-2-git-send-email-jorge.candelaria@ti.com>
 <20100505132951.48eda979.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46836 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752282Ab0EELLd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 07:11:33 -0400
In-Reply-To: <20100505132951.48eda979.jhnikula@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>, "Candelaria Villarreal, Jorge" <jorge.candelaria@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Jarkko
> Nikula
> Sent: Wednesday, May 05, 2010 4:00 PM
> To: Candelaria Villarreal, Jorge
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH 1/2] ARM: McBSP: Fix request for irq in OMAP4
> 
> On Tue,  4 May 2010 18:37:49 -0500
> Jorge Eduardo Candelaria <jorge.candelaria@ti.com> wrote:
> 
> > In OMAP4, there is only one irq line for TX and RX paths. Use
> > the correct irq line to avoid errors at runtime.
> >
> > Also, request irq line only once (instead of requesting for TX
> > and RX).
> >
> 
> > Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> > ---
> >  arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
> >  arch/arm/plat-omap/mcbsp.c  |   20 ++++++++++++--------
> >  2 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
> > index 2f3cad6..6b550ec 100644
> > --- a/arch/arm/mach-omap2/mcbsp.c
> > +++ b/arch/arm/mach-omap2/mcbsp.c
> > @@ -187,32 +187,28 @@ static struct omap_mcbsp_platform_data omap44xx_mcbsp_pdata[] = {
> >  		.phys_base      = OMAP44XX_MCBSP1_BASE,
> >  		.dma_rx_sync    = OMAP44XX_DMA_MCBSP1_RX,
> >  		.dma_tx_sync    = OMAP44XX_DMA_MCBSP1_TX,
> > -		.rx_irq         = INT_24XX_MCBSP1_IRQ_RX,
> > -		.tx_irq         = INT_24XX_MCBSP1_IRQ_TX,
> > +		.tx_irq         = INT_44XX_MCBSP1_IRQ,
> >  		.ops            = &omap2_mcbsp_ops,
> >  	},
> 
> These INT_44XX_MCBSPx appears to be undefined. Commit
> 5772ca7d7897722e7ed4c476bafee0b07bd9193e is removing them and I don't
> find are there somewhere a patch adding them to irqs-44xx.h.

Name isn't right here. Should be "OMAP44XX_IRQ_MCBSP1" defined
in " arch/arm/plat-omap/include/plat/irqs-44xx.h"
