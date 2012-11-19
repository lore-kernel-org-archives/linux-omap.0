From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v4 2/3] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Mon, 19 Nov 2012 23:29:15 +0800
Message-ID: <1353338956-19420-3-git-send-email-zonque@gmail.com>
References: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:49526 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753203Ab2KSP3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Nov 2012 10:29:43 -0500
In-Reply-To: <1353338956-19420-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 8607735..e23d561 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -92,17 +92,18 @@ static int omap2_nand_gpmc_retime(
 static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
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

