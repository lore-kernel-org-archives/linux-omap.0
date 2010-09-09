From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/7] omap4: l2x0: Fix init parameter for ES2.0
Date: Thu,  9 Sep 2010 16:53:11 +0530
Message-ID: <1284031395-25988-4-git-send-email-santosh.shilimkar@ti.com>
References: <1284031395-25988-1-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-2-git-send-email-santosh.shilimkar@ti.com>
 <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41354 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913Ab0IILXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 07:23:24 -0400
In-Reply-To: <1284031395-25988-3-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@deeprootsystems.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

On ES2.0 the L2 cache init parameter ineeds to be changed to take
care of cache size. The cache size is 1MB on ES2.0 vs 512KB on ES1.0

This patch fixes the init parameter to update the same using
dynamic cpu version check

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 13dc979..2b32229 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -64,7 +64,10 @@ static int __init omap_l2_cache_init(void)
 	 * 32KB way size, 16-way associativity,
 	 * parity disabled
 	 */
-	l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
+	if (omap_rev() == OMAP4430_REV_ES2_0)
+		l2x0_init(l2cache_base, 0x0e070000, 0xc0000fff);
+	else
+		l2x0_init(l2cache_base, 0x0e050000, 0xc0000fff);
 
 	return 0;
 }
-- 
1.6.0.4

