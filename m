From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/13] ARM: OMAP2+: CM/clock: convert
 _omap2_module_wait_ready() to use SoC-independent CM functions
Date: Thu, 25 Oct 2012 17:21:18 -0600
Message-ID: <20121025232117.17558.83100.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38291 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968Ab2JYXYE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:04 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Convert the OMAP clock code's _omap2_module_wait_ready() to use
SoC-independent CM functions that are provided by the CM code, rather
than using a deprecated function from mach-omap2/prcm.c.

This facilitates the future conversion of the CM code to a driver, and
also removes a mach-omap2/prcm.c user.  mach-omap2/prcm.c will be removed
by a subsequent patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c     |   14 +++++++-
 arch/arm/mach-omap2/cm.h        |   12 +++++++
 arch/arm/mach-omap2/cm2xxx.c    |   65 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h    |    4 ++
 arch/arm/mach-omap2/cm3xxx.c    |   66 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm3xxx.h    |    5 +++
 arch/arm/mach-omap2/cm_common.c |   48 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/io.c        |    5 +++
 8 files changed, 215 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index d0c6d9b..19acf08 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -33,6 +33,7 @@
 #include "soc.h"
 #include "clockdomain.h"
 #include "clock.h"
+#include "cm.h"
 #include "cm2xxx.h"
 #include "cm3xxx.h"
 #include "cm-regbits-24xx.h"
@@ -67,7 +68,9 @@ static bool clkdm_control = true;
 static void _omap2_module_wait_ready(struct clk *clk)
 {
 	void __iomem *companion_reg, *idlest_reg;
-	u8 other_bit, idlest_bit, idlest_val;
+	u8 other_bit, idlest_bit, idlest_val, idlest_reg_id;
+	s16 prcm_mod;
+	int r;
 
 	/* Not all modules have multiple clocks that their IDLEST depends on */
 	if (clk->ops->find_companion) {
@@ -78,8 +81,13 @@ static void _omap2_module_wait_ready(struct clk *clk)
 
 	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
 
-	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val,
-			     __clk_get_name(clk));
+	r = cm_split_idlest_reg(idlest_reg, &prcm_mod, &idlest_reg_id);
+	if (r) {
+		pr_err("clock: %s: could not split idlest reg va\n", clk->name);
+		return;
+	}
+
+	cm_wait_module_ready(prcm_mod, idlest_reg_id, idlest_bit);
 }
 
 /* Public functions */
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index b3cee91..e419ecb 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -37,8 +37,18 @@
 
 /**
  * struct cm_ll_data - fn ptrs to per-SoC CM function implementations
+ * @split_idlest_reg: ptr to the SoC CM-specific split_idlest_reg impl
+ * @wait_module_ready: ptr to the SoC CM-specific wait_module_ready impl
  */
-struct cm_ll_data {};
+struct cm_ll_data {
+	int (*split_idlest_reg)(void __iomem *idlest_reg, s16 *prcm_inst,
+				u8 *idlest_reg_id);
+	int (*wait_module_ready)(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
+};
+
+extern int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+			       u8 *idlest_reg_id);
+extern int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift);
 
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index e96cd70..db65069 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -198,6 +198,43 @@ void omap2xxx_cm_apll96_disable(void)
 	_omap2xxx_apll_disable(OMAP24XX_EN_96M_PLL_SHIFT);
 }
 
+/**
+ * omap2xxx_cm_split_idlest_reg - split CM_IDLEST reg addr into its components
+ * @idlest_reg: CM_IDLEST* virtual address
+ * @prcm_inst: pointer to an s16 to return the PRCM instance offset
+ * @idlest_reg_id: pointer to a u8 to return the CM_IDLESTx register ID
+ *
+ * XXX This function is only needed until absolute register addresses are
+ * removed from the OMAP struct clk records.
+ */
+int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+				 u8 *idlest_reg_id)
+{
+	unsigned long offs;
+	u8 idlest_offs;
+	int i;
+
+	if (idlest_reg < cm_base || idlest_reg > (cm_base + 0x0fff))
+		return -EINVAL;
+
+	idlest_offs = (unsigned long)idlest_reg & 0xff;
+	for (i = 0; i < ARRAY_SIZE(omap2xxx_cm_idlest_offs); i++) {
+		if (idlest_offs == omap2xxx_cm_idlest_offs[i]) {
+			*idlest_reg_id = i + 1;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(omap2xxx_cm_idlest_offs))
+		return -EINVAL;
+
+	offs = idlest_reg - cm_base;
+	offs &= 0xff00;
+	*prcm_inst = offs;
+
+	return 0;
+}
+
 /*
  *
  */
@@ -314,3 +351,31 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_clk_enable	= omap2xxx_clkdm_clk_enable,
 	.clkdm_clk_disable	= omap2xxx_clkdm_clk_disable,
 };
+
+/*
+ *
+ */
+
+static struct cm_ll_data omap2xxx_cm_ll_data = {
+	.split_idlest_reg	= &omap2xxx_cm_split_idlest_reg,
+	.wait_module_ready	= &omap2xxx_cm_wait_module_ready,
+};
+
+int __init omap2xxx_cm_init(void)
+{
+	if (!cpu_is_omap24xx())
+		return 0;
+
+	return cm_register(&omap2xxx_cm_ll_data);
+}
+
+static void __exit omap2xxx_cm_exit(void)
+{
+	if (!cpu_is_omap24xx())
+		return;
+
+	/* Should never happen */
+	WARN(cm_unregister(&omap2xxx_cm_ll_data),
+	     "%s: cm_ll_data function pointer mismatch\n", __func__);
+}
+__exitcall(omap2xxx_cm_exit);
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index bce3c4b..4cbb39b 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -60,6 +60,10 @@ extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 extern bool omap2xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
 extern int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 					 u8 idlest_shift);
+extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+					s16 *prcm_inst, u8 *idlest_reg_id);
+
+extern int __init omap2xxx_cm_init(void);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 8b03ec2..c2086f2 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -110,6 +110,44 @@ int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
 }
 
+/**
+ * omap3xxx_cm_split_idlest_reg - split CM_IDLEST reg addr into its components
+ * @idlest_reg: CM_IDLEST* virtual address
+ * @prcm_inst: pointer to an s16 to return the PRCM instance offset
+ * @idlest_reg_id: pointer to a u8 to return the CM_IDLESTx register ID
+ *
+ * XXX This function is only needed until absolute register addresses are
+ * removed from the OMAP struct clk records.
+ */
+int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+				 u8 *idlest_reg_id)
+{
+	unsigned long offs;
+	u8 idlest_offs;
+	int i;
+
+	if (idlest_reg < (cm_base + OMAP3430_IVA2_MOD) ||
+	    idlest_reg > (cm_base + 0x1ffff))
+		return -EINVAL;
+
+	idlest_offs = (unsigned long)idlest_reg & 0xff;
+	for (i = 0; i < ARRAY_SIZE(omap3xxx_cm_idlest_offs); i++) {
+		if (idlest_offs == omap3xxx_cm_idlest_offs[i]) {
+			*idlest_reg_id = i + 1;
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(omap3xxx_cm_idlest_offs))
+		return -EINVAL;
+
+	offs = idlest_reg - cm_base;
+	offs &= 0xff00;
+	*prcm_inst = offs;
+
+	return 0;
+}
+
 /* Clockdomain low-level operations */
 
 static int omap3xxx_clkdm_add_sleepdep(struct clockdomain *clkdm1,
@@ -597,3 +635,31 @@ void omap3_cm_restore_context(void)
 	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
 			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
+
+/*
+ *
+ */
+
+static struct cm_ll_data omap3xxx_cm_ll_data = {
+	.split_idlest_reg	= &omap3xxx_cm_split_idlest_reg,
+	.wait_module_ready	= &omap3xxx_cm_wait_module_ready,
+};
+
+int __init omap3xxx_cm_init(void)
+{
+	if (!cpu_is_omap34xx())
+		return 0;
+
+	return cm_register(&omap3xxx_cm_ll_data);
+}
+
+static void __exit omap3xxx_cm_exit(void)
+{
+	if (!cpu_is_omap34xx())
+		return;
+
+	/* Should never happen */
+	WARN(cm_unregister(&omap3xxx_cm_ll_data),
+	     "%s: cm_ll_data function pointer mismatch\n", __func__);
+}
+__exitcall(omap3xxx_cm_exit);
diff --git a/arch/arm/mach-omap2/cm3xxx.h b/arch/arm/mach-omap2/cm3xxx.h
index 4a6ac81..e8e146f 100644
--- a/arch/arm/mach-omap2/cm3xxx.h
+++ b/arch/arm/mach-omap2/cm3xxx.h
@@ -78,9 +78,14 @@ extern bool omap3xxx_cm_is_clkdm_in_hwsup(s16 module, u32 mask);
 extern int omap3xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 					 u8 idlest_shift);
 
+extern int omap3xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
+					s16 *prcm_inst, u8 *idlest_reg_id);
+
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
 
+extern int __init omap3xxx_cm_init(void);
+
 #endif
 
 #endif
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 3246cef..561969b 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -26,6 +26,54 @@ static struct cm_ll_data null_cm_ll_data;
 static struct cm_ll_data *cm_ll_data = &null_cm_ll_data;
 
 /**
+ * cm_split_idlest_reg - split CM_IDLEST reg addr into its components
+ * @idlest_reg: CM_IDLEST* virtual address
+ * @prcm_inst: pointer to an s16 to return the PRCM instance offset
+ * @idlest_reg_id: pointer to a u8 to return the CM_IDLESTx register ID
+ *
+ * Given an absolute CM_IDLEST register address @idlest_reg, passes
+ * the PRCM instance offset and IDLEST register ID back to the caller
+ * via the @prcm_inst and @idlest_reg_id.  Returns -EINVAL upon error,
+ * or 0 upon success.  XXX This function is only needed until absolute
+ * register addresses are removed from the OMAP struct clk records.
+ */
+int cm_split_idlest_reg(void __iomem *idlest_reg, s16 *prcm_inst,
+			u8 *idlest_reg_id)
+{
+	if (!cm_ll_data->split_idlest_reg) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return cm_ll_data->split_idlest_reg(idlest_reg, prcm_inst,
+					   idlest_reg_id);
+}
+
+/**
+ * cm_wait_module_ready - wait for a module to leave idle or standby
+ * @prcm_mod: PRCM module offset
+ * @idlest_id: CM_IDLESTx register ID (i.e., x = 1, 2, 3)
+ * @idlest_shift: shift of the bit in the CM_IDLEST* register to check
+ *
+ * Wait for the PRCM to indicate that the module identified by
+ * (@prcm_mod, @idlest_id, @idlest_shift) is clocked.  Return 0 upon
+ * success, -EBUSY if the module doesn't enable in time, or -EINVAL if
+ * no per-SoC wait_module_ready() function pointer has been registered
+ * or if the idlest register is unknown on the SoC.
+ */
+int cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
+{
+	if (!cm_ll_data->wait_module_ready) {
+		WARN_ONCE(1, "cm: %s: no low-level function defined\n",
+			  __func__);
+		return -EINVAL;
+	}
+
+	return cm_ll_data->wait_module_ready(prcm_mod, idlest_id, idlest_shift);
+}
+
+/**
  * cm_register - register per-SoC low-level data with the CM
  * @cld: low-level per-SoC OMAP CM data & function pointers to register
  *
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b853401..a52d399 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -46,6 +46,8 @@
 #include "clock44xx.h"
 #include "sdrc.h"
 #include "control.h"
+#include "cm2xxx.h"
+#include "cm3xxx.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
@@ -389,6 +391,7 @@ void __init omap2420_init_early(void)
 			       OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE),
 			       NULL, NULL);
 	omap2xxx_check_revision();
+	omap2xxx_cm_init();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
@@ -418,6 +421,7 @@ void __init omap2430_init_early(void)
 			       OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE),
 			       NULL, NULL);
 	omap2xxx_check_revision();
+	omap2xxx_cm_init();
 	omap_common_init_early();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
@@ -452,6 +456,7 @@ void __init omap3_init_early(void)
 			       NULL, NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
+	omap3xxx_cm_init();
 	omap_common_init_early();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();


