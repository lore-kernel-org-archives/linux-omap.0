From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: NAND: Adding config option to enable/disable HW
 ECC mode
Date: Tue, 15 Dec 2009 09:35:10 -0800
Message-ID: <20091215173510.GH4575@atomide.com>
References: <ce9ab5790912150746t29be1640g817ab883b16860a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61692 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbZLORfW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 12:35:22 -0500
Content-Disposition: inline
In-Reply-To: <ce9ab5790912150746t29be1640g817ab883b16860a3@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vimal Singh <vimal.newwork@gmail.com>
Cc: Linux MTD <linux-mtd@lists.infradead.org>, linux-omap@vger.kernel.org

* Vimal Singh <vimal.newwork@gmail.com> [091215 07:45]:
> OMAP NAND driver got HW ECC implemented.
> 
> From d5e28c9fdbc6b0a95c1259fac7add207f9c294d7 Mon Sep 17 00:00:00 2001
> From: Vimal Singh <vimalsingh@ti.com>
> Date: Tue, 15 Dec 2009 21:10:54 +0530
> Subject: [PATCH] OMAP: NAND: Adding config option to enable/disable HW ECC mode
> 
> This patch adds config option to select/deselect HW ECC feature
> on OMAP NAND driver. This is a feature provided by OMAP GPMC for
> NAND devices.
> 
> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  drivers/mtd/nand/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 34598e9..6c4b27c 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -97,6 +97,16 @@ config MTD_NAND_OMAP_PREFETCH_DMA
>  	 or in DMA interrupt mode.
>  	 Say y for DMA mode or MPU mode will be used
> 
> +config MTD_NAND_OMAP_HWECC
> +	bool "The Hardware ECC support"
> +	depends on MTD_NAND && MTD_NAND_OMAP2
> +	default n
> +	help
> +	 The ECC compuatation for the data to be written/read can be either by
> +	 software or omap has Hw ecc engine which calculates it.
> +	 MTD_NAND_OMAP_HWECC = y which enables the hw ecc
> +	 MTD_NAND_OMAP_HWECC = n enables software ecc
> +
>  config MTD_NAND_TS7250
>  	tristate "NAND Flash device on TS-7250 board"
>  	depends on MACH_TS72XX

This sounds like it should be an option passed from the board-*.c
files as platform_data rather than a Kconfig option.

Tony
