From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/2] OMAP3: MMC: Add mux for pins
Date: Mon, 15 Jun 2009 18:37:50 -0500
Message-ID: <1245109070-31154-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53175 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbZFOXjR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 19:39:17 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5FNdF3l022522
	for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 18:39:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>, Chikkature Rajashekar <madhu.cr@ti.com>

For OMAP3 add MMC1 MMC2 and MMC3 pin mux

Signed-off-by: Chikkature Rajashekar <madhu.cr@ti.com>
Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/devices.c         |   33 ++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |   49 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   28 +++++++++++++++++++
 3 files changed, 110 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 894cc35..7b87543 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -513,6 +513,39 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
 		}
 	}
+
+	if (cpu_is_omap3430()) {
+		if (controller_nr == 0 && (!mmc_controller->slots[0].nomux)) {
+			omap_cfg_reg(N28_3430_MMC1_CLK);
+			omap_cfg_reg(M27_3430_MMC1_CMD);
+			omap_cfg_reg(N27_3430_MMC1_DAT0);
+			omap_cfg_reg(N26_3430_MMC1_DAT1);
+			omap_cfg_reg(N25_3430_MMC1_DAT2);
+			omap_cfg_reg(P28_3430_MMC1_DAT3);
+			omap_cfg_reg(P27_3430_MMC1_DAT4);
+			omap_cfg_reg(P26_3430_MMC1_DAT5);
+			omap_cfg_reg(R27_3430_MMC1_DAT6);
+			omap_cfg_reg(R25_3430_MMC1_DAT7);
+		}
+		if (controller_nr == 1 && (!mmc_controller->slots[0].nomux)) {
+			/* MMC2 */
+			omap_cfg_reg(AE2_3430_MMC2_CLK);
+			omap_cfg_reg(AG5_3430_MMC2_CMD);
+			omap_cfg_reg(AH5_3430_MMC2_DAT0);
+			omap_cfg_reg(AH4_3430_MMC2_DAT1);
+			omap_cfg_reg(AG4_3430_MMC2_DAT2);
+			omap_cfg_reg(AF4_3430_MMC2_DAT3);
+		}
+		if (controller_nr == 2 && (!mmc_controller->slots[0].nomux)) {
+			/* MMC3 */
+			omap_cfg_reg(AF10_3430_MMC3_CLK);
+			omap_cfg_reg(AC3_3430_MMC3_CMD);
+			omap_cfg_reg(AE11_3430_MMC3_DAT0);
+			omap_cfg_reg(AH9_3430_MMC3_DAT1);
+			omap_cfg_reg(AF13_3430_MMC3_DAT2);
+			omap_cfg_reg(AF13_3430_MMC3_DAT3);
+		}
+	}
 }
 
 void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 026c4fc..d49b9a7 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -486,6 +486,55 @@ MUX_CFG_34XX("H19_34XX_GPIO164_OUT", 0x19c,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_OUTPUT)
 MUX_CFG_34XX("J25_34XX_GPIO170", 0x1c6,
 		OMAP34XX_MUX_MODE4 | OMAP34XX_PIN_INPUT)
+/* MMC1 */
+MUX_CFG_34XX("N28_3430_MMC1_CLK", 0x144,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("M27_3430_MMC1_CMD", 0x146,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("N27_3430_MMC1_DAT0", 0x148,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("N26_3430_MMC1_DAT1", 0x14a,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("N25_3430_MMC1_DAT2", 0x14c,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("P28_3430_MMC1_DAT3", 0x14e,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("P27_3430_MMC1_DAT4", 0x150,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("P26_3430_MMC1_DAT5", 0x152,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("R27_3430_MMC1_DAT6", 0x154,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("R25_3430_MMC1_DAT7", 0x156,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+
+/* MMC2 */
+MUX_CFG_34XX("AE2_3430_MMC2_CLK", 0x158,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AG5_3430_MMC2_CMD", 0x15A,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AH5_3430_MMC2_DAT0", 0x15c,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AH4_3430_MMC2_DAT1", 0x15e,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AG4_3430_MMC2_DAT2", 0x160,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF4_3430_MMC2_DAT3", 0x162,
+		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_INPUT_PULLUP)
+
+/* MMC3 */
+MUX_CFG_34XX("AF10_3430_MMC3_CLK", 0x5d8,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AC3_3430_MMC3_CMD", 0x1d0,
+		OMAP34XX_MUX_MODE3 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AE11_3430_MMC3_DAT0", 0x5e4,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AH9_3430_MMC3_DAT1", 0x5e6,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF13_3430_MMC3_DAT2", 0x5e8,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
+MUX_CFG_34XX("AF13_3430_MMC3_DAT3", 0x5e2,
+		OMAP34XX_MUX_MODE2 | OMAP34XX_PIN_INPUT_PULLUP)
 };
 
 #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
diff --git a/arch/arm/plat-omap/include/mach/mux.h b/arch/arm/plat-omap/include/mach/mux.h
index 85a6217..d24fdf9 100644
--- a/arch/arm/plat-omap/include/mach/mux.h
+++ b/arch/arm/plat-omap/include/mach/mux.h
@@ -853,6 +853,34 @@ enum omap34xx_index {
 	AE5_34XX_GPIO143,
 	H19_34XX_GPIO164_OUT,
 	J25_34XX_GPIO170,
+
+	/* MMC1 */
+	N28_3430_MMC1_CLK,
+	M27_3430_MMC1_CMD,
+	N27_3430_MMC1_DAT0,
+	N26_3430_MMC1_DAT1,
+	N25_3430_MMC1_DAT2,
+	P28_3430_MMC1_DAT3,
+	P27_3430_MMC1_DAT4,
+	P26_3430_MMC1_DAT5,
+	R27_3430_MMC1_DAT6,
+	R25_3430_MMC1_DAT7,
+
+	/* MMC2 */
+	AE2_3430_MMC2_CLK,
+	AG5_3430_MMC2_CMD,
+	AH5_3430_MMC2_DAT0,
+	AH4_3430_MMC2_DAT1,
+	AG4_3430_MMC2_DAT2,
+	AF4_3430_MMC2_DAT3,
+
+	/* MMC3 */
+	AF10_3430_MMC3_CLK,
+	AC3_3430_MMC3_CMD,
+	AE11_3430_MMC3_DAT0,
+	AH9_3430_MMC3_DAT1,
+	AF13_3430_MMC3_DAT2,
+	AF13_3430_MMC3_DAT3,
 };
 
 struct omap_mux_cfg {
-- 
1.6.0.3.613.g9f8f13

