From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/11] ARM: OMAP2+: Remove unused legacy code for PRM
Date: Wed, 31 May 2017 15:51:36 -0700
Message-ID: <20170531225139.30723-9-tony@atomide.com>
References: <20170531225139.30723-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170531225139.30723-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We are now booting all mach-omap2 in device tree only mode.
Any code that is only called in legacy boot mode where
of_have_populated_dt() is not set is safe to remove now.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/prm3xxx.c    | 17 +++++-------
 arch/arm/mach-omap2/prm44xx.c    | 59 ----------------------------------------
 arch/arm/mach-omap2/prm_common.c |  9 ++----
 3 files changed, 10 insertions(+), 75 deletions(-)

diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -690,6 +690,8 @@ static const struct of_device_id omap3_prm_dt_match_table[] = {
 
 static int omap3xxx_prm_late_init(void)
 {
+	struct device_node *np;
+	int irq_num;
 	int ret;
 
 	if (!(prm_features & PRM_HAS_IO_WAKEUP))
@@ -702,16 +704,11 @@ static int omap3xxx_prm_late_init(void)
 		omap3_prcm_irq_setup.reconfigure_io_chain =
 			omap3430_pre_es3_1_reconfigure_io_chain;
 
-	if (of_have_populated_dt()) {
-		struct device_node *np;
-		int irq_num;
-
-		np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
-		if (np) {
-			irq_num = of_irq_get(np, 0);
-			if (irq_num >= 0)
-				omap3_prcm_irq_setup.irq = irq_num;
-		}
+	np = of_find_matching_node(NULL, omap3_prm_dt_match_table);
+	if (np) {
+		irq_num = of_irq_get(np, 0);
+		if (irq_num >= 0)
+			omap3_prcm_irq_setup.irq = irq_num;
 	}
 
 	omap3xxx_prm_enable_io_wakeup();
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -337,27 +337,6 @@ static void omap44xx_prm_reconfigure_io_chain(void)
 }
 
 /**
- * omap44xx_prm_enable_io_wakeup - enable wakeup events from I/O wakeup latches
- *
- * Activates the I/O wakeup event latches and allows events logged by
- * those latches to signal a wakeup event to the PRCM.  For I/O wakeups
- * to occur, WAKEUPENABLE bits must be set in the pad mux registers, and
- * omap44xx_prm_reconfigure_io_chain() must be called.  No return value.
- */
-static void __init omap44xx_prm_enable_io_wakeup(void)
-{
-	s32 inst = omap4_prmst_get_prm_dev_inst();
-
-	if (inst == PRM_INSTANCE_UNKNOWN)
-		return;
-
-	omap4_prm_rmw_inst_reg_bits(OMAP4430_GLOBAL_WUEN_MASK,
-				    OMAP4430_GLOBAL_WUEN_MASK,
-				    inst,
-				    omap4_prcm_irq_setup.pm_ctrl);
-}
-
-/**
  * omap44xx_prm_read_reset_sources - return the last SoC reset source
  *
  * Return a u32 representing the last reset sources of the SoC.  The
@@ -689,8 +668,6 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_has_voltdm	= omap4_check_vcvp,
 };
 
-static int omap44xx_prm_late_init(void);
-
 /*
  * XXX document
  */
@@ -698,7 +675,6 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.read_reset_sources = &omap44xx_prm_read_reset_sources,
 	.was_any_context_lost_old = &omap44xx_prm_was_any_context_lost_old,
 	.clear_context_loss_flags_old = &omap44xx_prm_clear_context_loss_flags_old,
-	.late_init = &omap44xx_prm_late_init,
 	.assert_hardreset	= omap4_prminst_assert_hardreset,
 	.deassert_hardreset	= omap4_prminst_deassert_hardreset,
 	.is_hardreset_asserted	= omap4_prminst_is_hardreset_asserted,
@@ -735,41 +711,6 @@ int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 	return prm_register(&omap44xx_prm_ll_data);
 }
 
-static int omap44xx_prm_late_init(void)
-{
-	int irq_num;
-
-	if (!(prm_features & PRM_HAS_IO_WAKEUP))
-		return 0;
-
-	/* OMAP4+ is DT only now */
-	if (!of_have_populated_dt())
-		return 0;
-
-	irq_num = of_irq_get(prm_init_data->np, 0);
-	/*
-	 * Already have OMAP4 IRQ num. For all other platforms, we need
-	 * IRQ numbers from DT
-	 */
-	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
-		if (irq_num == -EPROBE_DEFER)
-			return irq_num;
-
-		/* Have nothing to do */
-		return 0;
-	}
-
-	/* Once OMAP4 DT is filled as well */
-	if (irq_num >= 0) {
-		omap4_prcm_irq_setup.irq = irq_num;
-		omap4_prcm_irq_setup.xlate_irq = NULL;
-	}
-
-	omap44xx_prm_enable_io_wakeup();
-
-	return omap_prcm_register_chain_handler(&omap4_prcm_irq_setup);
-}
-
 static void __exit omap44xx_prm_exit(void)
 {
 	prm_unregister(&omap44xx_prm_ll_data);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -267,10 +267,9 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 {
 	int nr_regs;
 	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
-	int offset, i;
+	int offset, i, irq;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
-	unsigned int irq;
 
 	if (!irq_setup)
 		return -EINVAL;
@@ -344,10 +343,8 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 		prcm_irq_chips[i] = gc;
 	}
 
-	if (of_have_populated_dt()) {
-		int irq = omap_prcm_event_to_irq("io");
-		omap_pcs_legacy_init(irq, irq_setup->reconfigure_io_chain);
-	}
+	irq = omap_prcm_event_to_irq("io");
+	omap_pcs_legacy_init(irq, irq_setup->reconfigure_io_chain);
 
 	return 0;
 
-- 
2.13.0
