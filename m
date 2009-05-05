From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP clock: GPIO de-bounce clocks don't affect module idle
 state
Date: Tue, 5 May 2009 16:55:14 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0905051654160.17514@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:32991 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021AbZEEWzP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 May 2009 18:55:15 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com


GPIO de-bounce clocks don't have any impact on the module idle state, so
the clock code should not wait for the module to enable after the de-bounce
clocks are enabled.

Problem found by Kevin Hilman <khilman@deeprootsystems.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/clock34xx.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 6763b8f..017a30e 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2182,7 +2182,7 @@ static struct clk wkup_32k_fck = {
 
 static struct clk gpio1_dbck = {
 	.name		= "gpio1_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &wkup_32k_fck,
 	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
@@ -2427,7 +2427,7 @@ static struct clk per_32k_alwon_fck = {
 
 static struct clk gpio6_dbck = {
 	.name		= "gpio6_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO6_SHIFT,
@@ -2437,7 +2437,7 @@ static struct clk gpio6_dbck = {
 
 static struct clk gpio5_dbck = {
 	.name		= "gpio5_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO5_SHIFT,
@@ -2447,7 +2447,7 @@ static struct clk gpio5_dbck = {
 
 static struct clk gpio4_dbck = {
 	.name		= "gpio4_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO4_SHIFT,
@@ -2457,7 +2457,7 @@ static struct clk gpio4_dbck = {
 
 static struct clk gpio3_dbck = {
 	.name		= "gpio3_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO3_SHIFT,
@@ -2467,7 +2467,7 @@ static struct clk gpio3_dbck = {
 
 static struct clk gpio2_dbck = {
 	.name		= "gpio2_dbck",
-	.ops		= &clkops_omap2_dflt_wait,
+	.ops		= &clkops_omap2_dflt,
 	.parent		= &per_32k_alwon_fck,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO2_SHIFT,
-- 
1.6.3.rc1.51.gea0b7

