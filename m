From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v1 1/5] ARM: OMAP2+: gpmc: update gpmc_hwecc_bch_capable() for new platforms and ECC schemes
Date: Wed, 5 Feb 2014 18:58:30 +0530
Message-ID: <1391606914-9947-2-git-send-email-pekon@ti.com>
References: <1391606914-9947-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56504 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750985AbaBEN2m (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Feb 2014 08:28:42 -0500
In-Reply-To: <1391606914-9947-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com
Cc: linux-omap <linux-omap@vger.kernel.org>, Pekon Gupta <pekon@ti.com>

This patch
 - refactors gpmc_hwecc_bch_capable()
 - add checks for new platforms like dra7xx, am43xx
 - add checks for OMAP3 SoC, w.r.t. new ECC schemes spawned in following commit:
    commit ac65caf514ec3e55e8d3d510ee37f80dd97418fe
    ARM: OMAP2+: cleaned-up DT support of various ECC schemes

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 174caec..4349e82 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -45,24 +45,31 @@ static struct platform_device gpmc_nand_device = {
 
 static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
-	/* support only OMAP3 class */
-	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
-		pr_err("BCH ecc is not supported on this CPU\n");
+	/* platforms which support all ECC schemes */
+	if (soc_is_am33xx() || cpu_is_omap44xx() ||
+		 soc_is_omap54xx() || soc_is_dra7xx())
+		return 1;
+
+	/* OMAP3xxx do not have ELM engine, so cannot support ECC schemes
+	 * which require H/W based ECC error detection */
+	if ((cpu_is_omap34xx() || cpu_is_omap3630()) &&
+	    ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) ||
+		 (ecc_opt == OMAP_ECC_BCH8_CODE_HW)))
 		return 0;
-	}
 
 	/*
 	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
 	 * and AM33xx derivates. Other chips may be added if confirmed to work.
 	 */
-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
-	    (!soc_is_am33xx())) {
-		pr_err("BCH 4-bit mode is not supported on this CPU\n");
+	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) &&
+	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)))
 		return 0;
-	}
 
-	return 1;
+	/* legacy platforms support only HAM1 (1-bit Hamming) ECC scheme */
+	if (ecc_opt == OMAP_ECC_HAM1_CODE_HW)
+		return 1;
+	else
+		return 0;
 }
 
 /* This function will go away once the device-tree convertion is complete */
@@ -133,8 +140,10 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
 
-	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt))
+	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
+		dev_err(dev, "Unsupported NAND ECC scheme selected\n");
 		return -EINVAL;
+	}
 
 	err = platform_device_register(&gpmc_nand_device);
 	if (err < 0) {
-- 
1.8.5.1.163.gd7aced9

