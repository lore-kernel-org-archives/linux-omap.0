From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH v3 2/4] ARM: OMAP: gpmc: enable hwecc for AM33xx SoCs
Date: Fri,  2 Nov 2012 16:25:54 +0100
Message-ID: <1351869956-2787-3-git-send-email-zonque@gmail.com>
References: <1351869956-2787-1-git-send-email-zonque@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:41655 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757540Ab2KBP0S (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 11:26:18 -0400
In-Reply-To: <1351869956-2787-1-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, jon-hunter@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, Daniel Mack <zonque@gmail.com>

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 arch/arm/mach-omap2/gpmc-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc-nand.c b/arch/arm/mach-omap2/gpmc-nand.c
index 8607735..c3616c6 100644
--- a/arch/arm/mach-omap2/gpmc-nand.c
+++ b/arch/arm/mach-omap2/gpmc-nand.c
@@ -92,7 +92,7 @@ static int omap2_nand_gpmc_retime(
 static bool __init gpmc_hwecc_bch_capable(enum omap_ecc ecc_opt)
 {
 	/* support only OMAP3 class */
-	if (!cpu_is_omap34xx()) {
+	if (!cpu_is_omap34xx() && !soc_is_am33xx()) {
 		pr_err("BCH ecc is not supported on this CPU\n");
 		return 0;
 	}
-- 
1.7.11.7

