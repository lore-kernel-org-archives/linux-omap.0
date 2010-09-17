From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 12/14] omap4: l2x0: Fix init parameter for es2.0
Date: Fri, 17 Sep 2010 15:17:56 +0530
Message-ID: <1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56814 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab0IQJsM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Sep 2010 05:48:12 -0400
In-Reply-To: <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On ES2.0 the L2 cache init parameter ineeds to be changed to take
care of cache size. The cache size is 1MB on ES2.0 vs 512KB on ES1.0

This patch fixes the init parameter to update the same using
dynamic cpu version check

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 13dc979..923f9f5 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -61,10 +61,14 @@ static int __init omap_l2_cache_init(void)
 	omap_smc1(0x102, 0x1);
 
 	/*
-	 * 32KB way size, 16-way associativity,
-	 * parity disabled
+	 * 16-way associativity, parity disabled
+	 * Way size - 32KB (es1.0)
+	 * Way size - 64KB (es2.0 +)
 	 */
-	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+	if (omap_rev() == OMAP4430_REV_ES1_0)
+		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+	else
+		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
 
 	return 0;
 }
-- 
1.6.0.4

