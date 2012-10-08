From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH v2 10/14] ARM: OMAP2+: nand: bch capability check
Date: Mon, 8 Oct 2012 11:07:46 +0530
Message-ID: <9575950c712e397fa9ddca535d167e6c77e1934d.1349672877.git.afzal@ti.com>
References: <cover.1349672877.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab2JHFh5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 01:37:57 -0400
In-Reply-To: <cover.1349672877.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Artem Bityutskiy <dedekind1@gmail.com>
Cc: Jon Hunter <jon-hunter@ti.com>, Paul Walmsley <paul@pwsan.com>, David Woodhouse <dwmw2@infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, Afzal Mohammed <afzal@ti.com>

Capability of bch schemes could be discovered using soc
revision checks. If soc revision indicates that selected
ecc scheme is not supported bail out.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index c1b9b1d..7983d54 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -90,6 +90,27 @@ static int omap2_nand_gpmc_retime(
 	return 0;
 }
 
+static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
+{
+	/* support only OMAP3 class */
+	if (!cpu_is_omap34xx()) {
+		pr_err("BCH ecc is not supported on this CPU\n");
+		return 0;
+	}
+
+	/*
+	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
+	 * Other chips may be added if confirmed to work.
+	 */
+	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
+	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
+		pr_err("BCH 4-bit mode is not supported on this CPU\n");
+		return 0;
+	}
+
+	return 1;
+}
+
 int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 			  struct gpmc_timings *gpmc_t)
 {
@@ -128,6 +149,9 @@ int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
 
 	gpmc_update_nand_reg(&gpmc_nand_data->reg, gpmc_nand_data->cs);
 
+	if (!gpmc_hwecc_bch_capable(gpmc_nand_data->ecc_opt))
+		return -EINVAL;
+
 	err = platform_device_register(&gpmc_nand_device);
 	if (err < 0) {
 		dev_err(dev, "Unable to register NAND device\n");
-- 
1.7.12

