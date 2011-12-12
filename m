From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 8/8] ARM: OMAP: mux: add support for selecting mpu_irq for each wakeup pad
Date: Mon, 12 Dec 2011 20:15:33 +0200
Message-ID: <1323713733-13115-9-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47268 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab1LLSQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 13:16:07 -0500
In-Reply-To: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

By default all registered pads will trigger mpu_irqs[0]. Now there is
an API for selecting used mpu_irq on pad basis, which can be used to
trigger different irq handlers for different pads in the same hwmod.
Each pad that requires its interrupt to be re-routed this way must
have a separate call to omap_hwmod_pad_route_irq(hwmod, pad, irq).

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c                    |   67 ++++++++++++++++++++++----
 arch/arm/mach-omap2/omap_hwmod.c             |    7 ---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 ++
 3 files changed, 61 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 0d1962e..2da3f3d 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -354,19 +354,53 @@ err1:
 	return NULL;
 }
 
+int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx,
+		int irq_idx)
+{
+	int nr_irqs;
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
+		oh->mux->irqs = kzalloc(sizeof(int) * oh->mux->nr_pads_dynamic,
+			GFP_KERNEL);
+		if (!oh->mux->irqs)
+			return -ENOMEM;
+	}
+	oh->mux->irqs[pad_idx] = irq_idx;
+
+	return 0;
+}
+
 /**
- * omap_hwmod_mux_get_wake_status - omap hwmod check pad wakeup
+ * omap_hwmod_mux_scan_wakeups - omap hwmod scan wakeup pads
  * @hmux:		Pads for a hwmod
+ * @mpu_irqs:		MPU irq array for a hwmod
  *
- * Gets the wakeup status of given pad from omap-hwmod.
- * Returns true if wakeup event is set for pad else false
- * if wakeup is not occured or pads are not avialable.
+ * Scans the wakeup status of pads for a single hwmod.
+ * If an irq array is defined for this mux, the parser
+ * will call the registered ISRs for corresponding pads,
+ * otherwise the parser will stop at the first wakeup
+ * active pad and return.
+ * Returns true if there is a pending and non-served
+ * wakeup event for the mux, otherwise false.
  */
-bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
+static bool omap_hwmod_mux_scan_wakeups(struct omap_hwmod_mux_info *hmux,
+		struct omap_hwmod_irq_info *mpu_irqs)
 {
 	int i;
 	unsigned int val;
-	u8 ret = false;
+	u32 handled_irqs = 0;
+	int irq;
 
 	for (i = 0; i < hmux->nr_pads; i++) {
 		struct omap_device_pad *pad = &hmux->pads[i];
@@ -375,13 +409,26 @@ bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
 			val = omap_mux_read(pad->partition,
 					pad->mux->reg_offset);
 			if (val & OMAP_WAKEUP_EVENT) {
-				ret = true;
-				break;
+				if (hmux->irqs) {
+					irq = hmux->irqs[i];
+					/*
+					 * make sure we only handle each
+					 * irq once
+					 */
+					if (handled_irqs & 1 << irq)
+						continue;
+
+					handled_irqs |= 1 << irq;
+
+					generic_handle_irq(mpu_irqs[irq].irq);
+				} else {
+					return true;
+				}
 			}
 		}
 	}
 
-	return ret;
+	return false;
 }
 
 /**
@@ -394,7 +441,7 @@ static int _omap_hwmod_mux_handle_irq(struct omap_hwmod *oh, void *data)
 {
 	if (!oh->mux || !oh->mux->enabled)
 		return 0;
-	if (omap_hwmod_mux_get_wake_status(oh->mux))
+	if (omap_hwmod_mux_scan_wakeups(oh->mux, oh->mpu_irqs))
 		generic_handle_irq(oh->mpu_irqs[0].irq);
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index d7f4623..8d37d83 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2721,10 +2721,3 @@ int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
 
 	return 0;
 }
-
-int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh)
-{
-	if (oh && oh->mux)
-		return omap_hwmod_mux_get_wake_status(oh->mux);
-	return -EINVAL;
-}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1b81dfb..a5f0a5f 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -97,6 +97,7 @@ struct omap_hwmod_mux_info {
 	struct omap_device_pad		*pads;
 	int				nr_pads_dynamic;
 	struct omap_device_pad		**pads_dynamic;
+	int				*irqs;
 	bool				enabled;
 };
 
@@ -605,6 +606,9 @@ int omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
 
 int omap_hwmod_pad_get_wakeup_status(struct omap_hwmod *oh);
+
+int omap_hwmod_pad_route_irq(struct omap_hwmod *oh, int pad_idx, int irq_idx);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.4.1

