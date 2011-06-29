From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 2/9] PRCM: Add support for PAD wakeup interrupts
Date: Wed, 29 Jun 2011 12:04:56 +0300
Message-ID: <1309338303-2086-3-git-send-email-t-kristo@ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48929 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab1F2JFP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Jun 2011 05:05:15 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5T95Fb5030682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:15 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5T95EGH027018
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:15 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5T95Dt7009086
	for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 04:05:14 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

PRCM interrupt handler will now parse registered pads to see whether there
is an active wakeup event. If there is a pending wakeup event, the registered
ISR will be called.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm.c             |   94 ++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/prcm.h |    5 ++
 2 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 794e451..6b603eb 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -30,6 +30,7 @@
 #include <plat/common.h>
 #include <plat/prcm.h>
 #include <plat/irqs.h>
+#include <plat/omap_hwmod.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -40,6 +41,7 @@
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
+#include "mux.h"
 
 void __iomem *prm_base;
 void __iomem *cm_base;
@@ -50,6 +52,15 @@ void __iomem *cm2_base;
 /* Setup for the interrupt handling based on used platform */
 static struct omap_prcm_irq_setup *irq_setup;
 
+/* PAD handlers list */
+struct pad_def {
+	struct omap_device_pad *pad;
+	unsigned int irq;
+	struct list_head node;
+};
+
+static LIST_HEAD(pad_handler_list);
+
 static void prcm_irq_ack(struct irq_data *data)
 {
 	unsigned int prcm_irq = data->irq - OMAP_PRCM_IRQ_BASE;
@@ -71,6 +82,24 @@ static void prcm_irq_unmask(struct irq_data *data)
 static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PENDING_REG];
 
 /*
+ * Handler for PAD irqs, called from PRCM interrupt handler
+ */
+static void omap_prcm_handle_pad_irqs(void)
+{
+	struct pad_def *def;
+	u16 val = 0;
+	list_for_each_entry(def, &pad_handler_list, node) {
+		/* Read padconf value */
+		val = omap_mux_read(def->pad->partition,
+			def->pad->mux->reg_offset);
+
+		/* If pad wakeupevent is active, call registered ISR */
+		if (val & OMAP3_PADCONF_WAKEUPEVENT0)
+			generic_handle_irq(def->irq);
+	}
+}
+
+/*
  * PRCM Interrupt Handler
  *
  * The PRM_IRQSTATUS_MPU register indicates if there are any pending
@@ -92,6 +121,9 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
+	/* Handle PAD events first, we don't want to ack them before parse */
+	omap_prcm_handle_pad_irqs();
+
 	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
@@ -139,6 +171,68 @@ int omap_prcm_event_to_irq(const char *name)
 }
 
 /*
+ * Register interrupt handler for a given omap_hwmod_mux. When the PRCM
+ * interrupt handler detects wakeupevent on the corresponding pad, the
+ * ISR will be called.
+ */
+int omap_prcm_register_pad_irqs(struct omap_hwmod_mux_info *mux,
+				unsigned int irq)
+{
+	struct pad_def *def;
+	int i;
+	u16 val;
+
+	if (!mux)
+		return 0;
+
+	for (i = 0; i < mux->nr_pads; i++) {
+		if (!(mux->pads[i].enable & OMAP_PIN_INPUT))
+			continue;
+
+		def = kmalloc(sizeof(struct pad_def), GFP_ATOMIC);
+		if (!def)
+			return -ENOMEM;
+
+		def->pad = mux->pads + i;
+		def->irq = irq;
+
+		/* Enable pad wakeup */
+		val = omap_mux_read(def->pad->partition,
+			def->pad->mux->reg_offset);
+		val |= OMAP_WAKEUP_EN;
+		omap_mux_write(def->pad->partition, val,
+			def->pad->mux->reg_offset);
+
+		list_add(&def->node, &pad_handler_list);
+	}
+	return 0;
+}
+
+/*
+ * Unregister pad irqs associated with a hwmod mux
+ */
+void omap_prcm_unregister_pad_irqs(struct omap_hwmod_mux_info *mux)
+{
+	struct pad_def *def;
+	int i;
+	u16 val;
+
+	list_for_each_entry(def, &pad_handler_list, node)
+		for (i = 0; i < mux->nr_pads; i++)
+			if (def->pad == mux->pads + i) {
+				list_del(&def->node);
+
+				/* Disable pad wakeup */
+				val = omap_mux_read(def->pad->partition,
+					def->pad->mux->reg_offset);
+				val &= ~OMAP_WAKEUP_EN;
+				omap_mux_write(def->pad->partition, val,
+					def->pad->mux->reg_offset);
+				kfree(def);
+			}
+}
+
+/*
  * Prepare the array of PRCM events corresponding to the current SoC,
  * and set-up the chained interrupt handler mechanism.
  */
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 205b9b1..7987819 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -66,10 +66,15 @@ struct omap_prcm_irq_setup {
 	int irq;
 };
 
+struct omap_hwmod_mux_info;
+
 int omap_prcm_event_to_irq(const char *name);
 int omap_prcm_irq_init(void);
 void omap_prcm_irq_setup(struct omap_prcm_irq_setup *setup);
 void omap_prcm_irq_cleanup(void);
+int omap_prcm_register_pad_irqs(struct omap_hwmod_mux_info *mux,
+				unsigned int irq);
+void omap_prcm_unregister_pad_irqs(struct omap_hwmod_mux_info *mux);
 u32 omap_prcm_get_reset_sources(void);
 int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
 			 const char *name);
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

