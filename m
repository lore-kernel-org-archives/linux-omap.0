From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Thu, 10 Apr 2014 18:57:05 +0530
Message-ID: <53469C29.8050906@ti.com>
References: <cover.1396605300.git.nsekhar@ti.com> <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com> <20140410120348.GK27282@n2100.arm.linux.org.uk> <53468B8E.9040604@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59071 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030658AbaDJN1j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 09:27:39 -0400
In-Reply-To: <53468B8E.9040604@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Thursday 10 April 2014 05:46 PM, Sekhar Nori wrote:
> This will work. NS_LOCKDOWN is required for L2C-220 as well and so I was
> thinking about adding a new l2c220_enable() which will set the
> NS_LOCKDOWN and then call l2c_enable()

Here is a patch for what I was saying above.

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index c47ac8f..dc9e03b 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -105,6 +105,8 @@
 #define L2X0_AUX_CTRL_DIRTY_LATENCY_MASK	(7 << 9)
 #define L2X0_AUX_CTRL_ASSOC_SHIFT		13
 #define L2X0_AUX_CTRL_ASSOC_MASK		(15 << 13)
+/* L2C-220/310 common bits */
+#define L2C_AUX_CTRL_NS_LOCKDOWN		BIT(26)
 /* L2C-210 specific bits */
 #define L210_AUX_CTRL_WRAP_DISABLE		BIT(12)
 #define L210_AUX_CTRL_WA_OVERRIDE		BIT(23)
@@ -113,7 +115,6 @@
 #define L220_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
 #define L220_AUX_CTRL_FWA_SHIFT			23
 #define L220_AUX_CTRL_FWA_MASK			(3 << 23)
-#define L220_AUX_CTRL_NS_LOCKDOWN		BIT(26)
 #define L220_AUX_CTRL_NS_INT_CTRL		BIT(27)
 /* L2C-310 specific bits */
 #define L310_AUX_CTRL_FULL_LINE_ZERO		BIT(0)	/* R2P0+ */
@@ -122,7 +123,6 @@
 #define L310_AUX_CTRL_EXCLUSIVE_CACHE		BIT(12)
 #define L310_AUX_CTRL_ASSOCIATIVITY_16		BIT(16)
 #define L310_AUX_CTRL_CACHE_REPLACE_RR		BIT(25)	/* R2P0+ */
-#define L310_AUX_CTRL_NS_LOCKDOWN		BIT(26)
 #define L310_AUX_CTRL_NS_INT_CTRL		BIT(27)
 #define L310_AUX_CTRL_DATA_PREFETCH		BIT(28)
 #define L310_AUX_CTRL_INSTR_PREFETCH		BIT(29)
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 6b2a056..34cafe0 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -216,8 +216,6 @@ int __init omap4_l2_cache_init(void)
 {
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
 	u32 aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		       L310_AUX_CTRL_NS_LOCKDOWN |
-		       L310_AUX_CTRL_NS_INT_CTRL |
 		       L2C_AUX_CTRL_SHARED_OVERRIDE |
 		       L310_AUX_CTRL_DATA_PREFETCH |
 		       L310_AUX_CTRL_INSTR_PREFETCH;
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index b1f103d..b6af13f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -498,11 +498,23 @@ static void l2c220_sync(void)
 	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
+static void __init l2c220_enable(void __iomem *base, u32 aux, unsigned num_lock)
+{
+	/*
+	 * Always enable non-secure access to the lockdown registers -
+	 * we write to them as part of the L2C enable sequence so they
+	 * need to be accessible.
+	 */
+	aux |= L2C_AUX_CTRL_NS_LOCKDOWN;
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
 	.outer_cache = {
 		.inv_range = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,
@@ -764,7 +776,7 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
 			power_ctrl & L310_STNDBY_MODE_EN ? "en" : "dis");
 	}
 
-	l2c_enable(base, aux, num_lock);
+	l2c220_enable(base, aux, num_lock);
 
 	if (aux & L310_AUX_CTRL_FULL_LINE_ZERO) {
 		set_auxcr(get_auxcr() | BIT(3) | BIT(2) | BIT(1));
@@ -1027,7 +1039,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
-	.enable = l2c_enable,
+	.enable = l2c220_enable,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,
 		.clean_range = l2c220_clean_range,

