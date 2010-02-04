From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] OMAP: SDP: Introducing 'board-sdp-flash.c' for
 flash init
Date: Thu, 4 Feb 2010 15:50:24 -0800
Message-ID: <20100204235024.GA22747@atomide.com>
References: <ce9ab5791001122253u6b431290o136b2586d90ca92b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:55435 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932660Ab0BDXtx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Feb 2010 18:49:53 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5791001122253u6b431290o136b2586d90ca92b@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [100112 22:51]:
> From 994785b066a9bd4fbaf7753cb6ab7317440afd36 Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 12 Jan 2010 17:22:42 +0530
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

Related to the comments for gpmc-nand.c, you can now get rid of the
gpmc_cs_baseaddr hardcoding in the board-*.c files. The address gets
assigned by gpmc_cs_request based on the chip select and size.

Regards,

Tony
