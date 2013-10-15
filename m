From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH 1/1] arm: omap: gpmc: remove detection of ecc-capability based on SoC name
Date: Tue, 15 Oct 2013 23:22:39 +0530
Message-ID: <1381859559-15281-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37199 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933185Ab3JORw7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Oct 2013 13:52:59 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, afzal@ti.com, Pekon Gupta <pekon@ti.com>

Legacy OMAP SoC like OMAP2xxx, OMAP3xxx do not have in-build ELM h/w engine,
so they cannot support h/w based BCH ECC error-detection. Thus,
gpmc_hwecc_bch_capable() check was added in following commit to find-out
which SoC have in-built ELM h/w to support hardware based ecc-correction.

commit 3852ccd66a9bcb2aa6f46bce5442b6d8d08e5b5d
Author:     Afzal Mohammed <afzal@ti.com>
AuthorDate: 2012-10-01

But with DT based kernel, presence of ELM h/w engine on SoC is parsed from DT
data part of .dtsi file, which is unique for each device. Hence hard-coded
check for each device can be dropped.

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 662c7fd..2b03eba 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -43,28 +43,6 @@ static struct platform_device gpmc_nand_device = {
 	.resource	= gpmc_nand_resource,
 };
 
-static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
-{
-	/* support only OMAP3 class */
-	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
-		pr_err("BCH ecc is not supported on this CPU\n");
-		return 0;
-	}
-
-	/*
-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
-	 * and AM33xx derivates. Other chips may be added if confirmed to work.
-	 */
-	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
-	    (!soc_is_am33xx())) {
-		pr_err("BCH 4-bit mode is not supported on this CPU\n");
-		return 0;
-	}
-
-	return 1;
-}
-
 int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 		   struct gpmc_timings *gpmc_t)
 {
@@ -127,9 +105,6 @@ int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
 
-	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt))
-		return -EINVAL;
-
 	err = platform_device_register(&gpmc_nand_device);
 	if (err < 0) {
 		dev_err(dev, "Unable to register NAND device\n");
-- 
1.8.1

