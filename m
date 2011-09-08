From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv7 7/9] OMAP2+: mux: add support for PAD wakeup interrupts
Date: Thu, 8 Sep 2011 18:22:22 +0300
Message-ID: <1315495344-23133-8-git-send-email-t-kristo@ti.com>
References: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40801 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754013Ab1IHPWl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Sep 2011 11:22:41 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1315495344-23133-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, govindraj.raja@ti.com

OMAP mux now provides a service routine to parse pending wakeup events
and to call registered ISR whenever active wakeups are detected. This
routine is called directly from PRCM interrupt handler.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c |   37 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/mux.h |    5 +++++
 2 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 50ee806..b6ec5de 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -32,6 +32,9 @@
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/power/omap_prm.h>
 
 #include <asm/system.h>
 
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
@@ -765,6 +796,12 @@ static int __init omap_mux_late_init(void)
 		}
 	}
 
+	ret = request_irq(omap_prcm_event_to_irq("io"),
+		omap_hwmod_mux_handle_irq, 0, "hwmod_io", NULL);
+
+	if (ret)
+		printk(KERN_WARNING "Failed to setup hwmod io irq %d\n", ret);
+
 	omap_mux_dbg_init();
 
 	return 0;
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 8b2150a..8014de0 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -232,6 +232,7 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state);
  * Called only from omap_hwmod.c, do not use.
  */
 bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux);
+
 #else
 
 static inline bool
@@ -259,6 +260,10 @@ static inline void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
 {
 }
 
+static inline void omap_hwmod_mux_handle_irq(void)
+{
+}
+
 static struct omap_board_mux *board_mux __initdata __maybe_unused;
 
 #endif
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

