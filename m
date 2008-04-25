From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] OMAP3xx: Add DMA and IRQ definition for McBSP 1
	and 2
Date: Fri, 25 Apr 2008 09:48:52 -0700
Message-ID: <20080425164852.GE23025@atomide.com>
References: <1209052465-13210-1-git-send-email-edubezval@gmail.com> <1209052465-13210-2-git-send-email-edubezval@gmail.com> <1209052465-13210-3-git-send-email-edubezval@gmail.com> <1209052465-13210-4-git-send-email-edubezval@gmail.com> <1209052465-13210-5-git-send-email-edubezval@gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB2E706B5A@dbde02.ent.ti.com> <a0580c510804242226w415ca9e4n745e05aa70ad5e57@mail.gmail.com> <5A47E75E594F054BAF48C5E4FC4B92AB2E706BB9@dbde02.ent.ti.com> <7EAD1AEEA7621C45899FE99123E124A001922B87@dbde01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64522 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762024AbYDYQs4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 12:48:56 -0400
Content-Disposition: inline
In-Reply-To: <7EAD1AEEA7621C45899FE99123E124A001922B87@dbde01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Syed Mohammed, Khasim" <khasim@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Syed Mohammed, Khasim <khasim@ti.com> [080424 23:18]:
> 
> > > > >  #define OMAP24XX_DMA_MS                      63      /* S_DMA_62 */
> > > > >  #define OMAP242X_DMA_EXT_DMAREQ5     64      /* S_DMA_63 */
> > > > >  #define OMAP243X_DMA_EXT_DMAREQ6     64      /* S_DMA_63 */
> > > > > +#define OMAP34XX_DMA_MCBSP1_TX               31      /* S_DMA_30 */
> > > > > +#define OMAP34XX_DMA_MCBSP1_RX               32      /* S_DMA_31 */
> > > > > +#define OMAP34XX_DMA_MCBSP2_TX               33      /* S_DMA_32 */
> > > > > +#define OMAP34XX_DMA_MCBSP2_RX               34      /* S_DMA_33 */
> > > > >  #define OMAP34XX_DMA_EXT_DMAREQ3     64      /* S_DMA_63 */
> > > > >  #define OMAP34XX_DMA_AES2_TX         65      /* S_DMA_64 */
> > > > >  #define OMAP34XX_DMA_AES2_RX         66      /* S_DMA_65 */
> > > >
> > > >  What's the point of this patch? Can't you use OMAP24XX_DMA_MCBSP*
> > names?
> > >
> > > Yes, OMAP24XX_DMA_MCBSP* can be used as they have same values.
> > > There is no big difference, but readability. That's the point
> > > of this patch.
> > > Defining names OMAP34XX_DMA_MCBSP* would let people to
> > > write more readable code when specifying things specific for OMAP34XX.
> > 
> > I was under the impression that one wouldn't be writing code specific to
> > OMAP34XX given that it would work with zero modifications on a 24XX as in
> > this case. In such a case, would it not make more sense to use the more
> > generic name? That was why I left it that way - anything common to a 24XX
> > and a 34XX gets the OMAP24XX name.
> > 
> > __Quote__
> > OMAP242X_* for 2420 specific names
> > OMAP243X_* for 2430 specific names/names present from 243X onwards
> > OMAP24XX_* for names common to all 24XX, 34XX
> > OMAP34XX_* for 34XX specific names
> > __End_Quote__
> > 
> 
> One small correction, can we make OMAP34XX as just OMAP3, today we have OMAP3410, 3420, 3430 and OMAP3530, 3503. We also have OMAP2530, but changing OMAP24XX to OMAP2 will be a painful task. Let's just take this up for OMAP3 alone.

Sounds good to me. Then for stuff that covers omap2 and omap3, we
should just OMAP2_* unless somebody have a better name.

And just to remind people, let's not start renaming things because
of the patch noise it causes. Let's rather wait on clean-up like
that until we have things in sync with mainline tree first.

Regards,

Tony

