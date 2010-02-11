From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/13] OMAP clock: drop .id field;
	ensure each clock has a unique name
Date: Thu, 11 Feb 2010 11:17:06 -0700
Message-ID: <20100211181703.795.54159.stgit@localhost.localdomain>
References: <20100211181236.795.56094.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35529 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756778Ab0BKSUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Feb 2010 13:20:55 -0500
In-Reply-To: <20100211181236.795.56094.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

After the clkdev conversion, the struct clk.id became superfluous, so,
drop it.  Bring the clock names closer to the TRMs and ensure they are
unique for debugfs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock_data.c        |   10 +---
 arch/arm/mach-omap2/clock2xxx_data.c    |   81 ++++++++++-------------------
 arch/arm/mach-omap2/clock34xx_data.c    |   88 +++++++++++--------------------
 arch/arm/plat-omap/clock.c              |    2 -
 arch/arm/plat-omap/include/plat/clock.h |    1 
 5 files changed, 61 insertions(+), 121 deletions(-)

diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index edefb34..cea91cd 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -530,7 +530,7 @@ static struct clk bclk_16xx = {
 };
 
 static struct clk mmc1_ck = {
-	.name		= "mmc_ck",
+	.name		= "mmc1_ck",
 	.ops		= &clkops_generic,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
@@ -541,8 +541,7 @@ static struct clk mmc1_ck = {
 };
 
 static struct clk mmc2_ck = {
-	.name		= "mmc_ck",
-	.id		= 1,
+	.name		= "mmc2_ck",
 	.ops		= &clkops_generic,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
@@ -553,8 +552,7 @@ static struct clk mmc2_ck = {
 };
 
 static struct clk mmc3_ck = {
-	.name		= "mmc_ck",
-	.id		= 2,
+	.name		= "mmc3_ck",
 	.ops		= &clkops_generic,
 	/* Functional clock is direct from ULPD, interface clock is ARMPER */
 	.parent		= &armper_ck.clk,
@@ -577,7 +575,6 @@ static struct clk virtual_ck_mpu = {
 remains active during MPU idle whenever this is enabled */
 static struct clk i2c_fck = {
 	.name		= "i2c_fck",
-	.id		= 1,
 	.ops		= &clkops_null,
 	.flags		= CLOCK_NO_IDLE_PARENT,
 	.parent		= &armxor_ck.clk,
@@ -586,7 +583,6 @@ static struct clk i2c_fck = {
 
 static struct clk i2c_ick = {
 	.name		= "i2c_ick",
-	.id		= 1,
 	.ops		= &clkops_null,
 	.flags		= CLOCK_NO_IDLE_PARENT,
 	.parent		= &armper_ck.clk,
diff --git a/arch/arm/mach-omap2/clock2xxx_data.c b/arch/arm/mach-omap2/clock2xxx_data.c
index 9bcef44..82ad8b4 100644
--- a/arch/arm/mach-omap2/clock2xxx_data.c
+++ b/arch/arm/mach-omap2/clock2xxx_data.c
@@ -1224,9 +1224,8 @@ static struct clk gpt12_fck = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1235,9 +1234,8 @@ static struct clk mcbsp1_ick = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1246,9 +1244,8 @@ static struct clk mcbsp1_fck = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1257,9 +1254,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1268,9 +1264,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1279,9 +1274,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1290,9 +1284,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1301,9 +1294,8 @@ static struct clk mcbsp4_ick = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1312,9 +1304,8 @@ static struct clk mcbsp4_fck = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1323,9 +1314,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1334,9 +1324,8 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1345,9 +1334,8 @@ static struct clk mcspi1_ick = {
 };
 
 static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &func_48m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1356,9 +1344,8 @@ static struct clk mcspi1_fck = {
 };
 
 static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1367,9 +1354,8 @@ static struct clk mcspi2_ick = {
 };
 
 static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &func_48m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1378,9 +1364,8 @@ static struct clk mcspi2_fck = {
 };
 
 static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1389,9 +1374,8 @@ static struct clk mcspi3_ick = {
 };
 
 static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &func_48m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1717,9 +1701,8 @@ static struct clk hdq_fck = {
 };
 
 static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1728,9 +1711,8 @@ static struct clk i2c2_ick = {
 };
 
 static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &func_12m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1739,9 +1721,8 @@ static struct clk i2c2_fck = {
 };
 
 static struct clk i2chs2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2chs2_fck",
 	.ops		= &clkops_omap2430_i2chs_wait,
-	.id		= 2,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1750,9 +1731,8 @@ static struct clk i2chs2_fck = {
 };
 
 static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1761,9 +1741,8 @@ static struct clk i2c1_ick = {
 };
 
 static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &func_12m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1772,9 +1751,8 @@ static struct clk i2c1_fck = {
 };
 
 static struct clk i2chs1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2chs1_fck",
 	.ops		= &clkops_omap2430_i2chs_wait,
-	.id		= 1,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -1941,7 +1919,7 @@ static struct clk usbhs_ick = {
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -1951,7 +1929,7 @@ static struct clk mmchs1_ick = {
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_96m_ck,
 	.clkdm_name	= "core_l3_clkdm",
@@ -1961,9 +1939,8 @@ static struct clk mmchs1_fck = {
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &l4_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -1972,9 +1949,8 @@ static struct clk mmchs2_ick = {
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &func_96m_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
 	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
@@ -2012,7 +1988,7 @@ static struct clk mdm_intc_ick = {
 };
 
 static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb_fck",
+	.name		= "mmchsdb1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
@@ -2022,9 +1998,8 @@ static struct clk mmchsdb1_fck = {
 };
 
 static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb_fck",
+	.name		= "mmchsdb2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &func_32k_ck,
 	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 92529da..950d6fc 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -1505,9 +1505,8 @@ static struct clk core_96m_fck = {
 };
 
 static struct clk mmchs3_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
@@ -1516,9 +1515,8 @@ static struct clk mmchs3_fck = {
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
@@ -1537,7 +1535,7 @@ static struct clk mspro_fck = {
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs_fck",
+	.name		= "mmchs1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
@@ -1547,9 +1545,8 @@ static struct clk mmchs1_fck = {
 };
 
 static struct clk i2c3_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
@@ -1558,9 +1555,8 @@ static struct clk i2c3_fck = {
 };
 
 static struct clk i2c2_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
@@ -1569,9 +1565,8 @@ static struct clk i2c2_fck = {
 };
 
 static struct clk i2c1_fck = {
-	.name		= "i2c_fck",
+	.name		= "i2c1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
@@ -1600,9 +1595,8 @@ static const struct clksel mcbsp_15_clksel[] = {
 };
 
 static struct clk mcbsp5_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp5_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -1614,9 +1608,8 @@ static struct clk mcbsp5_fck = {
 };
 
 static struct clk mcbsp1_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -1638,9 +1631,8 @@ static struct clk core_48m_fck = {
 };
 
 static struct clk mcspi4_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
@@ -1648,9 +1640,8 @@ static struct clk mcspi4_fck = {
 };
 
 static struct clk mcspi3_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
@@ -1658,9 +1649,8 @@ static struct clk mcspi3_fck = {
 };
 
 static struct clk mcspi2_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
@@ -1668,9 +1658,8 @@ static struct clk mcspi2_fck = {
 };
 
 static struct clk mcspi1_fck = {
-	.name		= "mcspi_fck",
+	.name		= "mcspi1_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_48m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
@@ -1879,9 +1868,8 @@ static struct clk usbtll_ick = {
 };
 
 static struct clk mmchs3_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430ES2_EN_MMC3_SHIFT,
@@ -1931,9 +1919,8 @@ static struct clk des2_ick = {
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
@@ -1942,7 +1929,7 @@ static struct clk mmchs2_ick = {
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs_ick",
+	.name		= "mmchs1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
@@ -1972,9 +1959,8 @@ static struct clk hdq_ick = {
 };
 
 static struct clk mcspi4_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI4_SHIFT,
@@ -1983,9 +1969,8 @@ static struct clk mcspi4_ick = {
 };
 
 static struct clk mcspi3_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI3_SHIFT,
@@ -1994,9 +1979,8 @@ static struct clk mcspi3_ick = {
 };
 
 static struct clk mcspi2_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI2_SHIFT,
@@ -2005,9 +1989,8 @@ static struct clk mcspi2_ick = {
 };
 
 static struct clk mcspi1_ick = {
-	.name		= "mcspi_ick",
+	.name		= "mcspi1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCSPI1_SHIFT,
@@ -2016,9 +1999,8 @@ static struct clk mcspi1_ick = {
 };
 
 static struct clk i2c3_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
@@ -2027,9 +2009,8 @@ static struct clk i2c3_ick = {
 };
 
 static struct clk i2c2_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
@@ -2038,9 +2019,8 @@ static struct clk i2c2_ick = {
 };
 
 static struct clk i2c1_ick = {
-	.name		= "i2c_ick",
+	.name		= "i2c1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
@@ -2089,9 +2069,8 @@ static struct clk gpt10_ick = {
 };
 
 static struct clk mcbsp5_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp5_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 5,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP5_SHIFT,
@@ -2100,9 +2079,8 @@ static struct clk mcbsp5_ick = {
 };
 
 static struct clk mcbsp1_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp1_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MCBSP1_SHIFT,
@@ -2897,9 +2875,8 @@ static struct clk gpt2_ick = {
 };
 
 static struct clk mcbsp2_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp2_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2908,9 +2885,8 @@ static struct clk mcbsp2_ick = {
 };
 
 static struct clk mcbsp3_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp3_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2919,9 +2895,8 @@ static struct clk mcbsp3_ick = {
 };
 
 static struct clk mcbsp4_ick = {
-	.name		= "mcbsp_ick",
+	.name		= "mcbsp4_ick",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.parent		= &per_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
@@ -2936,9 +2911,8 @@ static const struct clksel mcbsp_234_clksel[] = {
 };
 
 static struct clk mcbsp2_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp2_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 2,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP2_SHIFT,
@@ -2950,9 +2924,8 @@ static struct clk mcbsp2_fck = {
 };
 
 static struct clk mcbsp3_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp3_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 3,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP3_SHIFT,
@@ -2964,9 +2937,8 @@ static struct clk mcbsp3_fck = {
 };
 
 static struct clk mcbsp4_fck = {
-	.name		= "mcbsp_fck",
+	.name		= "mcbsp4_fck",
 	.ops		= &clkops_omap2_dflt_wait,
-	.id		= 4,
 	.init		= &omap2_init_clksel_parent,
 	.enable_reg	= OMAP_CM_REGADDR(OMAP3430_PER_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_MCBSP4_SHIFT,
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 0ae2753..c518c38 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -408,8 +408,6 @@ static int clk_debugfs_register_one(struct clk *c)
 	char *p = s;
 
 	p += sprintf(p, "%s", c->name);
-	if (c->id != 0)
-		sprintf(p, ":%d", c->id);
 	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
 	if (!d)
 		return -ENOMEM;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 7dc1ae7..bc9bccb 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -121,7 +121,6 @@ struct clk {
 	struct list_head	node;
 	const struct clkops	*ops;
 	const char		*name;
-	int			id;
 	struct clk		*parent;
 	struct list_head	children;
 	struct list_head	sibling;	/* node for children */


