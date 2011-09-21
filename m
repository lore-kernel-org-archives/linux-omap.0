From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/3] TI81XX: Prepare for addition of TI814X support
Date: Wed, 21 Sep 2011 13:40:58 -0700
Message-ID: <20110921204057.GJ2937@atomide.com>
References: <1316626735-5597-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29966 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1IUUlD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Sep 2011 16:41:03 -0400
Content-Disposition: inline
In-Reply-To: <1316626735-5597-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>

* Hemant Pedanekar <hemantp@ti.com> [110921 10:05]:
> --- a/arch/arm/mach-omap2/board-ti8168evm.c
> +++ b/arch/arm/mach-omap2/board-ti8168evm.c
> @@ -37,16 +37,16 @@ static void __init ti8168_evm_init(void)
>  
>  static void __init ti8168_evm_map_io(void)
>  {
> -	omap2_set_globals_ti816x();
> -	omapti816x_map_common_io();
> +	omap2_set_globals_ti81xx();
> +	omapti81xx_map_common_io();
>  }
>  
>  MACHINE_START(TI8168EVM, "ti8168evm")
>  	/* Maintainer: Texas Instruments */
>  	.atag_offset	= 0x100,
>  	.map_io		= ti8168_evm_map_io,
> -	.init_early	= ti816x_init_early,
> -	.init_irq	= ti816x_init_irq,
> +	.init_early	= ti81xx_init_early,
> +	.init_irq	= ti81xx_init_irq,
>  	.timer		= &omap3_timer,
>  	.init_machine	= ti8168_evm_init,
>  MACHINE_END

Looks like you still need a minor rebase on the current cleanup
branch as the ti8668_evm_map_io is no longer needed. The cleanup
branch already has Paul's CHIP_IS removal, so that should be
trivial.

Ideally the rename patch would be separate without any functional
changes, maybe you can move the changes and additions to the next
patch?

Tony
