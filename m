From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: hsmmc: Split the clock src selection and pbias programming
Date: Fri, 9 Mar 2012 14:41:47 +0530
Message-ID: <1331284309-22101-3-git-send-email-rnayak@ti.com>
References: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47057 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab2CIJMT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 04:12:19 -0500
In-Reply-To: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Balaji TK <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>

While the pbias programming is something needed every time a regulator
output voltage is changed, the clock source selection to select between
an internal loopback and external clock seems like a one time setting.

These are today clubbed into a single platform callback, called from
the driver for every regulator voltage switch. Split these into seperate
callbacks and make the driver do this once at setup.

Also some platforms like AM35x seem to be doing this using a .set_power
callback, which seems completely orthogonal to what the callback is
expected to do.

Lastly, though the System control module has the registers to control
clock source selection, even on OMAP2430, the latest 2430 TRM version Z
clearly mentions in Table 7-135 and Table 7-154, that these bits are not
useful/used on OMAP2430. So get rid of control_devconf1_offset and just
use the OMAP3 based offsets for the register.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Balaji TK <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>
---
 arch/arm/mach-omap2/hsmmc.c           |   86 ++++++++++++++-------------------
 arch/arm/plat-omap/include/plat/mmc.h |    1 +
 drivers/mmc/host/omap_hsmmc.c         |    3 +
 3 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 11e26fc..0133b29 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -27,7 +27,6 @@
 #if defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
 static u16 control_pbias_offset;
-static u16 control_devconf1_offset;
 static u16 control_mmc1;
 
 #define HSMMC_NAME_LEN	9
@@ -43,6 +42,32 @@ static int hsmmc_get_context_loss(struct device *dev)
 #define hsmmc_get_context_loss NULL
 #endif
 
+static void hsmmc1_select_input_clk_src(struct device *dev)
+{
+	u32 reg;
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
+	if (mmc->slots[0].internal_clock)
+		reg |= OMAP2_MMCSDIO1ADPCLKISEL;
+	else
+		reg &= ~OMAP2_MMCSDIO1ADPCLKISEL;
+	omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
+}
+
+static void hsmmc2_select_input_clk_src(struct device *dev)
+{
+	u32 reg;
+	struct omap_mmc_platform_data *mmc = dev->platform_data;
+
+	reg = omap_ctrl_readl(OMAP343X_CONTROL_DEVCONF1);
+	if (mmc->slots[0].internal_clock)
+		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
+	else
+		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
+	omap_ctrl_writel(reg, OMAP343X_CONTROL_DEVCONF1);
+}
+
 static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 				  int power_on, int vdd)
 {
@@ -72,12 +97,6 @@ static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
 			omap_ctrl_writel(reg, OMAP243X_CONTROL_DEVCONF1);
 		}
 
-		if (mmc->slots[0].internal_clock) {
-			reg = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
-			reg |= OMAP2_MMCSDIO1ADPCLKISEL;
-			omap_ctrl_writel(reg, OMAP2_CONTROL_DEVCONF0);
-		}
-
 		reg = omap_ctrl_readl(control_pbias_offset);
 		if (cpu_is_omap3630()) {
 			/* Set MMC I/O to 52Mhz */
@@ -171,17 +190,6 @@ static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
 	}
 }
 
-static void hsmmc2_select_input_clk_src(struct omap_mmc_platform_data *mmc)
-{
-	u32 reg;
-
-	reg = omap_ctrl_readl(control_devconf1_offset);
-	if (mmc->slots[0].internal_clock)
-		reg |= OMAP2_MMCSDIO2ADPCLKISEL;
-	else
-		reg &= ~OMAP2_MMCSDIO2ADPCLKISEL;
-	omap_ctrl_writel(reg, control_devconf1_offset);
-}
 
 static void hsmmc2_before_set_reg(struct device *dev, int slot,
 				   int power_on, int vdd)
@@ -190,26 +198,6 @@ static void hsmmc2_before_set_reg(struct device *dev, int slot,
 
 	if (mmc->slots[0].remux)
 		mmc->slots[0].remux(dev, slot, power_on);
-
-	if (power_on)
-		hsmmc2_select_input_clk_src(mmc);
-}
-
-static int am35x_hsmmc2_set_power(struct device *dev, int slot,
-				  int power_on, int vdd)
-{
-	struct omap_mmc_platform_data *mmc = dev->platform_data;
-
-	if (power_on)
-		hsmmc2_select_input_clk_src(mmc);
-
-	return 0;
-}
-
-static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
-							int vdd)
-{
-	return 0;
 }
 
 static inline void omap_hsmmc_mux(struct omap_mmc_platform_data *mmc_controller,
@@ -387,9 +375,6 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			}
 		}
 
-		if (cpu_is_omap3517() || cpu_is_omap3505())
-			mmc->slots[0].set_power = nop_mmc_set_power;
-
 		/* OMAP3630 HSMMC1 supports only 4-bit */
 		if (cpu_is_omap3630() &&
 				(c->caps & MMC_CAP_8_BIT_DATA)) {
@@ -397,21 +382,25 @@ static int omap_hsmmc_pdata_init(struct omap2_hsmmc_info *c,
 			c->caps |= MMC_CAP_4_BIT_DATA;
 			mmc->slots[0].caps = c->caps;
 		}
+
+		if (mmc->controller_flags & OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT)
+			mmc->select_input_clk_src = hsmmc1_select_input_clk_src;
 		break;
 	case 2:
-		if (cpu_is_omap3517() || cpu_is_omap3505())
-			mmc->slots[0].set_power = am35x_hsmmc2_set_power;
-
 		if (c->ext_clock)
 			c->transceiver = 1;
 		if (c->transceiver && (c->caps & MMC_CAP_8_BIT_DATA)) {
 			c->caps &= ~MMC_CAP_8_BIT_DATA;
 			c->caps |= MMC_CAP_4_BIT_DATA;
 		}
-		if (mmc->controller_flags & OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT) {
+
+		if (cpu_is_omap34xx()) {
 			mmc->slots[0].before_set_reg = hsmmc2_before_set_reg;
 			mmc->slots[0].after_set_reg = NULL;
 		}
+
+		if (mmc->controller_flags & OMAP_HSMMC_SUPPORTS_CLKSRC_SELECT)
+			mmc->select_input_clk_src = hsmmc2_select_input_clk_src;
 		break;
 	case 3:
 	case 4:
@@ -497,13 +486,10 @@ void omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 	omap_hsmmc_done = 1;
 
 	if (!cpu_is_omap44xx()) {
-		if (cpu_is_omap2430()) {
+		if (cpu_is_omap2430())
 			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
-		} else {
+		else
 			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
-			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
-		}
 	} else {
 		control_pbias_offset =
 			OMAP4_CTRL_MODULE_PAD_CORE_CONTROL_PBIASLITE;
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 5d9c98b..a155eb8 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -80,6 +80,7 @@ struct omap_mmc_platform_data {
 
 	/* Return context loss count due to PM states changing */
 	int (*get_context_loss_count)(struct device *dev);
+	void (*select_input_clk_src)(struct device *dev);
 
 	u64 dma_mask;
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index fd0c661..ce658e4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -2020,6 +2020,9 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (pdata->select_input_clk_src)
+		pdata->select_input_clk_src(&pdev->dev);
+
 	if (omap_hsmmc_have_reg() && !mmc_slot(host).set_power) {
 		ret = omap_hsmmc_reg_get(host);
 		if (ret)
-- 
1.7.1

