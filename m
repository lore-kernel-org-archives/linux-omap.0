From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/8] ARM: OMAP: Remove plat/io.h by moving it into
 mach/io.h
Date: Thu, 23 Feb 2012 16:06:58 -0800
Message-ID: <20120224000657.GJ18185@atomide.com>
References: <20120221233619.18709.87982.stgit@kaulin.local>
 <20120221234049.18709.28987.stgit@kaulin.local>
 <4F4451FB.7070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:40991 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757429Ab2BXAHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Feb 2012 19:07:02 -0500
Content-Disposition: inline
In-Reply-To: <4F4451FB.7070007@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Rob Herring <robherring2@gmail.com> [120221 17:53]:
> On 02/21/2012 05:40 PM, Tony Lindgren wrote:
> > This is needed so we can eventually remove mach/io.h
> > for omap2+.
...

> > -#include <plat/io.h>
> > +#ifndef __ASM_ARM_ARCH_IO_H
> > +#define __ASM_ARM_ARCH_IO_H
> > +
> > +#include <mach/hardware.h>
> 
> This shouldn't be needed.

Good catch, will update things for that.
 
> > +
> > +#define IO_SPACE_LIMIT 0xffffffff
> > +
> > +/*
> > + * We don't actually have real ISA nor PCI buses, but there is so many
> > + * drivers out there that might just work if we fake them...
> > + */
> > +#define __io(a)		__typesafe_io(a)
> > +#define __mem_pci(a)	(a)
> > +
> > +/*
> > + * ----------------------------------------------------------------------------
> > + * I/O mapping
> > + * ----------------------------------------------------------------------------
> > + */
> > +
> > +#ifdef __ASSEMBLER__
> > +#define IOMEM(x)		(x)
> > +#else
> > +#define IOMEM(x)		((void __force __iomem *)(x))
> > +#endif
> > +
> 
> This can't be moved to iomap.h? I did that for other platforms.

Well I was thinking we should define these somewhere for everybody,
so I was trying to avoid adding yet another copy.. But I can move
it and then we can clean it up later to avoid more dependencies here.
 
> > +/*
> > + * ----------------------------------------------------------------------------
> > + * Omap specific register access
> > + * ----------------------------------------------------------------------------
> > + */
> > +
> > +#ifndef __ASSEMBLER__
> > +
> > +/*
> > + * NOTE: Please use ioremap + __raw_read/write where possible instead of these
> > + */
> > +
> > +extern u8 omap_readb(u32 pa);
> > +extern u16 omap_readw(u32 pa);
> > +extern u32 omap_readl(u32 pa);
> > +extern void omap_writeb(u8 v, u32 pa);
> > +extern void omap_writew(u16 v, u32 pa);
> > +extern void omap_writel(u32 v, u32 pa);
> 
> These can't be moved to common.h like omap2?

Not for omap1 currently because a bunch of legacy drivers are
using them :(

Anyways, that should be OK for now as omap1 requires v5 flags
and it currently does not make sense to try to compile into a
common zImage. At least the USB driver already needs to be
cleaned up for that, so eventually omap1 io.h can disappear
too.
 
> Same comments on omap2 io.h.

Thanks, will post an updated patch.

Regards,

Tony
