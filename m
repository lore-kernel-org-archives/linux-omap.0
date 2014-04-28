From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 63/97] ARM: l2c: omap2: remove cache size override
Date: Mon, 28 Apr 2014 20:31:33 +0100
Message-ID: <E1WerH3-0001Y0-Rs@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55758 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932813AbaD1Tbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:31:36 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 9ce52548a484..06c6a181d6ad 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -213,20 +213,18 @@ static int __init omap_l2_cache_init(void)
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

