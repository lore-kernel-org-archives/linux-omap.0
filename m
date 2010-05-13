From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] omap3: GPMC register definition at common location
Date: Thu, 13 May 2010 08:41:59 -0700
Message-ID: <20100513154158.GJ29368@atomide.com>
References: <s-ghorai@ti.com>
 <1273657718-12517-1-git-send-email-s-ghorai@ti.com>
 <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64996 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759104Ab0EMPmI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 May 2010 11:42:08 -0400
Content-Disposition: inline
In-Reply-To: <1273657718-12517-2-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, sakoman@gmail.com, mike@compulab.co.il, Artem.Bityutskiy@nokia.com

* Sukumar Ghorai <s-ghorai@ti.com> [100512 02:43]:
> --- a/arch/arm/plat-omap/include/plat/gpmc.h
> +++ b/arch/arm/plat-omap/include/plat/gpmc.h
> @@ -25,10 +25,40 @@
>  #define GPMC_CS_NAND_ADDRESS	0x20
>  #define GPMC_CS_NAND_DATA	0x24
>  
> -#define GPMC_CONFIG		0x50
> -#define GPMC_STATUS		0x54
> +/* GPMC register offsets */
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
...

No thanks, that will just make the situation worse
leading into all the drivers messing with the GPMC
registers.

Tony
