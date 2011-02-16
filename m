From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re:
Date: Wed, 16 Feb 2011 15:00:33 +0300
Message-ID: <4D5BBC61.2000905@ru.mvista.com>
References: <1297857190-27449-1-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47076 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755267Ab1BPMBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:01:51 -0500
In-Reply-To: <1297857190-27449-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema HK <hemahk@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

On 16-02-2011 14:53, Hema HK wrote:

> From: Hema HK<hemahk@ti.com

> Moved all the board specific internal PHY functions out of usb_musb.c file
> as this file is shared between the OMAP2+ and AM35xx platforms.
> There exists a file which has the functions specific to internal PHY
> used for OMAP4 platform. Moved all phy specific functions to this file
> and passing these functions through board data in the board file.

> Signed-off-by: Hema HK<hemahk@ti.com>

> Index: linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/board-am3517evm.c
> +++ linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
> @@ -409,6 +409,10 @@ static struct omap_musb_board_data musb_
>   	.interface_type         = MUSB_INTERFACE_ULPI,
>   	.mode                   = MUSB_OTG,
>   	.power                  = 500,
> +	.set_phy_power		= am35x_musb_phy_power,
> +	.clear_irq		= am35x_musb_clear_irq,
> +	.set_mode		= am35x_musb_set_mode,
> +	.reset			= am35x_musb_reset,
>   };
>
>   static __init void am3517_evm_musb_init(void)
[...]
> Index: linux-2.6/arch/arm/mach-omap2/Makefile
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/Makefile
> +++ linux-2.6/arch/arm/mach-omap2/Makefile
> @@ -218,7 +218,8 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board
>   					   hsmmc.o \
>   					   omap_phy_internal.o
>
> -obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
> +obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
> +					   omap_phy_internal.o \
>
>   obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o

    Doesn't the above board needs board data modified as well?

WBR, Sergei
