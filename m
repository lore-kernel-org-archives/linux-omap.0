From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/9] ARM: OMAP2+: mux: add support for PAD wakeup interrupts
Date: Thu, 15 Dec 2011 14:36:21 -0700
Message-ID: <20111215213620.26632.7756.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41017 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146Ab1LOVhk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:40 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

From: Tero Kristo <t-kristo@ti.com>

OMAP mux now parses active wakeup events from pad registers and calls
corresponding hwmod ISRs once a wakeup is detected. This is
accomplished by registering an interrupt handler for PRCM IO event,
which is raised every time the HW detects wakeups.

[paul@pwsan.com: This patch is a merge of Govindraj R's "ARM: OMAP2+:
hwmod: Add API to check IO PAD wakeup status" patch, Tero Kristo's
"ARM: OMAP2+: mux: add support for PAD wakeup interrupts" patch, and
part of Tero's "ARM: OMAP: mux: add support for selecting mpu_irq for
each wakeup pad" patch.]

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
[paul@pwsan.com: reduced indentation level; renamed omap_hwmod function;
 improved function documentation; modified to iterate only through dynamic
 pads; modified to skip pads where idle mode doesn't enable wakeups; split
 patches]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/mux.c                    |   83 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 
 2 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index a474c81..e1cc75d 100644
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
+#include "prm.h"
 
 #define OMAP_MUX_BASE_OFFSET		0x30	/* Offset from CTRL_BASE */
 #define OMAP_MUX_BASE_SZ		0x5ca
@@ -353,6 +356,78 @@ err1:
 	return NULL;
 }
 
+/**
+ * omap_hwmod_mux_scan_wakeups - omap hwmod scan wakeup pads
+ * @hmux: Pads for a hwmod
+ * @mpu_irqs: MPU irq array for a hwmod
+ *
+ * Scans the wakeup status of pads for a single hwmod.  If an irq
+ * array is defined for this mux, the parser will call the registered
+ * ISRs for corresponding pads, otherwise the parser will stop at the
+ * first wakeup active pad and return.  Returns true if there is a
+ * pending and non-served wakeup event for the mux, otherwise false.
+ */
+static bool omap_hwmod_mux_scan_wakeups(struct omap_hwmod_mux_info *hmux,
+		struct omap_hwmod_irq_info *mpu_irqs)
+{
+	int i, irq;
+	unsigned int val;
+	u32 handled_irqs = 0;
+
+	for (i = 0; i < hmux->nr_pads_dynamic; i++) {
+		struct omap_device_pad *pad = hmux->pads_dynamic[i];
+
+		if (!(pad->flags & OMAP_DEVICE_PAD_WAKEUP) ||
+		    !(pad->idle & OMAP_WAKEUP_EN))
+			continue;
+
+		val = omap_mux_read(pad->partition, pad->mux->reg_offset);
+		if (!(val & OMAP_WAKEUP_EVENT))
+			continue;
+
+		if (!hmux->irqs)
+			return true;
+
+		irq = hmux->irqs[i];
+		/* make sure we only handle each irq once */
+		if (handled_irqs & 1 << irq)
+			continue;
+
+		handled_irqs |= 1 << irq;
+
+		generic_handle_irq(mpu_irqs[irq].irq);
+	}
+
+	return false;
+}
+
+/**
+ * _omap_hwmod_mux_handle_irq - Process wakeup events for a single hwmod
+ *
+ * Checks a single hwmod for every wakeup capable pad to see if there is an
+ * active wakeup event. If this is the case, call the corresponding ISR.
+ */
+static int _omap_hwmod_mux_handle_irq(struct omap_hwmod *oh, void *data)
+{
+	if (!oh->mux || !oh->mux->enabled)
+		return 0;
+	if (omap_hwmod_mux_scan_wakeups(oh->mux, oh->mpu_irqs))
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
@@ -717,6 +792,7 @@ static void __init omap_mux_free_names(struct omap_mux *m)
 static int __init omap_mux_late_init(void)
 {
 	struct omap_mux_partition *partition;
+	int ret;
 
 	list_for_each_entry(partition, &mux_partitions, node) {
 		struct omap_mux_entry *e, *tmp;
@@ -737,6 +813,13 @@ static int __init omap_mux_late_init(void)
 		}
 	}
 
+	ret = request_irq(omap_prcm_event_to_irq("io"),
+		omap_hwmod_mux_handle_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
+			"hwmod_io", omap_mux_late_init);
+
+	if (ret)
+		pr_warning("mux: Failed to setup hwmod io irq %d\n", ret);
+
 	omap_mux_dbg_init();
 
 	return 0;
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8b372ed..f705492 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -97,6 +97,7 @@ struct omap_hwmod_mux_info {
 	struct omap_device_pad		*pads;
 	int				nr_pads_dynamic;
 	struct omap_device_pad		**pads_dynamic;
+	int				*irqs;
 	bool				enabled;
 };
 


