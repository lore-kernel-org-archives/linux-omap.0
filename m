From: virtuoso@slind.org
Subject: [PATCH 4/6] omap3: move EMU peripheral addresses to a platform header
Date: Sat,  1 May 2010 20:38:19 +0300
Message-ID: <1272735501-2963-5-git-send-email-virtuoso@slind.org>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44780 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756345Ab0EARlW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:41:22 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

These addresses are also needed for the OFF code to save/restore the
contexts of the EMU peripherals correctly.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/mach-omap2/emu.c            |   14 ++++----------
 arch/arm/plat-omap/include/plat/io.h |   20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/emu.c b/arch/arm/mach-omap2/emu.c
index 9c442e2..6b41745 100644
--- a/arch/arm/mach-omap2/emu.c
+++ b/arch/arm/mach-omap2/emu.c
@@ -24,19 +24,13 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Alexander Shishkin");
 
-/* Cortex CoreSight components within omap3xxx EMU */
-#define ETM_BASE	(L4_EMU_34XX_PHYS + 0x10000)
-#define DBG_BASE	(L4_EMU_34XX_PHYS + 0x11000)
-#define ETB_BASE	(L4_EMU_34XX_PHYS + 0x1b000)
-#define DAPCTL		(L4_EMU_34XX_PHYS + 0x1d000)
-
 static struct amba_device omap3_etb_device = {
 	.dev		= {
 		.init_name = "etb",
 	},
 	.res		= {
-		.start	= ETB_BASE,
-		.end	= ETB_BASE + SZ_4K - 1,
+		.start	= OMAP34XX_ETB_PHYS,
+		.end	= OMAP34XX_ETB_PHYS + OMAP34XX_ETB_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	.periphid	= 0x000bb907,
@@ -47,8 +41,8 @@ static struct amba_device omap3_etm_device = {
 		.init_name = "etm",
 	},
 	.res		= {
-		.start	= ETM_BASE,
-		.end	= ETM_BASE + SZ_4K - 1,
+		.start	= OMAP34XX_ETM_PHYS,
+		.end	= OMAP34XX_ETM_PHYS + OMAP34XX_ETM_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	.periphid	= 0x102bb921,
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 128b549..81f736a 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -185,6 +185,26 @@
 
 /* 3430 IVA - currently unmapped */
 
+#define OMAP34XX_DBG_OFFSET	(0x00011000)
+#define OMAP34XX_DBG_VIRT	(L4_EMU_34XX_VIRT + OMAP34XX_DBG_OFFSET)
+#define OMAP34XX_DBG_PHYS	(L4_EMU_34XX_PHYS + OMAP34XX_DBG_OFFSET)
+#define OMAP34XX_DBG_SIZE	SZ_4K
+
+#define OMAP34XX_ETM_OFFSET	(0x00010000)
+#define OMAP34XX_ETM_VIRT	(L4_EMU_34XX_VIRT + OMAP34XX_ETM_OFFSET)
+#define OMAP34XX_ETM_PHYS	(L4_EMU_34XX_PHYS + OMAP34XX_ETM_OFFSET)
+#define OMAP34XX_ETM_SIZE	SZ_4K
+
+#define OMAP34XX_ETB_OFFSET	(0x0001b000)
+#define OMAP34XX_ETB_VIRT	(L4_EMU_34XX_VIRT + OMAP34XX_ETB_OFFSET)
+#define OMAP34XX_ETB_PHYS	(L4_EMU_34XX_PHYS + OMAP34XX_ETB_OFFSET)
+#define OMAP34XX_ETB_SIZE	SZ_4K
+
+#define OMAP34XX_DAP_OFFSET	(0x0001d000)
+#define OMAP34XX_DAP_VIRT	(L4_EMU_34XX_VIRT + OMAP34XX_DAP_OFFSET)
+#define OMAP34XX_DAP_PHYS	(L4_EMU_34XX_PHYS + OMAP34XX_DAP_OFFSET)
+#define OMAP34XX_DAP_SIZE	SZ_4K
+
 /*
  * ----------------------------------------------------------------------------
  * Omap4 specific IO mapping
-- 
1.7.1.1.g15764

