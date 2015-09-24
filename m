From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 17/17] ARM: OMAP2+: PRM: remove redundant system reset code
Date: Thu, 24 Sep 2015 17:26:58 +0300
Message-ID: <1443104818-993-18-git-send-email-t-kristo@ti.com>
References: <1443104818-993-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1443104818-993-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, s-anna@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is now handled via the reset controller and the provided information
from DT, so the legacy support code is no longer needed. OMAP3 version
shall be removed once OMAP3 is also DT only.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm2xxx.c     |   15 ---------------
 arch/arm/mach-omap2/prm33xx.c     |   18 ------------------
 arch/arm/mach-omap2/prm44xx.c     |    1 -
 arch/arm/mach-omap2/prminst44xx.c |   20 --------------------
 4 files changed, 54 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 752018ce..70f711b 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -101,20 +101,6 @@ static int omap2xxx_pwrst_to_common_pwrst(u8 omap2xxx_pwrst)
 }
 
 /**
- * omap2xxx_prm_dpll_reset - use DPLL reset to reboot the OMAP SoC
- *
- * Set the DPLL reset bit, which should reboot the SoC.  This is the
- * recommended way to restart the SoC.  No return value.
- */
-static void omap2xxx_prm_dpll_reset(void)
-{
-	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, WKUP_MOD,
-				   OMAP2_RM_RSTCTRL);
-	/* OCP barrier */
-	omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTCTRL);
-}
-
-/**
  * omap2xxx_prm_clear_mod_irqs - clear wakeup status bits for a module
  * @module: PRM module to clear wakeups from
  * @regs: register offset to clear
@@ -216,7 +202,6 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.assert_hardreset = &omap2_prm_assert_hardreset,
 	.deassert_hardreset = &omap2_prm_deassert_hardreset,
 	.is_hardreset_asserted = &omap2_prm_is_hardreset_asserted,
-	.reset_system = &omap2xxx_prm_dpll_reset,
 	.clear_mod_irqs = &omap2xxx_prm_clear_mod_irqs,
 };
 
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index dcb5001..12b15a2 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -336,23 +336,6 @@ static int am33xx_check_vcvp(void)
 	return 0;
 }
 
-/**
- * am33xx_prm_global_warm_sw_reset - reboot the device via warm reset
- *
- * Immediately reboots the device through warm reset.
- */
-static void am33xx_prm_global_warm_sw_reset(void)
-{
-	am33xx_prm_rmw_reg_bits(AM33XX_RST_GLOBAL_WARM_SW_MASK,
-				AM33XX_RST_GLOBAL_WARM_SW_MASK,
-				AM33XX_PRM_DEVICE_MOD,
-				AM33XX_PRM_RSTCTRL_OFFSET);
-
-	/* OCP barrier */
-	(void)am33xx_prm_read_reg(AM33XX_PRM_DEVICE_MOD,
-				  AM33XX_PRM_RSTCTRL_OFFSET);
-}
-
 struct pwrdm_ops am33xx_pwrdm_operations = {
 	.pwrdm_set_next_pwrst		= am33xx_pwrdm_set_next_pwrst,
 	.pwrdm_read_next_pwrst		= am33xx_pwrdm_read_next_pwrst,
@@ -375,7 +358,6 @@ static struct prm_ll_data am33xx_prm_ll_data = {
 	.assert_hardreset		= am33xx_prm_assert_hardreset,
 	.deassert_hardreset		= am33xx_prm_deassert_hardreset,
 	.is_hardreset_asserted		= am33xx_prm_is_hardreset_asserted,
-	.reset_system			= am33xx_prm_global_warm_sw_reset,
 };
 
 int __init am33xx_prm_init(const struct omap_prcm_init_data *data)
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 3076800..76d7e30 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -702,7 +702,6 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.assert_hardreset	= omap4_prminst_assert_hardreset,
 	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
 	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
-	.reset_system		= omap4_prminst_global_warm_sw_reset,
 	.vp_check_txdone	= omap4_prm_vp_check_txdone,
 	.vp_clear_txdone	= omap4_prm_vp_clear_txdone,
 };
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index d0b15db..ffed63f 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -174,23 +174,3 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 st_shift, u8 part, s16 inst,
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
-
-
-void omap4_prminst_global_warm_sw_reset(void)
-{
-	u32 v;
-	s32 inst = omap4_prmst_get_prm_dev_inst();
-
-	if (inst == PRM_INSTANCE_UNKNOWN)
-		return;
-
-	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst,
-					OMAP4_PRM_RSTCTRL_OFFSET);
-	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
-	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 inst, OMAP4_PRM_RSTCTRL_OFFSET);
-
-	/* OCP barrier */
-	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    inst, OMAP4_PRM_RSTCTRL_OFFSET);
-}
-- 
1.7.9.5
