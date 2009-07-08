From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 1/4] ARM: OMAP4: sDMA: Update the request lines
Date: Wed, 8 Jul 2009 09:37:13 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02B55BD77F@dbde02.ent.ti.com>
References: <1246956430-24863-1-git-send-email-rafiuddin.syed@ti.com>
 <alpine.DEB.2.00.0907071318510.5595@utopia.booyaka.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02B55BD76E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbZGHEH1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jul 2009 00:07:27 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02B55BD76E@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>, "Syed, Rafiuddin" <rafiuddin.syed@ti.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>

> > > diff --git a/arch/arm/plat-omap/include/mach/dma.h 
> > b/arch/arm/plat-omap/include/mach/dma.h
> > > index 8c1eae8..01ea54a 100644
> > > --- a/arch/arm/plat-omap/include/mach/dma.h
> > > +++ b/arch/arm/plat-omap/include/mach/dma.h
> > > @@ -122,6 +122,11 @@
> > >  #define OMAP_DMA4_CCFN(n)		(0x60 * (n) + 0xc0)
> > >  #define OMAP_DMA4_COLOR(n)		(0x60 * (n) + 0xc4)
> > >  
> > > +/* Additional registers available on OMAP4 */
> > > +#define OMAP_DMA4_CDP(n)		(0x60 * (n) + 0xd0)
> > > +#define OMAP_DMA4_CNDP(n)		(0x60 * (n) + 0xd4)
> > > +#define OMAP_DMA4_CCDN(n)		(0x60 * (n) + 0xd8)
> > > +
> > >  /* Dummy defines to keep multi-omap compiles happy */
> > >  #define OMAP1_DMA_REVISION		0
> > >  #define OMAP1_DMA_IRQSTATUS_L0		0
> > > @@ -311,6 +316,89 @@
> > >  #define OMAP34XX_DMA_USIM_TX		79	/* S_DMA_78 */
> > >  #define OMAP34XX_DMA_USIM_RX		80	/* S_DMA_79 */
> > >  
> > > +/* DMA request lines for 44xx */
> > > +#define OMAP44XX_DMA_DSS_DISPC_REQ	6	/* S_DMA_5 */
> > > +#define OMAP44XX_DMA_SYS_REQ2		7	/* S_DMA_6 */
> > > +#define OMAP44XX_DMA_ISS_REQ1		9	/* S_DMA_8 */
> > > +#define OMAP44XX_DMA_ISS_REQ2		10	/* S_DMA_9 */
> > > +#define OMAP44XX_DMA_ISS_EQ3		12	/* S_DMA_11 */
> > 
> > ^^^^^^^^^^
> > 
> > ... this one.
> > 
> > Suggest you resend a version that uses that data.
> 
> I am sorry but what's mistake you noticed in the patch ? 
Ya.... It should have been "REQ". We will cross verify and resubmit the patch