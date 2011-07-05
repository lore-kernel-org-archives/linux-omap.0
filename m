From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 04/11] OMAP2+: hwmod: add support for PAD wakeup interrupts
Date: Tue, 5 Jul 2011 13:27:50 +0300
Message-ID: <1309861677-2769-5-git-send-email-t-kristo@ti.com>
References: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58469 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755034Ab1GEK2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jul 2011 06:28:12 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p65ASB1v031103
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:11 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p65ASBBC019404
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:11 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p65ASBEw028475
	for <linux-omap@vger.kernel.org>; Tue, 5 Jul 2011 05:28:11 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1309861677-2769-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP hwmod now provides a service routine to parse pending wakeup events
and to call registered ISR whenever active wakeups are detected. This
routine is called directly from PRCM interrupt handler.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   19 +++++++++++++++++++
 arch/arm/mach-omap2/prcm.c                   |    4 ++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 0dd48ee..3f3e22d 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -135,6 +135,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/irq.h>
 
 #include <plat/common.h>
 #include <plat/cpu.h>
@@ -2324,6 +2325,24 @@ int omap_hwmod_disable_ioring_wakeup(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_mux_handle_irq - Process pad wakeup irqs.
+ *
+ * Checks every hwmod for every wakeup capable pad to see if there is an
+ * active wakeup event. If this is the case, call the corresponding ISR.
+ */
+void omap_hwmod_mux_handle_irq(void)
+{
+	struct omap_hwmod *oh;
+
+	list_for_each_entry(oh, &omap_hwmod_list, node) {
+		if (!oh->mux || !oh->mux->enabled)
+			continue;
+		if (omap_hwmod_mux_get_wake_status(oh->mux))
+			generic_handle_irq(oh->mpu_irqs[0].irq);
+	}
+}
+
+/**
  * omap_hwmod_enable_wakeup - allow device to wake up the system
  * @oh: struct omap_hwmod *
  *
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index e7d602c..17d3d85 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -30,6 +30,7 @@
 #include <plat/common.h>
 #include <plat/prcm.h>
 #include <plat/irqs.h>
+#include <plat/omap_hwmod.h>
 
 #include "clock.h"
 #include "clock2xxx.h"
@@ -74,6 +75,9 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
+	/* Handle PAD events first, we don't want to ack them before parse */
+	omap_hwmod_mux_handle_irq();
+
 	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8e5025c..076fa25 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -601,6 +601,7 @@ int omap_hwmod_set_clockact_none(struct omap_hwmod *oh);
 
 int omap_hwmod_enable_wakeup(struct omap_hwmod *oh);
 int omap_hwmod_disable_wakeup(struct omap_hwmod *oh);
+void omap_hwmod_mux_handle_irq(void);
 
 int omap_hwmod_for_each_by_class(const char *classname,
 				 int (*fn)(struct omap_hwmod *oh,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

