From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2]: OMAP: SDP: Introducing 'board-sdp-flash.c' for
 flash init
Date: Fri, 4 Dec 2009 14:17:12 -0800
Message-ID: <20091204221712.GL24013@atomide.com>
References: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62114 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbZLDWRI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Dec 2009 17:17:08 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790912030610y5608ed48t4635c8995623750@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

* Vimal Singh <vimal.newwork@gmail.com> [091203 06:09]:
> From 13d52884956a26f93826c443e2b8bd78615f74d6 Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Thu, 26 Nov 2009 16:10:24 +0530
> Subject: [PATCH] OMAP: SDP: Introducing 'board-sdp-flash.c' for flash init
> 
> This patch adds 'board-sdp-flash.c', which could be utilized
> by boards similar to 3430SDP. (For ex: 2430sdp, 36030sdp).
> 
> This file does initialization for all three flash devices present
> in SDP boards (NOR, NAND, OneNAND), by finding there 'cs' number
> dynamically using switch setting information (S8: 1-4).
> This also expects partition information from core board files (for
> ex: board-3430sdp.c). Which allows to choose different default
> partitions for different boards.
> 
> A new structure is created for this purpose: 'flash_partitions'
> in 'mach/board-sdp.h'. This has two members:
> 1. struct mtd_partition *parts
> 2. int nr_parts
> 
> A board file is expected to fill this structure and pass it to
> 'sdp-flsash-init'. Partition information should be passed in
> structure array of 'flash_partitions'. Partition information should
> be passed in below sequence in array:
> NOR
> OneNAND
> NAND
> 
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/board-sdp-flash.c        |  246 ++++++++++++++++++++++++++
>  arch/arm/mach-omap2/include/mach/board-sdp.h |   22 +++
>  arch/arm/plat-omap/include/plat/gpmc.h       |    2 +
>  3 files changed, 270 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-sdp-flash.c
>  create mode 100644 arch/arm/mach-omap2/include/mach/board-sdp.h
> 
> diff --git a/arch/arm/mach-omap2/board-sdp-flash.c
> b/arch/arm/mach-omap2/board-sdp-flash.c
> new file mode 100644
> index 0000000..fbbcd0e
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-sdp-flash.c

<snip>

> +__init board_nand_init(struct flash_partitions sdp_nand_parts, u8 cs)
> +{
> +	sdp_nand_data.cs		= cs;
> +	sdp_nand_data.parts		= sdp_nand_parts.parts;
> +	sdp_nand_data.nr_parts		= sdp_nand_parts.nr_parts;
> +
> +	sdp_nand_data.gpmc_cs_baseaddr	= (void *)(OMAP34XX_GPMC_VIRT +
> +							GPMC_CS0_BASE +
> +							cs * GPMC_CS_SIZE);
> +	sdp_nand_data.gpmc_baseaddr	 = (void *) (OMAP34XX_GPMC_VIRT);
> +
> +	gpmc_nand_init(&sdp_nand_data);
> +}

This does not look right. You're supposed to use gpmc_cs_request()
for allocating the GPMC area based on the chip select and size.

> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -27,6 +27,8 @@
> 
>  #define GPMC_CONFIG		0x50
>  #define GPMC_STATUS		0x54
> +#define GPMC_CS0_BASE		0x60
> +#define GPMC_CS_SIZE		0x30

The GPMC_CS0_BASE and GPMC_CS_SIZE seem to be values specic to
your board, not for the GPMC hardware.

Tony
