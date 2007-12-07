From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: [RFC/PATCH  4/4] MMC/SD Controller driver for OMAP2430
Date: Fri, 7 Dec 2007 19:22:48 +0530
Message-ID: <003c01c838d8$73f9a0d0$fe8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch updates the OMAP2430/3430 MMC clock structures to use the id field.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>

---
 arch/arm/mach-omap2/clock24xx.h |   18 ++++++++++++------
 arch/arm/mach-omap2/clock34xx.h |   28 ++++++++++++++++------------
 2 files changed, 28 insertions(+), 18 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock24xx.h	2007-12-07 13:31:32.295583027 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/clock24xx.h	2007-12-07 15:10:31.304906122 +0530
@@ -2380,7 +2380,8 @@
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs1_ick",
+	.name		= "mmchs_ick",
+	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -2389,7 +2390,8 @@
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs1_fck",
+	.name		= "mmchs_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2398,7 +2400,8 @@
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs2_ick",
+	.name		= "mmchs_ick",
+	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
@@ -2407,7 +2410,8 @@
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs2_fck",
+	.name		= "mmchs_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2443,7 +2447,8 @@
 };
 
 static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb1_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 1,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
@@ -2452,7 +2457,8 @@
 };
 
 static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb2_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 2,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
Index: linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/clock34xx.h	2007-12-07 13:31:32.295583027 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/clock34xx.h	2007-12-07 13:34:26.599027527 +0530
@@ -850,8 +850,9 @@
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc2_fck = {
-	.name		= "mmc2_fck",
+static struct clk mmchs2_fck = {
+	.name		= "mmchs_fck",
+	.id		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
@@ -868,8 +869,9 @@
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc1_fck = {
-	.name		= "mmc1_fck",
+static struct clk mmchs1_fck = {
+	.name		= "mmchs_fck",
+	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
@@ -1183,8 +1185,9 @@
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc2_ick = {
-	.name		= "mmc2_ick",
+static struct clk mmchs2_ick = {
+	.name		= "mmchs_ick",
+	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC2_SHIFT,
@@ -1192,8 +1195,9 @@
 	.recalc		= &followparent_recalc,
 };
 
-static struct clk mmc1_ick = {
-	.name		= "mmc1_ick",
+static struct clk mmchs1_ick = {
+	.name		= "mmchs_ick",
+	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_MMC1_SHIFT,
@@ -2273,9 +2277,9 @@
 	&gpt10_fck,
 	&gpt11_fck,
 	&core_96m_fck,
-	&mmc2_fck,
+	&mmchs2_fck,
 	&mspro_fck,
-	&mmc1_fck,
+	&mmchs1_fck,
 	&i2c3_fck,
 	&i2c2_fck,
 	&i2c1_fck,
@@ -2304,8 +2308,8 @@
 	&aes2_ick,
 	&sha12_ick,
 	&des2_ick,
-	&mmc2_ick,
-	&mmc1_ick,
+	&mmchs2_ick,
+	&mmchs1_ick,
 	&mspro_ick,
 	&hdq_ick,
 	&mcspi4_ick,
