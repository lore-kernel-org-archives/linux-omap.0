From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/10] ARM: OMAP2+: Drop board file for ti8168evm
Date: Wed, 29 Oct 2014 17:29:07 -0700
Message-ID: <1414628948-30702-10-git-send-email-tony@atomide.com>
References: <1414628948-30702-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:52314 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756446AbaJ3Aah (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Oct 2014 20:30:37 -0400
In-Reply-To: <1414628948-30702-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

The 81xx support is known to be broken for quite some
time now because of missing patches. And it should be
using device tree based booting now anyways.

So let's just drop the board file for it.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Kconfig           | 10 ------
 arch/arm/mach-omap2/Makefile          |  2 --
 arch/arm/mach-omap2/board-ti8168evm.c | 62 -----------------------------------
 3 files changed, 74 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-ti8168evm.c

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index f4d06ae..7adc4f7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -282,16 +282,6 @@ config MACH_SBC3530
 	default y
 	select OMAP_PACKAGE_CUS
 
-config MACH_TI8168EVM
-	bool "TI8168 Evaluation Module"
-	depends on SOC_TI81XX
-	default y
-
-config MACH_TI8148EVM
-	bool "TI8148 Evaluation Module"
-	depends on SOC_TI81XX
-	default y
-
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 3e824f8..3a54671 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -260,8 +260,6 @@ obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
 obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
 obj-$(CONFIG_MACH_SBC3530)		+= board-omap3stalker.o
-obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
-obj-$(CONFIG_MACH_TI8148EVM)		+= board-ti8168evm.o
 
 # Platform specific device init code
 
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
deleted file mode 100644
index 6273c28..0000000
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ /dev/null
@@ -1,62 +0,0 @@
-/*
- * Code for TI8168/TI8148 EVM.
- *
- * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/usb/musb.h>
-
-#include <asm/mach-types.h>
-#include <asm/mach/arch.h>
-#include <asm/mach/map.h>
-
-#include "common.h"
-
-static struct omap_musb_board_data musb_board_data = {
-	.set_phy_power	= ti81xx_musb_phy_power,
-	.interface_type	= MUSB_INTERFACE_ULPI,
-	.mode           = MUSB_OTG,
-	.power		= 500,
-};
-
-static void __init ti81xx_evm_init(void)
-{
-	omap_serial_init();
-	omap_sdrc_init(NULL, NULL);
-	usb_musb_init(&musb_board_data);
-}
-
-MACHINE_START(TI8168EVM, "ti8168evm")
-	/* Maintainer: Texas Instruments */
-	.atag_offset	= 0x100,
-	.map_io		= ti81xx_map_io,
-	.init_early	= ti81xx_init_early,
-	.init_irq	= ti81xx_init_irq,
-	.init_time	= omap3_sync32k_timer_init,
-	.init_machine	= ti81xx_evm_init,
-	.init_late	= ti81xx_init_late,
-	.restart	= omap44xx_restart,
-MACHINE_END
-
-MACHINE_START(TI8148EVM, "ti8148evm")
-	/* Maintainer: Texas Instruments */
-	.atag_offset	= 0x100,
-	.map_io		= ti81xx_map_io,
-	.init_early	= ti81xx_init_early,
-	.init_irq	= ti81xx_init_irq,
-	.init_time	= omap3_sync32k_timer_init,
-	.init_machine	= ti81xx_evm_init,
-	.init_late	= ti81xx_init_late,
-	.restart	= omap44xx_restart,
-MACHINE_END
-- 
2.1.1

