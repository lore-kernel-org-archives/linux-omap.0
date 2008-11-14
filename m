From: Tony Lindgren <tony@atomide.com>
Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS
	Patches
Date: Fri, 14 Nov 2008 13:50:37 -0800
Message-ID: <20081114215036.GQ3106@atomide.com>
References: <hvaibhav@ti.com> <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54244 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbYKNVuk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 16:50:40 -0500
Content-Disposition: inline
In-Reply-To: <1226644352-22060-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

* hvaibhav@ti.com <hvaibhav@ti.com> [081113 22:33]:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> Tested LCD, TV, DVI (480P) out on OMAP3EVM board.
> 
> Please make sure that you change the option
> CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE=7  and apply the
> Mans Rullgard clock patches to support set_rate and round_rate API.
> 
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c

> @@ -227,11 +430,13 @@ static void __init omap3_evm_init_irq(void)
> 
>  static struct omap_board_config_kernel omap3_evm_config[] __initdata = {
>  	{ OMAP_TAG_UART,	&omap3_evm_uart_config },
> -	{ OMAP_TAG_LCD,		&omap3_evm_lcd_config },
> +	{ OMAP_TAG_FBMEM,       &evm_fbmem0_config },
> +	{ OMAP_TAG_FBMEM,       &evm_fbmem1_config },
> +	{ OMAP_TAG_FBMEM,       &evm_fbmem2_config },
>  };
> 

Guys, please update your patches to remove the OMAP_TAG_FBMEM stuff
and rely on just platform_data. All the OMAP_TAGs will be disappearing
real soon now.

Tony
