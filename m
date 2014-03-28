From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 58/75] ARM: l2c: omap2: remove cache size override
Date: Fri, 28 Mar 2014 15:19:23 +0000
Message-ID: <E1WTYZ1-0007Gn-3J@rmk-PC.arm.linux.org.uk>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:41487 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751862AbaC1PTZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Mar 2014 11:19:25 -0400
In-Reply-To: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index ce2fad84a43c..c0f9a81a2d32 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -212,20 +212,18 @@ static int __init omap_l2_cache_init(void)
 		return -ENOMEM;
 
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
-	aux_ctrl = L310_AUX_CTRL_ASSOCIATIVITY_16 |
-		   L310_AUX_CTRL_CACHE_REPLACE_RR |
+	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
 		   L310_AUX_CTRL_NS_LOCKDOWN |
 		   L310_AUX_CTRL_NS_INT_CTRL |
-		   L2C_AUX_CTRL_WAY_SIZE(3) |
 		   L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
 		   L310_AUX_CTRL_INSTR_PREFETCH;
 
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
-		l2x0_of_init(aux_ctrl, L2X0_AUX_CTRL_MASK);
+		l2x0_of_init(aux_ctrl, 0xc19fffff);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, L2X0_AUX_CTRL_MASK);
+		l2x0_init(l2cache_base, aux_ctrl, 0xc19fffff);
 
 	return 0;
 }
-- 
1.8.3.1

