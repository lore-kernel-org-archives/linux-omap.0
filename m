From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v4 0/4] nand prefetch-irq support and ecc layout chanage
Date: Fri, 6 Aug 2010 14:33:48 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030E65BEFD@dbde02.ent.ti.com>
References: <1280764192-15053-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39480 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390Ab0HFJD6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Aug 2010 05:03:58 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Tony,

> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Wednesday, August 04, 2010 9:29 AM
> To: linux-omap@vger.kernel.org; 'Tony Lindgren'
> Cc: linux-arm-kernel@lists.infradead.org; linux-mtd@lists.infradead.org
> Subject: RE: [PATCH v4 0/4] nand prefetch-irq support and ecc layout
> chanage
> 
> > -----Original Message-----
> > From: Ghorai, Sukumar
> > Sent: Monday, August 02, 2010 9:20 PM
> > To: linux-omap@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org; linux-mtd@lists.infradead.org;
> > Ghorai, Sukumar
> > Subject: [PATCH v4 0/4] nand prefetch-irq support and ecc layout chanage
> >
> >    The following set of patches applies on top of omap-for-linus.
> >
> >    v4: Comments incorporated
> >
> >    v3: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg32071.html
> >    	Rebase on latest codebase and previous patch(posted).
> > 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html
> >
> >    v2: Rebase on latest codebase and previous patch(posted).
> > 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html
> >
> >    v1: http://www.mail-archive.com/linux-
> > omap@vger.kernel.org/msg26666.html
> >
> > Sukumar Ghorai (4):
> > 	omap3: nand: prefetch in irq mode support
> > 	omap: nand: configurable fifo threshold to gain the throughput
> > 	omap: nand: ecc layout select from board file
> > 	omap: nand: making ecc layout as compatible with romcode ecc
> >
> >  arch/arm/mach-omap2/board-flash.c      |    5 +-
> >  arch/arm/mach-omap2/gpmc.c             |   15 ++-
> >  arch/arm/plat-omap/include/plat/gpmc.h |    9 +-
> >  arch/arm/plat-omap/include/plat/irqs.h |    1 +
> >  arch/arm/plat-omap/include/plat/nand.h |    7 +
> >  drivers/mtd/nand/Kconfig               |   14 ++-
> >  drivers/mtd/nand/omap2.c               |  277
> > ++++++++++++++++++++++++++++---
> >  7 files changed, 294 insertions(+), 34 deletions(-)
> [Ghorai]
> Tony,
> Would you please check if you have any input further?

[Ghorai] 
Tony,
Would you please check the status of these patch(s).

Regards,
Ghorai
