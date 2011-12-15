From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/9] ARM: OMAP: hwmod: add support for selecting mpu_irq for
 each wakeup pad
Date: Thu, 15 Dec 2011 14:36:22 -0700
Message-ID: <20111215213621.26632.21627.stgit@dusk>
References: <20111215213358.26632.44165.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41022 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759526Ab1LOVhl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 16:37:41 -0500
In-Reply-To: <20111215213358.26632.44165.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>

From: Tero Kristo <t-kristo@ti.com>

By default all registered pads will trigger mpu_irqs[0]. Now there is
an API for selecting used mpu_irq on pad basis, which can be used to
trigger different irq handlers for different pads in the same hwmod.
Each pad that requires its interrupt to be re-routed this way must
have a separate call to omap_hwmod_pad_route_irq(hwmod, pad, irq).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Tested-by: Kevin Hilman <khilman@ti.com>
Reviewed-by: Kevin Hilman <khilman@ti.com>
[paul@pwsan.com: moved fn to omap_hwmod.c; separated fn from mux scan_wakeups
 changes; added kerneldoc]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   55 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 21ffd8a..7ea3df5 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -136,6 +136,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/slab.h>
 
 #include <plat/common.h>
 #include <plat/cpu.h>
@@ -2709,3 +2710,57 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
+
+/**
+ * omap_hwmod_pad_route_irq - route an I/O pad wakeup to a particular MPU IRQ
+ * @oh: struct omap_hwmod * containing hwmod mux entries
+ * @pad_idx: array index in oh->mux of the hwmod mux entry to route wakeup
+ * @irq_idx: the hwmod mpu_irqs array index of the IRQ to trigger on wakeup
+ *
+ * When an I/O pad wakeup arrives for the dynamic or wakeup hwmod mux
+ * entry number @pad_idx for the hwmod @oh, trigger the interrupt
+ * service routine for the hwmod's mpu_irqs array index @irq_idx.  If
+ * this function is not called for a given pad_idx, then the ISR
+ * associated with @oh's first MPU IRQ will be triggered when an I/O
+ * pad wakeup occurs on that pad.  Note that @pad_idx is the index of
+ * the _dynamic or wakeup_ entry: if there are other entries not
+ * marked with OMAP_DEVICE_PAD_WAKEUP or OMAP_DEVICE_PAD_REMUX, these
+ * entries are NOT COUNTED in the dynamic pad index.  This function
+ * must be called separately for each pad that requires its interrupt
+ * to be re-routed this way.  Returns -EINVAL if there is an argument
+ * problem or if @oh does not have hwmod mux entries or MPU IRQs;
+ * returns -ENOMEM if memory cannot be allocated; or 0 upon success.
+ *
+ * XXX This function interface is fragile.  Rather than using array
+ * indexes, which are subject to unpredictable change, it should be
+ * using hwmod IRQ names, and some other stable key for the hwmod mux
+ * pad records.
+ */
+int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx)
+{
+	int nr_irqs;
+
+	might_sleep();
+
+	if (!oh || !oh->mux || !oh->mpu_irqs || pad_idx < 0 ||
+	    pad_idx >= oh->mux->nr_pads_dynamic)
+		return -EINVAL;
+
+	/* Check the number of available mpu_irqs */
+	for (nr_irqs = 0; oh->mpu_irqs[nr_irqs].irq >= 0; nr_irqs++)
+		;
+
+	if (irq_idx >= nr_irqs)
+		return -EINVAL;
+
+	if (!oh->mux->irqs) {
+		/* XXX What frees this? */
+		oh->mux->irqs = kzalloc(sizeof(int) * oh->mux->nr_pads_dynamic,
+			GFP_KERNEL);
+		if (!oh->mux->irqs)
+			return -ENOMEM;
+	}
+	oh->mux->irqs[pad_idx] = irq_idx;
+
+	return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index f705492..ef4bf31 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -605,6 +605,8 @@ int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
+int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out


