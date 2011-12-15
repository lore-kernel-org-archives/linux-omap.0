From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 5/9] ARM: OMAP: PRCM: add suspend prepare / finish support
Date: Thu, 15 Dec 2011 14:36:20 -0700
Message-ID: <20111215213618.26632.7880.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41012 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759523Ab1LOVhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:40 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@ti.com>

From: Tero Kristo <t-kristo@ti.com>

PRCM chain handler needs to disable forwarding of interrupts during
suspend, because runtime PM is disabled and most of the drivers
are potentially not able to handle interrupts coming at this time.

This patch masks all the PRCM interrupt events if a PRCM interrupt
occurs during suspend, but does not ack them. Once suspend finish
is called, all the masked events will be re-enabled, which causes
immediate PRCM interrupt and handles the postponed event.

The suspend prepare and complete  callbacks will be called from
pm34xx.c / pm44xx.c files in the following patches.

The functions defined in this patch should eventually be moved to
suspend->prepare and suspend->finish driver hooks, once the PRCM
chain handler will be made as its own driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: add kerneldoc, add omap_prcm_irq_setup.saved_mask, add fn
 ptrs for save_and_clear_irqen() and restore_irqen()]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm-common.h  |   16 +++++++++++-
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   37 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    2 ++
 arch/arm/mach-omap2/prm44xx.c      |   48 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm44xx.h      |    2 ++
 arch/arm/mach-omap2/prm_common.c   |   47 ++++++++++++++++++++++++++++++++++-
 6 files changed, 148 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 76db379..0f69d8f 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -437,11 +437,16 @@ struct omap_prcm_irq {
  * @irq: MPU IRQ asserted when a PRCM interrupt arrives
  * @read_pending_irqs: fn ptr to determine if any PRCM IRQs are pending
  * @ocp_barrier: fn ptr to force buffered PRM writes to complete
+ * @save_and_clear_irqen: fn ptr to save and clear IRQENABLE regs
+ * @restore_irqen: fn ptr to save and clear IRQENABLE regs
+ * @saved_mask: IRQENABLE regs are saved here during suspend
  * @priority_mask: 1 bit per IRQ, set to 1 if omap_prcm_irq.priority = true
  * @base_irq: base dynamic IRQ number, returned from irq_alloc_descs() in init
+ * @suspended: set to true after Linux suspend code has called our ->prepare()
+ * @suspend_save_flag: set to true after IRQ masks have been saved and disabled
  *
- * @priority_mask and @base_irq are populated dynamically during
- * omap_prcm_register_chain_handler() - these fields are not to be
+ * @saved_mask, @priority_mask, @base_irq, @suspended, and
+ * @suspend_save_flag are populated dynamically, and are not to be
  * specified in static initializers.
  */
 struct omap_prcm_irq_setup {
@@ -453,8 +458,13 @@ struct omap_prcm_irq_setup {
 	int irq;
 	void (*read_pending_irqs)(unsigned long *events);
 	void (*ocp_barrier)(void);
+	void (*save_and_clear_irqen)(u32 *saved_mask);
+	void (*restore_irqen)(u32 *saved_mask);
+	u32 *saved_mask;
 	u32 *priority_mask;
 	int base_irq;
+	bool suspended;
+	bool suspend_save_flag;
 };
 
 /* OMAP_PRCM_IRQ: convenience macro for creating struct omap_prcm_irq records */
@@ -468,6 +478,8 @@ extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
 extern int omap_prcm_event_to_irq(const char *event);
+extern void omap_prcm_irq_prepare(void);
+extern void omap_prcm_irq_complete(void);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 177c3dd..58d9ce70 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -244,3 +244,40 @@ void omap3xxx_prm_ocp_barrier(void)
 {
 	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
 }
+
+/**
+ * omap3xxx_prm_save_and_clear_irqen - save/clear PRM_IRQENABLE_MPU reg
+ * @saved_mask: ptr to a u32 array to save IRQENABLE bits
+ *
+ * Save the PRM_IRQENABLE_MPU register to @saved_mask.  @saved_mask
+ * must be allocated by the caller.  Intended to be used in the PRM
+ * interrupt handler suspend callback.  The OCP barrier is needed to
+ * ensure the write to disable PRM interrupts reaches the PRM before
+ * returning; otherwise, spurious interrupts might occur.  No return
+ * value.
+ */
+void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask)
+{
+	saved_mask[0] = omap2_prm_read_mod_reg(OCP_MOD,
+					       OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+
+	/* OCP barrier */
+	omap2_prm_read_mod_reg(OCP_MOD, OMAP3_PRM_REVISION_OFFSET);
+}
+
+/**
+ * omap3xxx_prm_restore_irqen - set PRM_IRQENABLE_MPU register from args
+ * @saved_mask: ptr to a u32 array of IRQENABLE bits saved previously
+ *
+ * Restore the PRM_IRQENABLE_MPU register from @saved_mask.  Intended
+ * to be used in the PRM interrupt handler resume callback to restore
+ * values saved by omap3xxx_prm_save_and_clear_irqen().  No OCP
+ * barrier should be needed here; any pending PRM interrupts will fire
+ * once the writes reach the PRM.  No return value.
+ */
+void omap3xxx_prm_restore_irqen(u32 *saved_mask)
+{
+	omap2_prm_write_mod_reg(saved_mask[0], OCP_MOD,
+				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 3ef0e77..70ac2a1 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -318,6 +318,8 @@ extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 /* PRM interrupt-related functions */
 extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
 extern void omap3xxx_prm_ocp_barrier(void);
+extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
+extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
 #endif	/* CONFIG_ARCH_OMAP4 */
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 9b21154..c4be5d9 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -163,3 +163,51 @@ void omap44xx_prm_ocp_barrier(void)
 	omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
 				OMAP4_REVISION_PRM_OFFSET);
 }
+
+/**
+ * omap44xx_prm_save_and_clear_irqen - save/clear PRM_IRQENABLE_MPU* regs
+ * @saved_mask: ptr to a u32 array to save IRQENABLE bits
+ *
+ * Save the PRM_IRQENABLE_MPU and PRM_IRQENABLE_MPU_2 registers to
+ * @saved_mask.  @saved_mask must be allocated by the caller.
+ * Intended to be used in the PRM interrupt handler suspend callback.
+ * The OCP barrier is needed to ensure the write to disable PRM
+ * interrupts reaches the PRM before returning; otherwise, spurious
+ * interrupts might occur.  No return value.
+ */
+void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask)
+{
+	saved_mask[0] =
+		omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+					OMAP4_PRM_IRQSTATUS_MPU_OFFSET);
+	saved_mask[1] =
+		omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+					OMAP4_PRM_IRQSTATUS_MPU_2_OFFSET);
+
+	omap4_prm_write_inst_reg(0, OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
+	omap4_prm_write_inst_reg(0, OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
+
+	/* OCP barrier */
+	omap4_prm_read_inst_reg(OMAP4430_PRM_DEVICE_INST,
+				OMAP4_REVISION_PRM_OFFSET);
+}
+
+/**
+ * omap44xx_prm_restore_irqen - set PRM_IRQENABLE_MPU* registers from args
+ * @saved_mask: ptr to a u32 array of IRQENABLE bits saved previously
+ *
+ * Restore the PRM_IRQENABLE_MPU and PRM_IRQENABLE_MPU_2 registers from
+ * @saved_mask.  Intended to be used in the PRM interrupt handler resume
+ * callback to restore values saved by omap44xx_prm_save_and_clear_irqen().
+ * No OCP barrier should be needed here; any pending PRM interrupts will fire
+ * once the writes reach the PRM.  No return value.
+ */
+void omap44xx_prm_restore_irqen(u32 *saved_mask)
+{
+	omap4_prm_write_inst_reg(saved_mask[0], OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_PRM_IRQENABLE_MPU_OFFSET);
+	omap4_prm_write_inst_reg(saved_mask[1], OMAP4430_PRM_DEVICE_INST,
+				 OMAP4_PRM_IRQENABLE_MPU_2_OFFSET);
+}
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index bd7f248..7978092 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -766,6 +766,8 @@ extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 /* PRM interrupt-related functions */
 extern void omap44xx_prm_read_pending_irqs(unsigned long *events);
 extern void omap44xx_prm_ocp_barrier(void);
+extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
+extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 5694be5..860118a 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -89,10 +89,25 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	int nr_irqs = prcm_irq_setup->nr_regs * 32;
 
 	/*
+	 * If we are suspended, mask all interrupts from PRCM level,
+	 * this does not ack them, and they will be pending until we
+	 * re-enable the interrupts, at which point the
+	 * omap_prcm_irq_handler will be executed again.  The
+	 * _save_and_clear_irqen() function must ensure that the PRM
+	 * write to disable all IRQs has reached the PRM before
+	 * returning, or spurious PRCM interrupts may occur during
+	 * suspend.
+	 */
+	if (prcm_irq_setup->suspended) {
+		prcm_irq_setup->save_and_clear_irqen(prcm_irq_setup->saved_mask);
+		prcm_irq_setup->suspend_save_flag = true;
+	}
+
+	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq() can cause new irqs to come
 	 */
-	while (1) {
+	while (!prcm_irq_setup->suspended) {
 		prcm_irq_setup->read_pending_irqs(pending);
 
 		/* No bit set, then all IRQs are handled */
@@ -174,6 +189,9 @@ void omap_prcm_irq_cleanup(void)
 		prcm_irq_chips = NULL;
 	}
 
+	kfree(prcm_irq_setup->saved_mask);
+	prcm_irq_setup->saved_mask = NULL;
+
 	kfree(prcm_irq_setup->priority_mask);
 	prcm_irq_setup->priority_mask = NULL;
 
@@ -185,6 +203,29 @@ void omap_prcm_irq_cleanup(void)
 	prcm_irq_setup->base_irq = 0;
 }
 
+void omap_prcm_irq_prepare(void)
+{
+	prcm_irq_setup->suspended = true;
+}
+
+void omap_prcm_irq_complete(void)
+{
+	prcm_irq_setup->suspended = false;
+
+	/* If we have not saved the masks, do not attempt to restore */
+	if (!prcm_irq_setup->suspend_save_flag)
+		return;
+
+	prcm_irq_setup->suspend_save_flag = false;
+
+	/*
+	 * Re-enable all masked PRCM irq sources, this causes the PRCM
+	 * interrupt to fire immediately if the events were masked
+	 * previously in the chain handler
+	 */
+	prcm_irq_setup->restore_irqen(prcm_irq_setup->saved_mask);
+}
+
 /**
  * omap_prcm_register_chain_handler - initializes the prcm chained interrupt
  * handler based on provided parameters
@@ -219,10 +260,12 @@ int omap_prcm_register_chain_handler(struct omap_prcm_irq_setup *irq_setup)
 	prcm_irq_setup = irq_setup;
 
 	prcm_irq_chips = kzalloc(sizeof(void *) * nr_regs, GFP_KERNEL);
+	prcm_irq_setup->saved_mask = kzalloc(sizeof(u32) * nr_regs, GFP_KERNEL);
 	prcm_irq_setup->priority_mask = kzalloc(sizeof(u32) * nr_regs,
 		GFP_KERNEL);
 
-	if (!prcm_irq_chips || !prcm_irq_setup->priority_mask) {
+	if (!prcm_irq_chips || !prcm_irq_setup->saved_mask ||
+	    !prcm_irq_setup->priority_mask) {
 		pr_err("PRCM: kzalloc failed\n");
 		goto err;
 	}


