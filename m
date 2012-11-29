From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v6 4/5] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Thu, 29 Nov 2012 17:01:31 +0100
Message-ID: <1354204892-22762-5-git-send-email-zonque@gmail.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:53101 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab2K2QBz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 11:01:55 -0500
In-Reply-To: <1354204892-22762-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Daniel Mack <zonque@gmail.com>

The am33xx is capable of handling bch error correction modes, so
enable that feature in the driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index f9f23a2..c8a72ba 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -92,17 +92,18 @@ static int omap2_nand_gpmc_retime(
 static bool gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
-	if (!cpu_is_omap34xx()) {
+	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
 		pr_err("BCH ecc is not supported on this CPU\n");
 		return 0;
 	}
 
 	/*
-	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1.
-	 * Other chips may be added if confirmed to work.
+	 * For now, assume 4-bit mode is only supported on OMAP3630 ES1.x, x>=1
+	 * and AM33xx derivates. Other chips may be added if confirmed to work.
 	 */
 	if ((ecc_opt == OMAP_ECC_BCH4_CODE_HW) &&
-	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0))) {
+	    (!cpu_is_omap3630() || (GET_OMAP_REVISION() == 0)) &&
+	    (!soc_is_am33xx())) {
 		pr_err("BCH 4-bit mode is not supported on this CPU\n");
 		return 0;
 	}
-- 
1.7.11.7

