From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH] arm: omap: complete removal of machine_desc.io_pg_offst and .phys_io
Date: Mon, 18 Oct 2010 18:27:36 +0530
Message-ID: <1287406656-24133-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49733 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753939Ab0JRM54 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Oct 2010 08:57:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Anand Gadiyar <gadiyar@ti.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Tony Lindgren <tony@atomide.com>

Commit 861bd81ee6 in linux-next as of 20101018 (arm: remove
machine_desc.io_pg_offst and .phys_io) missed out on updating
a few boards. This causes the build of omap2plus_defconfig
to fail. Fix this.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Eric Miao <eric.miao at canonical.com>
Cc: Tony Lindgren <tony@atomide.com>
---
I've not boot tested on these three boards, and am simply following
what the original patch does.

 arch/arm/mach-omap2/board-cm-t3517.c   |    2 --
 arch/arm/mach-omap2/board-igep0030.c   |    2 --
 arch/arm/mach-omap2/board-omap3logic.c |    4 ----
 3 files changed, 8 deletions(-)

Index: mainline/arch/arm/mach-omap2/board-cm-t3517.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-cm-t3517.c
+++ mainline/arch/arm/mach-omap2/board-cm-t3517.c
@@ -283,8 +283,6 @@ static void __init cm_t3517_init(void)
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.reserve        = omap_reserve,
Index: mainline/arch/arm/mach-omap2/board-igep0030.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-igep0030.c
+++ mainline/arch/arm/mach-omap2/board-igep0030.c
@@ -392,8 +392,6 @@ static void __init igep3_init(void)
 }
 
 MACHINE_START(IGEP0030, "IGEP OMAP3 module")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.init_irq	= igep3_init_irq,
Index: mainline/arch/arm/mach-omap2/board-omap3logic.c
===================================================================
--- mainline.orig/arch/arm/mach-omap2/board-omap3logic.c
+++ mainline/arch/arm/mach-omap2/board-omap3logic.c
@@ -225,8 +225,6 @@ static void __init omap3logic_init(void)
 }
 
 MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.init_irq	= omap3logic_init_irq,
@@ -235,8 +233,6 @@ MACHINE_START(OMAP3_TORPEDO, "Logic OMAP
 MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
-	.phys_io	= 0x48000000,
-	.io_pg_offst	= ((0xd8000000) >> 18) & 0xfffc,
 	.boot_params	= 0x80000100,
 	.map_io		= omap3_map_io,
 	.init_irq	= omap3logic_init_irq,
