From: Francisco Alecrim <francisco.alecrim@indt.org.br>
Subject: [RFC PATCH 1/1] OMAP2430: Adding missing #defines for TWL4030
Date: Sun,  6 Apr 2008 14:35:07 +0300
Message-ID: <1207481707-3326-1-git-send-email-francisco.alecrim@indt.org.br>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:31273 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720AbYDFLfI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Apr 2008 07:35:08 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m36BYvoW022931
	for <linux-omap@vger.kernel.org>; Sun, 6 Apr 2008 14:35:03 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Francisco Alecrim <francisco.alecrim@indt.org.br>

Adding missing #defines for TWL4030

Signed-off-by: Francisco Alecrim <francisco.alecrim@indt.org.br>
---
 include/asm-arm/arch-omap/board-2430osk.h |   13 ++++++++++---
 include/asm-arm/arch-omap/board-2430sdp.h |   12 ++++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/asm-arm/arch-omap/board-2430osk.h b/include/asm-arm/arch-omap/board-2430osk.h
index e5b63ae..fcb1a2a 100644
--- a/include/asm-arm/arch-omap/board-2430osk.h
+++ b/include/asm-arm/arch-omap/board-2430osk.h
@@ -39,9 +39,16 @@
 #define IH_TWL4030_BASE			IH_BOARD_BASE
 #define IH_TWL4030_END			(IH_TWL4030_BASE+8)
 
+#define IH_TWL4030_PWRBASE		(IH_TWL4030_END)
+#define IH_TWL4030_PWRBASE_END		(IH_TWL4030_PWRBASE+8)
+
+#ifdef CONFIG_TWL4030_GPIO
+
 /* TWL4030 GPIO Interrupts */
-#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
-#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
+#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_PWRBASE_END)
+#define IH_TWL4030_GPIO_END		(IH_TWL4030_GPIO_BASE+18)
 #define NR_IRQS				(IH_TWL4030_GPIO_END)
-
+#else
+#define NR_IRQS				(IH_TWL4030_PWRBASE_END)
+#endif /* CONFIG_I2C_TWL4030_GPIO */
 #endif /* __ASM_ARCH_OMAP_2430OSK_H */
diff --git a/include/asm-arm/arch-omap/board-2430sdp.h b/include/asm-arm/arch-omap/board-2430sdp.h
index 186e9cc..1a5414e 100644
--- a/include/asm-arm/arch-omap/board-2430sdp.h
+++ b/include/asm-arm/arch-omap/board-2430sdp.h
@@ -40,10 +40,18 @@
 #define IH_TWL4030_BASE			IH_BOARD_BASE
 #define IH_TWL4030_END			(IH_TWL4030_BASE+8)
 
+#define IH_TWL4030_PWRBASE		(IH_TWL4030_END)
+#define IH_TWL4030_PWRBASE_END		(IH_TWL4030_PWRBASE+8)
+
+#ifdef CONFIG_TWL4030_GPIO
+
 /* TWL4030 GPIO Interrupts */
-#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_END)
-#define IH_TWL4030_GPIO_END		(IH_TWL4030_BASE+18)
+#define IH_TWL4030_GPIO_BASE		(IH_TWL4030_PWRBASE_END)
+#define IH_TWL4030_GPIO_END		(IH_TWL4030_GPIO_BASE+18)
 #define NR_IRQS				(IH_TWL4030_GPIO_END)
+#else
+#define NR_IRQS				(IH_TWL4030_PWRBASE_END)
+#endif /* CONFIG_I2C_TWL4030_GPIO */
 
 /* Function prototypes */
 extern void sdp2430_flash_init(void);
-- 
1.5.4.4

