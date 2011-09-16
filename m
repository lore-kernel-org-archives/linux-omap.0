From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH v2 6/6] OMAP4: Clock: Correct the name of SLIMBUS interface clocks
Date: Fri, 16 Sep 2011 12:48:50 -0500
Message-ID: <1316195330-15099-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675Ab1IPRs4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Sep 2011 13:48:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

Currently the interface clocks for the two SLIMBUS peripherals are
named slimbus1_fck and slimbus2_fck. Rename these clocks to be
slimbus1_ick and slimbus2_ick so it is clear that these are
interface clocks and not functional clocks.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index eb2a345..d75ebdd 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2210,8 +2210,8 @@ static struct clk slimbus1_slimbus_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus1_fck = {
-	.name		= "slimbus1_fck",
+static struct clk slimbus1_ick = {
+	.name		= "slimbus1_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM1_ABE_SLIMBUS_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -2250,8 +2250,8 @@ static struct clk slimbus2_slimbus_clk = {
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk slimbus2_fck = {
-	.name		= "slimbus2_fck",
+static struct clk slimbus2_ick = {
+	.name		= "slimbus2_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L4PER_SLIMBUS2_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_SWCTRL,
@@ -3272,11 +3272,11 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_443X),
 	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2,	CK_443X),
 	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk,	CK_443X),
-	CLK(NULL,	"slimbus1_fck",			&slimbus1_fck,	CK_443X),
+	CLK(NULL,	"slimbus1_ick",			&slimbus1_ick,	CK_443X),
 	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1,	CK_443X),
 	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_443X),
 	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_443X),
-	CLK(NULL,	"slimbus2_fck",			&slimbus2_fck,	CK_443X),
+	CLK(NULL,	"slimbus2_ick",			&slimbus2_ick,	CK_443X),
 	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
 	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-- 
1.7.4.1

