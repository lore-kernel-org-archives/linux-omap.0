From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 2/5] omap:hwspinlock-define HWSPINLOCK base address
Date: Tue, 27 Jul 2010 11:50:11 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E4D25C9B4@dlee03.ent.ti.com>
References: <1279558221-14954-1-git-send-email-h-kanigeri2@ti.com>
 <1279558221-14954-3-git-send-email-h-kanigeri2@ti.com>
 <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2246@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36386 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750937Ab0G0QuO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 12:50:14 -0400
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301E7DA2246@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Que, Simon" <sque@ti.com>

Sanjeev,

> > @@ -49,5 +49,10 @@
> >  #define OMAP44XX_MAILBOX_BASE		(L4_44XX_BASE + 0xF4000)
> >  #define OMAP44XX_HSUSB_OTG_BASE		(L4_44XX_BASE + 0xAB000)
> >
> > +#define OMAP4_MMU1_BASE			0x55082000
> > +#define OMAP4_MMU2_BASE			0x4A066000
> 
> [sp] Are these 2 base addresses related to this patch?

Nope. Thanks for finding this. I will update the patch.

> 
> ~sanjeev
> 
> > +
> > +#define OMAP44XX_SPINLOCK_BASE		(L4_44XX_BASE + 0xF6000)
> > +
> >  #endif /* __ASM_ARCH_OMAP44XX_H */
> >
> > --
> > 1.7.0
> >
> >

Best regards,
Hari
