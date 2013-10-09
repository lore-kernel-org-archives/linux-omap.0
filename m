From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/3] ARM: OMAP3: use CLK_SET_RATE_PARENT for dss clocks
Date: Wed, 9 Oct 2013 16:12:38 +0300
Message-ID: <1381324359-28825-2-git-send-email-tomi.valkeinen@ti.com>
References: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757062Ab3JINNW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:13:22 -0400
In-Reply-To: <1381324359-28825-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Set CLK_SET_RATE_PARENT flag for dss1_alwon_fck_3430es2,
dss1_alwon_fck_3430es1 and dpll4_m4x2_ck so that the DSS's fclk can be
configured without the need to get the parent's parent of the fclk.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 334b767..a51dd75 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -869,7 +869,8 @@ static struct clk_hw_omap dpll4_m4x2_ck_hw = {
 	.clkdm_name	= "dpll4_clkdm",
 };
 
-DEFINE_STRUCT_CLK(dpll4_m4x2_ck, dpll4_m4x2_ck_parent_names, dpll4_m5x2_ck_ops);
+DEFINE_STRUCT_CLK_FLAGS(dpll4_m4x2_ck, dpll4_m4x2_ck_parent_names,
+		dpll4_m5x2_ck_ops, CLK_SET_RATE_PARENT);
 
 static struct clk dpll4_m4x2_ck_3630 = {
 	.name		= "dpll4_m4x2_ck",
@@ -877,6 +878,7 @@ static struct clk dpll4_m4x2_ck_3630 = {
 	.parent_names	= dpll4_m4x2_ck_parent_names,
 	.num_parents	= ARRAY_SIZE(dpll4_m4x2_ck_parent_names),
 	.ops		= &dpll4_m5x2_ck_3630_ops,
+	.flags		= CLK_SET_RATE_PARENT,
 };
 
 DEFINE_CLK_DIVIDER(dpll4_m6_ck, "dpll4_ck", &dpll4_ck, 0x0,
@@ -968,8 +970,9 @@ static struct clk_hw_omap dss1_alwon_fck_3430es1_hw = {
 	.clkdm_name	= "dss_clkdm",
 };
 
-DEFINE_STRUCT_CLK(dss1_alwon_fck_3430es1, dss1_alwon_fck_3430es1_parent_names,
-		  aes2_ick_ops);
+DEFINE_STRUCT_CLK_FLAGS(dss1_alwon_fck_3430es1,
+		dss1_alwon_fck_3430es1_parent_names, aes2_ick_ops,
+		CLK_SET_RATE_PARENT);
 
 static struct clk dss1_alwon_fck_3430es2;
 
@@ -983,8 +986,9 @@ static struct clk_hw_omap dss1_alwon_fck_3430es2_hw = {
 	.clkdm_name	= "dss_clkdm",
 };
 
-DEFINE_STRUCT_CLK(dss1_alwon_fck_3430es2, dss1_alwon_fck_3430es1_parent_names,
-		  aes2_ick_ops);
+DEFINE_STRUCT_CLK_FLAGS(dss1_alwon_fck_3430es2,
+		dss1_alwon_fck_3430es1_parent_names, aes2_ick_ops,
+		CLK_SET_RATE_PARENT);
 
 static struct clk dss2_alwon_fck;
 
-- 
1.8.1.2

