From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: [PATCH v5] OMAP1: LCD_DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Sat, 5 Dec 2009 14:49:29 +0100
Message-ID: <200912051449.30525.jkrzyszt@tis.icnet.pl>
References: <20091116222517.GT3684@atomide.com> <20091117161058.GA29266@atomide.com> <200911242234.11705.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:49542 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZLENtT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Dec 2009 08:49:19 -0500
In-Reply-To: <200911242234.11705.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tuesday 24 November 2009 22:34:10 Janusz Krzysztofik napisa=C5=82(a):
> The patch corrects the issue introduced with one of my earlier patche=
s:
> 	OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set[1]
> as pointed out by OMAP subsystem maintainer.

Tony,

I've noticed that you've marked this patch as Superseded in your patchw=
ork=20
queue. This is not the case. It is still supposed to correct the issue,=
 now=20
sitting in mach-omap1/lcd_dma.c after being moved from plat-omap/dma.c.

Thanks,
Janusz

> Applies on top of my prevoius patch:
>   OMAP: DMA: move LCD DMA related code from plat-omap to mach-omap1[2=
]
>
> Tested on Amstrad Delta
> Compile tested with omap_generic_2420_defconfig
>
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>
> [1] http://patchwork.kernel.org/patch/57922/
> [2] http://patchwork.kernel.org/patch/61952/
> ---
>
> Tuesday 17 November 2009 17:10:58 Tony Lindgren wrote:
> > * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091117 02:45]:
> > > 1. While keeping those hex constants as they are for now, solve t=
he
> > > issue during refactoring arch/arm/plat-omap/dma.c for a separate
> > > arch/arm/mach-omap1/lcd_dma.c, as Paul suggested (may take some t=
ime).
> > > Since the register test would be put there, some headers will hav=
e to
> > > be moved out of drivers/video/omap/lcdc.c anyway.
> >
> > This sounds like the best way to go to me.
>
> Tony,
>
> At your service :-).
>
> Since it's very similiar to reverted v3[*], I hope you have no proble=
ms
> with this one.
>
> Thanks,
> Janusz
>
> [*] http://patchwork.kernel.org/patch/60478/
>
> diff -uprN git.orig/arch/arm/mach-omap1/include/mach/lcdc.h
> git/arch/arm/mach-omap1/include/mach/lcdc.h ---
> git.orig/arch/arm/mach-omap1/include/mach/lcdc.h	1970-01-01
> 01:00:00.000000000 +0100 +++
> git/arch/arm/mach-omap1/include/mach/lcdc.h	2009-11-21 03:26:32.00000=
0000
> +0100 @@ -0,0 +1,57 @@
> +/*
> + * arch/arm/mach-omap1/include/mach/lcdc.h
> + *
> + * Extracted from drivers/video/omap/lcdc.c
> + * Copyright (C) 2004 Nokia Corporation
> + * Author: Imre Deak <imre.deak@nokia.com>
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify it
> + * under the terms of the GNU General Public License as published by=
 the
> + * Free Software Foundation; either version 2 of the License, or (at=
 your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful, b=
ut
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License=
 along
> + * with this program; if not, write to the Free Software Foundation,=
 Inc.,
> + * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
> + */
> +#ifndef __MACH_LCDC_H__
> +#define __MACH_LCDC_H__
> +
> +#define OMAP_LCDC_BASE			0xfffec000
> +#define OMAP_LCDC_SIZE			256
> +#define OMAP_LCDC_IRQ			INT_LCD_CTRL
> +
> +#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
> +#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
> +#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
> +#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
> +#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
> +#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
> +#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
> +#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
> +
> +#define OMAP_LCDC_STAT_DONE		(1 << 0)
> +#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
> +#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
> +#define OMAP_LCDC_STAT_ABC		(1 << 3)
> +#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
> +#define OMAP_LCDC_STAT_FUF		(1 << 5)
> +#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
> +
> +#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
> +#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
> +#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
> +
> +#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
> +#define OMAP_LCDC_IRQ_DONE		(1 << 3)
> +#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
> +#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
> +#define OMAP_LCDC_IRQ_LINE		(1 << 6)
> +#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
> +
> +#endif /* __MACH_LCDC_H__ */
> diff -uprN git.orig/arch/arm/mach-omap1/lcd_dma.c
> git/arch/arm/mach-omap1/lcd_dma.c ---
> git/arch/arm/mach-omap1/lcd_dma.c	2009-11-21 14:36:59.000000000 +0100=
 +++
> git.orig/arch/arm/mach-omap1/lcd_dma.c	2009-11-21 03:42:25.000000000 =
+0100
> @@ -28,6 +28,7 @@
>  #include <linux/io.h>
>
>  #include <mach/hardware.h>
> +#include <mach/lcdc.h>
>  #include <plat/dma.h>
>
>  int omap_lcd_dma_running(void)
> @@ -37,7 +38,7 @@ int omap_lcd_dma_running(void)
>  	 * when it gets enabled, so assume DMA running if LCD enabled.
>  	 */
>  	if (cpu_is_omap1510())
> -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
>  			return 1;
>
>  	/* Check if LCD DMA is running */
> diff -uprN git.orig/drivers/video/omap/lcdc.c git/drivers/video/omap/=
lcdc.c
> --- git.orig/drivers/video/omap/lcdc.c	2009-11-21 14:33:16.000000000 =
+0100
> +++ git/drivers/video/omap/lcdc.c	2009-11-21 02:17:17.000000000 +0100
> @@ -29,6 +29,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/clk.h>
>
> +#include <mach/lcdc.h>
>  #include <plat/dma.h>
>  #include <plat/omapfb.h>
>
> @@ -38,38 +39,6 @@
>
>  #define MODULE_NAME			"lcdc"
>
> -#define OMAP_LCDC_BASE			0xfffec000
> -#define OMAP_LCDC_SIZE			256
> -#define OMAP_LCDC_IRQ			INT_LCD_CTRL
> -
> -#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
> -#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
> -#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
> -#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
> -#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
> -#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
> -#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
> -#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
> -
> -#define OMAP_LCDC_STAT_DONE		(1 << 0)
> -#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
> -#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
> -#define OMAP_LCDC_STAT_ABC		(1 << 3)
> -#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
> -#define OMAP_LCDC_STAT_FUF		(1 << 5)
> -#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
> -
> -#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
> -#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
> -#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
> -
> -#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
> -#define OMAP_LCDC_IRQ_DONE		(1 << 3)
> -#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
> -#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
> -#define OMAP_LCDC_IRQ_LINE		(1 << 6)
> -#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
> -
>  #define MAX_PALETTE_SIZE		PAGE_SIZE
>
>  enum lcdc_load_mode {


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
