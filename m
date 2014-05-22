From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 4/5] [RFC] ARM: OMAP2+: gpmc: fix gpmc_hwecc_bch_capable
Date: Fri, 23 May 2014 01:06:25 +0200
Message-ID: <1400799986-20043-5-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:63815 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaEVXHB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:07:01 -0400
Received: by mail-la0-f46.google.com with SMTP id ec20so1734735lab.5
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:07:00 -0700 (PDT)
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Most dt omap3 boards configure nand-ecc-opt as bch8. Due
to lack of hardware elm support, bch8 software implementation
gets set.

Since commit 0611c41934ab35ce84dea "ARM: OMAP2+: gpmc: update
gpmc_hwecc_bch_capable() for new platforms and ECC schemes",
nand support stops working.

This patch allows ecc software fallback.
---
 arch/arm/mach-omap2/gpmc-nand.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 4349e82..52c4834 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -43,13 +43,17 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= gpmc_nand_resource,
 };
 
-static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
+static bool gpmc_ecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* platforms which support all ECC schemes */
 	if (soc_is_am33xx() || cpu_is_omap44xx() ||
 		 soc_is_omap54xx() || soc_is_dra7xx())
 		return 1;
 
+	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) ||
+		(ecc_opt == OMAP_ECC_BCH8_CODE_HW_DETECTION_SW))
+		return 1;
+
 	/* OMAP3xxx do not have ELM engine, so cannot support ECC schemes
 	 * which require H/W based ECC error detection */
 	if ((cpu_is_omap34xx() || cpu_is_omap3630()) &&
@@ -57,14 +61,6 @@ static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 		 (ecc_opt == OMAP_ECC_BCH8_CODE_HW)))
 		return 0;
 
-	/*
-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
-	 * and AM33xx derivates. Other chips may be added if confirmed to work.
-	 */
-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW_DETECTION_SW) &&
-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)))
-		return 0;
-
 	/* legacy platforms support only HAM1 (1-bit Hamming) ECC scheme */
 	if (ecc_opt == OMAP_ECC_HAM1_CODE_HW)
 		return 1;
@@ -140,7 +136,7 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
 
-	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt)) {
+	if (!gpmc_ecc_bch_capable(gpmc_nand_data->ecc_opt)) {
 		dev_err(dev, "Unsupported NAND ECC scheme selected\n");
 		return -EINVAL;
 	}
-- 
1.7.10.4

