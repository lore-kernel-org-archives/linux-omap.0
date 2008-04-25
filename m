From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: RE: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1 and
 2
Date: Fri, 25 Apr 2008 11:16:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB2E706BB9@dbde02.ent.ti.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-2-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-3-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-4-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-5-git-send-email-edubezval@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB2E706B5A@dbde02.ent.ti.com>
 <a0580c510804242226w415ca9e4n745e05aa70ad5e57@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53991 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199AbYDYFqR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 01:46:17 -0400
In-Reply-To: <a0580c510804242226w415ca9e4n745e05aa70ad5e57@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@indt.org.br>

> > <snip>
> >
> > > diff --git a/include/asm-arm/arch-omap/dma.h
> > > b/include/asm-arm/arch-omap/dma.h
> > > index be0431e..270e158 100644
> > > --- a/include/asm-arm/arch-omap/dma.h
> > > +++ b/include/asm-arm/arch-omap/dma.h
> > > @@ -273,6 +273,10 @@
> > >  #define OMAP24XX_DMA_MS                      63      /* S_DMA_62 */
> > >  #define OMAP242X_DMA_EXT_DMAREQ5     64      /* S_DMA_63 */
> > >  #define OMAP243X_DMA_EXT_DMAREQ6     64      /* S_DMA_63 */
> > > +#define OMAP34XX_DMA_MCBSP1_TX               31      /* S_DMA_30 */
> > > +#define OMAP34XX_DMA_MCBSP1_RX               32      /* S_DMA_31 */
> > > +#define OMAP34XX_DMA_MCBSP2_TX               33      /* S_DMA_32 */
> > > +#define OMAP34XX_DMA_MCBSP2_RX               34      /* S_DMA_33 */
> > >  #define OMAP34XX_DMA_EXT_DMAREQ3     64      /* S_DMA_63 */
> > >  #define OMAP34XX_DMA_AES2_TX         65      /* S_DMA_64 */
> > >  #define OMAP34XX_DMA_AES2_RX         66      /* S_DMA_65 */
> >
> >  What's the point of this patch? Can't you use OMAP24XX_DMA_MCBSP* names?
>
> Yes, OMAP24XX_DMA_MCBSP* can be used as they have same values.
> There is no big difference, but readability. That's the point
> of this patch.
> Defining names OMAP34XX_DMA_MCBSP* would let people to
> write more readable code when specifying things specific for OMAP34XX.

I was under the impression that one wouldn't be writing code specific to OMAP34XX given that it would work with zero modifications on a 24XX as in this case. In such a case, would it not make more sense to use the more generic name? That was why I left it that way - anything common to a 24XX and a 34XX gets the OMAP24XX name.

__Quote__
OMAP242X_* for 2420 specific names
OMAP243X_* for 2430 specific names/names present from 243X onwards
OMAP24XX_* for names common to all 24XX, 34XX
OMAP34XX_* for 34XX specific names
__End_Quote__

That's why I did not see a point in this patch.

-Anand
