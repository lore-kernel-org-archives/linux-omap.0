From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: Fix GPMC memory initialisation
Date: Fri, 1 Feb 2013 13:51:54 -0800
Message-ID: <20130201215154.GV22517@atomide.com>
References: <1359736726-10193-1-git-send-email-jon-hunter@ti.com>
 <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43042 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757470Ab3BAVv4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Feb 2013 16:51:56 -0500
Content-Disposition: inline
In-Reply-To: <1359736726-10193-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Afzal Mohammed <afzal@ti.com>

Hi Jon,

* Jon Hunter <jon-hunter@ti.com> [130201 08:42]:
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -32,6 +32,7 @@
>  
>  #include "soc.h"
>  #include "common.h"
> +#include "control.h"
>  #include "omap_device.h"
>  #include "gpmc.h"
>  
> @@ -778,18 +779,26 @@ static void gpmc_mem_exit(void)
>  static int gpmc_mem_init(void)
>  {
>  	int cs, rc;
> -	unsigned long boot_rom_space = 0;
>  
> -	/* never allocate the first page, to facilitate bug detection;
> -	 * even if we didn't boot from ROM.
> +	/*
> +	 * The first 1MB of GPMC address space is mapped to the
> +	 * internal ROM. OMAP2 devices are an exception to this
> +	 * where the first 1MB may be mapped to the GPMC.
>  	 */
> -	boot_rom_space = BOOT_ROM_SPACE;
> -	/* In apollon the CS0 is mapped as 0x0000 0000 */
> -	if (machine_is_omap_apollon())
> -		boot_rom_space = 0;

This part is going away anyways with the patch dropping apollon
board support from Kyungin.

> -	gpmc_mem_root.start = GPMC_MEM_START + boot_rom_space;
> +	gpmc_mem_root.start = GPMC_MEM_START + BOOT_ROM_SPACE;
>  	gpmc_mem_root.end = GPMC_MEM_END;
>  
> +	/*
> +	 * OMAP2 devices that boot from external memory devices, will
> +	 * map CS0 to the start of the GPMC address space (0x0). We can
> +	 * test this by checking if SYS_BOOT3 pin is set. If not set
> +	 * then CS0 is mapped to 0x0.
> +	 */
> +	if (cpu_is_omap24xx())
> +		if (!(omap_ctrl_readl(OMAP24XX_CONTROL_STATUS) &
> +		      OMAP2_SYSBOOT_3_MASK))
> +			gpmc_mem_root.start = GPMC_MEM_START;
> +
>  	/* Reserve all regions that has been set up by bootloader */
>  	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
>  		u32 base, size;

How about let's fix this properly to start with so we don't add
more blockers moving this code to drivers/bus?

Looks like gpmc_mem_init() gets called from gpmc_probe() so
we can pass that information in pdev.

Regards,

Tony
