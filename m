From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH]Omap HSMMC2 8-bit mux configuration
Date: Thu, 22 Oct 2009 23:13:04 +0530 (IST)
Message-ID: <65111.192.168.10.89.1256233384.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56952 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753714AbZJVRnC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Oct 2009 13:43:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org

>From c6eb46e918044739ba21ec31a9bd09ebcfa9fb53 Mon Sep 17 00:00:00 2001
From: Madhu <madhu.cr@ti.com>
Date: Wed, 21 Oct 2009 16:49:24 -0400
Subject: [PATCH] Omap HSMMC2 8-bit mux configuration.

Add support for omap hsmmc2 8-bit mux configuration.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
---
 arch/arm/mach-omap2/devices.c         |    6 ++++++
 arch/arm/mach-omap2/mux.c             |    8 ++++++++
 arch/arm/plat-omap/include/plat/mux.h |    4 ++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 1fdfc7f..2ca415a 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -609,6 +609,12 @@ static inline void omap2_mmc_mux(struct
omap_mmc_platform_data *mmc_controller,
 				omap_cfg_reg(AG4_3430_MMC2_DAT2);
 				omap_cfg_reg(AF4_3430_MMC2_DAT3);
 			}
+			if (mmc_controller->slots[0].wires == 8) {
+				omap_cfg_reg(AE4_3430_MMC2_DAT4);
+				omap_cfg_reg(AH3_3430_MMC2_DAT5);
+				omap_cfg_reg(AF3_3430_MMC2_DAT6);
+				omap_cfg_reg(AE3_3430_MMC2_DAT7);
+			}
 		}

 		/*
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 32c953e..83256d3 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -532,6 +532,14 @@ MUX_CFG_34XX("AG4_3430_MMC2_DAT2", 0x160,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
 MUX_CFG_34XX("AF4_3430_MMC2_DAT3", 0x162,
 		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE4_3430_MMC2_DAT4", 0x164,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AH3_3430_MMC2_DAT5", 0x166,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF3_3430_MMC2_DAT6", 0x168,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE3_3430_MMC2_DAT7", 0x16A,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)

 /* MMC3 */
 MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x5d8,
diff --git a/arch/arm/plat-omap/include/plat/mux.h
b/arch/arm/plat-omap/include/plat/mux.h
index f3c1d8a..df38e16 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -829,6 +829,10 @@ enum omap34xx_index {
 	AH4_3430_MMC2_DAT1,
 	AG4_3430_MMC2_DAT2,
 	AF4_3430_MMC2_DAT3,
+	AE4_3430_MMC2_DAT4,
+	AH3_3430_MMC2_DAT5,
+	AF3_3430_MMC2_DAT6,
+	AE3_3430_MMC2_DAT7,

 	/* MMC3 */
 	AF10_3430_MMC3_CLK,
-- 
1.6.0.4



