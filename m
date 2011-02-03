From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v9 0/7] nand prefetch-irq support and ecc layout chanage
Date: Fri, 4 Feb 2011 01:06:34 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B036AB6B036@dbde02.ent.ti.com>
References: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56520 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756491Ab1BCTgn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 14:36:43 -0500
In-Reply-To: <1296209529-22696-1-git-send-email-s-ghorai@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

 
> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Friday, January 28, 2011 3:42 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> Ghorai, Sukumar
> Subject: [PATCH v9 0/7] nand prefetch-irq support and ecc layout chanage
> 
> The following set of patches applies on linux-2.6.
> 
> The main motivations behind this patch series are -
>         1. support NAND I/O in irq mode.
>         2. support of different ECC schema.
>         3. also add support ecc layout as like in romcode ecc layout, but
> not enabled
> 
> v9: gpmc_init() changed to postcore_initcall(gpmc_init);
> 
> v8: free_irq() added; used timeout for while(tight loop)
> And resend of http://www.mail-archive.com/linux-
> omap@vger.kernel.org/msg41614.html
> 
> v7: NAND type (x16 or x8) is board specific and not omap specific; this
> passed form board file.
>     http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41469.html
> 
> v6: configurable transfer type from board file;
>     #define irq number used for nand-irq
>     http://www.mail-archive.com/linux-omap@vger.kernel.org/msg39397.html
> 
> v5: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35860.html
> This address the input as to support the irq_chained in GPMC.
> And resend of
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg35848.html
> 
> v4: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34882.html
> and resend of
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32689.html
> 
> v3: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg32071.html
> Rebase on latest codebase and previous patch(posted).
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31963.html
> 
> v2: Rebase on latest codebase and previous patch(posted).
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31471.html
> 
> v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26666.html
> 
> Sukumar Ghorai (7):
>   omap3630: nand: fix device size to work in polled mode
>   omap3: nand: configurable transfer type per board
>   omap: gpmc: enable irq mode in gpmc
>   omap3: nand: prefetch in irq mode support
>   omap3: nand: configurable fifo threshold to gain the throughput
>   omap3: nand: ecc layout select from board file
>   omap3: nand: making ecc layout as compatible with romcode ecc
> 
>  arch/arm/mach-omap2/board-3430sdp.c    |    2 +-
>  arch/arm/mach-omap2/board-3630sdp.c    |    3 +-
>  arch/arm/mach-omap2/board-flash.c      |   13 +-
>  arch/arm/mach-omap2/board-flash.h      |    4 +-
>  arch/arm/mach-omap2/board-ldp.c        |    2 +-
>  arch/arm/mach-omap2/board-zoom.c       |    5 +-
>  arch/arm/mach-omap2/gpmc-nand.c        |    7 +-
>  arch/arm/mach-omap2/gpmc.c             |   56 +++++-
>  arch/arm/mach-omap2/io.c               |    2 -
>  arch/arm/plat-omap/include/plat/gpmc.h |   18 ++-
>  arch/arm/plat-omap/include/plat/irqs.h |    9 +-
>  arch/arm/plat-omap/include/plat/nand.h |   11 +
>  drivers/mtd/nand/Kconfig               |   17 --
>  drivers/mtd/nand/omap2.c               |  367 ++++++++++++++++++++++++---
> -----
>  14 files changed, 386 insertions(+), 130 deletions(-)
Tony,
In this version I have addressed all inputs on previous versions.
Please check if it's possible to push all theses in any of your testing
branch!
