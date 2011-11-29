From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP3: hsmmc: fix MMC 2 setup for AM35x
Date: Tue, 29 Nov 2011 11:37:48 +0200
Message-ID: <1322559468-5883-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37574
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752866Ab1K2JiC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 04:38:02 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

AM35x MMC 2 controller has internal clock loopback setting which cannot
be utilized without this patch and thus SDIO devices connected to this
controller and depend on this setting will fail to initialize.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/hsmmc.c |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index ecde558..c80859e 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -171,6 +171,17 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
+static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
+{
+	u32 reg;
+
+	if (mmc->slots[0].internal_clock) {
+		reg = omap_ctrl_readl(control_devconf1_offset);
+		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+		omap_ctrl_writel(reg, control_devconf1_offset);
+	}
+}
+
 static void hsmmc23_before_set_reg(struct device *dev, int slot,
 				   int power_on, int vdd)
 {
@@ -179,16 +190,19 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 	if (mmc->slots[0].remux)
 		mmc->slots[0].remux(dev, slot, power_on);
 
-	if (power_on) {
-		/* Only MMC2 supports a CLKIN */
-		if (mmc->slots[0].internal_clock) {
-			u32 reg;
+	if (power_on)
+		hsmmc2_select_input_clk_src(mmc);
+}
 
-			reg = omap_ctrl_readl(control_devconf1_offset);
-			reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-			omap_ctrl_writel(reg, control_devconf1_offset);
-		}
-	}
+static int am35x_hsmmc2_set_power(struct device *dev, int slot,
+				  int power_on, int vdd)
+{
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	if (power_on)
+		hsmmc2_select_input_clk_src(mmc);
+
+	return 0;
 }
 
 static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
@@ -346,9 +360,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	else
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
-	if (cpu_is_omap3517() || cpu_is_omap3505())
-		mmc->slots[0].set_power = nop_mmc_set_power;
-	else
+	if (!cpu_is_omap3517() && !cpu_is_omap3505())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
 	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
@@ -371,6 +383,9 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
+		if (cpu_is_omap3517() || cpu_is_omap3505())
+			mmc->slots[0].set_power = nop_mmc_set_power;
+
 		/* OMAP3630 HSMMC1 supports only 4-bit */
 		if (cpu_is_omap3630() &&
 				(c->caps & MMC_CAP_8_BIT_DATA)) {
@@ -380,6 +395,9 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 		}
 		break;
 	case 2:
+		if (cpu_is_omap3517() || cpu_is_omap3505())
+			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
+
 		if (c->ext_clock)
 			c->transceiver = 1;
 		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
-- 
1.7.3.4

