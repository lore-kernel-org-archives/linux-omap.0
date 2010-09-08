From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v2 08/11] OMAP: DMA: Convert DMA library into DMA
 platform Driver
Date: Wed, 8 Sep 2010 07:16:31 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402782B8D23@dbde02.ent.ti.com>
References: <1282647866-6918-1-git-send-email-manjugk@ti.com>
	<1282647866-6918-9-git-send-email-manjugk@ti.com>
	<878w3iv4lw.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402782B8A91@dbde02.ent.ti.com>
 <87aantgol2.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48941 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225Ab0IHBqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Sep 2010 21:46:39 -0400
In-Reply-To: <87aantgol2.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>




> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Wednesday, September 08, 2010 4:15 AM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Cousson, Benoit; Shilimkar, Santosh
> Subject: Re: [PATCH v2 08/11] OMAP: DMA: Convert DMA library 
> into DMA platform Driver
> 
> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
> 
> [...]
> 
> >> > diff --git a/arch/arm/mach-omap1/include/mach/dma.h 
> >> b/arch/arm/mach-omap1/include/mach/dma.h
> >> > index d446cdd..1eb0d31 100644
> >> > --- a/arch/arm/mach-omap1/include/mach/dma.h
> >> > +++ b/arch/arm/mach-omap1/include/mach/dma.h
> >> > @@ -77,4 +77,70 @@
> >> >  #define OMAP1_DMA_CCR2(n)		(0x40 * (n) + 0x24)
> >> >  #define OMAP1_DMA_LCH_CTRL(n)		(0x40 * (n) + 0x2a)
> >> >  
> >> > +/* Dummy defines to support multi omap code */
> >> 
> >> These should not be needed anymore as this is now an OMAP1-specific
> >> header.
> >
> > Because it is OMAP1 specific header, there are common API's 
> used between
> > omap1 and omap2 plus in plat-omap/dma.c which needs these 
> defines otherwise
> > build will break for omap1 since these defines exists omap2 
> specific header
> > Which is in respective mach directory.
> 
> OK, then the split you are proposing is not the right thing to do, or
> more likely, the split was not taken far enough.
> 
> defines that are used in common code should be defined in a common
> header, rather than duplicating them in both omap1 and omap2+ code.

It cannot be moved to common header since it will have duplicated #defines
(one from mach header and other one from common header.
> 
> When you find yourself putting OMAP1 defines in OMAP2+ code and vice
> versa, it should be an indication that there is still some abstraction
> missing in the split

These common API's use device attributes to differentiate between omap1 and omap2
plus code. If we want to eliminate this, we should move these api's to respective
mach directory. In that case, both omap1 and omap2plus dma drivers will become
separate drivers. The rationale behind spilit is, tried to common API's as for as 
possible in plat-oma dma and move omap1 and omap2plus specific code respectivem 
mach dma.

-Manjunath