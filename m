From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/6] TI816X: Add low level debug support
Date: Thu, 16 Sep 2010 15:28:18 -0700
Message-ID: <20100916222817.GS29610@atomide.com>
References: <1281546687-11593-1-git-send-email-hemantp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60416 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756287Ab0IPW2W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 18:28:22 -0400
Content-Disposition: inline
In-Reply-To: <1281546687-11593-1-git-send-email-hemantp@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hemant Pedanekar <hemantp@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com

* Hemant Pedanekar <hemantp@ti.com> [100811 10:04]:
> This patch adds support for low level debugging on TI816X boards. Currently the
> support for UART3 console on TI816X EVM is added.

> --- a/arch/arm/mach-omap2/include/mach/debug-macro.S
> +++ b/arch/arm/mach-omap2/include/mach/debug-macro.S
> @@ -66,6 +66,12 @@ omap_uart_lsr:	.word	0
>  		beq	34f			@ configure OMAP3UART4
>  		cmp	\rx, #OMAP4UART4	@ only on 44xx
>  		beq	44f			@ configure OMAP4UART4
> +		cmp	\rx, #TI816XUART1	@ ti816x UART offsets different
> +		beq	81f			@ configure UART1
> +		cmp	\rx, #TI816XUART2	@ ti816x UART offsets different
> +		beq	82f			@ configure UART2
> +		cmp	\rx, #TI816XUART3	@ ti816x UART offsets different
> +		beq	83f			@ configure UART3
>  		cmp	\rx, #ZOOM_UART		@ only on zoom2/3
>  		beq	95f			@ configure ZOOM_UART
>  

Would be nice to have the TI816XUART defines in this patch too
instead of defining them in some other patch earlier.

Tony
