From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 3/3] omap4: SRAM start and size change for EMU/HS devices
Date: Sat, 10 Jul 2010 02:08:33 -0500
Message-ID: <1278745713-31255-4-git-send-email-vikram.pandita@ti.com>
References: <1278745713-31255-1-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-2-git-send-email-vikram.pandita@ti.com>
 <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33406 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655Ab0GJHHL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 10 Jul 2010 03:07:11 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o6A77Atj018644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 10 Jul 2010 02:07:10 -0500
In-Reply-To: <1278745713-31255-3-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

On OMAP4 the SRAM configuration is:
GP Device:
        Start Address: 0x4030 0000
        Size: 0xE000 (56KB)

EMU/HS Device:
        Start Address: 0x4030 4000
        Size: 0xA000 (40KB)

Implement this mapping in the sram file

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/plat-omap/sram.c |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 112b807..3c7c9a6 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -53,7 +53,7 @@
 #define OMAP4_SRAM_PUB_PA	(OMAP4_SRAM_PA + 0x4000)
 #define OMAP4_SRAM_PUB_VA	(OMAP4_SRAM_VA + 0x4000)
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2PLUS)
 #define SRAM_BOOTLOADER_SZ	0x00
 #else
 #define SRAM_BOOTLOADER_SZ	0x80
@@ -134,9 +134,18 @@ void __init omap_detect_sram(void)
 					omap_sram_size = 0x8000; /* 32K */
 				}
 			} else if (cpu_is_omap44xx()) {
-				omap_sram_base = OMAP4_SRAM_PUB_VA;
-				omap_sram_start = OMAP4_SRAM_PUB_PA;
-				omap_sram_size = 0xa000; /* 40K */
+				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
+				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
+					/* 40K For Public SRAM */
+					omap_sram_base = OMAP4_SRAM_PUB_VA;
+					omap_sram_start = OMAP4_SRAM_PUB_PA;
+					omap_sram_size = 0xA000;
+				} else {
+					/* 56 KB SRAM on GP device */
+					omap_sram_base = OMAP4_SRAM_VA;
+					omap_sram_start = OMAP4_SRAM_PA;
+					omap_sram_size = 0xE000;
+				}
 			} else {
 				omap_sram_base = OMAP2_SRAM_PUB_VA;
 				omap_sram_start = OMAP2_SRAM_PUB_PA;
-- 
1.6.6.1

