From: "Chandra shekhar" <x0044955@ti.com>
Subject: [PATCH 1/5] mach:omap: some correction in Clock 34XX
Date: Mon, 12 Nov 2007 19:16:23 +0530
Message-ID: <200711121346.lACDkOeF020773@dbdp31.itg.ti.com>
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
List-Id: linux-omap@vger.kernel.org


Resumbmitting the patch earlier sent by girish, after fixing review comments given by paul.

This patch modifies the I2C clock nodes as per LDM, corrects usage of DPLL mask and updates the flags of 96M clock nodes

Signed-off-by: Chandra Shekhar <x0044955@ti.com>

---
 arch/arm/mach-omap2/clock34xx.c |    1 +
 arch/arm/mach-omap2/clock34xx.h |   27 ++++++++++++++++++---------
 2 files changed, 19 insertions(+), 9 deletions(-)

Index: linux-omap-git/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-12 17:07:54.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/clock34xx.h	2007-11-12 17:08:23.000000000 +0530
@@ -437,14 +437,16 @@
 static struct clk omap_96m_alwon_fck = {
 	.name		= "omap_96m_alwon_fck",
 	.parent		= &dpll4_m2x2_ck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				 PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
 static struct clk omap_96m_fck = {
 	.name		= "omap_96m_fck",
 	.parent		= &omap_96m_alwon_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -830,7 +832,8 @@
 static struct clk core_96m_fck = {
 	.name		= "core_96m_fck",
 	.parent		= &omap_96m_fck,
-	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES |
+				PARENT_CONTROLS_CLOCK,
 	.recalc		= &followparent_recalc,
 };
 
@@ -862,7 +865,8 @@
 };
 
 static struct clk i2c3_fck = {
-	.name		= "i2c3_fck",
+	.name		= "i2c_fck",
+	.id		= 3,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
@@ -871,7 +875,8 @@
 };
 
 static struct clk i2c2_fck = {
-	.name		= "i2c2_fck",
+	.name		= "i2c_fck",
+	.id 		= 2,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
@@ -880,7 +885,8 @@
 };
 
 static struct clk i2c1_fck = {
-	.name		= "i2c1_fck",
+	.name		= "i2c_fck",
+	.id		= 1,
 	.parent		= &core_96m_fck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
@@ -1222,7 +1228,8 @@
 };
 
 static struct clk i2c3_ick = {
-	.name		= "i2c3_ick",
+	.name		= "i2c_ick",
+	.id		= 3,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C3_SHIFT,
@@ -1231,7 +1238,8 @@
 };
 
 static struct clk i2c2_ick = {
-	.name		= "i2c2_ick",
+	.name		= "i2c_ick",
+	.id		= 2,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C2_SHIFT,
@@ -1240,7 +1248,8 @@
 };
 
 static struct clk i2c1_ick = {
-	.name		= "i2c1_ick",
+	.name		= "i2c_ick",
+	.id		= 1,
 	.parent		= &core_l4_ick,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	= OMAP3430_EN_I2C1_SHIFT,
Index: linux-omap-git/arch/arm/mach-omap2/clock34xx.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/clock34xx.c	2007-11-12 17:07:57.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/clock34xx.c	2007-11-12 17:09:17.000000000 +0530
@@ -79,6 +79,7 @@
 	WARN_ON(!dd->control_reg || !dd->enable_mask);
 
 	v = cm_read_reg(dd->control_reg) & dd->enable_mask;
+	v >>= mask_to_shift(dd->enable_mask);
 	if (v != DPLL_LOCKED)
 		clk->rate = clk->parent->rate;
 	else
