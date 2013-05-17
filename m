From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/6] ARM: OMAP2+: Remove omap4 pdata from hsmmc.c
Date: Fri, 17 May 2013 12:17:59 -0700
Message-ID: <20130517191759.468.9983.stgit@localhost>
References: <20130517191304.468.73487.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19236 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756699Ab3EQTSB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 May 2013 15:18:01 -0400
In-Reply-To: <20130517191304.468.73487.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This is no longer needed as omap4 is now booted using
device tree.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c |  103 ++++---------------------------------------
 1 file changed, 10 insertions(+), 93 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 2ef1f87..07d4c7b 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -29,7 +29,6 @@
 
 static u16 control_pbias_offset;
 static u16 control_devconf1_offset;
-static u16 control_mmc1;
 
 #define HSMMC_NAME_LEN	9
 
@@ -121,57 +120,6 @@ static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
-				  int power_on, int vdd)
-{
-	u32 reg;
-
-	/*
-	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
-	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
-	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
-	 */
-	reg = omap4_ctrl_pad_readl(control_pbias_offset);
-	reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-		OMAP4_MMC1_PWRDNZ_MASK |
-		OMAP4_MMC1_PBIASLITE_VMODE_MASK);
-	omap4_ctrl_pad_writel(reg, control_pbias_offset);
-}
-
-static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
-				 int power_on, int vdd)
-{
-	u32 reg;
-	unsigned long timeout;
-
-	if (power_on) {
-		reg = omap4_ctrl_pad_readl(control_pbias_offset);
-		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK;
-		if ((1 << vdd) <= MMC_VDD_165_195)
-			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE_MASK;
-		else
-			reg |= OMAP4_MMC1_PBIASLITE_VMODE_MASK;
-		reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ_MASK |
-			OMAP4_MMC1_PWRDNZ_MASK);
-		omap4_ctrl_pad_writel(reg, control_pbias_offset);
-
-		timeout = jiffies + msecs_to_jiffies(5);
-		do {
-			reg = omap4_ctrl_pad_readl(control_pbias_offset);
-			if (!(reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK))
-				break;
-			usleep_range(100, 200);
-		} while (!time_after(jiffies, timeout));
-
-		if (reg & OMAP4_MMC1_PBIASLITE_VMODE_ERROR_MASK) {
-			pr_err("Pbias Voltage is not same as LDO\n");
-			/* Caution : On VMODE_ERROR Power Down MMC IO */
-			reg &= ~(OMAP4_MMC1_PWRDNZ_MASK);
-			omap4_ctrl_pad_writel(reg, control_pbias_offset);
-		}
-	}
-}
-
 static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
 {
 	u32 reg;
@@ -317,11 +265,7 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	mmc->slots[0].pm_caps = c->pm_caps;
 	mmc->slots[0].internal_clock = !c->ext_clock;
 	mmc->max_freq = c->max_freq;
-	if (cpu_is_omap44xx())
-		mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
-	else
-		mmc->reg_offset = 0;
-
+	mmc->reg_offset = 0;
 	mmc->get_context_loss_count = hsmmc_get_context_loss;
 
 	mmc->slots[0].switch_pin = c->gpio_cd;
@@ -368,24 +312,14 @@ static int __init omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 	if (!soc_is_am35xx())
 		mmc->slots[0].features |= HSMMC_HAS_PBIAS;
 
-	if (cpu_is_omap44xx() && (omap_rev() > OMAP4430_REV_ES1_0))
-		mmc->slots[0].features |= HSMMC_HAS_UPDATED_RESET;
-
 	switch (c->mmc) {
 	case 1:
 		if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
 			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			if (cpu_is_omap44xx()) {
-				mmc->slots[0].before_set_reg =
-						omap4_hsmmc1_before_set_reg;
-				mmc->slots[0].after_set_reg =
-						omap4_hsmmc1_after_set_reg;
-			} else {
-				mmc->slots[0].before_set_reg =
-						omap_hsmmc1_before_set_reg;
-				mmc->slots[0].after_set_reg =
-						omap_hsmmc1_after_set_reg;
-			}
+			mmc->slots[0].before_set_reg =
+					omap_hsmmc1_before_set_reg;
+			mmc->slots[0].after_set_reg =
+					omap_hsmmc1_after_set_reg;
 		}
 
 		if (soc_is_am35xx())
@@ -563,34 +497,17 @@ free_mmc:
 
 void __init omap_hsmmc_init(struct omap2_hsmmc_info *controllers)
 {
-	u32 reg;
-
 	if (omap_hsmmc_done)
 		return;
 
 	omap_hsmmc_done = 1;
 
-	if (!cpu_is_omap44xx()) {
-		if (cpu_is_omap2430()) {
-			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
-		} else {
-			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
-		}
+	if (cpu_is_omap2430()) {
+		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
+		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
 	} else {
-		control_pbias_offset =
-			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE;
-		control_mmc1 = OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_MMC1;
-		reg = omap4_ctrl_pad_readl(control_mmc1);
-		reg |= (OMAP4_SDMMC1_PUSTRENGTH_GRP0_MASK |
-			OMAP4_SDMMC1_PUSTRENGTH_GRP1_MASK);
-		reg &= ~(OMAP4_SDMMC1_PUSTRENGTH_GRP2_MASK |
-			OMAP4_SDMMC1_PUSTRENGTH_GRP3_MASK);
-		reg |= (OMAP4_SDMMC1_DR0_SPEEDCTRL_MASK |
-			OMAP4_SDMMC1_DR1_SPEEDCTRL_MASK |
-			OMAP4_SDMMC1_DR2_SPEEDCTRL_MASK);
-		omap4_ctrl_pad_writel(reg, control_mmc1);
+		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
+		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
 	}
 
 	for (; controllers->mmc; controllers++)

