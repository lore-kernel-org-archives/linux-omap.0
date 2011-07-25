From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 04/11] OMAP2+: mux: add support for PAD wakeup interrupts
Date: Mon, 25 Jul 2011 19:36:04 +0300
Message-ID: <1311611771-15093-5-git-send-email-t-kristo@ti.com>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49142 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382Ab1GYQgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Jul 2011 12:36:33 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p6PGaXHT028179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:33 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6PGaXDq007453
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:33 -0500 (CDT)
Received: from dnce72.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id p6PGaWoK009271
	for <linux-omap@vger.kernel.org>; Mon, 25 Jul 2011 11:36:33 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

OMAP mux now provides a service routine to parse pending wakeup events
and to call registered ISR whenever active wakeups are detected. This
routine is called directly from PRCM interrupt handler.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c  |   27 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h  |   11 +++++++++++
 arch/arm/mach-omap2/prcm.c |    4 ++++
 3 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 50ee806..b6c4ea1 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -32,6 +32,7 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/irq.h>
 
 #include <asm/system.h>
 
@@ -381,6 +382,32 @@ bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
 	return ret;
 }
 
+/**
+ * omap_hwmod_mux_handle_irq - Process wakeup events for a single hwmod
+ *
+ * Checks a single hwmod for every wakeup capable pad to see if there is an
+ * active wakeup event. If this is the case, call the corresponding ISR.
+ */
+static int _omap_hwmod_mux_handle_irq(struct omap_hwmod *oh, void *data)
+{
+	if (!oh->mux || !oh->mux->enabled)
+		return 0;
+	if (omap_hwmod_mux_get_wake_status(oh->mux))
+		generic_handle_irq(oh->mpu_irqs[0].irq);
+	return 0;
+}
+
+/**
+ * omap_hwmod_mux_handle_irq - Process pad wakeup irqs.
+ *
+ * Calls a function for each registered omap_hwmod to check
+ * pad wakeup statuses.
+ */
+void omap_hwmod_mux_handle_irq(void)
+{
+	omap_hwmod_for_each(_omap_hwmod_mux_handle_irq, NULL);
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 8b2150a..6e7f1a4 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -232,6 +232,13 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
  * Called only from omap_hwmod.c, do not use.
  */
 bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux);
+
+/**
+ * omap_hwmod_mux_handle_irq - handler for IO pad wakeup events
+ *
+ * Called only from prcm.c to process PRCM IO events, do not use.
+ */
+void omap_hwmod_mux_handle_irq(void);
 #else
 
 static inline bool
@@ -259,6 +266,10 @@ static inline void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 }
 
+static inline void omap_hwmod_mux_handle_irq(void)
+{
+}
+
 static struct omap_board_mux *board_mux __initdata __maybe_unused;
 
 #endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 83cf8ae..7d8a6d8 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -40,6 +40,7 @@
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
+#include "mux.h"
 
 void __iomem *prm_base;
 void __iomem *cm_base;
@@ -112,6 +113,9 @@ static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
 	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
 
+	/* Handle PAD events first, we don't want to ack them before parse */
+	omap_hwmod_mux_handle_irq();
+
 	/*
 	 * Loop until all pending irqs are handled, since
 	 * generic_handle_irq() can cause new irqs to come
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

