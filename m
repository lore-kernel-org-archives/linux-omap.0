From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] ARM: OMAP2/3/4: Move SRAM map to claim more io space
Date: Sun, 23 Aug 2009 19:04:53 +0530
Message-ID: <1251034495-10107-3-git-send-email-santosh.shilimkar@ti.com>
References: <1251034495-10107-1-git-send-email-santosh.shilimkar@ti.com>
 <1251034495-10107-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55718 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933803AbZHWNfH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Aug 2009 09:35:07 -0400
In-Reply-To: <1251034495-10107-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch moves SRAM map to free up more kernel address io space.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index ea350a0..71c0aaa 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -41,14 +41,14 @@
 #define OMAP1_SRAM_VA		VMALLOC_END
 #define OMAP2_SRAM_PA		0x40200000
 #define OMAP2_SRAM_PUB_PA	0x4020f800
-#define OMAP2_SRAM_VA		0xe3000000
+#define OMAP2_SRAM_VA		0xfe400000
 #define OMAP2_SRAM_PUB_VA	(OMAP2_SRAM_VA + 0x800)
 #define OMAP3_SRAM_PA           0x40200000
-#define OMAP3_SRAM_VA           0xe3000000
+#define OMAP3_SRAM_VA           0xfe400000
 #define OMAP3_SRAM_PUB_PA       0x40208000
 #define OMAP3_SRAM_PUB_VA       (OMAP3_SRAM_VA + 0x8000)
 #define OMAP4_SRAM_PA		0x40200000		/*0x402f0000*/
-#define OMAP4_SRAM_VA		0xd7000000		/*0xd70f0000*/
+#define OMAP4_SRAM_VA		0xfe400000		/*0xfe4f0000*/
 
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
 #define SRAM_BOOTLOADER_SZ	0x00
-- 
1.5.4.7

