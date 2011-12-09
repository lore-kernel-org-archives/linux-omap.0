From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 3/3] arm: omap: add minimal support for Nokia RM-696
Date: Fri,  9 Dec 2011 17:06:51 +0200
Message-ID: <1323443211-3648-4-git-send-email-aaro.koskinen@nokia.com>
References: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:42063 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294Ab1LIPEy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:04:54 -0500
In-Reply-To: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Add minimal support for Nokia RM-696 board.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/Kconfig                  |    3 ++-
 arch/arm/mach-omap2/board-rm680.c            |   12 +++++++++++-
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index e1293aa..73d86dc 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -238,10 +238,11 @@ config MACH_NOKIA_N8X0
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
index 616fb39..a5bcc75 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -1,5 +1,5 @@
 /*
- * Board support file for Nokia RM-680.
+ * Board support file for Nokia RM-680/696.
  *
  * Copyright (C) 2010 Nokia
  *
@@ -152,3 +152,13 @@ MACHINE_START(NOKIA_RM680, "Nokia RM-680 board")
 	.init_machine	= rm680_init,
 	.timer		= &omap3_timer,
 MACHINE_END
+
+MACHINE_START(NOKIA_RM696, "Nokia RM-696 board")
+	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3630_init_early,
+	.init_irq	= omap3_init_irq,
+	.init_machine	= rm680_init,
+	.timer		= &omap3_timer,
+MACHINE_END
diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
index 2f472e9..de3e35c 100644
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

