From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: Re: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1 and 2
Date: Fri, 25 Apr 2008 01:26:51 -0400
Message-ID: <a0580c510804242226w415ca9e4n745e05aa70ad5e57@mail.gmail.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-2-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-3-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-4-git-send-email-edubezval@gmail.com>
	 <1209052465-13210-5-git-send-email-edubezval@gmail.com>
	 <5A47E75E594F054BAF48C5E4FC4B92AB2E706B5A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:32817 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667AbYDYF0y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 01:26:54 -0400
Received: by wa-out-1112.google.com with SMTP id m16so5769616waf.23
        for <linux-omap@vger.kernel.org>; Thu, 24 Apr 2008 22:26:54 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB2E706B5A@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@indt.org.br>

Hi Anand,

On Fri, Apr 25, 2008 at 1:11 AM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> <snip>
>
> > diff --git a/include/asm-arm/arch-omap/dma.h
>  > b/include/asm-arm/arch-omap/dma.h
>  > index be0431e..270e158 100644
>  > --- a/include/asm-arm/arch-omap/dma.h
>  > +++ b/include/asm-arm/arch-omap/dma.h
>  > @@ -273,6 +273,10 @@
>  >  #define OMAP24XX_DMA_MS                      63      /* S_DMA_62 */
>  >  #define OMAP242X_DMA_EXT_DMAREQ5     64      /* S_DMA_63 */
>  >  #define OMAP243X_DMA_EXT_DMAREQ6     64      /* S_DMA_63 */
>  > +#define OMAP34XX_DMA_MCBSP1_TX               31      /* S_DMA_30 */
>  > +#define OMAP34XX_DMA_MCBSP1_RX               32      /* S_DMA_31 */
>  > +#define OMAP34XX_DMA_MCBSP2_TX               33      /* S_DMA_32 */
>  > +#define OMAP34XX_DMA_MCBSP2_RX               34      /* S_DMA_33 */
>  >  #define OMAP34XX_DMA_EXT_DMAREQ3     64      /* S_DMA_63 */
>  >  #define OMAP34XX_DMA_AES2_TX         65      /* S_DMA_64 */
>  >  #define OMAP34XX_DMA_AES2_RX         66      /* S_DMA_65 */
>
>  What's the point of this patch? Can't you use OMAP24XX_DMA_MCBSP* names?

Yes, OMAP24XX_DMA_MCBSP* can be used as they have same values.
There is no big difference, but readability. That's the point of this patch.
Defining names OMAP34XX_DMA_MCBSP* would let people to
write more readable code when specifying things specific for OMAP34XX.

>
>
>  > diff --git a/include/asm-arm/arch-omap/irqs.h
>  > b/include/asm-arm/arch-omap/irqs.h
>  > index 15446fd..4e185a8 100644
>  > --- a/include/asm-arm/arch-omap/irqs.h
>  > +++ b/include/asm-arm/arch-omap/irqs.h
>  > @@ -316,7 +316,11 @@
>  >  #define INT_34XX_USIM_IRQ    35
>  >  #define INT_34XX_WDT3_IRQ    36
>  >  #define INT_34XX_SPI4_IRQ    48
>  > +#define INT_34XX_MCBSP1_IRQ_TX       59
>  > +#define INT_34XX_MCBSP1_IRQ_RX       60
>  >  #define INT_34XX_I2C3_IRQ    61
>  > +#define INT_34XX_MCBSP2_IRQ_TX       62
>  > +#define INT_34XX_MCBSP2_IRQ_RX       63
>  >  #define INT_34XX_PBIAS_IRQ   75
>  >  #define INT_34XX_OHCI_IRQ    76
>  >  #define INT_34XX_EHCI_IRQ    77
>
>  Ditto with the IRQ lines?

same here.

>
>  @Tony,
>  It would be nice to give people some time to take a look at the patches before they get pushed.
>
>  Regards,
>  Anand
>



-- 
Eduardo Bezerra Valentin
