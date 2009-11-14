From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: OMAP: DMA: Use some define rather than a hexadecimal constant for LCD register
Date: Sat, 14 Nov 2009 03:12:43 +0100
Message-ID: <200911140312.45490.jkrzyszt@tis.icnet.pl>
References: <20091114005710.GI3684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:55132 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753952AbZKNCM4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Nov 2009 21:12:56 -0500
In-Reply-To: <20091114005710.GI3684@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Saturday 14 November 2009 01:57:10 Tony Lindgren napisa=C5=82(a):
> * Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091110 03:20]:
> > The patch corrects the issue introduced with my previous patch:
> > 	"OMAP: DMA: Fix omapfb/lcdc on OMAP1510 broken when PM set"
> > as pointed out by OMAP subsystem maintainer.
>
> Looks like this patch needs to be refreshed against linux-omap
> for-next branch.

OK, I'll take care of this.

Janusz

> Tony
>
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >
> > ---
> > Hi,
> >
> > I'd really like to have the first one get in as a fix in the -rc se=
ries,
> > that's why I decided to correct the issue in a follow up.
> >
> > Thanks,
> > Janusz
> > ---
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > diff -upr linux-2.6.32-rc6.orig/arch/arm/plat-omap/dma.c
> > linux-2.6.32-rc6/arch/arm/plat-omap/dma.c ---
> > linux-2.6.32-rc6.orig/arch/arm/plat-omap/dma.c	2009-11-05
> > 19:30:39.000000000 +0100 +++
> > linux-2.6.32-rc6/arch/arm/plat-omap/dma.c	2009-11-10 03:57:06.00000=
0000
> > +0100 @@ -34,6 +34,7 @@
> >  #include <mach/hardware.h>
> >  #include <mach/dma.h>
> >
> > +#include <mach/omapfb.h>
> >  #include <mach/tc.h>
> >
> >  #undef DEBUG
> > @@ -1113,7 +1114,7 @@ int omap_dma_running(void)
> >  	 * when it gets enabled, so assume DMA running if LCD enabled.
> >  	 */
> >  	if (cpu_is_omap1510())
> > -		if (omap_readw(0xfffec000 + 0x00) & (1 << 0))
> > +		if (omap_readw(OMAP_LCDC_CONTROL) & OMAP_LCDC_CTRL_LCD_EN)
> >  			return 1;
> >
> >  	/* Check if LCD DMA is running */
> > diff -upr linux-2.6.32-rc6.orig/arch/arm/plat-omap/include/mach/oma=
pfb.h
> > linux-2.6.32-rc6/arch/arm/plat-omap/include/mach/omapfb.h ---
> > linux-2.6.32-rc6.orig/arch/arm/plat-omap/include/mach/omapfb.h	2009=
-11-03
> > 20:37:49.000000000 +0100 +++
> > linux-2.6.32-rc6/arch/arm/plat-omap/include/mach/omapfb.h	2009-11-1=
0
> > 03:52:00.000000000 +0100 @@ -170,6 +170,38 @@ enum omapfb_update_mo=
de {
> >
> >  #include <mach/board.h>
> >
> > +#define OMAP_LCDC_BASE			0xfffec000
> > +#define OMAP_LCDC_SIZE			256
> > +#define OMAP_LCDC_IRQ			INT_LCD_CTRL
> > +
> > +#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
> > +#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
> > +#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
> > +#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
> > +#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
> > +#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
> > +#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
> > +#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
> > +
> > +#define OMAP_LCDC_STAT_DONE		(1 << 0)
> > +#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
> > +#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
> > +#define OMAP_LCDC_STAT_ABC		(1 << 3)
> > +#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
> > +#define OMAP_LCDC_STAT_FUF		(1 << 5)
> > +#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
> > +
> > +#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
> > +#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
> > +#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
> > +
> > +#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
> > +#define OMAP_LCDC_IRQ_DONE		(1 << 3)
> > +#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
> > +#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
> > +#define OMAP_LCDC_IRQ_LINE		(1 << 6)
> > +#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
> > +
> >  #define OMAP_LCDC_INV_VSYNC             0x0001
> >  #define OMAP_LCDC_INV_HSYNC             0x0002
> >  #define OMAP_LCDC_INV_PIX_CLOCK         0x0004
> > diff -upr linux-2.6.32-rc6.orig/drivers/video/omap/lcdc.c
> > linux-2.6.32-rc6/drivers/video/omap/lcdc.c ---
> > linux-2.6.32-rc6.orig/drivers/video/omap/lcdc.c	2009-11-03
> > 20:37:49.000000000 +0100 +++
> > linux-2.6.32-rc6/drivers/video/omap/lcdc.c	2009-11-10 03:51:16.0000=
00000
> > +0100 @@ -38,38 +38,6 @@
> >
> >  #define MODULE_NAME			"lcdc"
> >
> > -#define OMAP_LCDC_BASE			0xfffec000
> > -#define OMAP_LCDC_SIZE			256
> > -#define OMAP_LCDC_IRQ			INT_LCD_CTRL
> > -
> > -#define OMAP_LCDC_CONTROL		(OMAP_LCDC_BASE + 0x00)
> > -#define OMAP_LCDC_TIMING0		(OMAP_LCDC_BASE + 0x04)
> > -#define OMAP_LCDC_TIMING1		(OMAP_LCDC_BASE + 0x08)
> > -#define OMAP_LCDC_TIMING2		(OMAP_LCDC_BASE + 0x0c)
> > -#define OMAP_LCDC_STATUS		(OMAP_LCDC_BASE + 0x10)
> > -#define OMAP_LCDC_SUBPANEL		(OMAP_LCDC_BASE + 0x14)
> > -#define OMAP_LCDC_LINE_INT		(OMAP_LCDC_BASE + 0x18)
> > -#define OMAP_LCDC_DISPLAY_STATUS	(OMAP_LCDC_BASE + 0x1c)
> > -
> > -#define OMAP_LCDC_STAT_DONE		(1 << 0)
> > -#define OMAP_LCDC_STAT_VSYNC		(1 << 1)
> > -#define OMAP_LCDC_STAT_SYNC_LOST	(1 << 2)
> > -#define OMAP_LCDC_STAT_ABC		(1 << 3)
> > -#define OMAP_LCDC_STAT_LINE_INT		(1 << 4)
> > -#define OMAP_LCDC_STAT_FUF		(1 << 5)
> > -#define OMAP_LCDC_STAT_LOADED_PALETTE	(1 << 6)
> > -
> > -#define OMAP_LCDC_CTRL_LCD_EN		(1 << 0)
> > -#define OMAP_LCDC_CTRL_LCD_TFT		(1 << 7)
> > -#define OMAP_LCDC_CTRL_LINE_IRQ_CLR_SEL	(1 << 10)
> > -
> > -#define OMAP_LCDC_IRQ_VSYNC		(1 << 2)
> > -#define OMAP_LCDC_IRQ_DONE		(1 << 3)
> > -#define OMAP_LCDC_IRQ_LOADED_PALETTE	(1 << 4)
> > -#define OMAP_LCDC_IRQ_LINE_NIRQ		(1 << 5)
> > -#define OMAP_LCDC_IRQ_LINE		(1 << 6)
> > -#define OMAP_LCDC_IRQ_MASK		(((1 << 5) - 1) << 2)
> > -
> >  #define MAX_PALETTE_SIZE		PAGE_SIZE
> >
> >  enum lcdc_load_mode {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
