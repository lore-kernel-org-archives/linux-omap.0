From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v7 3/5] ARM: OMAP: gpmc-nand: drop __init annotation
Date: Wed,  5 Dec 2012 20:09:29 +0100
Message-ID: <1354734571-10774-4-git-send-email-zonque@gmail.com>
References: <1354734571-10774-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:50962 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580Ab2LETJq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 14:09:46 -0500
In-Reply-To: <1354734571-10774-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

gpmc_nand_init() will be called from another driver's probe() function,
so the easiest way to prevent section mismatches is to drop the
annotation here.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index db969a5..3059f5e 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -89,7 +89,7 @@ static int omap2_nand_gpmc_retime(
 	return 0;
 }
 
-static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
+static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
 	if (!cpu_is_omap34xx()) {
@@ -110,8 +110,8 @@ static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 	return 1;
 }
 
-int __init gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
-			  struct gpmc_timings *gpmc_t)
+int gpmc_nand_init(struct omap_nand_platform_data *gpmc_nand_data,
+		   struct gpmc_timings *gpmc_t)
 {
 	int err	= 0;
 	struct device *dev = &gpmc_nand_device.dev;
-- 
1.7.11.7

