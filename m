From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH 2/2] arm:omap: am33xx SRAM support (minimal)
Date: Fri, 10 Feb 2012 21:07:33 +0530
Message-ID: <1328888253-1389-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38495 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758661Ab2BJPxx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Feb 2012 10:53:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: hvaibhav@ti.com, nsekhar@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Afzal Mohammed <afzal@ti.com>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

Update SRAM start & size for am33xx SoC's.

Note: cpu_is_34xx() is true for am33xx also. Doing
cpu_is_am33xx() check after cpu_is_34xx() will not
achieve what we want due to the above reason.
Hence cpu_is_am33xx() is done before cpu_is_34xx()

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/plat-omap/include/plat/sram.h |    1 +
 arch/arm/plat-omap/sram.c              |   14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-omap/include/plat/sram.h
index 75aa1b2..227ae26 100644
--- a/arch/arm/plat-omap/include/plat/sram.h
+++ b/arch/arm/plat-omap/include/plat/sram.h
@@ -101,4 +101,5 @@ static inline void omap_push_sram_idle(void) {}
 #else
 #define OMAP4_SRAM_PA		0x40300000
 #endif
+#define AM33XX_SRAM_PA		0x40300000
 #endif
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 4243bdc..596f222 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -86,7 +86,7 @@ static int is_sram_locked(void)
 			__raw_writel(0xCFDE, OMAP24XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xCFDE, OMAP24XX_VA_WRITEPERM0); /* all i-write */
 		}
-		if (cpu_is_omap34xx()) {
+		if (cpu_is_omap34xx() && !cpu_is_am33xx()) {
 			__raw_writel(0xFFFF, OMAP34XX_VA_REQINFOPERM0); /* all q-vects */
 			__raw_writel(0xFFFF, OMAP34XX_VA_READPERM0);  /* all i-read */
 			__raw_writel(0xFFFF, OMAP34XX_VA_WRITEPERM0); /* all i-write */
@@ -124,7 +124,10 @@ static void __init omap_detect_sram(void)
 				omap_sram_size = 0x800; /* 2K */
 			}
 		} else {
-			if (cpu_is_omap34xx()) {
+			if (cpu_is_am33xx()) {
+				omap_sram_start = AM33XX_SRAM_PA;
+				omap_sram_size = 0x10000; /* 64K */
+			} else if (cpu_is_omap34xx()) {
 				omap_sram_start = OMAP3_SRAM_PA;
 				omap_sram_size = 0x10000; /* 64K */
 			} else if (cpu_is_omap44xx()) {
@@ -368,6 +371,11 @@ static inline int omap34xx_sram_init(void)
 	return 0;
 }
 
+static inline int am33xx_sram_init(void)
+{
+	return 0;
+}
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -379,6 +387,8 @@ int __init omap_sram_init(void)
 		omap242x_sram_init();
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
+	else if (cpu_is_am33xx())
+		am33xx_sram_init();
 	else if (cpu_is_omap34xx())
 		omap34xx_sram_init();
 
-- 
1.7.1

