From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
Date: Fri, 26 Nov 2010 23:27:37 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369E7B95B@dbde02.ent.ti.com>
References: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41285 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751302Ab0KZR5q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Nov 2010 12:57:46 -0500
In-Reply-To: <1290785677-16005-1-git-send-email-s-ghorai@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hello Grazvydas & Charles,
Would you please check this series in you setup and please update the status or any issue you observe?

Regards,
Ghorai


> -----Original Message-----
> From: Ghorai, Sukumar
> Sent: Friday, November 26, 2010 9:05 PM
> To: linux-omap@vger.kernel.org
> Cc: linux-mtd@lists.infradead.org; linux-arm-kernel@lists.infradead.org;
> Ghorai, Sukumar
> Subject: [PATCH v6 0/7] nand prefetch-irq support and ecc layout chanage
> 
> The following set of patches applies on linux-2.6.
> 
> The main motivations behind this patch series are -
>         1. support NAND I/O in irq mode.
>         2. support of different ECC schema.
>         3. also to make ecc layout as like in romcode ecc layout
> 
> 
> v6: configurable transfer type from board file;
>     #define irq number used for nand-irq
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
>   omap: nand: ecc layout select from board file
>   omap: nand: making ecc layout as compatible with romcode ecc
> 
>  arch/arm/mach-omap2/board-2430sdp.c        |    1 +
>  arch/arm/mach-omap2/board-3430sdp.c        |    1 +
>  arch/arm/mach-omap2/board-3630sdp.c        |    1 +
>  arch/arm/mach-omap2/board-4430sdp.c        |    2 +
>  arch/arm/mach-omap2/board-am3517evm.c      |    2 +
>  arch/arm/mach-omap2/board-apollon.c        |    1 +
>  arch/arm/mach-omap2/board-cm-t35.c         |    1 +
>  arch/arm/mach-omap2/board-devkit8000.c     |    1 +
>  arch/arm/mach-omap2/board-flash.c          |    7 +
>  arch/arm/mach-omap2/board-generic.c        |    2 +
>  arch/arm/mach-omap2/board-h4.c             |    1 +
>  arch/arm/mach-omap2/board-igep0020.c       |    1 +
>  arch/arm/mach-omap2/board-ldp.c            |    1 +
>  arch/arm/mach-omap2/board-n8x0.c           |    2 +
>  arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
>  arch/arm/mach-omap2/board-omap3evm.c       |    2 +
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 +
>  arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
>  arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
>  arch/arm/mach-omap2/board-omap4panda.c     |    2 +
>  arch/arm/mach-omap2/board-overo.c          |    1 +
>  arch/arm/mach-omap2/board-rx51.c           |    1 +
>  arch/arm/mach-omap2/board-zoom2.c          |    2 +
>  arch/arm/mach-omap2/board-zoom3.c          |    2 +
>  arch/arm/mach-omap2/gpmc.c                 |   50 ++++-
>  arch/arm/mach-omap2/io.c                   |    2 -
>  arch/arm/plat-omap/include/plat/gpmc.h     |   16 ++-
>  arch/arm/plat-omap/include/plat/irqs.h     |    9 +-
>  arch/arm/plat-omap/include/plat/nand.h     |   11 +
>  drivers/mtd/nand/Kconfig                   |   17 --
>  drivers/mtd/nand/omap2.c                   |  314 ++++++++++++++++++++++-
> -----
>  31 files changed, 364 insertions(+), 94 deletions(-)

