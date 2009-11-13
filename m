From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/14] omap3: HSMMC2 8-bit mux configuration
Date: Thu, 12 Nov 2009 16:09:09 -0800
Message-ID: <20091113000909.9034.78191.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59409 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbZKMAJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:09:05 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Madhusudhan Chikkature <madhu.cr@ti.com>

From: Madhu <madhu.cr@ti.com>

Add support for omap hsmmc2 8-bit mux configuration.

Signed-off-by: Madhusudhan Chikkature <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c         |    6 ++++++
 arch/arm/mach-omap2/mux.c             |    8 ++++++++
 arch/arm/plat-omap/include/plat/mux.h |    4 ++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 8d23e1f..8b6cd8c 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -609,6 +609,12 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
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
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 56e357e..f74331d 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -834,6 +834,10 @@ enum omap34xx_index {
 	AH4_3430_MMC2_DAT1,
 	AG4_3430_MMC2_DAT2,
 	AF4_3430_MMC2_DAT3,
+	AE4_3430_MMC2_DAT4,
+	AH3_3430_MMC2_DAT5,
+	AF3_3430_MMC2_DAT6,
+	AE3_3430_MMC2_DAT7,
 
 	/* MMC3 */
 	AF10_3430_MMC3_CLK,

