From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] irq: call also chip->irq_mask from irq_disable
Date: Wed, 14 Sep 2011 11:53:48 +0300
Message-ID: <1315990428-22676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754215Ab1INIxw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 04:53:52 -0400
Content-Class: urn:content-classes:message
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: lkml@vger.kernel.org
Cc: linux-omap@vger.kernel.org

Current implementation of the irq_disable only calls chip->irq_disable.
This fails to disable interrupt on some chip implementations, as there
are two alternative chip specific functions for this task,
chip->irq_disable and chip->irq_mask. Added alternative path for
chip->irq_disable also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 kernel/irq/chip.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index d5a3009..15597f1 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -198,10 +198,11 @@ void irq_enable(struct irq_desc *desc)
 void irq_disable(struct irq_desc *desc)
 {
 	irq_state_set_disabled(desc);
-	if (desc->irq_data.chip->irq_disable) {
+	if (desc->irq_data.chip->irq_disable)
 		desc->irq_data.chip->irq_disable(&desc->irq_data);
-		irq_state_set_masked(desc);
-	}
+	else
+		desc->irq_data.chip->irq_mask(&desc->irq_data);
+	irq_state_set_masked(desc);
 }
 
 static inline void mask_ack_irq(struct irq_desc *desc)
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

