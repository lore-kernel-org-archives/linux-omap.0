From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 05/14] OMAP2+: mux: add support for PAD wakeup interrupts
Date: Fri, 9 Dec 2011 16:27:28 +0200
Message-ID: <1323440857-385-6-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54902 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753781Ab1LIO2O (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:14 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com

OMAP mux now provides a service routine to parse pending wakeup events
and to call registered ISR whenever active wakeups are detected. This
routine is called directly from PRCM interrupt handler.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 5f15ab8..0d1962e 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -32,6 +32,8 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
 
 #include <asm/system.h>
 
@@ -39,6 +41,7 @@
 
 #include "control.h"
 #include "mux.h"
+#include "prcm-common.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
@@ -381,6 +384,33 @@ bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
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
+static irqreturn_t omap_hwmod_mux_handle_irq(int irq, void *unused)
+{
+	omap_hwmod_for_each(_omap_hwmod_mux_handle_irq, NULL);
+	return IRQ_HANDLED;
+}
+
 /* Assumes the calling function takes care of locking */
 void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
@@ -745,6 +775,7 @@ static void __init omap_mux_free_names(struct omap_mux *m)
 static int __init omap_mux_late_init(void)
 {
 	struct omap_mux_partition *partition;
+	int ret;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
 		struct omap_mux_entry *e, *tmp;
@@ -765,6 +796,13 @@ static int __init omap_mux_late_init(void)
 		}
 	}
 
+	ret = request_irq(omap_prcm_event_to_irq("io"),
+		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
+			"hwmod_io", omap_mux_late_init);
+
+	if (ret)
+		printk(KERN_WARNING "Failed to setup hwmod io irq %d\n", ret);
+
 	omap_mux_dbg_init();
 
 	return 0;
-- 
1.7.4.1

