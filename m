From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 3/6] OMAP: PRCM: Added an api to get id for a PRCM event
Date: Wed, 22 Jun 2011 19:42:11 +0300
Message-ID: <1308760934-9757-4-git-send-email-t-kristo@ti.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34849 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756602Ab1FVQmj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Jun 2011 12:42:39 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p5MGgdSi022994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:39 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p5MGgd2m009421
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:39 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p5MGgbbo012063
	for <linux-omap@vger.kernel.org>; Wed, 22 Jun 2011 11:42:38 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1308760934-9757-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This is required by OMAP3 as it needs to dynamically unmask events during
idle cycle.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prcm.c             |   17 ++++++++++++++---
 arch/arm/plat-omap/include/plat/prcm.h |    1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index cc92064..f6cde6f 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -174,12 +174,23 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
  */
 int omap_prcm_event_to_irq(const char *name)
 {
-	int i;
+	int id;
+
+	id = omap_prcm_event_to_id(name);
+	if (id < 0)
+		return id;
+	return OMAP_PRCM_IRQ_BASE + id;
+}
 
+/*
+ * Given a PRCM event name, returns the corresponding event id.
+ */
+int omap_prcm_event_to_id(const char *name)
+{
+	int i;
 	for (i = 0; i < omap_prcm_irqs_nr; i++)
 		if (!strcmp(omap_prcm_irqs[i].name, name))
-			return OMAP_PRCM_IRQ_BASE + omap_prcm_irqs[i].offset;
-
+			return omap_prcm_irqs[i].offset;
 	return -ENOENT;
 }
 
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 789eb17..b5413ea 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -70,6 +70,7 @@ void omap4_prcm_ack_event(unsigned event);
 void omap4_prcm_pending_events(unsigned long *pending);
 
 int omap_prcm_event_to_irq(const char *name);
+int omap_prcm_event_to_id(const char *name);
 int omap_prcm_irq_init(void);
 void omap_prcm_irq_cleanup(void);
 int omap_prcm_register_pad_irq(u32 pad, unsigned int irq);
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

