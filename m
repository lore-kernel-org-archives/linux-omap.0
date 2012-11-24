From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/6] ARM: OMAP2/3: PRM: fix bogus OMAP2xxx powerstate return
 values
Date: Fri, 23 Nov 2012 20:42:35 -0700
Message-ID: <20121124034234.24638.79865.stgit@dusk.lan>
References: <20121124033809.24638.11090.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57018 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756828Ab2KXDoQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 22:44:16 -0500
In-Reply-To: <20121124033809.24638.11090.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP2xxx chips, the register bitfields for the
PM_PWSTCTRL_*.POWERSTATE and PM_PWSTST_*.LASTSTATEENTERED are
different than those used on OMAP3/4.  The order is reversed.  So, for
example, on OMAP2xxx, 0x0 indicates 'ON'; but on OMAP3/4, 0x0
indicates 'OFF'.  Similarly, on OMAP2xxx, 0x3 indicates 'OFF', but on
OMAP3/4, 0x3 indicates 'ON'.

To fix this, we treat the OMAP3/4 values as the powerdomain API
values, and create new low-level powerdomain functions for the
OMAP2xxx chips which translate between the OMAP2xxx values and the
OMAP3/4 values.

Without this patch, the conversion of the OMAP2xxx PM code to the
functional powerstate code results in a non-booting kernel.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm2xxx.c      |   88 +++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   22 ---------
 arch/arm/mach-omap2/prm3xxx.c      |   28 ++++++++++-
 3 files changed, 110 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index bf24fc4..e4cdb69 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -29,6 +29,14 @@
 #include "prm-regbits-24xx.h"
 
 /*
+ * OMAP24xx PM_PWSTCTRL_*.POWERSTATE and PM_PWSTST_*.LASTSTATEENTERED bits -
+ * these are reversed from the bits used on OMAP3+
+ */
+#define OMAP24XX_PWRDM_POWER_ON			0x0
+#define OMAP24XX_PWRDM_POWER_RET		0x1
+#define OMAP24XX_PWRDM_POWER_OFF		0x3
+
+/*
  * omap2xxx_prm_reset_src_map - map from bits in the PRM_RSTST_WKUP
  *   hardware register (which are specific to the OMAP2xxx SoCs) to
  *   reset source ID bit shifts (which is an OMAP SoC-independent
@@ -69,6 +77,34 @@ static u32 omap2xxx_prm_read_reset_sources(void)
 }
 
 /**
+ * omap2xxx_pwrst_to_common_pwrst - convert OMAP2xxx pwrst to common pwrst
+ * @omap2xxx_pwrst: OMAP2xxx hardware power state to convert
+ *
+ * Return the common power state bits corresponding to the OMAP2xxx
+ * hardware power state bits @omap2xxx_pwrst, or -EINVAL upon error.
+ */
+static int omap2xxx_pwrst_to_common_pwrst(u8 omap2xxx_pwrst)
+{
+	u8 pwrst;
+
+	switch (omap2xxx_pwrst) {
+	case OMAP24XX_PWRDM_POWER_OFF:
+		pwrst = PWRDM_POWER_OFF;
+		break;
+	case OMAP24XX_PWRDM_POWER_RET:
+		pwrst = PWRDM_POWER_RET;
+		break;
+	case OMAP24XX_PWRDM_POWER_ON:
+		pwrst = PWRDM_POWER_ON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return pwrst;
+}
+
+/**
  * omap2xxx_prm_dpll_reset - use DPLL reset to reboot the OMAP SoC
  *
  * Set the DPLL reset bit, which should reboot the SoC.  This is the
@@ -98,10 +134,56 @@ int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm)
 	return 0;
 }
 
+static int omap2xxx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	u8 omap24xx_pwrst;
+
+	switch (pwrst) {
+	case PWRDM_POWER_OFF:
+		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_OFF;
+		break;
+	case PWRDM_POWER_RET:
+		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_RET;
+		break;
+	case PWRDM_POWER_ON:
+		omap24xx_pwrst = OMAP24XX_PWRDM_POWER_ON;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+				   (omap24xx_pwrst << OMAP_POWERSTATE_SHIFT),
+				   pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap2xxx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	u8 omap2xxx_pwrst;
+
+	omap2xxx_pwrst = omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+						       OMAP2_PM_PWSTCTRL,
+						       OMAP_POWERSTATE_MASK);
+
+	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
+}
+
+static int omap2xxx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	u8 omap2xxx_pwrst;
+
+	omap2xxx_pwrst = omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+						       OMAP2_PM_PWSTST,
+						       OMAP_POWERSTATEST_MASK);
+
+	return omap2xxx_pwrst_to_common_pwrst(omap2xxx_pwrst);
+}
+
 struct pwrdm_ops omap2_pwrdm_operations = {
-	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
-	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
-	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_set_next_pwrst	= omap2xxx_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap2xxx_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap2xxx_pwrdm_read_pwrst,
 	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
 	.pwrdm_set_mem_onst	= omap2_pwrdm_set_mem_onst,
 	.pwrdm_set_mem_retst	= omap2_pwrdm_set_mem_retst,
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 30517f5..a3e121f 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -103,28 +103,6 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
 /* Powerdomain low-level functions */
 
 /* Common functions across OMAP2 and OMAP3 */
-int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
-{
-	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
-				   (pwrst << OMAP_POWERSTATE_SHIFT),
-				   pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
-	return 0;
-}
-
-int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
-{
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					     OMAP2_PM_PWSTCTRL,
-					     OMAP_POWERSTATE_MASK);
-}
-
-int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
-{
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					     OMAP2_PM_PWSTST,
-					     OMAP_POWERSTATEST_MASK);
-}
-
 int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
 								u8 pwrst)
 {
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index b86116c..18762a2 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -278,6 +278,28 @@ static u32 omap3xxx_prm_read_reset_sources(void)
 
 /* Powerdomain low-level functions */
 
+static int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+				   (pwrst << OMAP_POWERSTATE_SHIFT),
+				   pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	return 0;
+}
+
+static int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTCTRL,
+					     OMAP_POWERSTATE_MASK);
+}
+
+static int omap3_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTST,
+					     OMAP_POWERSTATEST_MASK);
+}
+
 /* Applicable only for OMAP3. Not supported on OMAP2 */
 static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
@@ -356,9 +378,9 @@ static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 }
 
 struct pwrdm_ops omap3_pwrdm_operations = {
-	.pwrdm_set_next_pwrst	= omap2_pwrdm_set_next_pwrst,
-	.pwrdm_read_next_pwrst	= omap2_pwrdm_read_next_pwrst,
-	.pwrdm_read_pwrst	= omap2_pwrdm_read_pwrst,
+	.pwrdm_set_next_pwrst	= omap3_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= omap3_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= omap3_pwrdm_read_pwrst,
 	.pwrdm_read_prev_pwrst	= omap3_pwrdm_read_prev_pwrst,
 	.pwrdm_set_logic_retst	= omap2_pwrdm_set_logic_retst,
 	.pwrdm_read_logic_pwrst	= omap3_pwrdm_read_logic_pwrst,


