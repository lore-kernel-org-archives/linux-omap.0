From: Yong Li <sdliyong@gmail.com>
Subject: [PATCH] ARM: OMAP2+: allow DEBUG_UNCOMPRESS for OMAP2+
Date: Tue, 29 Dec 2015 12:09:19 +0800
Message-ID: <1451362159-27910-1-git-send-email-sdliyong@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sdliyong@gmail.com, linux@arm.linux.org.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Based on the below
commit ae3c99a26c60 ("ARM: 7806/1: allow DEBUG_UNCOMPRESS for Tegra"),
change the .data section to .text section,
to enable DEBUG_UNCOMPRESS for OMAP2+ platforms
Tested okay using BeagleBone Black

Signed-off-by: Yong Li <sdliyong@gmail.com>
---
 arch/arm/Kconfig.debug             |  2 +-
 arch/arm/include/debug/omap2plus.S | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 259c0ca..e5ae36a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1596,7 +1596,7 @@ config DEBUG_UART_8250_FLOW_CONTROL
 config DEBUG_UNCOMPRESS
 	bool
 	depends on ARCH_MULTIPLATFORM || PLAT_SAMSUNG || ARM_SINGLE_ARMV7M
-	default y if DEBUG_LL && !DEBUG_OMAP2PLUS_UART && \
+	default y if DEBUG_LL && (!DEBUG_OMAP2PLUS_UART || !ZBOOT_ROM) && \
 		     (!DEBUG_TEGRA_UART || !ZBOOT_ROM)
 	help
 	  This option influences the normal decompressor output for
diff --git a/arch/arm/include/debug/omap2plus.S b/arch/arm/include/debug/omap2plus.S
index 6d867ae..12421f9 100644
--- a/arch/arm/include/debug/omap2plus.S
+++ b/arch/arm/include/debug/omap2plus.S
@@ -58,11 +58,18 @@
 
 #define UART_OFFSET(addr)	((addr) & 0x00ffffff)
 
+#if defined(ZIMAGE)
+	omap_uart_phys:	.word	0
+	omap_uart_virt:	.word	0
+	omap_uart_lsr:	.word	0
+#else
+
 		.pushsection .data
-omap_uart_phys:	.word	0
-omap_uart_virt:	.word	0
-omap_uart_lsr:	.word	0
+	omap_uart_phys:	.word	0
+	omap_uart_virt:	.word	0
+	omap_uart_lsr:	.word	0
 		.popsection
+#endif
 
 		.macro	addruart, rp, rv, tmp
 
-- 
2.1.4
