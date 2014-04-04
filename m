From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v2 1/3] ARM: OMAP2+: L2 cache: allow different aux ctrl settings
Date: Fri, 4 Apr 2014 15:40:27 +0530
Message-ID: <26e5bedd5fa33981e2ef3a8e3e498405bf854765.1396605300.git.nsekhar@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36561 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284AbaDDKLP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 4 Apr 2014 06:11:15 -0400
In-Reply-To: <cover.1396605300.git.nsekhar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

Different SoCs likely need different L2 cache aux ctrl
settings based on use cases and optimizations required.

For example, if CMA is always used for coherent memory allocations,
there is no need for sharable attribute override bit to be set.

Pass aux control settings as argument to the L2 cache initialization
function to allow for this.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 06c6a18..0a2e4f0 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -196,10 +196,8 @@ static void omap4_l2c310_write_sec(unsigned long val, unsigned reg)
 	omap_smc1(smc_op, val);
 }
 
-static int __init omap_l2_cache_init(void)
+static int __init omap_l2_cache_init(u32 aux_ctrl, u32 aux_flags)
 {
-	u32 aux_ctrl;
-
 	/*
 	 * To avoid code running on other OMAPs in
 	 * multi-omap builds
@@ -212,23 +210,28 @@ static int __init omap_l2_cache_init(void)
 	if (WARN_ON(!l2cache_base))
 		return -ENOMEM;
 
-	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
-	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		   L310_AUX_CTRL_NS_LOCKDOWN |
-		   L310_AUX_CTRL_NS_INT_CTRL |
-		   L2C_AUX_CTRL_SHARED_OVERRIDE |
-		   L310_AUX_CTRL_DATA_PREFETCH |
-		   L310_AUX_CTRL_INSTR_PREFETCH;
-
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
-		l2x0_of_init(aux_ctrl, 0xc19fffff);
+		l2x0_of_init(aux_ctrl, aux_flags);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, 0xc19fffff);
+		l2x0_init(l2cache_base, aux_ctrl, aux_flags);
 
 	return 0;
 }
-omap_early_initcall(omap_l2_cache_init);
+
+static int __init omap4_l2_cache_init(void)
+{
+	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
+	u32 aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
+		       L310_AUX_CTRL_NS_LOCKDOWN |
+		       L310_AUX_CTRL_NS_INT_CTRL |
+		       L2C_AUX_CTRL_SHARED_OVERRIDE |
+		       L310_AUX_CTRL_DATA_PREFETCH |
+		       L310_AUX_CTRL_INSTR_PREFETCH;
+
+	return omap_l2_cache_init(aux_ctrl, 0xc19fffff);
+}
+omap_early_initcall(omap4_l2_cache_init);
 #endif
 
 void __iomem *omap4_get_sar_ram_base(void)
-- 
1.7.10.1

