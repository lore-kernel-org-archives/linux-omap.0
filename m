From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: AM43x: L2 cache support
Date: Fri, 11 Apr 2014 12:25:01 +0100
Message-ID: <20140411112500.GM27282@n2100.arm.linux.org.uk>
References: <efa5fda5ae625a43fac14bf173cbd96ad7b44e7a.1396605300.git.nsekhar@ti.com> <20140404101808.GG27282@n2100.arm.linux.org.uk> <53440D73.6060504@ti.com> <20140409162327.GH27282@n2100.arm.linux.org.uk> <534686DF.7070207@ti.com> <20140410120348.GK27282@n2100.arm.linux.org.uk> <53468B8E.9040604@ti.com> <53469C29.8050906@ti.com> <20140410134028.GL27282@n2100.arm.linux.org.uk> <53477EC5.5080400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:58033 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754076AbaDKLZh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Apr 2014 07:25:37 -0400
Content-Disposition: inline
In-Reply-To: <53477EC5.5080400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>

On Fri, Apr 11, 2014 at 11:03:57AM +0530, Sekhar Nori wrote:
> Here is a revised patch which is just an extension of your patch 
> with L2C-220 case handled. I dont really have L2C-220 hardware so even 
> if you want to handle that at a later time, it would be perfectly okay 
> with me.

This is what I came up with, which of course is very similar to yours.
I think the only difference is that I'm allowing the state of the NS
access bits to be preserved by the OMAP code, getting OMAP closer to
the target of a ~0 mask.  The only bits which are clear in the mask
passed into the L2 code by OMAP now are:

- L310_AUX_CTRL_INSTR_PREFETCH
- L310_AUX_CTRL_DATA_PREFETCH
- L310_AUX_CTRL_CACHE_REPLACE_RR
- L2C_AUX_CTRL_SHARED_OVERRIDE
- L2C_AUX_CTRL_PARITY_ENABLE

It sounds like we can kill L310_AUX_CTRL_CACHE_REPLACE_RR as well since
that's already set for us (and fwir is the power-on-reset default too.)

 arch/arm/mach-omap2/omap4-common.c |  4 +---
 arch/arm/mm/cache-l2x0.c           | 23 +++++++++++++++++++++--
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index c0f9a81a2d32..3b01c5223b11 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -213,8 +213,6 @@ static int __init omap_l2_cache_init(void)
 
 	/* 16-way associativity, parity disabled, way size - 64KB (es2.0 +) */
 	aux_ctrl = L310_AUX_CTRL_CACHE_REPLACE_RR |
-		   L310_AUX_CTRL_NS_LOCKDOWN |
-		   L310_AUX_CTRL_NS_INT_CTRL |
 		   L2C_AUX_CTRL_SHARED_OVERRIDE |
 		   L310_AUX_CTRL_DATA_PREFETCH |
 		   L310_AUX_CTRL_INSTR_PREFETCH;
@@ -223,7 +221,7 @@ static int __init omap_l2_cache_init(void)
 	if (of_have_populated_dt())
 		l2x0_of_init(aux_ctrl, 0xc19fffff);
 	else
-		l2x0_init(l2cache_base, aux_ctrl, 0xc19fffff);
+		l2x0_init(l2cache_base, aux_ctrl, 0xcd9fffff);
 
 	return 0;
 }
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 98796b789eb9..5ec454d51a9f 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -502,11 +502,23 @@ static void l2c220_sync(void)
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
@@ -776,6 +788,13 @@ static void __init l2c310_enable(void __iomem *base, u32 aux, unsigned num_lock)
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
@@ -1052,7 +1071,7 @@ static const struct l2c_init_data of_l2c220_data __initconst = {
 	.way_size_0 = SZ_8K,
 	.num_lock = 1,
 	.of_parse = l2x0_of_parse,
-	.enable = l2c_enable,
+	.enable = l2c220_enable,
 	.save = l2c_save,
 	.outer_cache = {
 		.inv_range   = l2c220_inv_range,

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
