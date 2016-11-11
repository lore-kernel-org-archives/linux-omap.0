From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/14] ARM: OMAP2+: Remove legacy usb-musb.c platform init code
Date: Fri, 11 Nov 2016 11:17:04 -0800
Message-ID: <20161111191711.5079-8-tony@atomide.com>
References: <20161111191711.5079-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161111191711.5079-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is no longer needed when booted with device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile   |   1 -
 arch/arm/mach-omap2/usb-musb.c | 106 -----------------------------------------
 2 files changed, 107 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/usb-musb.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
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
- * Felipe Balbi <felipe.balbi@nokia.com>
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
-
-	dev = &pdev->dev;
-	get_device(dev);
-	dev->dma_mask = &musb_dmamask;
-	dev->coherent_dma_mask = musb_dmamask;
-	put_device(dev);
-}
-- 
2.10.2
