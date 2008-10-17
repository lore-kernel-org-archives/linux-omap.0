From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3 NAND: move NAND_BLOCK_SIZE macro to board-3430sdp-flash.c
Date: Fri, 17 Oct 2008 15:28:10 -0700
Message-ID: <20081017222810.GH18573@atomide.com>
References: <46446.192.168.10.89.1223359868.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63369 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101AbYJQW2N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 18:28:13 -0400
Content-Disposition: inline
In-Reply-To: <46446.192.168.10.89.1223359868.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: vimal singh <vimalsingh@ti.com>
Cc: linux-omap@vger.kernel.org

* vimal singh <vimalsingh@ti.com> [081006 23:11]:
> Moving NAND_BLOCK_SIZE definition to board-3430sdp-flash.c

Hmm, looks like this reverts some earlier mistake, pushing.

Tony


> Signed-off-by: Vimal Singh <vimalsingh@ti.com>
> ---
>  arch/arm/mach-omap2/board-3430sdp-flash.c |    2 ++
>  include/linux/mtd/nand.h                  |    2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c
> ===================================================================
> ---
> linux-omap-2.6_27_08_2008.orig/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-10-07
> 11:28:53.000000000 +0530
> +++
> linux-omap-2.6_27_08_2008/arch/arm/mach-omap2/board-3430sdp-flash.c	2008-10-07
> 11:30:12.000000000 +0530
> @@ -26,6 +26,8 @@
>  #include <mach/gpmc.h>
>  #include <mach/nand.h>
> 
> +#define NAND_BLOCK_SIZE		SZ_128K
> +
>  static struct mtd_partition sdp_nor_partitions[] = {
>  	/* bootloader (U-Boot, etc) in first sector */
>  	{
> Index: linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h
> ===================================================================
> --- linux-omap-2.6_27_08_2008.orig/include/linux/mtd/nand.h	2008-10-07
> 11:29:00.000000000 +0530
> +++ linux-omap-2.6_27_08_2008/include/linux/mtd/nand.h	2008-10-07
> 11:29:56.000000000 +0530
> @@ -45,7 +45,7 @@
>   */
>  #define NAND_MAX_OOBSIZE	64
>  #define NAND_MAX_PAGESIZE	2048
> -#define NAND_BLOCK_SIZE		SZ_128K
> +
>  /*
>   * Constants for hardware specific CLE/ALE/NCE function
>   *
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
