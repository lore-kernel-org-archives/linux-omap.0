From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] OMAP3: MMC: Add mux for pins
Date: Wed, 12 Aug 2009 15:18:49 +0300
Message-ID: <20090812121849.17601.42907.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64351 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbZHLMSv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:18:51 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Vikram Pandita <vikram.pandita@ti.com>, linux-omap@vger.kernel.org, Chikkature Rajashekar <madhu.cr@ti.com>

From: Vikram Pandita <vikram.pandita@ti.com>

For OMAP3 add MMC1 MMC2 pin mux
MMC3 mux is not added as there are multiple configurations possible,
so the muxing is left to be done in board file

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Chikkature Rajashekar <madhu.cr@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/devices.c         |   42 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.c             |   49 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/mux.h |   28 +++++++++++++++++++
 3 files changed, 119 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 894cc35..91cb84d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -513,6 +513,48 @@ static inline void omap2_mmc_mux(struct omap_mmc_platform_data *mmc_controller,
 			omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
 		}
 	}
+
+	if (cpu_is_omap3430()) {
+		if (controller_nr == 0) {
+			omap_cfg_reg(N28_3430_MMC1_CLK);
+			omap_cfg_reg(M27_3430_MMC1_CMD);
+			omap_cfg_reg(N27_3430_MMC1_DAT0);
+			if (mmc_controller->slots[0].wires == 4 ||
+				mmc_controller->slots[0].wires == 8) {
+				omap_cfg_reg(N26_3430_MMC1_DAT1);
+				omap_cfg_reg(N25_3430_MMC1_DAT2);
+				omap_cfg_reg(P28_3430_MMC1_DAT3);
+			}
+			if (mmc_controller->slots[0].wires == 8) {
+				omap_cfg_reg(P27_3430_MMC1_DAT4);
+				omap_cfg_reg(P26_3430_MMC1_DAT5);
+				omap_cfg_reg(R27_3430_MMC1_DAT6);
+				omap_cfg_reg(R25_3430_MMC1_DAT7);
+			}
+		}
+		if (controller_nr == 1) {
+			/* MMC2 */
+			omap_cfg_reg(AE2_3430_MMC2_CLK);
+			omap_cfg_reg(AG5_3430_MMC2_CMD);
+			omap_cfg_reg(AH5_3430_MMC2_DAT0);
+			if (mmc_controller->slots[0].wires == 4 ||
+				mmc_controller->slots[0].wires == 8) {
+				omap_cfg_reg(AH4_3430_MMC2_DAT1);
+				omap_cfg_reg(AG4_3430_MMC2_DAT2);
+				omap_cfg_reg(AF4_3430_MMC2_DAT3);
+			}
+			if (mmc_controller->slots[0].wires == 8)
+				printk(KERN_WARNING
+					"\n MMC2: DAT4, DAT5, DAT6, DAT7: "
+					"Setup the mux in board file");
+		}
+		if (controller_nr == 2) {
+			/* MMC3 */
+			printk(KERN_WARNING
+				"\n MMC3: Setup the mux in board file: "
+				"Multiple options exist, so is board specific");
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

