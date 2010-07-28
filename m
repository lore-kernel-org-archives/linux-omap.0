From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
Date: Wed, 28 Jul 2010 09:55:58 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D2F3535@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2246@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D25C9B4@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F22@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D25D34F@dlee03.ent.ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F4A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:43251 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755262Ab0G1O4B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 10:56:01 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F4A@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

> 
> > > > Sanjeev,
> > > >
> > > > > > @@ -49,5 +49,10 @@
> > > > > >  #define OMAP44XX_MAILBOX_BASE
> > (L4_44XX_BASE + 0xF4000)
> > > > > >  #define OMAP44XX_HSUSB_OTG_BASE
> > (L4_44XX_BASE + 0xAB000)
> > > > > >
> > > > > > +#define OMAP4_MMU1_BASE			0x55082000
> > > > > > +#define OMAP4_MMU2_BASE			0x4A066000
> > > > >
> > > > > [sp] Are these 2 base addresses related to this patch?
> > > >
> > > > Nope. Thanks for finding this. I will update the patch.
> > >
> > > [sp] Then additional patch only to add the base address
> > won't make much
> > > sense.
> > >      You may want to combine it with appropriately with
> > another one in
> > > this
> > >      series.
> >
> > I think the define to add SPINLOCK base address is
> > independent of adding spinlock driver functionality, and I
> > don't see a reason why it shouldn't be a separate patch.
> > Example: The driver patches might take time to get
> > upstreamed, but that shouldn't stop this patch that adds the
> > missing Base address.
> 
> [sp] Without driver would this base address be of any use?
I could find you examples where there are definitions without being used.
But any case, it is a small change I will follow your suggestion.

> 
> >
> > >
> > > >
> > > > >
> > > > > ~sanjeev
> > > > >
> > > > > > +
> > > > > > +#define OMAP44XX_SPINLOCK_BASE
> > (L4_44XX_BASE + 0xF6000)
> > > > > > +
> > > > > >  #endif /* __ASM_ARCH_OMAP44XX_H */
> > > > > >
> > > > > > --
> > > > > > 1.7.0
> > > > > >
> > > > > >
> > > >
> > > > Best regards,
> > > > Hari
> > > >
> >
