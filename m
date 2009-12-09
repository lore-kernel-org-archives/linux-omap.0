From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/6] OMAP4: Fix SRAM base and size
Date: Wed,  9 Dec 2009 23:59:06 +0530
Message-ID: <1260383350-32681-2-git-send-email-santosh.shilimkar@ti.com>
References: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51617 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755934AbZLIS3T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Dec 2009 13:29:19 -0500
In-Reply-To: <1260383350-32681-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux@arm.linux.org.uk, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch fixes the public sram base address and available
size on OMAP4430.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 3e92366..3044009 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -47,8 +47,10 @@
 #define OMAP3_SRAM_VA           0xfe400000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
-#define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
-#define OMAP4_SRAM_VA		0xfe400000		/*0xfe4f0000*/
+#define OMAP4_SRAM_PA		0x40300000
+#define OMAP4_SRAM_VA		0xfe400000
+#define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
+#define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
@@ -139,6 +141,10 @@ void __init omap_detect_sram(void)
 				} else {
 					omap_sram_size = 0x8000; /* 32K */
 				}
+			} else if (cpu_is_omap44xx()) {
+				omap_sram_base = OMAP4_SRAM_PUB_VA;
+				omap_sram_start = OMAP4_SRAM_PUB_PA;
+				omap_sram_size = 0xa000; /* 40K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
@@ -152,7 +158,7 @@ void __init omap_detect_sram(void)
 			} else if (cpu_is_omap44xx()) {
 				omap_sram_base = OMAP4_SRAM_VA;
 				omap_sram_start = OMAP4_SRAM_PA;
-				omap_sram_size = 0x8000; /* 32K */
+				omap_sram_size = 0xe000; /* 56K */
 			} else {
 				omap_sram_base = OMAP2_SRAM_VA;
 				omap_sram_start = OMAP2_SRAM_PA;
-- 
1.6.0.4

