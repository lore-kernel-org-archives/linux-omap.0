From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 2/3] PRCM: Add support for PAD wakeup interrupts
Date: Fri, 17 Jun 2011 15:06:27 +0300
Message-ID: <1308312388-3952-3-git-send-email-t-kristo@ti.com>
References: <1308312388-3952-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54356 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757934Ab1FQMHO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Jun 2011 08:07:14 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5HC7Dqk009137
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:13 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5HC7DFn012343
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:13 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5HC7C1g012102
	for <linux-omap@vger.kernel.org>; Fri, 17 Jun 2011 07:07:12 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308312388-3952-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>

PRCM interrupt handler will now parse registered pads to see whether there
is an active wakeup event. If this is the case, the corresponding interrupt
will be triggered. This can be used for example with UART driver to register
PAD wakeup event for the UART RX pin, and when this happens, UART interrupt
will be triggered.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm.c             |   53 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/prcm.h |    1 +
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 362c59c..754a5a6 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -53,6 +53,15 @@ static struct omap_prcm_irq *omap_prcm_irqs;
 /* Number of entries in omap_prcm_irqs */
 static int omap_prcm_irqs_nr;
 
+/* PAD handlers list */
+struct pad_def {
+	u32 pad;
+	unsigned int irq;
+	struct list_head node;
+};
+
+static LIST_HEAD(pad_handler_list);
+
 /* Pointers to either OMAP3 or OMAP4 specific functions */
 static void (*omap_prcm_mask_event)(unsigned event);
 static void (*omap_prcm_unmask_event)(unsigned event);
@@ -84,6 +93,27 @@ static struct irq_chip prcm_irq_chip = {
 	.irq_unmask	= prcm_irq_unmask,
 };
 
+
+/*
+ * Handler for PAD irqs, called from PRCM interrupt handler
+ */
+static void omap_prcm_handle_pad_irqs(void)
+{
+	struct pad_def *def;
+	u16 val = 0;
+	list_for_each_entry(def, &pad_handler_list, node) {
+		/* Read padconf value based on cpu type */
+		if (cpu_is_omap34xx())
+			val = omap_ctrl_readw(def->pad);
+
+		/* TODO: add omap4 support for reading pads */
+
+		/* if pad wakeupevent is active, fire registered IRQ */
+		if (val & OMAP3_PADCONF_WAKEUPEVENT0)
+			generic_handle_irq(def->irq);
+	}
+}
+
 /*
  * PRCM Interrupt Handler
  *
@@ -106,6 +137,9 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
+	/* Handle PAD events first, we don't want to ack them before parse */
+	omap_prcm_handle_pad_irqs();
+
 	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
@@ -153,6 +187,25 @@ int omap_prcm_event_to_irq(const char *name)
 }
 
 /*
+ * Register interrupt handler for a given pad. When the PRCM interrupt
+ * handler detects wakeupevent on the corresponding pad, the IRQ will
+ * be triggered.
+ */
+int omap_prcm_register_pad_irq(u32 pad, unsigned int irq)
+{
+	struct pad_def *def;
+
+	def = kmalloc(sizeof(struct pad_def), GFP_ATOMIC);
+	if (!def)
+		return -ENOMEM;
+
+	def->pad = pad;
+	def->irq = irq;
+	list_add(&def->node, &pad_handler_list);
+	return 0;
+}
+
+/*
  * Prepare the array of PRCM events corresponding to the current SoC,
  * and set-up the chained interrupt handler mechanism.
  */
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 5785555..789eb17 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -72,6 +72,7 @@ void omap4_prcm_pending_events(unsigned long *pending);
 int omap_prcm_event_to_irq(const char *name);
 int omap_prcm_irq_init(void);
 void omap_prcm_irq_cleanup(void);
+int omap_prcm_register_pad_irq(u32 pad, unsigned int irq);
 u32 omap_prcm_get_reset_sources(void);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

