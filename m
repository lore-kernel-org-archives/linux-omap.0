From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH] ARM: OMAP2+: Remove unused MUSB initialization code
Date: Thu, 10 Nov 2016 19:43:20 +0200
Message-ID: <1478799800-27945-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

With the removal of board-ldp.c and board-rx51.c, the last users of the
MUSB initialization board code are gone. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
---
 arch/arm/mach-omap2/Makefile   |   1 -
 arch/arm/mach-omap2/usb-musb.c | 106 -----------------------------------------
 arch/arm/mach-omap2/usb.h      |   1 -
 3 files changed, 108 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/usb-musb.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 5b37ec29996e..76e8ba70d952 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -242,7 +242,6 @@ obj-y					+= $(omap-flash-y) $(omap-flash-m)
 omap-hsmmc-$(CONFIG_MMC_OMAP_HS)	:= hsmmc.o
 obj-y					+= $(omap-hsmmc-m) $(omap-hsmmc-y)
 
-obj-y					+= usb-musb.o
 obj-y					+= omap_phy_internal.o
 
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
deleted file mode 100644
index e4562b2b973b..000000000000
--- a/arch/arm/mach-omap2/usb-musb.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- * linux/arch/arm/mach-omap2/usb-musb.c
- *
- * This file will contain the board specific details for the
- * MENTOR USB OTG controller on OMAP3430
- *
- * Copyright (C) 2007-2008 Texas Instruments
- * Copyright (C) 2008 Nokia Corporation
- * Author: Vikram Pandita
- *
- * Generalization by:
- * Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/clk.h>
-#include <linux/dma-mapping.h>
-#include <linux/io.h>
-#include <linux/usb/musb.h>
-
-#include "omap_device.h"
-#include "soc.h"
-#include "mux.h"
-#include "usb.h"
-
-static struct musb_hdrc_config musb_config = {
-	.multipoint	= 1,
-	.dyn_fifo	= 1,
-	.num_eps	= 16,
-	.ram_bits	= 12,
-};
-
-static struct musb_hdrc_platform_data musb_plat = {
-	.mode		= MUSB_OTG,
-
-	/* .clock is set dynamically */
-	.config		= &musb_config,
-
-	/* REVISIT charge pump on TWL4030 can supply up to
-	 * 100 mA ... but this value is board-specific, like
-	 * "mode", and should be passed to usb_musb_init().
-	 */
-	.power		= 50,			/* up to 100 mA */
-};
-
-static u64 musb_dmamask = DMA_BIT_MASK(32);
-
-static struct omap_musb_board_data musb_default_board_data = {
-	.interface_type		= MUSB_INTERFACE_ULPI,
-	.mode			= MUSB_OTG,
-	.power			= 100,
-};
-
-void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
-{
-	struct omap_hwmod		*oh;
-	struct platform_device		*pdev;
-	struct device			*dev;
-	int				bus_id = -1;
-	const char			*oh_name, *name;
-	struct omap_musb_board_data	*board_data;
-
-	if (musb_board_data)
-		board_data = musb_board_data;
-	else
-		board_data = &musb_default_board_data;
-
-	/*
-	 * REVISIT: This line can be removed once all the platforms using
-	 * musb_core.c have been converted to use use clkdev.
-	 */
-	musb_plat.clock = "ick";
-	musb_plat.board_data = board_data;
-	musb_plat.power = board_data->power >> 1;
-	musb_plat.mode = board_data->mode;
-	musb_plat.extvbus = board_data->extvbus;
-
-	oh_name = "usb_otg_hs";
-	name = "musb-omap2430";
-
-        oh = omap_hwmod_lookup(oh_name);
-        if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
-                 __func__, oh_name))
-                return;
-
-	pdev = omap_device_build(name, bus_id, oh, &musb_plat,
-				 sizeof(musb_plat));
-	if (IS_ERR(pdev)) {
-		pr_err("Could not build omap_device for %s %s\n",
-						name, oh_name);
-		return;
-	}
