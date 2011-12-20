From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [RFC PATCH] arm:omap:omap4: Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
Date: Tue, 20 Dec 2011 14:27:31 +0530
Message-ID: <1324371451-2267-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54207 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1LTI5j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 Dec 2011 03:57:39 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

PRM module in AM33XX is closer to OMAP4 PRM module, so it makes complete
sense to reuse all the code from existing OMAP4 implementation.
Having said that, ther is a catch here with respect to AM33XX device,

The register offset in PRM module is not consistent
across (crazy IP integration), for example,

PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
===============================================
PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08

So in order to reuse the existing OMAP4 code, we have to add
separate entry for register offsets, especially
PWRSTCTRL & PWRSTST.

This patch removes the existing hard-coded way of providing
offset to omap4_prminst_xxx API's and instead use offsets
provided in powerdomainsxxxx_data.

This patch has been boot tested on AM/DM37x, OMAP4-Panda and AM335XEVM
platform.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c            |   26 +++++++++++++-------------
 arch/arm/mach-omap2/powerdomain.h           |    4 ++++
 arch/arm/mach-omap2/powerdomain44xx.c       |   24 ++++++++++++------------
 arch/arm/mach-omap2/powerdomains44xx_data.c |    8 ++++++++
 arch/arm/mach-omap2/prcm44xx.h              |    4 +++-
 arch/arm/mach-omap2/prminst44xx.c           |   11 ++++++-----
 6 files changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5192cab..4fd53d4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1288,14 +1288,14 @@ static int _assert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
-						  ohri.rst_shift);
-	else if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx() || cpu_is_am33xx())
 		return omap4_prminst_assert_hardreset(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	else if (cpu_is_omap24xx() || cpu_is_omap34xx())
+		return omap2_prm_assert_hardreset(oh->prcm.omap2.module_offs,
+						  ohri.rst_shift);
 	else
 		return -EINVAL;
 }
@@ -1322,11 +1322,7 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
-						   ohri.rst_shift,
-						   ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
 		if (ohri.st_shift)
 			pr_err("omap_hwmod: %s: %s: hwmod data error: OMAP4 does not support st_shift\n",
 			       oh->name, name);
@@ -1334,6 +1330,10 @@ static int _deassert_hardreset(struct omap_hwmod *oh, const char *name)
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		ret = omap2_prm_deassert_hardreset(oh->prcm.omap2.module_offs,
+						   ohri.rst_shift,
+						   ohri.st_shift);
 	} else {
 		return -EINVAL;
 	}
@@ -1364,14 +1364,14 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
 	if (IS_ERR_VALUE(ret))
 		return ret;

-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
-						       ohri.st_shift);
-	} else if (cpu_is_omap44xx()) {
+	if (cpu_is_omap44xx() || cpu_is_am33xx()) {
 		return omap4_prminst_is_hardreset_asserted(ohri.rst_shift,
 				  oh->clkdm->pwrdm.ptr->prcm_partition,
 				  oh->clkdm->pwrdm.ptr->prcm_offs,
 				  oh->prcm.omap4.rstctrl_offs);
+	} else if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
+		return omap2_prm_is_hardreset_asserted(oh->prcm.omap2.module_offs,
+						       ohri.st_shift);
 	} else {
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..9ebb872 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -92,6 +92,8 @@ struct powerdomain;
  * @pwrdm_clkdms: Clockdomains in this powerdomain
  * @node: list_head linking all powerdomains
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
+ * @pwrstctrl_offs: XXX_PWRSTCTRL reg offset from prcm_offs
+ * @pwrstst_offs: XXX_PWRSTST reg offset from prcm_offs
  * @state:
  * @state_counter:
  * @timer:
@@ -121,6 +123,8 @@ struct powerdomain {
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];

+	u8 pwrstctrl_offs;
+	u8 pwrstst_offs;
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
 	s64 state_timer[PWRDM_MAX_PWRSTS];
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index a7880af..b088540 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -28,7 +28,7 @@ static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 	omap4_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
 					(pwrst << OMAP_POWERSTATE_SHIFT),
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+					pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
 	return 0;
 }

@@ -37,7 +37,7 @@ static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 	u32 v;

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 	v &= OMAP_POWERSTATE_MASK;
 	v >>= OMAP_POWERSTATE_SHIFT;

@@ -49,7 +49,7 @@ static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 	u32 v;

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP_POWERSTATEST_MASK;
 	v >>= OMAP_POWERSTATEST_SHIFT;

@@ -61,7 +61,7 @@ static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 	u32 v;

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP4430_LASTPOWERSTATEENTERED_MASK;
 	v >>= OMAP4430_LASTPOWERSTATEENTERED_SHIFT;

@@ -73,7 +73,7 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
 					(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+					pwrdm->prcm_offs, pwrdm->pwrstctrl_offs);
 	return 0;
 }

@@ -82,7 +82,7 @@ static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
 					OMAP4430_LASTPOWERSTATEENTERED_MASK,
 					pwrdm->prcm_partition,
-					pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+					pwrdm->prcm_offs, pwrdm->pwrstst_offs);
 	return 0;
 }

@@ -93,7 +93,7 @@ static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
 	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
 					pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);

 	return 0;
 }
@@ -107,7 +107,7 @@ static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,

 	omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
 					pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);

 	return 0;
 }
@@ -131,7 +131,7 @@ static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 	u32 v;

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= OMAP4430_LOGICSTATEST_MASK;
 	v >>= OMAP4430_LOGICSTATEST_SHIFT;

@@ -157,7 +157,7 @@ static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTST);
+					pwrdm->pwrstst_offs);
 	v &= m;
 	v >>= __ffs(m);

@@ -171,7 +171,7 @@ static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);

 	v = omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_offs,
-					OMAP4_PM_PWSTCTRL);
+					pwrdm->pwrstctrl_offs);
 	v &= m;
 	v >>= __ffs(m);

@@ -191,7 +191,7 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	/* XXX Is this udelay() value meaningful? */
 	while ((omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
 					    pwrdm->prcm_offs,
-					    OMAP4_PM_PWSTST) &
+					    pwrdm->pwrstst_offs) &
 		OMAP_INTRANSITION_MASK) &&
 	       (c++ < PWRDM_TRANSITION_BAILOUT))
 		udelay(1);
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 704664c..e1f545b 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -352,7 +352,15 @@ static struct powerdomain *powerdomains_omap44xx[] __initdata = {

 void __init omap44xx_powerdomains_init(void)
 {
+	int i;
+
 	pwrdm_register_platform_funcs(&omap4_pwrdm_operations);
+	/* Initialise PRM reg offs to default value */
+	for (i = 0; powerdomains_omap44xx[i] != NULL; i++) {
+		struct powerdomain *pwrdm = powerdomains_omap44xx[i];
+		pwrdm->pwrstctrl_offs = OMAP4_PM_PWSTCTRL;
+		pwrdm->pwrstst_offs = OMAP4_PM_PWSTST;
+	}
 	pwrdm_register_pwrdms(powerdomains_omap44xx);
 	pwrdm_complete_init();
 }
diff --git a/arch/arm/mach-omap2/prcm44xx.h b/arch/arm/mach-omap2/prcm44xx.h
index 7334ffb..d193f91 100644
--- a/arch/arm/mach-omap2/prcm44xx.h
+++ b/arch/arm/mach-omap2/prcm44xx.h
@@ -31,12 +31,14 @@
 #define OMAP4430_CM2_PARTITION			3
 #define OMAP4430_SCRM_PARTITION			4
 #define OMAP4430_PRCM_MPU_PARTITION		5
+/* AM33XX PRCM is closer to OMAP4, so try to reuse all API's */
+#define AM33XX_PRM_PARTITION			6

 /*
  * OMAP4_MAX_PRCM_PARTITIONS: set to the highest value of the PRCM partition
  * IDs, plus one
  */
-#define OMAP4_MAX_PRCM_PARTITIONS		6
+#define OMAP4_MAX_PRCM_PARTITIONS		7


 #endif
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index f6de5bc..7e15b7e 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -19,6 +19,7 @@
 #include "common.h"

 #include "prm44xx.h"
+#include "prm33xx.h"
 #include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prcm44xx.h"
@@ -26,11 +27,12 @@

 static u32 _prm_bases[OMAP4_MAX_PRCM_PARTITIONS] = {
 	[OMAP4430_INVALID_PRCM_PARTITION]	= 0,
-	[OMAP4430_PRM_PARTITION]		= OMAP4430_PRM_BASE,
+	[OMAP4430_PRM_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE),
 	[OMAP4430_CM1_PARTITION]		= 0,
 	[OMAP4430_CM2_PARTITION]		= 0,
 	[OMAP4430_SCRM_PARTITION]		= 0,
-	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP4430_PRCM_MPU_BASE,
+	[OMAP4430_PRCM_MPU_PARTITION]		= OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE),
+	[AM33XX_PRM_PARTITION]			= AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE)
 };

 /* Read a register in a PRM instance */
@@ -39,8 +41,7 @@ u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	return __raw_readl(OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst +
-					       idx));
+	return __raw_readl(_prm_bases[part] + inst + idx);
 }

 /* Write into a register in a PRM instance */
@@ -49,7 +50,7 @@ void omap4_prminst_write_inst_reg(u32 val, u8 part, s16 inst, u16 idx)
 	BUG_ON(part >= OMAP4_MAX_PRCM_PARTITIONS ||
 	       part == OMAP4430_INVALID_PRCM_PARTITION ||
 	       !_prm_bases[part]);
-	__raw_writel(val, OMAP2_L4_IO_ADDRESS(_prm_bases[part] + inst + idx));
+	__raw_writel(val, _prm_bases[part] + inst + idx);
 }

 /* Read-modify-write a register in PRM. Caller must lock */
--
1.7.0.4

