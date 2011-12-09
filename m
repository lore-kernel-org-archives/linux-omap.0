From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 04/14] omap: prm: add support for suspend prepare and finish callbacks
Date: Fri, 9 Dec 2011 16:27:27 +0200
Message-ID: <1323440857-385-5-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59515 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab1LIO2L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:11 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

These are needed because runtime PM is disabled during suspend, and
it is bad if we get interrupts from the PRCM chain handler during it.
This patch masks all the PRCM interrupt events, but does not ack them,
if an interrupt is received during suspend. Once suspend->finish
is called, all the masked events will be re-enabled, which causes
immediate PRCM interrupt and handles the postponed event.

The suspend prepare and complete  callbacks will be called from pm34xx.c /
pm44xx.c files in the following patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm-common.h |    4 +++
 arch/arm/mach-omap2/prcm.c        |   46 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 3c54e3c..6cb0daf 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -425,6 +425,8 @@ struct omap_prcm_irq_setup {
 	u32 *priority_mask;
 	int base_irq;
 	int irq;
+	bool suspended;
+	bool suspend_save_flag;
 };
 
 #define OMAP_PRCM_IRQ(_name, _offset, _priority) {	\
@@ -437,6 +439,8 @@ extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
 extern int omap_prcm_event_to_irq(const char *event);
+extern void omap_prcm_irq_prepare(void);
+extern void omap_prcm_irq_complete(void);
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 948247f..e7c8f3f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -221,12 +221,28 @@ static void omap_prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 	unsigned int virtirq;
 	int nr_irqs = prcm_irq_setup->nr_regs * 32;
+	int i;
+
+	/*
+	 * If we are suspended, mask all interrupts from PRCM level,
+	 * this does not ack them, and they will be pending until
+	 * we re-enable the interrupts, at which point the
+	 * omap_prcm_irq_handler will be executed again
+	 */
+	if (prcm_irq_setup->suspended) {
+		for (i = 0; i < prcm_irq_setup->nr_regs; i++) {
+			prcm_irq_setup->saved_mask[i] =
+				prcm_irq_read_reg(prcm_irq_setup->mask + i * 4);
+			prcm_irq_write_reg(0, prcm_irq_setup->mask + i * 4);
+		}
+		prcm_irq_setup->suspend_save_flag = true;
+	}
 
 	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq() can cause new irqs to come
 	 */
-	while (1) {
+	while (!prcm_irq_setup->suspended) {
 		omap_prm_pending_events(pending);
 
 		/* No bit set, then all IRQs are handled */
@@ -307,6 +323,34 @@ void omap_prcm_irq_cleanup(void)
 	prcm_irq_setup->base_irq = 0;
 }
 
+void omap_prcm_irq_prepare(void)
+{
+	prcm_irq_setup->suspended = true;
+}
+
+void omap_prcm_irq_complete(void)
+{
+	int i;
+
+	prcm_irq_setup->suspended = false;
+
+	/* If we have not saved the masks, do not attempt to restore */
+	if (!prcm_irq_setup->suspend_save_flag)
+		return;
+
+	prcm_irq_setup->suspend_save_flag = false;
+
+	/*
+	 * Re-enable all masked PRCM irq sources, this
+	 * causes the PRCM interrupt to fire immediately
+	 * if the events were masked previously in the chain
+	 * handler
+	 */
+	for (i = 0; i < prcm_irq_setup->nr_regs; i++)
+		prcm_irq_write_reg(prcm_irq_setup->saved_mask[i],
+			prcm_irq_setup->mask + i * 4);
+}
+
 /*
  * Initializes the prcm chain handler based on provided parameters
  */
-- 
1.7.4.1

