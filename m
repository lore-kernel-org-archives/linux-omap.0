From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 3b/6] omap: Split vmalloc.h for mach-omap1 and
	mach-omap2
Date: Tue, 20 Oct 2009 10:42:23 -0700
Message-ID: <20091020174223.GH12576@atomide.com>
References: <20091014213748.30227.71513.stgit@kaulin.muru.com> <20091014214920.30227.10280.stgit@kaulin.muru.com> <20091020165714.GC12576@atomide.com> <A24693684029E5489D1D202277BE89444CFD9E9C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49629 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbZJTRmW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 13:42:22 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE89444CFD9E9C@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [091020 10:15]:
> Tony, 
> 
> > -----Original Message-----
> > From: linux-omap-owner@vger.kernel.org 
> > [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> > Sent: Tuesday, October 20, 2009 11:57 AM
> > To: linux-arm-kernel@lists.infradead.org
> > Cc: linux-omap@vger.kernel.org
> > Subject: [PATCH 3b/6] omap: Split vmalloc.h for mach-omap1 
> > and mach-omap2
> > 
> > I've added a patch to split vmalloc.h into this series to allow
> > different VMALLOC_END on omap1 and omap2.
> > 
> > Regards,
> > 
> > Tony
> > 
> > From 72464dbae2749dd57bc2b3cd57d4fc6ba7abca37 Mon Sep 17 00:00:00 2001
> > From: Tony Lindgren <tony@atomide.com>
> > Date: Mon, 19 Oct 2009 17:26:29 -0700
> > Subject: [PATCH] omap: Split vmalloc.h for mach-omap1 and mach-omap2
> > 
> > Earlier patch "omap: Remap L3, L4 to get more kernel io address space"
> > changed the VMALLOC_END.
> > 
> > However, this change causes problems on mach-omap1:
> > 
> > BUG: mapping for 0xe0000000 at 0xe0000000 overlaps vmalloc space
> > BUG: mapping for 0xe1000000 at 0xe1000000 overlaps vmalloc space
> > 
> > Fix this by creating separate vmalloc.h files for mach-omap1
> > and mach-omap2.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h 
> > b/arch/arm/mach-omap1/include/mach/vmalloc.h
> > similarity index 86%
> > copy from arch/arm/plat-omap/include/mach/vmalloc.h
> > copy to arch/arm/mach-omap1/include/mach/vmalloc.h
> > index fc338a5..1b2af14 100644
> > --- a/arch/arm/plat-omap/include/mach/vmalloc.h
> > +++ b/arch/arm/mach-omap1/include/mach/vmalloc.h
> > @@ -1,5 +1,5 @@
> >  /*
> > - *  arch/arm/plat-omap/include/mach/vmalloc.h
> > + *  arch/arm/mach-omap1/include/mach/vmalloc.h
> 
> I thought that keeping file paths was discouraged...
> 
> Why not getting rid of it to avoid changing it every time?

Well mostly to keep things consistent with existing files.
If we want to, we can do a separate series to remove the
paths for all the files later on.

Regards,

Tony
 
> Regards,
> Sergio
> >   *
> >   *  Copyright (C) 2000 Russell King.
> >   *
> > @@ -17,8 +17,4 @@
> >   * along with this program; if not, write to the Free Software
> >   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
> > 02111-1307 USA
> >   */
> > -#ifdef CONFIG_ARCH_OMAP1
> >  #define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
> > -#else
> > -#define VMALLOC_END	(PAGE_OFFSET + 0x38000000)
> > -#endif
> > diff --git a/arch/arm/plat-omap/include/mach/vmalloc.h 
> > b/arch/arm/mach-omap2/include/mach/vmalloc.h
> > similarity index 85%
> > rename from arch/arm/plat-omap/include/mach/vmalloc.h
> > rename to arch/arm/mach-omap2/include/mach/vmalloc.h
> > index fc338a5..9ce9b6e 100644
> > --- a/arch/arm/plat-omap/include/mach/vmalloc.h
> > +++ b/arch/arm/mach-omap2/include/mach/vmalloc.h
> > @@ -17,8 +17,4 @@
> >   * along with this program; if not, write to the Free Software
> >   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 
> > 02111-1307 USA
> >   */
> > -#ifdef CONFIG_ARCH_OMAP1
> > -#define VMALLOC_END	(PAGE_OFFSET + 0x18000000)
> > -#else
> > -#define VMALLOC_END	(PAGE_OFFSET + 0x38000000)
> > -#endif
> > +#define VMALLOC_END	  (PAGE_OFFSET + 0x38000000)
> > --
> > To unsubscribe from this list: send the line "unsubscribe 
> > linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
