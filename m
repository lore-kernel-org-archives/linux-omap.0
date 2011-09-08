From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 5/9] TEMP: power: omap-prm: added prcm events
Date: Thu, 8 Sep 2011 18:22:20 +0300
Message-ID: <1315495344-23133-6-git-send-email-t-kristo@ti.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47222 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab1IHPWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:38 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

Added wakeup and io event definitions for the PRCM interrupt handler.
This should eventually be generated from PRM hwmod data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/power/omap_prm.c |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/power/omap_prm.c b/drivers/power/omap_prm.c
index 745a4bc..ce0a872 100644
--- a/drivers/power/omap_prm.c
+++ b/drivers/power/omap_prm.c
@@ -50,6 +50,26 @@ static struct omap_prm_device prm_dev = {
 	},
 };
 
+struct omap_prcm_irq {
+	const char *name;
+	unsigned int offset;
+	const struct omap_chip_id omap_chip;
+};
+
+#define OMAP_PRCM_IRQ(_name, _offset, _chip) {	\
+	.name = _name,				\
+	.offset = _offset,			\
+	.omap_chip = OMAP_CHIP_INIT(_chip)	\
+	}
+
+static struct omap_prcm_irq omap_prcm_irqs[] = {
+	OMAP_PRCM_IRQ("wkup",		0,
+			CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1),
+	OMAP_PRCM_IRQ("io",		9,
+			CHIP_IS_OMAP3430 | CHIP_GE_OMAP3630ES1_1 |
+			CHIP_IS_OMAP4430),
+};
+
 static void prm_pending_events(unsigned long *events)
 {
 	u32 ena, st;
@@ -167,10 +187,18 @@ static int __init omap_prcm_irq_init(void)
 	int i;
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
+	u32 mask[OMAP_PRCM_MAX_NR_PENDING_REG];
 	int offset;
-	int max_irq = 64;
+	int max_irq = 0;
 
-	/* XXX: supported irqs should be setup here */
+	memset(mask, 0, sizeof(mask));
+	for (i = 0; i < ARRAY_SIZE(omap_prcm_irqs); i++)
+		if (omap_chip_is(omap_prcm_irqs[i].omap_chip)) {
+			offset = omap_prcm_irqs[i].offset;
+			mask[offset >> 5] |= 1 << (offset & 0x1f);
+			if (offset > max_irq)
+				max_irq = offset;
+		}
 
 	irq_set_chained_handler(prm_dev.irq_setup.irq, prcm_irq_handler);
 
@@ -207,7 +235,7 @@ static int __init omap_prcm_irq_init(void)
 		ct->regs.ack = prm_dev.irq_setup.ack + (i << 2);
 		ct->regs.mask = prm_dev.irq_setup.mask + (i << 2);
 
-		irq_setup_generic_chip(gc, 0xffffffff, 0, IRQ_NOREQUEST, 0);
+		irq_setup_generic_chip(gc, mask[i], 0, IRQ_NOREQUEST, 0);
 		prm_dev.irq_chips[i] = gc;
 	}
 
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

