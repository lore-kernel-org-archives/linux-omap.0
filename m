From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 86/97] ARM: l2c: always enable non-secure access to lockdown
 registers
Date: Mon, 28 Apr 2014 20:33:31 +0100
Message-ID: <E1WerIx-0001ZX-Dm@rmk-PC.arm.linux.org.uk>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:55845 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932433AbaD1Tde (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Apr 2014 15:33:34 -0400
In-Reply-To: <20140428192419.GV26756@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.ifradead.org
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Since we always write to these during the cache initialisation, it is
a good idea to always have the non-secure access bit set.  Set it in
core code and remove it from OMAP4.  Remove the NS access bit for the
interrupt registers from OMAP4 as well - nothing in the kernel accesses
that yet, and we can add it in core code when we have the need.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/omap4-common.c |  6 ++----
 arch/arm/mm/cache-l2x0.c           | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 06c6a181d6ad..df3f53195c57 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -214,17 +214,15 @@ static int __init omap_l2_cache_init(void)
 
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
 	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		   L310_AUX_CTRL_NS_LOCKDOWN |
-		   L310_AUX_CTRL_NS_INT_CTRL |
 		   L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
 		   L310_AUX_CTRL_INSTR_PREFETCH;
 
 	outer_cache.write_sec = omap4_l2c310_write_sec;
 	if (of_have_populated_dt())
-		l2x0_of_init(aux_ctrl, 0xc19fffff);
+		l2x0_of_init(aux_ctrl, 0xcd9fffff);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, 0xc19fffff);
+		l2x0_init(l2cache_base, aux_ctrl, 0xcd9fffff);
 
 	return 0;
 }
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 333ef64873f9..efc5cabf70e0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -440,11 +440,23 @@ static void l2c220_sync(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void l2c220_enable(void __iomem *base, u32 aux, unsigned num_lock)
+{
+	/*
+	 * Always enable non-secure access to the lockdown registers -
+	 * we write to them as part of the L2C enable sequence so they
+	 * need to be accessible.
+	 */
+	aux |= L220_AUX_CTRL_NS_LOCKDOWN;
+
+	l2c_enable(base, aux, num_lock);
+}
+
 static const struct l2c_init_data l2c220_data = {
 	.type = "L2C-220",
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
-	.enable = l2c_enable,
+	.enable = l2c220_enable,
 	.save = l2c_save,
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
@@ -707,6 +719,13 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
 	}
 
+	/*
+	 * Always enable non-secure access to the lockdown registers -
+	 * we write to them as part of the L2C enable sequence so they
+	 * need to be accessible.
+	 */
+	aux |= L310_AUX_CTRL_NS_LOCKDOWN;
+
 	l2c_enable(base, aux, num_lock);
 
 	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
@@ -983,7 +1002,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
-	.enable = l2c_enable,
+	.enable = l2c220_enable,
 	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
-- 
1.8.3.1

