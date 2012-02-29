From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
 mach/io.h
Date: Tue, 28 Feb 2012 17:47:19 -0800
Message-ID: <20120229014719.GK18901@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234049.18709.28987.stgit@kaulin.local>
 <4F4451FB.7070007@gmail.com>
 <20120224000657.GJ18185@atomide.com>
 <20120224182246.GL18185@atomide.com>
 <4F4AFCC7.3020509@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33089 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965866Ab2B2BrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 20:47:25 -0500
Content-Disposition: inline
In-Reply-To: <4F4AFCC7.3020509@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>

* Rob Herring <robherring2@gmail.com> [120226 19:15]:
> On 02/24/2012 12:22 PM, Tony Lindgren wrote:
> > * Tony Lindgren <tony@atomide.com> [120223 15:36]:
> >> * Rob Herring <robherring2@gmail.com> [120221 17:53]:
> >>> On 02/21/2012 05:40 PM, Tony Lindgren wrote:
> >>>> +
> >>>> +/*
> >>>> + * NOTE: Please use ioremap + __raw_read/write where possible instead of these
> >>>> + */
> >>>> +
> >>>> +extern u8 omap_readb(u32 pa);
> >>>> +extern u16 omap_readw(u32 pa);
> >>>> +extern u32 omap_readl(u32 pa);
> >>>> +extern void omap_writeb(u8 v, u32 pa);
> >>>> +extern void omap_writew(u16 v, u32 pa);
> >>>> +extern void omap_writel(u32 v, u32 pa);
> >>>
> >>> These can't be moved to common.h like omap2?
> >>
> >> Not for omap1 currently because a bunch of legacy drivers are
> >> using them :(
> > 
> > Looks like we can have them in mach-omap1/include/mach/hardware.h.
> > 
> > Eventually the SoC specific hardware.h files could be renamed to
> > just something like omap1.h, omap2plus.h and so. And then they
> > could be included in the common hardware.h.
> > 
> > Updated patch below, now io.h for both omap1 and omap2+ are
> > minimized, and turns out only minimal driver changes were needed.
> > 
> 
> Looks good to me. Do you have a branch for this that I can base on?

Yes it's now in iomap branch that merged into my cleanup branch that
I'll ask Arnd and Olof to pull tomorrow.

So take your pick out of the following two:

1. iomap branch based on v3.3-rc4 that you probably want to use

   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap iomap


2. cleanup branch based on RMK's commit 61b80086a525c8a6081257ae40da5dee2bcaee16
   (Merge branch 'entry-macro-cleanup' of git://sources.calxeda.com/kernel/linux into for-armsoc)

   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap cleanup


BTW, I noticed the following fix is needed for some .configs that
I found with randconfig builds, that's only in the cleanup branch
as I already merged in iomap and pushed it out. Should not affect
your patches though.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 28 Feb 2012 17:28:09 -0800
Subject: [PATCH] ARM: OMAP2+: Fix L4_EMU_34XX_BASE error after iomap changes

With the introduction of iomap changes platform init code
fails for emu.c if CONFIG_OMAP3_EMU is selected:

arch/arm/mach-omap2/emu.c:35:8: error:
'L4_EMU_34XX_BASE' undeclared here (not in a function)

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/emu.c
+++ b/arch/arm/mach-omap2/emu.c
@@ -21,6 +21,8 @@
 #include <linux/clk.h>
 #include <linux/err.h>
 
+#include <mach/hardware.h>
+
 #include "iomap.h"
 
 MODULE_LICENSE("GPL");
