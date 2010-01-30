From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/9] omap3/4: Fix compile for multi-omap for
	clkops_noncore_dpll_ops
Date: Fri, 29 Jan 2010 18:01:36 -0800
Message-ID: <20100130020136.10590.83332.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49422 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756150Ab0A3CBO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 21:01:14 -0500
In-Reply-To: <20100130020036.10590.78028.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Rename clkops_noncore_dpll_ops for omap3 and omap4.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock34xx.c      |    2 +-
 arch/arm/mach-omap2/clock34xx.h      |    2 +-
 arch/arm/mach-omap2/clock34xx_data.c |    6 +++---
 arch/arm/mach-omap2/clock44xx.c      |    2 +-
 arch/arm/mach-omap2/clock44xx.h      |    2 +-
 arch/arm/mach-omap2/clock44xx_data.c |   12 ++++++------
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1f1b5a6..ae9e2c8 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -130,7 +130,7 @@ const struct clkops clkops_omap3430es2_hsotgusb_wait = {
 	.find_companion = omap2_clk_dflt_find_companion,
 };
 
-const struct clkops clkops_noncore_dpll_ops = {
+const struct clkops omap3_clkops_noncore_dpll_ops = {
 	.enable		= omap3_noncore_dpll_enable,
 	.disable	= omap3_noncore_dpll_disable,
 };
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 73f2109..313efc0 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -20,6 +20,6 @@ extern struct clk *arm_fck_p;
 extern const struct clkops clkops_omap3430es2_ssi_wait;
 extern const struct clkops clkops_omap3430es2_hsotgusb_wait;
 extern const struct clkops clkops_omap3430es2_dss_usbhost_wait;
-extern const struct clkops clkops_noncore_dpll_ops;
+extern const struct clkops omap3_clkops_noncore_dpll_ops;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 0d04f92..8728f1f 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -337,7 +337,7 @@ static struct dpll_data dpll2_dd = {
 
 static struct clk dpll2_ck = {
 	.name		= "dpll2_ck",
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap3_clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll2_dd,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -554,7 +554,7 @@ static struct dpll_data dpll4_dd = {
 
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap3_clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll4_dd,
 	.round_rate	= &omap2_dpll_round_rate,
@@ -854,7 +854,7 @@ static struct dpll_data dpll5_dd = {
 
 static struct clk dpll5_ck = {
 	.name		= "dpll5_ck",
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap3_clkops_noncore_dpll_ops,
 	.parent		= &sys_ck,
 	.dpll_data	= &dpll5_dd,
 	.round_rate	= &omap2_dpll_round_rate,
diff --git a/arch/arm/mach-omap2/clock44xx.c b/arch/arm/mach-omap2/clock44xx.c
index c238717..84ee6b0 100644
--- a/arch/arm/mach-omap2/clock44xx.c
+++ b/arch/arm/mach-omap2/clock44xx.c
@@ -13,7 +13,7 @@
 #include <linux/errno.h>
 #include "clock.h"
 
-const struct clkops clkops_noncore_dpll_ops = {
+const struct clkops omap4_clkops_noncore_dpll_ops = {
 	.enable		= &omap3_noncore_dpll_enable,
 	.disable	= &omap3_noncore_dpll_disable,
 };
diff --git a/arch/arm/mach-omap2/clock44xx.h b/arch/arm/mach-omap2/clock44xx.h
index 1f55b6b..efe8494 100644
--- a/arch/arm/mach-omap2/clock44xx.h
+++ b/arch/arm/mach-omap2/clock44xx.h
@@ -12,6 +12,6 @@
 
 int omap4xxx_clk_init(void);
 
-extern const struct clkops clkops_noncore_dpll_ops;
+extern const struct clkops omap4_clkops_noncore_dpll_ops;
 
 #endif
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 35ffe63..86af31d 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -279,7 +279,7 @@ static struct clk dpll_abe_ck = {
 	.parent		= &abe_dpll_refclk_mux_ck,
 	.dpll_data	= &dpll_abe_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
@@ -668,7 +668,7 @@ static struct clk dpll_iva_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_iva_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
@@ -731,7 +731,7 @@ static struct clk dpll_mpu_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_mpu_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
@@ -807,7 +807,7 @@ static struct clk dpll_per_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_per_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
@@ -930,7 +930,7 @@ static struct clk dpll_unipro_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_unipro_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,
@@ -988,7 +988,7 @@ static struct clk dpll_usb_ck = {
 	.parent		= &dpll_sys_ref_clk,
 	.dpll_data	= &dpll_usb_dd,
 	.init		= &omap2_init_dpll_parent,
-	.ops		= &clkops_noncore_dpll_ops,
+	.ops		= &omap4_clkops_noncore_dpll_ops,
 	.recalc		= &omap3_dpll_recalc,
 	.round_rate	= &omap2_dpll_round_rate,
 	.set_rate	= &omap3_noncore_dpll_set_rate,

