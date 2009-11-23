From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] OMAP3: id code detection 3525 vs 3515
Date: Mon, 23 Nov 2009 21:49:11 +0530
Message-ID: <1258993162-12635-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60349 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489AbZKWQT2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Nov 2009 11:19:28 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergey Lapin <slapin@ossfans.org>, Sanjeev Premi <premi@ti.com>

From: Sergey Lapin <slapin@ossfans.org>

The runtime detection of OMAP3515 and OMAP3525
was reversed.

Signed-off-by: Sergey Lapin <slapin@ossfans.org>
Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/id.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index f48a4b2..4fad192 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -277,10 +277,10 @@ void __init omap3_cpuinfo(void)
 	} else if (omap3_has_iva() && omap3_has_sgx()) {
 		/* OMAP3430, OMAP3525, OMAP3515, OMAP3503 devices */
 		strcpy(cpu_name, "OMAP3430/3530");
-	} else if (omap3_has_sgx()) {
+	} else if (omap3_has_iva()) {
 		omap_revision = OMAP3525_REV(rev);
 		strcpy(cpu_name, "OMAP3525");
-	} else if (omap3_has_iva()) {
+	} else if (omap3_has_sgx()) {
 		omap_revision = OMAP3515_REV(rev);
 		strcpy(cpu_name, "OMAP3515");
 	} else {
-- 
1.6.2.2

