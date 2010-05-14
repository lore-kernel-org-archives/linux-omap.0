From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] omap: hsmmc: fix the hsmmc driver for am3517
Date: Fri, 14 May 2010 14:27:57 -0700
Message-ID: <20100514212757.25599.32414.stgit@baageli.muru.com>
References: <20100514212506.25599.98073.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56369 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755797Ab0ENV16 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 May 2010 17:27:58 -0400
In-Reply-To: <20100514212506.25599.98073.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

From: stanley.miao <stanley.miao@windriver.com>

AM3517 don't have the register OMAP343X_CONTROL_PBIAS_LITE and the regulators
like "vmmc", so we set a noop "set_power" function for it.

Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/hsmmc.c           |   27 +++++++++++++++++++++------
 arch/arm/plat-omap/include/plat/mmc.h |    4 ++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 9ad2295..2d36f3a 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -139,6 +139,12 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
 	}
 }
 
+static int nop_mmc_set_power(struct device *dev, int slot, int power_on,
+							int vdd)
+{
+	return 0;
+}
+
 static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
 
 void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
@@ -216,11 +222,18 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 		 */
 		mmc->slots[0].ocr_mask = c->ocr_mask;
 
+		if (cpu_is_omap3517() || cpu_is_omap3505())
+			mmc->slots[0].set_power = nop_mmc_set_power;
+		else
+			mmc->slots[0].features |= HSMMC_HAS_PBIAS;
+
 		switch (c->mmc) {
 		case 1:
-			/* on-chip level shifting via PBIAS0/PBIAS1 */
-			mmc->slots[0].before_set_reg = hsmmc1_before_set_reg;
-			mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
+			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+				/* on-chip level shifting via PBIAS0/PBIAS1 */
+				mmc->slots[0].before_set_reg = hsmmc1_before_set_reg;
+				mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
+			}
 
 			/* Omap3630 HSMMC1 supports only 4-bit */
 			if (cpu_is_omap3630() && c->wires > 4) {
@@ -235,9 +248,11 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
 				c->wires = 4;
 			/* FALLTHROUGH */
 		case 3:
-			/* off-chip level shifting, or none */
-			mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
-			mmc->slots[0].after_set_reg = NULL;
+			if (mmc->slots[0].features & HSMMC_HAS_PBIAS) {
+				/* off-chip level shifting, or none */
+				mmc->slots[0].before_set_reg = hsmmc23_before_set_reg;
+				mmc->slots[0].after_set_reg = NULL;
+			}
 			break;
 		default:
 			pr_err("MMC%d configuration not supported!\n", c->mmc);
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index a1bac07..c835f1e 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -102,6 +102,10 @@ struct omap_mmc_platform_data {
 		/* Regulator off remapped to sleep */
 		unsigned vcc_aux_disable_is_sleep:1;
 
+		/* we can put the features above into this variable */
+#define HSMMC_HAS_PBIAS		(1 << 0)
+		unsigned features;
+
 		int switch_pin;			/* gpio (card detect) */
 		int gpio_wp;			/* gpio (write protect) */
 

