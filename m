From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/8] OMAP2/3 clock: ensure each clock has a unique name
Date: Fri, 05 Jun 2009 04:19:40 -0600
Message-ID: <20090605101939.32500.95716.stgit@localhost.localdomain>
References: <20090605101635.32500.63083.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47669 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752015AbZFEKUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 06:20:33 -0400
In-Reply-To: <20090605101635.32500.63083.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

After the clkdev conversion, struct clk .name fields are free to be
unique and to reflect the underlying hardware naming convention.  This
is important since it is useful for some core code that is unrelated
to the platform_device subsystem, such as the clock debugfs code and
the omap_hwmod code, to be able to address clocks by a single unique
identifier, since platform drivers are only weakly bound to clocks.
So, update all of the non-unique clock names in OMAP2/3 to be unique
names.  In the future it might be ideal to ensure that the names match
the hardware information exactly, for ease of debugging and reference.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |   52 +++++++++++++++++-----------------
 arch/arm/mach-omap2/clock34xx.h |   60 ++++++++++++++++++++-------------------
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 88c5acb..c0cc2ac 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -1810,7 +1810,7 @@ static struct clk gpt12_fck = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
@@ -1821,7 +1821,7 @@ static struct clk mcbsp1_ick = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
@@ -1832,7 +1832,7 @@ static struct clk mcbsp1_fck = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
@@ -1843,7 +1843,7 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
@@ -1854,7 +1854,7 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
@@ -1865,7 +1865,7 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_96m_ck,
@@ -1876,7 +1876,7 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &l4_ck,
@@ -1887,7 +1887,7 @@ static struct clk mcbsp4_ick = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &func_96m_ck,
@@ -1898,7 +1898,7 @@ static struct clk mcbsp4_fck = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &l4_ck,
@@ -1909,7 +1909,7 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &func_96m_ck,
@@ -1920,7 +1920,7 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
@@ -1931,7 +1931,7 @@ static struct clk mcspi1_ick = {
 };
 
 static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_48m_ck,
@@ -1942,7 +1942,7 @@ static struct clk mcspi1_fck = {
 };
 
 static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
@@ -1953,7 +1953,7 @@ static struct clk mcspi2_ick = {
 };
 
 static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_48m_ck,
@@ -1964,7 +1964,7 @@ static struct clk mcspi2_fck = {
 };
 
 static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &l4_ck,
@@ -1975,7 +1975,7 @@ static struct clk mcspi3_ick = {
 };
 
 static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &func_48m_ck,
@@ -2303,7 +2303,7 @@ static struct clk hdq_fck = {
 };
 
 static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &l4_ck,
@@ -2314,7 +2314,7 @@ static struct clk i2c2_ick = {
 };
 
 static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_12m_ck,
@@ -2325,7 +2325,7 @@ static struct clk i2c2_fck = {
 };
 
 static struct clk i2chs2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2chs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &func_96m_ck,
@@ -2336,7 +2336,7 @@ static struct clk i2chs2_fck = {
 };
 
 static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
@@ -2347,7 +2347,7 @@ static struct clk i2c1_ick = {
 };
 
 static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_12m_ck,
@@ -2358,7 +2358,7 @@ static struct clk i2c1_fck = {
 };
 
 static struct clk i2chs1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2chs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
@@ -2547,7 +2547,7 @@ static struct clk mmchs1_fck = {
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &l4_ck,
@@ -2558,7 +2558,7 @@ static struct clk mmchs2_ick = {
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_96m_ck,
@@ -2598,7 +2598,7 @@ static struct clk mdm_intc_ick = {
 };
 
 static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb_fck",
+	.name		= "mmchsdb1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2608,7 +2608,7 @@ static struct clk mmchsdb1_fck = {
 };
 
 static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb_fck",
+	.name		= "mmchsdb2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &func_32k_ck,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 017a30e..1380563 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -1300,7 +1300,7 @@ static struct clk core_96m_fck = {
 };
 
 static struct clk mmchs3_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_96m_fck,
@@ -1311,7 +1311,7 @@ static struct clk mmchs3_fck = {
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_96m_fck,
@@ -1332,7 +1332,7 @@ static struct clk mspro_fck = {
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1342,7 +1342,7 @@ static struct clk mmchs1_fck = {
 };
 
 static struct clk i2c3_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_96m_fck,
@@ -1353,7 +1353,7 @@ static struct clk i2c3_fck = {
 };
 
 static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_96m_fck,
@@ -1364,7 +1364,7 @@ static struct clk i2c2_fck = {
 };
 
 static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_96m_fck,
@@ -1395,7 +1395,7 @@ static const struct clksel mcbsp_15_clksel[] = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
@@ -1409,7 +1409,7 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
@@ -1433,7 +1433,7 @@ static struct clk core_48m_fck = {
 };
 
 static struct clk mcspi4_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &core_48m_fck,
@@ -1443,7 +1443,7 @@ static struct clk mcspi4_fck = {
 };
 
 static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_48m_fck,
@@ -1453,7 +1453,7 @@ static struct clk mcspi3_fck = {
 };
 
 static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_48m_fck,
@@ -1463,7 +1463,7 @@ static struct clk mcspi2_fck = {
 };
 
 static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_48m_fck,
@@ -1643,7 +1643,7 @@ static struct clk usbtll_ick = {
 };
 
 static struct clk mmchs3_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
@@ -1695,7 +1695,7 @@ static struct clk des2_ick = {
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
@@ -1706,7 +1706,7 @@ static struct clk mmchs2_ick = {
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1736,7 +1736,7 @@ static struct clk hdq_ick = {
 };
 
 static struct clk mcspi4_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &core_l4_ick,
@@ -1747,7 +1747,7 @@ static struct clk mcspi4_ick = {
 };
 
 static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_l4_ick,
@@ -1758,7 +1758,7 @@ static struct clk mcspi3_ick = {
 };
 
 static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
@@ -1769,7 +1769,7 @@ static struct clk mcspi2_ick = {
 };
 
 static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
@@ -1780,7 +1780,7 @@ static struct clk mcspi1_ick = {
 };
 
 static struct clk i2c3_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &core_l4_ick,
@@ -1791,7 +1791,7 @@ static struct clk i2c3_ick = {
 };
 
 static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &core_l4_ick,
@@ -1802,7 +1802,7 @@ static struct clk i2c2_ick = {
 };
 
 static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
@@ -1853,7 +1853,7 @@ static struct clk gpt10_ick = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 5,
 	.parent		= &core_l4_ick,
@@ -1864,7 +1864,7 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 1,
 	.parent		= &core_l4_ick,
@@ -2644,7 +2644,7 @@ static struct clk gpt2_ick = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.parent		= &per_l4_ick,
@@ -2655,7 +2655,7 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.parent		= &per_l4_ick,
@@ -2666,7 +2666,7 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.parent		= &per_l4_ick,
@@ -2683,7 +2683,7 @@ static const struct clksel mcbsp_234_clksel[] = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 2,
 	.init		= &omap2_init_clksel_parent,
@@ -2697,7 +2697,7 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 3,
 	.init		= &omap2_init_clksel_parent,
@@ -2711,7 +2711,7 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.id		= 4,
 	.init		= &omap2_init_clksel_parent,


