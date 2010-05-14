From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/2] omap3 nand: cleanup for not to use GPMC virtual
 address
Date: Fri, 14 May 2010 08:28:55 -0700
Message-ID: <20100514152855.GV3428@atomide.com>
References: <s-ghorai@ti.com>
 <1273850591-19040-1-git-send-email-s-ghorai@ti.com>
 <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61136 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab0ENP3B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 11:29:01 -0400
Content-Disposition: inline
In-Reply-To: <1273850591-19040-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com

* Sukumar Ghorai <s-ghorai@ti.com> [100514 08:18]:
> Necessary function added in GPMC module and used by nand driver. This is for
> not to use GPMC address directly from nand driver. Also it was passing GPMC
> base address from board files and that is removed.

Great, this is starting to look good! I'll take a closer look today, some
quick comments below.
 
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -29,27 +29,27 @@
>  #include <plat/sdrc.h>
>  
>  /* GPMC register offsets */
> -#define GPMC_REVISION		0x00
> -#define GPMC_SYSCONFIG		0x10
> -#define GPMC_SYSSTATUS		0x14
> -#define GPMC_IRQSTATUS		0x18
> -#define GPMC_IRQENABLE		0x1c
> -#define GPMC_TIMEOUT_CONTROL	0x40
> -#define GPMC_ERR_ADDRESS	0x44
> -#define GPMC_ERR_TYPE		0x48
> -#define GPMC_CONFIG		0x50
> -#define GPMC_STATUS		0x54
> -#define GPMC_PREFETCH_CONFIG1	0x1e0
> -#define GPMC_PREFETCH_CONFIG2	0x1e4
> -#define GPMC_PREFETCH_CONTROL	0x1ec
> -#define GPMC_PREFETCH_STATUS	0x1f0
> -#define GPMC_ECC_CONFIG		0x1f4
> -#define GPMC_ECC_CONTROL	0x1f8
> -#define GPMC_ECC_SIZE_CONFIG	0x1fc
> -
> -#define GPMC_CS0		0x60
> -#define GPMC_CS_SIZE		0x30
> -
> +#define GPMC_REVISION           0x00
> +#define GPMC_SYSCONFIG          0x10
> +#define GPMC_SYSSTATUS          0x14
> +#define GPMC_IRQSTATUS          0x18
> +#define GPMC_IRQENABLE          0x1c
> +#define GPMC_TIMEOUT_CONTROL    0x40
> +#define GPMC_ERR_ADDRESS        0x44
> +#define GPMC_ERR_TYPE           0x48
> +#define GPMC_CONFIG             0x50
> +#define GPMC_STATUS             0x54
> +#define GPMC_PREFETCH_CONFIG1   0x1e0
> +#define GPMC_PREFETCH_CONFIG2   0x1e4
> +#define GPMC_PREFETCH_CONTROL   0x1ec
> +#define GPMC_PREFETCH_STATUS    0x1f0
> +#define GPMC_ECC_CONFIG         0x1f4
> +#define GPMC_ECC_CONTROL        0x1f8
> +#define GPMC_ECC_SIZE_CONFIG    0x1fc
> +#define GPMC_ECC1_RESULT        0x200
> +
> +#define GPMC_CS0_BASE		0x60
> +#define GPMC_CS_SIZE            0x30
>  #define GPMC_MEM_START		0x00000000
>  #define GPMC_MEM_END		0x3FFFFFFF
>  #define BOOT_ROM_SPACE		0x100000	/* 1MB */

These defines should not be modified that much, looks like some spaces
sneaked in instead of tabs?

Maybe also split this patch into two: First add the new functions,
then remove and convert everything to use the new functions.

Regards,

Tony
