From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
Date: Wed, 28 Jul 2010 19:41:35 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301E7E39F22@dbde02.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2246@dbde02.ent.ti.com>
 <8F7AF80515AF0D4D93307E594F3CB40E4D25C9B4@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465Ab0G1OLo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jul 2010 10:11:44 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E4D25C9B4@dlee03.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

 

> -----Original Message-----
> From: Kanigeri, Hari 
> Sent: Tuesday, July 27, 2010 10:20 PM
> To: Premi, Sanjeev; Linux Omap; Tony Lindgren
> Cc: Shilimkar, Santosh; Cousson, Benoit; Que, Simon
> Subject: RE: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK 
> base address
> 
> Sanjeev,
> 
> > > @@ -49,5 +49,10 @@
> > >  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
> > >  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
> > >
> > > +#define OMAP4_MMU1_BASE			0x55082000
> > > +#define OMAP4_MMU2_BASE			0x4A066000
> > 
> > [sp] Are these 2 base addresses related to this patch?
> 
> Nope. Thanks for finding this. I will update the patch.

[sp] Then additional patch only to add the base address won't make much sense.
     You may want to combine it with appropriately with another one in this
     series.

> 
> > 
> > ~sanjeev
> > 
> > > +
> > > +#define OMAP44XX_SPINLOCK_BASE		(L4_44XX_BASE + 0xF6000)
> > > +
> > >  #endif /* __ASM_ARCH_OMAP44XX_H */
> > >
> > > --
> > > 1.7.0
> > >
> > >
> 
> Best regards,
> Hari
> 