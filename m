From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: omap: add minimal support for Nokia RM-696
Date: Mon,  5 Mar 2012 19:08:57 +0200
Message-ID: <1330967337-9634-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:43286 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753421Ab2CEQ5K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Mar 2012 11:57:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Add minimal support for Nokia RM-696 board.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---

	The patch is based & boot-tested with 3.3-rc6.


 arch/arm/mach-omap2/Kconfig                  |    3 ++-
 arch/arm/mach-omap2/board-rm680.c            |   14 +++++++++++++-
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e20c8ab..b740c2e 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -245,10 +245,11 @@ config MACH_NOKIA_N8X0
 	select MACH_NOKIA_N810_WIMAX
 
 config MACH_NOKIA_RM680
-	bool "Nokia RM-680 board"
+	bool "Nokia RM-680/696 board"
 	depends on ARCH_OMAP3
 	default y
 	select OMAP_PACKAGE_CBB
+	select MACH_NOKIA_RM696
 
 config MACH_NOKIA_RX51
 	bool "Nokia RX-51 board"
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 8678b38..094473e 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -1,5 +1,5 @@
 /*
- * Board support file for Nokia RM-680.
+ * Board support file for Nokia RM-680/696.
  *
  * Copyright (C) 2010 Nokia
  *
@@ -154,3 +154,15 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.timer		= &omap3_timer,
 	.restart	= omap_prcm_restart,
 MACHINE_END
+
+MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3630_init_early,
+	.init_irq	= omap3_init_irq,
+	.handle_irq	= omap3_intc_handle_irq,
+	.init_machine	= rm680_init,
+	.timer		= &omap3_timer,
+	.restart	= omap_prcm_restart,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 6ee9049..cc3f11b 100644
--- a/arch/arm/plat-omap/include/plat/uncompress.h
+++ b/arch/arm/plat-omap/include/plat/uncompress.h
@@ -160,6 +160,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
 		DEBUG_LL_OMAP3(3, igep0020);
 		DEBUG_LL_OMAP3(3, igep0030);
 		DEBUG_LL_OMAP3(3, nokia_rm680);
+		DEBUG_LL_OMAP3(3, nokia_rm696);
 		DEBUG_LL_OMAP3(3, nokia_rx51);
 		DEBUG_LL_OMAP3(3, omap3517evm);
 		DEBUG_LL_OMAP3(3, omap3_beagle);
-- 
1.7.2.5

