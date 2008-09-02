From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Kconfig support HW ECC for nand driver on
	OMAP3
Date: Tue, 2 Sep 2008 15:24:43 -0700
Message-ID: <20080902222443.GG23085@atomide.com>
References: <19F8576C6E063C45BE387C64729E739403CD45C99B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50467 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbYIBWYq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 18:24:46 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E739403CD45C99B@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Singh, Vimal" <vimalsingh@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

* Singh, Vimal <vimalsingh@ti.com> [080824 22:53]:
> From: Teerth Reddy <teerth@ti.com>
> 
> Add kconfig support for HW ECC for nand driver on OMAP3
> 
> Signed-off-by: Teerth Reddy <teerth@ti.com>
> ---
>  drivers/mtd/nand/Kconfig |   10 ++++++++++
>  1 files changed, 10 insertions(+)
> 
> Index : linux-omap-2.6/drivers/mtd/nand/Kconfig
> ==================================================================================
> --- a/drivers/mtd/nand/Kconfig	2008-08-25 10:26:51.708901000 +0530
> +++ b/drivers/mtd/nand/Kconfig	2008-08-25 10:28:12.820012000 +0530
> @@ -74,6 +74,16 @@ config MTD_NAND_OMAP2
>  	help
>            Support for NAND flash on Texas Instruments OMAP2 and OMAP3 platforms.
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
>  config MTD_NAND_OMAP
>  	tristate "NAND Flash device on OMAP H3/H2/P2 boards"
>  	depends on ARM && ARCH_OMAP1 && MTD_NAND && (MACH_OMAP_H2 || MACH_OMAP_H3 || MACH_OMAP_PERSEUS2)

This stuff should be all going to the MTD list now. If we still have
some MTD drivers that are not included in the MTD tree, we should
prepare them for merging and send them to the MTD list.

Thanks,

Tony
